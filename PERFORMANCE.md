# Performance — lag investigation & fixes

Triggered by: *"I see some lag on the web site."*

Diagnosed with a real headless-Chrome load of the deployed site plus a 66-agent
source audit (59 findings raised, 19 survived adversarial verification).

---

## Measured result

| metric | before | after | change |
|---|---:|---:|---:|
| **Image requests on landing** | 78 | **61** | −17 |
| **Image bytes on landing** | 14,895 KB | **1,241 KB** | **−91.7%** |
| Largest single image | 3,594 KB | **193 KB** | −94.6% |
| Screenshot corpus on disk | 46.05 MB | **6.58 MB** | −85.7% |
| `build/web/assets/assets` | 47 MB | **8.0 MB** | −83% |
| Text faces fetched from gstatic | ~1.0 MB | **0 KB** (316 KB bundled) | −100% remote |
| Noto fallback fetched from gstatic | 442 KB | **68 KB** | −85% |
| **All font traffic** | 1,213 KB / 14 req | **418 KB / 10 req** | **−65%** |
| Total transfer (gzip-normalised) | ~17.1 MB | **~2.7 MB** | **−84%** |
| First contentful paint | 3.85 s | 1.97 s | −49% |

Console errors: 0. Failed requests: 0. `flutter analyze`: clean. Tests: 30/30 pass.
Design-token gate: 0 errors, 0 warnings.

> **Measurement caveat.** "Before" was measured against the live GitHub Pages
> deploy (gzip on); "after" against a local `python3 -m http.server` build (no
> gzip), which reports `main.dart.js` at its raw 3,185 KB instead of the 941 KB
> GitHub Pages actually sends. The total row normalises for that. The image rows
> are apples-to-apples — WebP/PNG/JPG bytes are already compressed and gzip does
> not touch them either way.

---

## Root causes

1. **Unresized screenshots, eagerly fetched.** `home_page.dart:123` is a
   non-lazy `SingleChildScrollView` + `Column`, and `reveal_on_scroll.dart`
   rendered hidden children as `Opacity(0, child)` — which skips *painting* but
   still builds, lays out and resolves images. So all 17 featured cards mounted
   on frame 1 and pulled full-resolution phone captures for content 5–8
   viewports below the fold.
2. **`RevealOnScroll` swapped widget *type* on reveal**, so `canUpdate` failed
   and Flutter destroyed and re-inflated the whole subtree mid-scroll — ~42
   `ProjectCard`s at the Work boundary, 17 `PageController`s at Featured.

---

## Completed

- [x] **Kill the eager gallery prefetch** — `featured_section.dart`
      Removed the `addPostFrameCallback((_) => _precacheAround(_page))` in the
      gallery `LayoutBuilder`. It fired once per featured card, and all 17 lay
      out on the first frame, so it downloaded page 1 of *every* gallery (~9 MB,
      more than the page-0 images actually on screen) before anyone swiped.
      Page 1 is now fetched from `onPageChanged`, guarded by a `Set<int>
      _precached` so a resize cannot re-arm it. **−17 image requests.**

- [x] **Stop `RevealOnScroll` re-inflating its subtree** — `reveal_on_scroll.dart`
      Rewrote around a `SingleTickerProviderStateMixin` + `AnimationController`.
      The child is built **once** and passed through `AnimatedBuilder`'s `child:`
      slot; the fade/translate is applied by the builder, and hit-testing is
      gated with `IgnorePointer(ignoring: !_shown)` — a *parameter* change, not a
      structural one. Replaces the old
      `_shown ? child.animate(…) : IgnorePointer(Opacity(0, child))` type swap.
      Entrance visuals (16px rise + fade, `context.motion` duration/curve, stagger
      `delay`) are unchanged. Dropped the now-unused `flutter_animate` import.

- [x] **Detach the visibility detector once it has fired** — `reveal_on_scroll.dart`
      `onVisibilityChanged: _shown ? null : (…)`. Passing `null` makes
      `VisibilityDetector` `forget()` the key and cancel its composition
      callback. ~70 of these stay mounted for the life of the page and each one
      still listening walks its ancestor transforms every frame. Steady-state
      live detectors: **~70 → 1** (`terminal_status_strip`, which needs it).

- [x] **Drop the Cairo runtime font fetch** — `app_typography.dart`
      `_arabic` called `GoogleFonts.cairo()`, fetching ~91 KB from gstatic at
      theme-build time on every page load. Superseded by the font bundling
      below, which removed `google_fonts` entirely.

      **Correction to the original rationale.** This was first justified as
      "glyphs no English string can use". That was wrong: seven `apps.json`
      entries (`sphoto`, `falta`, `montajat`, `gigapp`, `4x4kw`, `hababah`,
      `montajat-vendor`) have Arabic `description` text that renders even in the
      `en` locale, and `screenshot_viewer.dart:82` has a live RTL detector for
      exactly that. The change still stands on a different footing: those
      descriptions appear **only inside the screenshot-viewer modal**, never on
      the landing page, so Cairo was being fetched eagerly for click-gated text.
      Arabic now resolves through the engine's Noto fallback, on demand.

- [x] **Bundle the text faces instead of fetching them at runtime** —
      `assets/fonts/`, `pubspec.yaml`, `app_typography.dart`
      Every style was a `GoogleFonts.*` call, so Space Grotesk w600, Inter
      w400/w500 and JetBrains Mono w400/w500 all downloaded from gstatic *after*
      `main.dart.js` executed — and each face completion posts `fontsChanged`,
      invalidating text layout across a ~13,000px scroll view.

      Now five TTFs (**316 KB total**, the Google Fonts latin subsets — vs the
      ~1.0 MB of full faces `google_fonts` was serving) ship under
      `assets/fonts/`, declared in `pubspec.yaml` with explicit weights.
      `AppTypography` uses plain `TextStyle(fontFamily: …)` and the
      `google_fonts` dependency is **removed**. Licenses bundled alongside as
      `assets/fonts/OFL-*.txt` (SIL OFL 1.1).

      Glyph coverage was verified programmatically against every character
      reachable on the landing page (translations, `profile.json`, app
      names/taglines/categories, and all Dart string literals): **93 characters,
      all covered.**

- [x] **Kill a 374 KB font fetch caused by two characters** — `contact_section.dart`
      The contact details used `▸` (U+25B8, Geometric Shapes) as a row prefix.
      No bundled face covers that block, so those two characters alone made
      CanvasKit pull **Noto Sans Symbols2 (374 KB)** from gstatic on every
      landing. Swapped for `›` (U+203A), which all five bundled faces cover.
      Visually near-identical and closer to the terminal aesthetic. Verified
      gone from the network log.

- [x] **Preload the app bundle** — `web/index.html`
      Added `<link rel="preload" as="script" href="main.dart.js">`.
      `flutter_bootstrap.js` must download, parse *and* await a full
      service-worker install-to-activate cycle before it injects the script tag,
      so the preload scanner never saw the bundle. Relative `href` resolves
      against `<base href>`, so it is correct for both the `/clever_portfolio/`
      project-page deploy and a CNAME root deploy.

- [x] **Re-encode the screenshot corpus to WebP** — `scripts/convert_screenshots_to_webp.sh`
      192 of 196 screenshots converted at `-q 80`, downscaled to max 1080px wide
      (never upscaled — 136 sources were already 600×1067). Sources were raw
      phone captures up to 2064×2752 / 3.7 MB, displayed at ~384 logical px
      (~768 device px at DPR 2). `apps.json` screenshot paths rewritten to
      `.webp`; **app icons deliberately untouched** (42 files, 0.61 MB, already
      correctly sized). Originals removed — they remain recoverable from git
      history, and carrying both sets would defeat the purpose.
      **46.05 MB → 6.58 MB (−85.7%).**
      Re-runnable and idempotent; `DRY_RUN=1`, `QUALITY=`, `MAX_WIDTH=` supported.

- [x] **Drop 487 KB of unused Font Awesome families** — `app_icons.dart`,
      `pubspec.yaml`, 4 call sites
      `font_awesome_flutter` declares three families in its own `pubspec.yaml`,
      and Flutter's icon tree-shaker only rewrites a family it finds referenced
      icons for — so Free-Regular (86 KB) and **Free-Solid (401 KB)** shipped
      whole while all 8 call sites used Brands. That weight sat on the
      pre-first-frame path, since the engine awaits `loadAssetFonts` before it is
      allowed to paint.

      The package is now **removed**. Only `Font-Awesome-7-Brands-Regular-400.otf`
      is bundled, declared as family `FontAwesomeBrands`, with the six glyphs
      actually used defined as `const IconData` in
      `lib/core/constants/app_icons.dart` (codepoints copied verbatim from
      `font_awesome_flutter` 10.12.0). Being `const` with a literal `fontFamily`,
      they still tree-shake — **199,352 B → 2,684 B**.

      Verified by parsing the built font's `cmap`: all six codepoints
      (`github` 0xf09b, `linkedinIn` 0xf0e1, `xTwitter` 0xe61b, `whatsapp`
      0xf232, `appStoreIos` 0xf370, `googlePlay` 0xf3ab) survive the shake —
      7 glyphs total, the six plus `.notdef`. Confirmed visually for GitHub,
      LinkedIn and WhatsApp. License text bundled as
      `assets/fonts/LICENSE-fontawesome.txt`.

- [x] **Stop requesting 60 frames a second to paint 12** — `motion_background.dart`
      The drift clock was an `AnimationController`, which ticks at vsync and so
      asks the engine for a frame 60×/sec — but `_tick` is quantised to 12 fps,
      so 48 of those recomputed the same bucket and painted nothing. Because
      this widget sits `Positioned.fill` behind the entire page, that tax was
      paid on a completely idle, untouched tab.

      Replaced with a `Timer.periodic` at 12 fps. Reduced-motion and
      background-tab pausing behave as before; the painter's `t` math is
      unchanged (`_tick` cycles `0…_period-1` where `_period = 24 * _fps`), so
      the visuals are identical.

      **Note on the original finding:** the audit proposed gating this on
      visibility. That does not apply — `home_page.dart:118-120` places it
      `Positioned.fill` behind everything, so it is *always* visible. The waste
      was the ticker rate, not the viewport.

      Verified by screenshotting a text-free corner where only the aurora paints
      at four points across the drift cycle — four distinct frames, so the
      animation still runs.

- [x] **`_decodeWidth` — obsolete, comment corrected** — `screenshot_viewer.dart`
      No longer worth changing: the WebP pass capped every source at 1080px
      (most are 600), so `ResizeImage(allowUpscaling: false)` already clamps the
      decode to source width on any normal display. The over-decode the audit
      described (edu-market_4/5/6 at 2064×2752) cannot happen — those sources no
      longer exist. Only the stale doc comment ("up to ~1290px") was fixed.

---

## Not done — remaining wins, highest value first

- [ ] **Serve CanvasKit same-origin — DO NOT apply without measuring first.**
      The audit recommended adding `--no-web-resources-cdn` to
      `.github/workflows/deploy.yml:47`, on the grounds that `canvaskit.wasm`
      (5,686,836 B) loads cross-origin from gstatic at a revision-hashed URL, so
      it cannot be preloaded — and it, not `main.dart.js`, gates the first frame.

      **The catch:** gstatic serves it compressed (~2.87 MB). GitHub Pages is
      widely reported not to compress `application/wasm`, which would mean
      shipping 5.69 MB raw — a ~2.8 MB *regression*, wiping out most of the
      image win. I tried to settle this empirically against Pages-hosted wasm
      files and could not (the large samples I tried 404'd; the one that
      resolved was 83 bytes, below any compression threshold). So this stays
      unapplied on purpose.

      To decide it: apply the flag on a branch, deploy, then run
      `curl -sI -H 'Accept-Encoding: gzip, br' \`
      `https://<user>.github.io/clever_portfolio/canvaskit/canvaskit.wasm \`
      `| grep -i 'content-encoding\|content-length'`.
      A `content-encoding` header means keep it; none means revert. Note that
      `web/index.html:68` already `preconnect`s to `www.gstatic.com`, so the
      cross-origin handshake cost is largely mitigated today.

- [ ] **Chase the last two Noto fallbacks** (130 KB — Roboto 62 KB,
      Noto Sans Symbols 68 KB). No landing-reachable app character is uncovered
      by the bundled faces, so these appear to be engine-level fallback-chain
      initialisation rather than app text. Confirming would need CanvasKit
      font-fallback tracing; low value next to the Font Awesome item above.

- [ ] **`CustomScrollView` + slivers** — correct long-term shape for
      `home_page.dart:123-147`, but **not a drop-in**: `_scrollTo` uses
      `Scrollable.ensureVisible` and `_updateActiveSection` walks
      `_keys[id].currentContext.localToGlobal`. Lazy slivers unmount off-screen
      sections past the cache extent and would silently break every nav anchor
      and the scroll-spy. Worth little now that the bytes are gone.

---

## Verified already correct — do not re-optimise

- `cacheWidth` / `cacheHeight` decode hygiene in `parallax_image.dart` and
  `app_icon_tile.dart`. Correct — it caps the raster bitmap. It just never
  touched wire bytes, which is why it did not prevent this.
- `PageView.builder` in `featured_section.dart` is **already lazy**
  (`allowImplicitScrolling` unset ⇒ `cacheExtent` 0, only page 0 mounts). It was
  never loading all 96 featured screenshots.
- App icons — 42 files, 0.61 MB total, correctly sized.
- `RepaintBoundary` placement in `index_section.dart`, `featured_section.dart`,
  `parallax_image.dart`, and around `MotionBackground`.
- `TickerMode` gating in `terminal_status_strip.dart`.
- `_showBackToTop` `setState` in `home_page.dart:70` — fires only on the 600px
  threshold crossing, and 8 of 9 section children are `const`.
- gzip on JS/wasm — already compressed, nothing to reclaim.
- `preconnect` hints for `fonts.gstatic.com` — DNS/TLS already warm.
