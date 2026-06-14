# Ahmed Maher — Flutter Developer Portfolio | Implementation Plan

## Overview

This is the single source of truth for building **Ahmed Maher's Flutter Web portfolio** — a dark-first, engineering-grade single-page site that frames his **37 shipped apps as a versioned, filterable release index**. The aesthetic is "Production Terminal — Indexed Edition": IDE precision meets editorial catalog calm, anchored by one electric-emerald signal accent and restrained per-category hues. The build runs on the existing `clever_portfolio` Flutter project (Flutter 3.41.4 / Dart 3.11.1, web platform enabled, currently a default counter app) and strictly follows Clean Architecture, a generic `UseCase<Output, Params>` contract, `flutter_bloc` Cubits, `dartz` `Either<Failure, T>` everywhere, Dio for the one real network surface, a responsive sizing helper, and a fully token-driven dual-theme system with **zero hardcoded colors or text sizes in widgets**.

### Goals & Success Criteria

- **Showcase breadth credibly** — the 37 apps are the hero visual, presented as a numbered index (01–37) with a default dense list and a card-grid toggle, filterable by category and platform.
- **Engineering signal** — the codebase itself is a portfolio artifact: textbook Clean Architecture, sealed states, generic use cases, full token system, tests.
- **Both themes first-class** — dark-first default, light fully supported, animated cross-fade.
- **Build-ready incrementally** — phased roadmap (M0–M7) so the site is runnable after every milestone.
- **Web-grade delivery** — accessible (AA contrast, keyboard nav, reduced-motion), SEO-tagged (static `<head>` + JSON-LD), and deployed via GitHub Pages CI.
- **Success = ** all global rules satisfied, all 37 apps rendering with correct conditional store links, Lighthouse A11y/SEO ≥ 95, green CI deploy.

---

## 2. Tech Stack & Packages

> Build target: **Flutter Web only** (the scaffolded desktop/mobile platforms are ignored). Flutter 3.41.4 / Dart 3.11.1 (SDK `^3.11.1`). Versions are floor constraints (`^`) compatible with this SDK; pin exact versions from the `pub get` resolution at install time.

**A note on the mandated `sizeHelper` package (read first):** there is **no maintained pub.dev package literally named `sizeHelper`/`size_helper`** (verified — only `size_config`, `sized_context`, `responsive_size_widget`, etc. exist, none authoritative). The rule's *intent* is "a responsive sizing helper." We satisfy it with **`flutter_screenutil`** (de-facto standard, CSS-like `.w/.h/.sp/.r` scaling + breakpoints), wrapped behind our own `core/responsive/` abstraction (`AppBreakpoints`, `Responsive<T>`, `context.bp`) so widgets never call the package directly and it can be swapped without touching the UI. This **is** the mandated "sizeHelper" for this build — **confirmed as the house standard**: the user's other production projects (e.g. *Rolli*) standardize on `flutter_screenutil` for responsive sizing (`.sp`/`.w`/`.h`/`.r`).

### `dependencies`

| Package | Version (`^`) | Purpose |
|---|---|---|
| `flutter_bloc` | `^9.1.1` | **State management (mandated).** Provides the Cubits in §5 + `BlocProvider`/`BlocBuilder`. |
| `bloc` | `^9.0.1` | Core BLoC primitives + `BlocObserver` (`AppObserver`); pinned explicitly for the observer. |
| `dartz` | `^0.10.1` | **Mandated.** `Either<Failure, T>` / `Unit` — the universal error-handling currency across every repository + use case. |
| `dio` | `^5.9.0` | **Mandated.** HTTP client; wired in `DioClient`, reserved for the contact-form POST + future remote content. |
| `flutter_screenutil` | `^5.9.3` | **The mandated "sizeHelper."** Responsive `.w/.h/.sp/.r` scaling + breakpoint base; wrapped behind `core/responsive/`. Sufficient alone — no secondary sizer needed. |
| `get_it` | `^8.2.0` | Service locator backing DI. |
| `injectable` | `^2.5.1` | Annotation-driven DI registration (codegen with `get_it`). |
| `go_router` | `^16.2.4` | Router-ready single `/` route + clean web URLs (hash sync); `/work/:appId` deep link added later. Navigation v1 is smooth-scroll anchors (see §9). |
| `google_fonts` | `^6.3.2` | Loads Space Grotesk / Inter / JetBrains Mono for `app_text_theme.dart` (no hardcoded text styles). |
| `url_launcher` | `^6.3.2` | Opens App Store / Google Play links, mailto, tel, and the bundled CV PDF. |
| `flutter_svg` | `^2.2.0` | Renders crisp store-badge / icon SVGs (`app_store.svg`, `google_play.svg`) on web. |
| `font_awesome_flutter` | `^10.10.0` | Social / store / brand glyphs (GitHub, store affordances); broader coverage than `simple_icons`. |
| `flutter_animate` | `^4.5.2` | Declarative entrance animations (fade + 16px translate, staggered), hairline `scaleX` reveals, hero clip reveal — all reduced-motion gated. |
| `visibility_detector` | `^0.4.0+2` | Triggers scroll-in reveals, count-up stats, and section-active detection feeding `NavigationCubit`. |
| `shared_preferences` | `^2.5.3` | Persists `ThemeMode` (`ThemeCubit`) + last `Locale` (`LocaleCubit`). |
| `easy_localization` | `^3.0.8` | **Localization (house standard).** Loads `assets/translations/en.json` + `ar.json`; drives `.tr()`, runtime locale switch, and RTL `Directionality`. EN + AR + RTL are first-class (§7.1). |
| `freezed_annotation` | `^3.1.0` | Annotations for Freezed unions / data classes — all Cubit states + data models (codegen by `freezed`). |
| `json_annotation` | `^4.12.0` | `@JsonSerializable` annotations for model `fromJson`/`toJson` (codegen by `json_serializable`). |
| `equatable` | `^2.0.7` | Value equality for pure domain **entities** + `Failure`s (Freezed already covers state/model equality). |
| `cupertino_icons` | `^1.0.8` | Already present; iOS-style glyphs. |

> `cached_network_image` is **omitted by default** — the design uses no remote imagery (the index is type/accent-driven, not a screenshot grid). If a future spotlight adds remote screenshots, add `cached_network_image: ^3.4.1` then. Stated explicitly so the omission is a decision, not an oversight.

### `dev_dependencies`

| Package | Version (`^`) | Purpose |
|---|---|---|
| `build_runner` | `^2.15.0` | Drives all codegen: `freezed`, `json_serializable`, `injectable_generator`. |
| `freezed` | `^3.1.0` | Generates `*.freezed.dart` for Cubit-state unions + data models (free `copyWith` / equality / exhaustive unions). |
| `json_serializable` | `^6.9.0` | Generates `*.g.dart` `fromJson`/`toJson` for data models. |
| `injectable_generator` | `^2.6.2` | Generates `injection.config.dart`. |
| `bloc_test` | `^10.0.0` | Cubit unit tests (`ProjectsCubit`, `ContactCubit`, filter logic). |
| `mocktail` | `^1.0.4` | Mocks repositories / data sources / `DioClient` in domain + data tests. |
| `flutter_lints` | `^6.0.0` | Already present; baseline lint rules. |
| `very_good_analysis` | `^9.0.0` | (Recommended) strict analyzer ruleset, exemplary for a Team Lead review. |

---

## 3. Design System

**Name:** *Production Terminal — Indexed Edition.* A dark-first, engineering-grade portfolio that frames 37 shipped apps as a versioned, filterable release index — IDE precision meets editorial catalog calm, with one electric-emerald signal accent and restrained per-category hues.

### 3.1 Palettes

Every value below lives in `ColorScheme` + `ThemeExtension`s (`CategoryColors`) — **zero hardcoded colors in widgets**. One electric-emerald primary is the only signal accent used for state (status dots, hover accent line, focus ring, active filter). Per-category hues are downgraded to solid, AA-checked single colors applied **only** to: a card's left accent line, the small category tag text, the active filter pill, and the index-number dot. Never as fills, never as text-on-gradient.

#### Light palette (`#F7F8FA` canvas)

| Token | Hex | Swatch | Token | Hex | Swatch |
|---|---|---|---|---|---|
| background | `#F7F8FA` | ⬜ | onBackground | `#0B0F14` | ⬛ |
| surface | `#FFFFFF` | ⬜ | onSurface | `#1A2129` | ⬛ |
| surfaceVariant | `#EEF1F4` | ⬜ | muted | `#5B6571` | ◼ |
| surfaceElevated | `#FFFFFF` | ⬜ | outline | `#D7DCE2` | ◻ |
| primary | `#0E8F6E` | 🟩 | outlineStrong | `#BCC4CD` | ◻ |
| primaryHover | `#0B7559` | 🟩 | focusRing | `#0E8F6E` | 🟩 |
| primaryPressed | `#095F49` | 🟩 | success | `#0E8F6E` | 🟩 |
| onPrimary | `#FFFFFF` | ⬜ | warning | `#B7791F` | 🟧 |
| secondary | `#1F6FEB` | 🟦 | danger | `#C13C37` | 🟥 |
| accent | `#0E8F6E` | 🟩 | glassTint | `#FFFFFFCC` | ⬜ |
| accentSoft | `#D6F2E8` | 🟩 | codeText | `#3A4452` | ◼ |
| | | | folio | `#9AA4B0` | ◻ |

**Light category hues** (darkened to ~4.5:1 on `#FFFFFF`):
| catEcommerce | catGames | catBooking | catBusiness | catFood | catServices | catMedical | catEducation | catTravel |
|---|---|---|---|---|---|---|---|---|
| `#0E8F6E` | `#C2410C` | `#0E7490` | `#1F6FEB` | `#B45309` | `#2563EB` | `#0D9488` | `#6D28D9` | `#0891B2` |

#### Dark palette (`#0A0C10` canvas — default)

| Token | Hex | Swatch | Token | Hex | Swatch |
|---|---|---|---|---|---|
| background | `#0A0C10` | ⬛ | onBackground | `#E6EDF3` | ⬜ |
| surface | `#10141A` | ⬛ | onSurface | `#C9D1D9` | ◻ |
| surfaceVariant | `#161B22` | ⬛ | muted | `#8B97A5` | ◼ |
| surfaceElevated | `#1B222B` | ⬛ | outline | `#222A33` | ◼ |
| primary | `#3DF5A3` | 🟩 | outlineStrong | `#303A45` | ◼ |
| primaryHover | `#56FFB4` | 🟩 | focusRing | `#3DF5A3` | 🟩 |
| primaryPressed | `#2BD98C` | 🟩 | success | `#3DF5A3` | 🟩 |
| onPrimary | `#04130C` | ⬛ | warning | `#E3B341` | 🟨 |
| secondary | `#5AA2FF` | 🟦 | danger | `#FF6B6B` | 🟥 |
| accent | `#3DF5A3` | 🟩 | glassTint | `#10141ACC` | ⬛ |
| accentSoft | `#0F2A20` | 🟩 | codeText | `#7EE3B8` | 🟩 |
| glow | `#3DF5A340` | 🟩 | folio | `#5A6470` | ◼ |

**Dark category hues** (brightened for use on `#10141A`):
| catEcommerce | catGames | catBooking | catBusiness | catFood | catServices | catMedical | catEducation | catTravel |
|---|---|---|---|---|---|---|---|---|
| `#3DF5A3` | `#FB923C` | `#22D3EE` | `#5AA2FF` | `#FBBF24` | `#60A5FA` | `#2DD4BF` | `#A78BFA` | `#38BDF8` |

### 3.2 Typography & Type Scale

**Fonts** (via `google_fonts`; weight subset: Space Grotesk 500/600/700, Inter 400/500/600, JetBrains Mono 400/500):
- **Display — Space Grotesk** (geometric technical display): hero, section titles, app names.
- **Body — Inter** (readable web body): narrative, descriptions, labels.
- **Mono — JetBrains Mono** (engineer-signal): eyebrows, category tags, folio/index numbers 01-37 / section folios 00-10, store IDs, dates, versions, terminal status line.

> Playfair-style serif was rejected — mono + geometric-sans is more credible for a Flutter lead.

| Style | Family | Size | Weight | Line height | Letter-spacing | Notes |
|---|---|---|---|---|---|---|
| displayHero | Space Grotesk | `clamp(48→88)` fluid | 600 | 1.02 | -1.5 | one-time clip reveal |
| displaySection | Space Grotesk | 36 | 600 | 1.1 | -0.5 | |
| title | Space Grotesk | 22 | 600 | 1.25 | -0.2 | app/card names |
| eyebrowMono | JetBrains Mono | 14 | 500 | 1.3 | 0.5 | UPPERCASE |
| body | Inter | 17 | 400 | 1.65 | — | max 62ch |
| bodySmall | Inter | 15 | 400 | 1.55 | — | |
| label | Inter | 13 | 500 | 1.3 | 0.3 | |
| folioMono | JetBrains Mono | 12 | 500 | 1.2 | 0.5 | index 01-37 / folios 00-10, folio color |
| captionMono | JetBrains Mono | 12 | 400 | 1.4 | — | store ids, dates, versions, muted |

> Display steps modular ~1.5; text steps ~1.2. Sizes are base desktop values; the sizeHelper applies fluid `clamp()` between mobile and 1024px.

### 3.3 Spacing, Radii & Layout

Exposed via an **`AppSpacing` class + ThemeExtension** — never inline literals.

- **Base unit:** 8. **Tokens:** `xs 4`, `sm 8`, `md 16`, `lg 24`, `xl 40`, `xxl 64`, `sectionDesktop 96`, `sectionMobile 56`.
- **Radii:** `pill 999`, `card 16`, `chip 8`, `input 10`.
- **Layout:** `maxContentWidth 1200`; gutters `24` mobile / `64` desktop; grid 12-col desktop / 6-col tablet / 1-2 col mobile; **appGrid** 3 desktop / 2 tablet / 1 mobile, 20px gap; persistent **folio column** carries the section number + running head, sticky on desktop, collapses on mobile.
- **Breakpoints:** mobile `<600`, tablet `600-1024`, desktop `>1024` (via sizeHelper).

### 3.4 Component Styles

- **Primary button** — fill `primary`, text `onPrimary`, radius 10, padding V14/H24, label 15/600; hover → `primaryHover` over 120ms; pressed `primaryPressed`; focus 2px `focusRing` offset 2px; disabled 40% opacity.
- **Secondary ghost button** — transparent, 1px `outlineStrong`, text `onSurface`, radius 10; hover border+text → `primary` (120ms). Used for *Download CV / Resume*, *View Work* alt.
- **Text link** — color `onSurface`, underline in `primary`; underline **wipe-in left-to-right 200ms** on hover.
- **Project card** — surface `#10141A`/`#FFFFFF`, 1px `outline` border, radius 16, padding 20; 3px category-hue **left accent line** hidden by default, animates in from top on hover/focus; top row = app name (title) + right-aligned mono category tag; mid = one-line role descriptor; bottom = mono platform pills + conditional store icon buttons (rendered **only** when the link exists). Hover: lift 4px (`AnimatedContainer` 160ms easeOut) + soft shadow / faint emerald glow (dark) + outline → `outlineStrong` + accent line draws in + store labels fade in. Focus: visible emerald ring, keyboard-activatable.
- **List row** (grafted from Quiet Index — the **default** Work view): mono index 01-37 flush left (folio color + category-hue dot), app name in Space Grotesk title, category as mono tag, platform availability as right-aligned mono text; single 1px hairline separator. Hover: index+name recolor toward category hue, name nudges 6px right (easeOut), inline `open →` store affordance fades in.
- **Skill chip** — glass pill (radius 999), `surfaceVariant` translucent, 1px outline, label 13.
- **Filter pill** — pill radius 999; inactive = `surfaceVariant` bg + muted text + 1px outline; active = category-hue text + `accentSoft` bg + hue border (emerald for "All"). Used in the sticky category bar + iOS/Android toggle.
- **Platform pill** — small mono pill radius 8, JetBrains Mono 12, muted (iOS / Android badges).
- **Navbar** — fixed glass; **glassmorphism reserved exclusively for the nav** (backdrop blur + `glassTint`). Layout: mono wordmark `ahmed.maher` left, anchor links center, theme toggle + *Download CV* ghost button right. On scroll past hero the hairline bottom border gains a faint emerald glow (`AnimatedContainer` blur/border transition). Mobile collapses to wordmark + menu with links in a slide-over.

### 3.5 Motion

Premium and restrained, never bouncy. All durations/curves live in a **`MotionTokens`** ThemeExtension — no inline literals.

- **Entrance:** sections reveal on scroll — 16px upward translate + opacity fade, **480ms easeOutCubic**, ~60ms stagger per child in grids/lists (triggers once).
- **Hero headline:** one-time mask/clip reveal on first load.
- **Hairlines:** section-opener rules draw in horizontally (`scaleX 0→1`, **600ms**) as the section enters.
- **Counters:** stats tween 0→value over **1200ms** on scroll-in.
- **Hover:** cards lift 160ms easeOut (shadow + accent-line draw); list rows shift 6px + recolor; buttons shift bg 120ms; text-link underline wipes in 200ms.
- **Nav:** glass blur/border-glow transition on scroll past hero.
- **View toggle:** List ↔ Grid uses `AnimatedSwitcher` + implicit layout animation.
- **Theme:** `AnimatedTheme` cross-fades the whole `ColorScheme` over **300ms**.
- **Reduced motion:** respect `prefers-reduced-motion` (`MediaQuery.disableAnimations` / `accessibleNavigation`) — disable translate/clip/scaleX reveals and counter tweens (jump to final value), keep opacity-only fades, freeze caret/dot pulse.

### 3.6 Signature Elements

- Single electric-emerald signal accent (`#3DF5A3` dark / `#0E8F6E` light), used surgically — status dots, hover accent lines, focus rings, active filter — never as large fills.
- A monospace **engineer-signal system**: eyebrows, category tags, folio/index numbers, store IDs, dates and versions all in JetBrains Mono, like code comments annotating the design.
- The 37 apps presented as a literal numbered **INDEX (01-37)** — a default dense ruled list with a toggle to a card grid. The breadth of work *is* the hero visual.
- Restrained **per-category hue system** — a tiny category-colored accent line/dot/tag per app so the catalog reads as varied at a glance (AA-safe solid colors, not gradients).
- Persistent mono **folio numbers (00-10)** anchored in a sticky left-margin column as editorial running heads.
- Live **terminal "build status" strip** in the hero with blinking caret + pulsing emerald dot.
- Hairline 1px borders + faint emerald glow on dark instead of heavy shadows — **elevation by light, not by drop shadow**.
- Glassmorphism reserved exclusively for the floating nav so it stays special.
- **Store-aware** project cards/rows that conditionally render App Store / Google Play links based on which links exist in the data.
- Animated **count-up metrics** (37 / 5+ / 15 / 8) reinforcing the "ships to production" thesis.
- A real Flutter-Web **colophon** in the footer crediting the typefaces and the Clean Architecture build.

---

## 4. Information Architecture / Page Sections

Single long-scroll page composed of 11 sections (folios `00`–`10`). Each is a self-contained widget wrapped by a shared `SectionScaffold` / `SectionShell` that renders the sticky left **folio column** (mono number + running head, collapses below tablet), the in-view entrance animation, and the horizontal hairline opener. All section copy/data flows from the domain layer; nothing is inlined in widgets. Global layout invariants from `AppSpacing`: `maxContentWidth = 1200`, gutters `24` mobile / `64` desktop, vertical section padding `96` desktop / `56` mobile.

| Folio | Section | Layout spec | Data consumed |
|---|---|---|---|
| `00` | **Nav** (fixed glass) | Full-width glass bar (blur + `glassTint`). Mono wordmark `ahmed.maher` left; center anchors (About · Work · Experience · Contact); right `ThemeCubit` toggle + **language toggle (EN ⇄ ع, `LocaleCubit`)** + ghost **Download CV**. Hairline bottom border gains emerald glow once scrolled past hero. | Static nav model, `cvAssetPath`, current `ThemeMode` + `Locale`. |
| `01` | **Hero** | Full-viewport (`100vh`) dark canvas. Mono eyebrow `// flutter team lead — 6th october city, eg`; `displayHero` headline; Inter summary (≤62ch); primary **View Work** + ghost **Download Resume**; terminal status strip with blinking caret + pulsing emerald dot: `> apps_shipped: 37 | platforms: ios + android | status: live`. Faint dot-grid + single top-left radial emerald glow, no particles. | `Profile`, `apps.length` (37), `cvAssetPath`. |
| `02` | **Stats band** | 4-up hairline-celled metrics (1 col mobile / 2 tablet / 4 desktop). Mono counters count up on scroll-in. | `Stats`: **37 Published Apps, 5+ Years Flutter, 15 Yrs Data Engineering, 8 Countries**. |
| `03` | **About** | Two-column: left sticky folio + Flutter-lead narrative with the 15-yr Oil & Gas career-switch **pull quote**; right `career.log` monospace timeline. One column on mobile. | `Profile.summary`, condensed `Experience` for the log. |
| `04` | **Skills matrix** | Grouped glass capability chips on a precise grid; group label = `eyebrowMono`. | `SkillGroup[]`: Languages, State Mgmt, Backend/APIs, Architecture & Quality, Tooling. |
| `05` | **The Index (Work)** — **centerpiece** | Sticky category filter bar (All, E-commerce, Games, Booking, Business, Services, Food, Medical, Education, Travel) + iOS/Android toggle + search field. **Default: dense numbered LIST** `01-37`; toggle to masonry **card grid**. Both bound to one `ProjectsCubit` filtered list. | `List<AppProject>` (37), `ProjectFilter`, `CategoryColors`. |
| `06` | **Featured spotlight** | 2-3 flagship apps in larger split cards (image/placeholder + meta), category + platform badges + dual store buttons. | Featured subset (see §6). |
| `07` | **Experience** | Stacked role cards; company/location/date-range as mono chips; bullet outcomes. | `Experience[]`: Baramjk, Spark Systems, Oil & Gas. |
| `08` | **Education** | Compact single line. | B.Sc. Chemistry & Geology, Cairo University, 2001-2006. |
| `09` | **Contact** | Dark panel; mono `get in touch` eyebrow; large email link, phone, location, language fluency; minimal name/email/message form wired to **optional Dio-backed endpoint** via `SendMessage`. | `Profile` contact fields, `ContactMessage`. |
| `10` | **Footer / Colophon** | Mono wordmark, `Built with Flutter Web · Clean Architecture`, typeface credit, back-to-top, `© {currentYear} Ahmed Maher`. | Static colophon, `DateTime.now().year`. |

---

## 5. Clean Architecture — Project Structure

**Layering rule:** `presentation → domain ← data`. Domain depends on nothing (pure Dart + dartz). Data depends on domain (implements its repos, maps models → entities). Presentation depends on domain only (Cubits call use cases, never repos/data sources). DI is the only place all three meet.

### 5.1 Folder tree

```
lib/
├── main.dart                              # entrypoint: calls bootstrap()
├── bootstrap.dart                         # async pre-run: binding, DI, prefs, url strategy, error zone
│
├── app/
│   ├── portfolio_app.dart                 # root MaterialApp.router; AnimatedTheme; ThemeCubit + GoRouter
│   └── view/app_observer.dart             # BlocObserver (web console debug logging)
│
├── core/
│   ├── abstract/
│   │   └── base_cubit.dart                # BaseCubit<T> = Cubit<T> + emit guard (isClosed). EVERY cubit extends this.
│   │
│   ├── theme/
│   │   ├── app_theme.dart                 # AppTheme.light / AppTheme.dark -> ThemeData
│   │   ├── app_color_scheme.dart          # ColorScheme.light/dark from design-system hex (single source)
│   │   ├── app_text_theme.dart            # TextTheme via google_fonts (Space Grotesk / Inter / JetBrains Mono)
│   │   ├── tokens/
│   │   │   ├── app_spacing.dart           # ThemeExtension: xs..xxl, sectionDesktop/Mobile, gutters
│   │   │   ├── app_radii.dart             # ThemeExtension: pill/card/chip/input
│   │   │   ├── category_colors.dart       # ThemeExtension: per-category AA-safe solid hues (light+dark)
│   │   │   ├── motion_tokens.dart         # ThemeExtension: durations + curves (no inline literals)
│   │   │   └── app_typography.dart        # named TextStyle getters (displayHero, eyebrowMono, folioMono...)
│   │   └── theme_extensions.dart          # barrel + BuildContext getters (context.spacing, context.cat, context.motion)
│   │
│   ├── responsive/
│   │   ├── app_breakpoints.dart           # mobile<600 / tablet 600-1024 / desktop>1024 / wide>1440
│   │   ├── responsive.dart                # Responsive<T>(mobile,tablet,desktop) + context.bp resolver
│   │   ├── responsive_layout.dart         # ResponsiveLayout widget (picks subtree by breakpoint)
│   │   └── screen_util_init.dart          # ScreenUtilInit wrapper = the mandated "sizeHelper" boundary
│   │
│   ├── di/
│   │   ├── injection.dart                 # @InjectableInit getIt; configureDependencies()
│   │   ├── injection.config.dart          # GENERATED (injectable_generator)
│   │   └── register_module.dart           # @module: Dio, SharedPreferences, AssetBundle
│   │
│   ├── router/
│   │   ├── app_router.dart                # GoRouter: single '/' route + hash anchors (deep /work/:id later)
│   │   └── app_routes.dart                # route name + path constants
│   │
│   ├── network/
│   │   ├── dio_client.dart                # configured Dio (base options, interceptors) — reserved for contact POST
│   │   ├── api_endpoints.dart             # endpoint constants (optional contact endpoint)
│   │   └── interceptors/logging_interceptor.dart
│   │
│   ├── error/
│   │   ├── failures.dart                  # sealed Failure hierarchy (Equatable)
│   │   └── exceptions.dart                # CacheException / AssetException / ServerException
│   │
│   ├── usecase/usecase.dart               # abstract UseCase<Output, Params> + SyncUseCase + NoParams
│   │
│   ├── constants/
│   │   ├── app_assets.dart                # asset paths (apps.json, profile.json, CV pdf, store SVGs)
│   │   └── app_strings.dart               # static const i18n KEYS (e.g. heroTitle = 'hero.title') -> AppStrings.x.tr(); never inline raw key literals
│   │
│   ├── localization/
│   │   ├── locale_cubit.dart              # active Locale (en/ar) + persistence; drives language toggle + RTL
│   │   └── locale_state.dart              # Freezed union
│   │
│   ├── utils/
│   │   ├── typedefs.dart                  # ResultFuture<T>, ResultVoid, DataMap
│   │   └── store_link_builder.dart        # build App Store / Google Play URLs from raw ids
│   │
│   └── widgets/                           # atomic design-system widgets (App* convention, theme-driven, zero hardcoded values)
│       ├── app_button.dart                # AppButton{.primary/.ghost} — use instead of raw Elevated/OutlinedButton
│       ├── app_text_field.dart            # AppTextField — contact form (instead of raw TextFormField)
│       ├── app_text_link.dart             # wipe-in underline link
│       ├── app_filter_chip.dart           # category/platform filter pill
│       ├── app_platform_chip.dart         # iOS / Android badge
│       ├── app_skill_chip.dart            # glass skill pill
│       ├── glass_nav_container.dart       # the one glassmorphism surface (nav)
│       ├── folio_label.dart               # sticky margin mono folio (00-10), start-aligned (RTL-mirrored)
│       ├── section_scaffold.dart          # folio column + content + scaleX hairline opener
│       ├── reveal_on_scroll.dart          # visibility_detector + flutter_animate entrance, reduced-motion aware
│       └── terminal_status_strip.dart     # blinking caret + pulsing emerald dot
│
├── features/
│   ├── projects/                          # "The Index" — CENTERPIECE (37 apps)
│   │   ├── domain/
│   │   │   ├── entities/{app_project.dart, app_category.dart, app_platform.dart, store_link.dart}
│   │   │   ├── repositories/projects_repository.dart
│   │   │   └── usecases/{get_projects.dart, filter_projects.dart, get_featured_projects.dart}
│   │   ├── data/
│   │   │   ├── datasources/projects_local_data_source.dart   # reads assets/data/apps.json
│   │   │   ├── models/{app_project_model.dart, store_link_model.dart}
│   │   │   └── repositories/projects_repository_impl.dart     # try->Right / Exception->Left(Failure)
│   │   └── presentation/
│   │       ├── cubit/{projects_cubit.dart, projects_state.dart}
│   │       ├── pages/index_section.dart                       # sticky filter bar + List<->Grid switcher
│   │       └── widgets/{project_list_row.dart, project_card.dart, category_filter_bar.dart,
│   │                    platform_toggle.dart, view_mode_toggle.dart, featured_spotlight.dart}
│   │
│   ├── profile/                           # Hero + Stats + About + Skills + Education
│   │   ├── domain/
│   │   │   ├── entities/{profile.dart, skill_group.dart, education.dart, stat_metric.dart}
│   │   │   ├── repositories/profile_repository.dart
│   │   │   └── usecases/get_profile.dart                      # UseCase<Profile, NoParams>
│   │   ├── data/
│   │   │   ├── datasources/profile_local_data_source.dart     # assets/data/profile.json
│   │   │   ├── models/{profile_model.dart, skill_group_model.dart, education_model.dart}
│   │   │   └── repositories/profile_repository_impl.dart
│   │   └── presentation/
│   │       ├── cubit/{profile_cubit.dart, profile_state.dart}
│   │       └── widgets/{hero_section.dart, stats_band.dart, about_section.dart,
│   │                    skills_matrix.dart, education_line.dart}
│   │
│   ├── experience/                        # section 07
│   │   ├── domain/{entities/experience_item.dart, repositories/experience_repository.dart,
│   │   │           usecases/get_experience.dart}
│   │   ├── data/{datasources/experience_local_data_source.dart, models/experience_item_model.dart,
│   │   │          repositories/experience_repository_impl.dart}
│   │   └── presentation/{cubit/{experience_cubit.dart, experience_state.dart},
│   │                      widgets/{experience_section.dart, role_card.dart}}
│   │
│   └── contact/                           # section 09 (Dio-backed optional POST)
│       ├── domain/
│       │   ├── entities/{contact_info.dart, contact_message.dart}
│       │   ├── repositories/contact_repository.dart
│       │   └── usecases/{get_contact_info.dart, send_message.dart}   # UseCase<Unit, ContactMessage>
│       ├── data/
│       │   ├── datasources/{contact_local_data_source.dart, contact_remote_data_source.dart}
│       │   ├── models/contact_message_model.dart
│       │   └── repositories/contact_repository_impl.dart
│       └── presentation/{cubit/{contact_cubit.dart, contact_state.dart},
│                          widgets/{contact_section.dart, contact_form.dart}}
│
└── shared/
    └── navigation/                        # cross-cutting scroll/nav (pure presentation, no domain layer)
        ├── cubit/{navigation_cubit.dart, navigation_state.dart}
        └── widgets/{glass_navbar.dart, nav_links.dart, theme_toggle.dart, language_toggle.dart,
                      mobile_menu_drawer.dart, footer_colophon.dart}

assets/
├── data/{apps.json, profile.json}
├── docs/{Ahmed_Maher_cv.pdf, Ahmed_Maher_Portfolio.pdf}     # copied from repo root
├── translations/{en.json, ar.json}                          # easy_localization (key parity enforced)
├── icons/{app_store.svg, google_play.svg}
└── images/{og-image.png, avatar.png, projects/_placeholder.png, projects/<id>.png ...}

scripts/
└── check_design_tokens.sh                                   # CI gate: no Color(0x)/Colors.* in features; .sp/.w/.h/.r; start/end (RTL); prefer App* widgets; .tr() on user-facing Text

test/
├── core/usecase/usecase_test.dart
├── features/projects/{domain/usecases/get_projects_test.dart,
│                      data/repositories/projects_repository_impl_test.dart,   # mocktail
│                      presentation/cubit/projects_cubit_test.dart}            # bloc_test
└── ... (mirror per feature)
```

### 5.2 Base generic `UseCase`, `NoParams`, `Failure`, typedefs

`core/usecase/usecase.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clever_portfolio/core/error/failures.dart';

/// Generic base contract. Every use case is callable and returns
/// Either<Failure, Output>. Output = success payload, Params = input.
abstract class UseCase<Output, Params> {
  const UseCase();
  Future<Either<Failure, Output>> call(Params params);
}

/// Synchronous variant for pure in-memory transforms (e.g. filtering an
/// already-loaded list) where no async/IO boundary exists.
abstract class SyncUseCase<Output, Params> {
  const SyncUseCase();
  Either<Failure, Output> call(Params params);
}

/// Sentinel for parameterless use cases (e.g. GetProjects, GetProfile).
class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => const [];
}
```

`core/error/failures.dart`

```dart
import 'package:equatable/equatable.dart';

/// Sealed root so exhaustive `switch` in the UI is analyzer-enforced.
sealed class Failure extends Equatable {
  const Failure({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

final class AssetFailure extends Failure {        // local asset / JSON load or parse
  const AssetFailure({super.message = 'Could not load local content.'});
}
final class CacheFailure extends Failure {        // SharedPreferences (theme mode)
  const CacheFailure({super.message = 'Local storage error.'});
}
final class ServerFailure extends Failure {       // Dio (contact-form POST)
  const ServerFailure({required super.message, this.statusCode});
  final int? statusCode;
  @override
  List<Object?> get props => [message, statusCode];
}
final class NetworkFailure extends Failure {      // no connectivity on POST
  const NetworkFailure({super.message = 'No internet connection.'});
}
final class ValidationFailure extends Failure {   // client-side contact form validation
  const ValidationFailure({required super.message});
}
```

`core/utils/typedefs.dart`

```dart
import 'package:dartz/dartz.dart';
import 'package:clever_portfolio/core/error/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, Unit>>; // dartz Unit for "void success"
typedef DataMap = Map<String, dynamic>;
```

A concrete use case (`features/projects/domain/usecases/get_projects.dart`):

```dart
@injectable
class GetProjects extends UseCase<List<AppProject>, NoParams> {
  const GetProjects(this._repository);
  final ProjectsRepository _repository;

  @override
  ResultFuture<List<AppProject>> call(NoParams params) => _repository.getProjects();
}
```

`FilterProjects` extends `SyncUseCase<List<AppProject>, ProjectFilter>` (pure in-memory: category + platform + search), always yielding `Right(filtered)` but staying inside the `Either` contract for uniformity.

### 5.3 Repository + data-source pattern (local-first, dartz everywhere, Dio reserved)

All static content ships as **bundled JSON assets** parsed in the data-source layer — no remote dependency for the core site. Data sources throw typed `Exception`s; repository impls catch them and return `Left(Failure)`; success is `Right(entity)`. Cubits only ever see `Either<Failure, T>` and `fold(...)` it into states. `dartz` is therefore the single error-handling currency across every feature, satisfying the mandate even though most data is static.

Why JSON-as-asset over a `const` Dart list: the data-source boundary stays real (async `rootBundle.loadString` + `jsonDecode`), so the `Either` error path is genuinely exercisable and unit-testable, and content edits don't require recompiling logic.

```dart
// domain/repositories/projects_repository.dart  (pure: returns Either)
abstract class ProjectsRepository {
  ResultFuture<List<AppProject>> getProjects();
  ResultFuture<List<AppProject>> getFeaturedProjects();
}
```

```dart
// data/datasources/projects_local_data_source.dart
abstract class ProjectsLocalDataSource {
  Future<List<AppProjectModel>> getProjects(); // throws AssetException on failure
}

@LazySingleton(as: ProjectsLocalDataSource)
class ProjectsLocalDataSourceImpl implements ProjectsLocalDataSource {
  const ProjectsLocalDataSourceImpl(this._bundle);
  final AssetBundle _bundle;

  @override
  Future<List<AppProjectModel>> getProjects() async {
    try {
      final raw = await _bundle.loadString(AppAssets.appsJson);
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => AppProjectModel.fromJson(e as DataMap))
          .toList(growable: false);
    } on Object catch (e, s) {
      throw AssetException('apps.json parse failed: $e', s);
    }
  }
}
```

```dart
// data/repositories/projects_repository_impl.dart  — the Exception -> Failure boundary
@LazySingleton(as: ProjectsRepository)
class ProjectsRepositoryImpl implements ProjectsRepository {
  const ProjectsRepositoryImpl(this._local);
  final ProjectsLocalDataSource _local;

  @override
  ResultFuture<List<AppProject>> getProjects() async {
    try {
      final models = await _local.getProjects();
      return Right(models.map((m) => m.toEntity()).toList(growable: false));
    } on AssetException catch (e) {
      return Left(AssetFailure(message: e.message));
    }
  }

  @override
  ResultFuture<List<AppProject>> getFeaturedProjects() async =>
      (await getProjects()).map(
        (all) => all.where((p) => p.featured).toList(growable: false),
      );
}
```

This canonical pattern repeats across `profile`, `experience`, `contact` (local). **Store URLs are not stored** — only raw ids live in JSON; `core/utils/store_link_builder.dart` produces `https://apps.apple.com/us/app/id<rawId>` and `https://play.google.com/store/apps/details?id=<rawId>`, so cards/rows render a store button **only when the corresponding raw id exists** (store-aware rendering per design system).

**How mandated Dio is wired pragmatically.** Dio is **not** used for static content (assets cover that). It is reserved and fully wired for the **one genuine network surface — the contact form** (section 09), plus future remote content (e.g. a CMS-served `apps.json`):

```dart
// core/network/dio_client.dart
@lazySingleton
class DioClient {
  DioClient(this._dio) {
    _dio
      ..options = BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,           // env-injected; empty disables remote
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      )
      ..interceptors.add(LoggingInterceptor());
  }
  final Dio _dio;

  ResultFuture<Unit> post(String path, {required DataMap body}) async {
    try {
      await _dio.post(path, data: body);
      return const Right(unit);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) return const Left(NetworkFailure());
      return Left(ServerFailure(message: e.message ?? 'Request failed',
        statusCode: e.response?.statusCode));
    }
  }
}
```

`SendMessage` (`UseCase<Unit, ContactMessage>`) validates input in-domain (`Left(ValidationFailure)` on bad email/empty message) before delegating to `ContactRemoteDataSource → DioClient.post`. If no endpoint is configured, `ContactRepositoryImpl` short-circuits to a graceful `Left(ServerFailure)` / mailto fallback — keeping the Dio dependency real and load-bearing, not decorative.

### 5.4 Cubits (flutter_bloc)

All Cubit states are **Freezed unions** (`@freezed` — sealed under the hood, so exhaustive `switch`/`when` plus free `copyWith` + value equality), and **every cubit extends `BaseCubit<T>`** (never `Cubit<T>` directly) so `emit` is guarded against post-close `isClosed`.

```dart
// core/abstract/base_cubit.dart  — house rule: all cubits extend this
abstract class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);
  @override
  void emit(T state) { if (!isClosed) super.emit(state); }
}
```

**`ThemeCubit extends BaseCubit<ThemeState>`** — light/dark + persistence:
```dart
@freezed
sealed class ThemeState with _$ThemeState {
  const factory ThemeState.initial() = ThemeInitial;          // resolves dark-first
  const factory ThemeState.loaded(ThemeMode mode) = ThemeLoaded;
}
```
Reads persisted mode on init via `GetThemeMode` (SharedPreferences, `Either<CacheFailure, ThemeMode>`); first load with no stored choice follows system brightness, then persists explicit toggles. `toggle()` flips mode, emits `ThemeLoaded`, fires `SaveThemeMode`. `AnimatedTheme` cross-fades the `ColorScheme` (300ms).

**`ProjectsCubit extends BaseCubit<ProjectsState>`** — load + category/platform/search filter + view mode:
```dart
enum ProjectViewMode { list, grid }

@freezed
sealed class ProjectsState with _$ProjectsState {
  const factory ProjectsState.initial() = ProjectsInitial;
  const factory ProjectsState.loading() = ProjectsLoading;
  const factory ProjectsState.error(Failure failure) = ProjectsError;
  const factory ProjectsState.loaded({
    required List<AppProject> all,
    required List<AppProject> visible,
    AppCategory? activeCategory,                              // null == "All"
    AppPlatform? activePlatform,                             // null == both
    @Default('') String query,
    @Default(ProjectViewMode.list) ProjectViewMode viewMode, // default dense list
  }) = ProjectsLoaded;
}
```
`load() → GetProjects(NoParams())`, folds to `ProjectsLoaded`/`ProjectsError`. `setCategory/setPlatform/search` recompute `visible` via `FilterProjects` + Freezed's free `copyWith` (no reload). `toggleViewMode` flips list↔grid (drives `AnimatedSwitcher`).

**`NavigationCubit extends BaseCubit<NavigationState>`** — active section + scroll + nav glass:
```dart
@freezed
sealed class NavigationState with _$NavigationState {
  const factory NavigationState({
    @Default(SectionId.hero) SectionId activeSection, // hero, stats, about, skills, index, featured, experience, education, contact
    @Default(false) bool navElevated,                 // scrolled past hero -> glass border gains emerald glow
  }) = _NavigationState;
}
```
Driven by scroll/`VisibilityDetector`. `scrollTo(SectionId)` animates to the anchor and updates the GoRouter location hash for deep links.

**`ContactCubit extends BaseCubit<ContactState>`** — form lifecycle (Dio-backed), Freezed union: `ContactIdle / ContactSubmitting / ContactSuccess / ContactFailure(Failure)`. `submit(ContactMessage) → SendMessage`. `ContactInfo` loaded once via `GetContactInfo` so the panel renders independent of network state.

**`LocaleCubit extends BaseCubit<LocaleState>`** — holds the active `Locale` (en/ar), persists it via `shared_preferences`, and is dispatched by the navbar language toggle; `EasyLocalization` + `MaterialApp.locale` react to it (§7.1).

> `ProfileCubit` and `ExperienceCubit` are Freezed unions of the same trivial `initial / loading / loaded(entity) / error(failure)` shape (single load via a `NoParams` use case), each extending `BaseCubit`.

### 5.5 Dependency injection + bootstrap

**`get_it` + `injectable`** (codegen). One `getIt`; everything annotated.

```dart
// core/di/injection.dart
final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true, asExtension: false)
Future<void> configureDependencies() async => init(getIt);
```
```dart
// core/di/register_module.dart
@module
abstract class RegisterModule {
  @lazySingleton Dio get dio => Dio();
  @lazySingleton AssetBundle get assetBundle => rootBundle;
  @preResolve @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
```
`@LazySingleton(as: ...)` on every repository impl + data source; `@injectable` on use cases; Cubits `@injectable` (factory) so each `BlocProvider` gets a fresh instance. `injectable_generator` emits `injection.config.dart` via `build_runner`.

```dart
// main.dart / bootstrap.dart
Future<void> main() async => bootstrap();

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();   // load translation assets (en/ar)
  Bloc.observer = AppObserver();
  await configureDependencies();      // awaits @preResolve prefs
  setUrlStrategy(PathUrlStrategy());  // clean web URLs
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const PortfolioApp(),
    ),
  );
}
```
```dart
// app/portfolio_app.dart
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => getIt<ThemeCubit>()..load()),
      BlocProvider(create: (_) => getIt<LocaleCubit>()..load()),
      BlocProvider(create: (_) => getIt<NavigationCubit>()),
      BlocProvider(create: (_) => getIt<ProjectsCubit>()..load()),
      BlocProvider(create: (_) => getIt<ProfileCubit>()..load()),
      BlocProvider(create: (_) => getIt<ExperienceCubit>()..load()),
      BlocProvider(create: (_) => getIt<ContactCubit>()),
    ],
    child: BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) => ScreenUtilInit(   // the mandated "sizeHelper" boundary
        designSize: const Size(1440, 1024),          // desktop-first base
        minTextAdapt: true,
        builder: (_, __) => MaterialApp.router(
          title: 'Ahmed Maher — Flutter Team Lead',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: state.mode,
          // easy_localization (en/ar) + automatic RTL Directionality:
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,                  // tracks LocaleCubit via context.setLocale
          routerConfig: getIt<AppRouter>().config,
        ),
      ),
    ),
  );
}
```

---

## 6. Data Models & Content Inventory

### 6.1 Domain entities

These live in `lib/features/.../domain/entities/`. Pure, immutable value objects (`const`, value equality), **no** UI/framework imports.

```dart
// ───────────────────────── Enums / Taxonomy ─────────────────────────
enum AppPlatform { android, ios }

extension AppPlatformX on AppPlatform {
  String get label => switch (this) {
    AppPlatform.android => 'Android',
    AppPlatform.ios     => 'iOS',
  };
}

/// Top-level filter buckets. `label` is the chip text; declaration order = chip order.
enum AppCategory {
  ecommerce('E-commerce'),
  gamesTrivia('Games / Trivia'),
  bookingReservations('Booking & Reservations'),
  businessAdmin('Business & Admin'),
  services('Services'),
  foodAndDiet('Food & Diet'),
  education('Education'),
  travel('Travel'),
  medical('Medical'),
  community('Community / Sports');
  const AppCategory(this.label);
  final String label;
}

// ───────────────────────── Core entities ─────────────────────────
class AppProject {
  const AppProject({
    required this.id,            // stable slug, e.g. 'sphoto'
    required this.name,          // 'Sphoto'
    required this.tagline,       // one-line role descriptor
    required this.category,
    required this.platforms,     // List<AppPlatform>, never empty
    this.androidUrl,             // full https Play URL or null
    this.iosUrl,                 // full https App Store URL or null
    this.bundleId,               // android package id
    this.iconAsset,              // 'assets/images/projects/sphoto.png' or null (placeholder)
    this.accentColor,            // ARGB int (NOT dart:ui Color — keeps entity framework-free)
    this.featured = false,
  });
  final String id, name, tagline;
  final AppCategory category;
  final List<AppPlatform> platforms;
  final String? androidUrl, iosUrl, bundleId, iconAsset;
  final int? accentColor;
  final bool featured;

  bool get isAndroid => platforms.contains(AppPlatform.android);
  bool get isIos => platforms.contains(AppPlatform.ios);
  bool get isCrossPlatform => isAndroid && isIos;
}

class Profile {
  const Profile({required this.name, required this.title, required this.location,
    required this.email, required this.phone, required this.summary,
    required this.languages, required this.socialLinks});
  final String name, title, location, email, phone, summary;
  final List<LanguageProficiency> languages;
  final List<SocialLink> socialLinks;
}

class LanguageProficiency {
  const LanguageProficiency({required this.language, required this.level});
  final String language, level; // 'Arabic' / 'Native'
}

enum SocialPlatform { email, phone, github, linkedin, playStore, appStore, website }
class SocialLink {
  const SocialLink({required this.platform, required this.url, this.label});
  final SocialPlatform platform;
  final String url; final String? label;
}

class Skill {
  const Skill({required this.name, this.proficiency});
  final String name; final double? proficiency; // 0..1, optional meter
}
class SkillGroup {
  const SkillGroup({required this.title, required this.skills});
  final String title; final List<Skill> skills;
}

class ExperienceItem {
  const ExperienceItem({required this.role, required this.company, required this.location,
    required this.period, required this.bullets, this.isCurrent = false});
  final String role, company, location, period;
  final List<String> bullets;
  final bool isCurrent;
}

class EducationItem {
  const EducationItem({required this.degree, required this.institution,
    required this.period, this.grade});
  final String degree, institution, period; final String? grade;
}

class StatMetric {
  const StatMetric({required this.value, required this.label, this.suffix = ''});
  final int value; final String label, suffix; // 37 / 5+ / 15 / 8
}
```

> **`accentColor` is `int?` (ARGB)** so the entity stays free of `dart:ui`/Flutter. Presentation maps it to a `Color` blended against `Theme.of(context).colorScheme` — per the no-hardcoded-colors rule, per-card accents are *data*, not literals in widgets, and both themes stay consistent. In practice each card's accent comes from `CategoryColors.forCategory(category)` so explicit `accentColor` overrides are rarely needed.

### 6.2 Category taxonomy (all 37 bucketed, sums to 37)

Admin companions fold into **Business & Admin**; their consumer-facing counterparts sit under **Services**. Every app is in exactly one bucket.

| Category (filter chip) | Count | Apps |
|---|---:|---|
| **E-commerce** | 16 | Montajat, Almulla Farms, Prestige, Organz, Melocanna, Highness, Vecasa, Alsalman, LIVI, Baqah, Morgap, U Pick, Square, TIS The Season, Stock Client, ATE 18 |
| **Business & Admin** | 5 | Mashro3y, Glamor, Slots Admin, Ghaslah Admin, Stock Delivery |
| **Booking & Reservations** | 4 | Sphoto, BBT, TSEBO, GigApp |
| **Games / Trivia** | 3 | Falta Game, Nuqat Game, Thabbit Game |
| **Food & Diet** | 3 | Gahwa, Sultani, Lions |
| **Services** | 2 | Slots, Ghaslah |
| **Education** | 1 | Edu Market |
| **Travel** | 1 | Amaken Misr |
| **Medical** | 1 | Dr-Raed |
| **Community / Sports** | 1 | Fishtail |
| **TOTAL** | **37** | |

> **Decisions:** Sphoto (Celebrity Booking) → Booking. Stock Delivery (logistics, admin/driver-side) → Business & Admin. Slots/Ghaslah consumer apps → Services; their Admin variants → Business & Admin. Fishtail (Community/Sports) gets its own small bucket rather than being mislabeled a game. The Index filter bar shows the primary chips (All, E-commerce, Games, Booking, Business, Services, Food, Education, Travel, Medical); Community folds into the nearest visible chip or appears as an 11th chip — confirm during build.

### 6.3 Full 37-app table (reconstructed store URLs)

URL rules: **Android** `https://play.google.com/store/apps/details?id=<pkg>`; **iOS** `https://apps.apple.com/us/app/id<digits>` (Apple resolves without a slug).

| # | Name | Category | Platforms | Featured | Android URL | iOS URL |
|---|------|----------|-----------|:--------:|-------------|---------|
| 1 | Edu Market | Education | Android+iOS | ✅ | https://play.google.com/store/apps/details?id=com.raiseright.edumarketapp | https://apps.apple.com/us/app/id6749850424 |
| 2 | Sphoto | Booking & Reservations | Android+iOS | ✅ | https://play.google.com/store/apps/details?id=com.baramjk.sphotocustomer | https://apps.apple.com/us/app/id6746163624 |
| 3 | Falta Game | Games / Trivia | Android+iOS | ✅ | https://play.google.com/store/apps/details?id=com.baramjk.falta | https://apps.apple.com/us/app/id6743669553 |
| 4 | Fishtail | Community / Sports | Android+iOS | — | https://play.google.com/store/apps/details?id=com.perfectneeds.fishtailapp | https://apps.apple.com/us/app/id6463719006 |
| 5 | Nuqat Game | Games / Trivia | Android+iOS | — | https://play.google.com/store/apps/details?id=com.baramjk.noqat | https://apps.apple.com/us/app/id6705129823 |
| 6 | Thabbit Game | Games / Trivia | iOS | — | — | https://apps.apple.com/us/app/id6737889402 |
| 7 | Montajat | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6737238922 |
| 8 | Almulla Farms | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6740340980 |
| 9 | Prestige | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id1554715657 |
| 10 | Mashro3y | Business & Admin | iOS | ✅ | — | https://apps.apple.com/us/app/id6737435318 |
| 11 | Glamor | Business & Admin | iOS | — | — | https://apps.apple.com/us/app/id6479636026 |
| 12 | Slots | Services | iOS | — | — | https://apps.apple.com/us/app/id6469031888 |
| 13 | Slots Admin | Business & Admin | iOS | — | — | https://apps.apple.com/us/app/id6478079179 |
| 14 | Gahwa | Food & Diet | iOS | — | — | https://apps.apple.com/us/app/id6563145037 |
| 15 | Organz | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6504950234 |
| 16 | Melocanna | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6502879449 |
| 17 | Highness | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6502949581 |
| 18 | Vecasa | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6479958495 |
| 19 | Sultani | Food & Diet | iOS | — | — | https://apps.apple.com/us/app/id6478279544 |
| 20 | BBT | Booking & Reservations | iOS | — | — | https://apps.apple.com/us/app/id6468564577 |
| 21 | Alsalman | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6476140940 |
| 22 | LIVI | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6457257016 |
| 23 | Ghaslah | Services | iOS | — | — | https://apps.apple.com/us/app/id6463858126 |
| 24 | Ghaslah Admin | Business & Admin | iOS | — | — | https://apps.apple.com/us/app/id6476490376 |
| 25 | Lions | Food & Diet | Android+iOS | — | https://play.google.com/store/apps/details?id=com.baramjk.lionskw | https://apps.apple.com/us/app/id6450896898 |
| 26 | Baqah | E-commerce | Android+iOS | ✅ | https://play.google.com/store/apps/details?id=com.baramjk.baqah | https://apps.apple.com/us/app/id6447472404 |
| 27 | Morgap | E-commerce | Android+iOS | — | https://play.google.com/store/apps/details?id=com.baramjk.Morgap | https://apps.apple.com/us/app/id1482283063 |
| 28 | U Pick | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6446490838 |
| 29 | Square | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id1626286616 |
| 30 | TIS The Season | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id6448727597 |
| 31 | Stock Delivery | Business & Admin | Android | — | https://play.google.com/store/apps/details?id=com.spark.stockdeliveryapp | — |
| 32 | Stock Client | E-commerce | Android+iOS | ✅ | https://play.google.com/store/apps/details?id=com.spark.stockclientapp | https://apps.apple.com/us/app/id1639101527 |
| 33 | Amaken Misr | Travel | Android+iOS | ✅ | https://play.google.com/store/apps/details?id=com.spark.amakenmisr | https://apps.apple.com/us/app/id1615751332 |
| 34 | TSEBO | Booking & Reservations | iOS | — | — | https://apps.apple.com/us/app/id1602490848 |
| 35 | ATE 18 | E-commerce | iOS | — | — | https://apps.apple.com/us/app/id1575687421 |
| 36 | Dr-Raed | Medical | iOS | ✅ | — | https://apps.apple.com/us/app/id1490292939 |
| 37 | GigApp | Booking & Reservations | iOS | — | — | https://apps.apple.com/us/app/id1476997873 |

> Store URLs above are for reference/verification. In `apps.json` store **only raw ids** (`googlePlay` package + `appStore` numeric id); the full URL is built by `store_link_builder.dart`. A store button renders only when its id exists.

**Featured picks (8, spread across buckets — 6 cross-platform + 2 strong iOS-only):**
Edu Market (Education, both), Sphoto (Booking, both), Falta Game (Games, both), Baqah (E-commerce, both), Stock Client (E-commerce, both), Amaken Misr (Travel, both), Mashro3y (Business, iOS), Dr-Raed (Medical, iOS). The Featured **spotlight** section (06) surfaces the flagship trio **Edu Market, Sphoto, Falta Game**; the full featured set powers the `featured` flag used elsewhere.

### 6.4 Profile / contact / languages / skills / experience / education

**Profile**

| Field | Value |
|---|---|
| name | Ahmed Maher |
| title | Flutter Team Lead |
| location | 6th October City, Giza – Egypt |
| email | Ahclever2006@gmail.com |
| phone | (+20) 1155728617 |
| summary | Flutter Developer with 5+ years building and leading cross-platform mobile apps. Previously 15 years in Oil & Gas as a Data Engineer. Specialized in E-commerce, Booking, and Business apps. Strong in Flutter, Dart, APIs, and State Management. Published and maintained 30+ apps on Google Play and the App Store. |

**Social / contact links**

| platform | url |
|---|---|
| email | mailto:Ahclever2006@gmail.com |
| phone | tel:+201155728617 |
| playStore (developer) | *(developer page URL TBD — placeholder)* |
| appStore (developer) | *(developer page URL TBD — placeholder)* |

**Languages:** Arabic — Native; English — Fluent.

**Skills (grouped)**

| Group | Skills |
|---|---|
| Languages & Frameworks | Flutter, Dart |
| State Management | Provider, BLoC |
| Backend & APIs | RESTful APIs, Firebase, Google Maps |
| Architecture & Quality | OOP, Clean Architecture, TDD, Unit Testing |
| Tools & Workflow | Git, Trello |
| UI / UX | Responsive Apps, Animations |

**Experience**

| # | Role | Company | Location | Period | Current | Bullets |
|---|---|---|---|---|:--:|---|
| 1 | Flutter Team Lead | Baramjk | Remote, Kuwait | Mar 2023 – Present | ✅ | Leads the Flutter team delivering production apps; built large-scale E-commerce and Gaming apps; mentored developers; improved workflow with Git & Trello. |
| 2 | Flutter Developer | Spark Systems | Giza, Egypt | Jan 2020 – Mar 2023 | — | Built & maintained retail & logistics apps; delivered Stock Client and Stock Delivery (Android/iOS); improved performance with responsive UI and optimized APIs. |
| 3 | Data Engineer | Oil & Gas (Halliburton, Oilserv, DHI) | Egypt, Qatar, Saudi Arabia, Spain, Ghana, Kuwait, Iraq, Malaysia | Jun 2008 – Feb 2023 | — | Designed, managed, and analyzed large datasets for oilfield operations across multinational projects. |

**Education:** B.Sc. in Chemistry & Geology — Cairo University — 2001–2006 — Grade: Good.

**CV → section mapping:** Profile drives Hero (01) + Contact (09). Stats (02) are derived: `37 Published Apps` (apps.length), `5+ Years Flutter` (summary), `15 Yrs Data Engineering` (Oil & Gas tenure), `8 Countries` (Data Engineer locations). Summary + Oil & Gas hook → About (03) pull quote + `career.log`. Skills → Skills matrix (04). The 37 apps → The Index (05) + Featured (06). Experience → (07). Education → (08).

---

## 7. Theming

`AppTheme` (`core/theme/app_theme.dart`) exposes `static ThemeData light` and `static ThemeData dark`, each built **entirely from the design system** — both first-class, dark default.

- **ColorScheme** mapped from the palettes: `primary→primary`, `onPrimary→onPrimary`, `secondary→secondary`, `surface→surface`, `surfaceContainerHighest→surfaceVariant`, `surfaceContainerHigh→surfaceElevated`, `onSurface→onSurface`, `onSurfaceVariant→muted`, `outline→outline`, `outlineVariant→outlineStrong`, `error→danger`, `surfaceTint→accent`. Background/onBackground (`#0A0C10`/`#E6EDF3` dark) via scaffold.
- **TextTheme via google_fonts:** display/title from `GoogleFonts.spaceGrotesk`, body/label from `GoogleFonts.inter`, engineer-signal (eyebrow/folio/caption/platform) from `GoogleFonts.jetBrainsMono` — each `TextStyle` carries the exact `typeScale` size/weight/height/letterSpacing; weight subset honored.
- **Component themes** so widgets never style locally: `FilledButtonTheme`/`ElevatedButtonTheme` (primary), `OutlinedButtonTheme` (ghost), `CardTheme` (radius 16, 1px outline, elevation 0 — elevation by light/glow), `ChipTheme` (skill/filter/platform base), `AppBarTheme` (transparent; glass nav paints its own blur), `InputDecorationTheme` (radius 10, outline border, focusRing on focus).
- **ThemeExtensions** registered on both themes: `AppSpacing` (spacing + radii + layout), `CategoryColors` (9 per-category AA-safe hues, light+dark — `forCategory(cat)`), `MotionTokens` (durations + curves).
- **ThemeCubit toggle:** holds `ThemeMode`; navbar toggle dispatches `toggle()`. `MaterialApp` sets `themeMode: state.mode`. Initial mode dark-first; first run with no stored choice may follow system brightness, then persist explicit choices via `shared_preferences`. `AnimatedTheme` cross-fades 300ms.

**NO-HARDCODE RULE (enforced by `scripts/check_design_tokens.sh`, run in CI — mirrors the user's house gate):** widgets read **only** `Theme.of(context).colorScheme`, `…textTheme`, `…extension<AppSpacing>()`, `…extension<CategoryColors>()`, `…extension<MotionTokens>()`. The gate fails the build on, inside `lib/features/` + `lib/core/widgets/`:

- `Color(0x…)` / `Colors.*` (except `Colors.transparent`) → use `AppColors` / `colorScheme`;
- literal `fontSize:` → must be `.sp`; raw `SizedBox` width/height → `.w` / `.h`; `BorderRadius.circular(...)` → `.r` or `AppRadius`;
- `EdgeInsets.only(left:|right:)` / `Alignment.*Left|Right` → use `start`/`end` (RTL) — suppress only with `// ignore-rtl` + a written reason;
- raw `ElevatedButton` / `OutlinedButton` / `TextFormField` → prefer `AppButton` / `AppTextField`;
- user-facing `Text(...)` without `.tr()` → mark intentional exceptions `// no-tr`.

### 7.1 Localization & RTL — `easy_localization` (EN + AR, first-class)

The audience is bilingual (Arabic native / English fluent; Egypt + Gulf), so **English + Arabic with full RTL are v1 scope**, wired exactly like the user's house projects:

- **Source files:** `assets/translations/en.json` + `ar.json`. A CI key-parity check (+ a unit test, §13) fails if the two files' key sets diverge.
- **No inline keys:** every key is a `static const` on `AppStrings` (`core/constants/app_strings.dart`) and used as `AppStrings.heroTitle.tr()` — never a bare `'hero.title'.tr()` literal. New sections add their keys to `AppStrings` first.
- **Wiring:** `EasyLocalization` wraps the app in `bootstrap()` (§5.5); `MaterialApp.router` consumes `context.localizationDelegates / supportedLocales / locale`. `LocaleCubit` persists the choice (`shared_preferences`) and the **navbar language toggle** (`EN ⇄ ع`) calls `context.setLocale(...)`.
- **RTL is a first-class concern, not an afterthought.** The design leans on directional layout (left accent line, flush-left index `01–37`, sticky left-margin folio column, list-row 6px rightward nudge). All of these use **`start`/`end`** primitives (`EdgeInsetsDirectional`, `AlignmentDirectional`, `PositionedDirectional`) so Flutter mirrors them automatically under `Directionality(textDirection: rtl)`. Mono folio/index numerals stay Latin-digit LTR but anchor to the correct side.
- **Arabic type:** JetBrains Mono + Inter cover Latin; Arabic glyphs fall back to a bundled Arabic face (e.g. `GoogleFonts.cairo` / `notoKufiArabic`) selected per-locale in `app_text_theme.dart`.
- **Content:** UI chrome (nav, buttons, eyebrows, stat labels, contact form) is translated. App names and store IDs stay verbatim; per-app taglines carry `en`/`ar` variants in `apps.json`.

---

## 8. Responsive Strategy

**Breakpoints** — single source of truth in `core/responsive/app_breakpoints.dart`, consumed via the sizeHelper (`flutter_screenutil`) behind `core/responsive/`:

| Class | Range | Notes |
|---|---|---|
| mobile | `< 600` | 1 col, gutters 24, folio column hidden, drawer nav |
| tablet | `600–1024` | 6-col base grid, gutters scale toward 64 |
| desktop | `> 1024` | 12-col grid, sticky folio column, full anchor nav |
| wide | `> 1440` | content capped at `maxContentWidth = 1200`, centered, larger gutters |

**How sizeHelper drives it:** `MaterialApp` is wrapped in `ScreenUtilInit` (designSize `1440×1024`). A `context.bp` extension maps width to the enum above; layout widgets switch column counts and `AppSpacing` lookups (`sectionDesktop` vs `sectionMobile`, gutters) off it. Type uses **fluid clamps** — base desktop sizes clamped between mobile and 1024px (so `displayHero` reads `clamp(48→88)`). **No widget reads `MediaQuery` directly for sizing** — only the breakpoint extension + theme tokens.

- **Projects grid** (`appGrid`): mobile **1**, tablet **2**, desktop/wide **3**, gap `20`. The default **list view** is single-column at all breakpoints (mono index collapses gracefully; platform tags drop below name on mobile).
- **Navbar + drawer:** custom `GlassNavBar` fixed at top. Desktop/tablet: wordmark + center anchors + toggle + CV button. Mobile (`<600`): wordmark + hamburger; anchors move into a right-side slide-over `Drawer` that closes on tap and triggers the same scroll.

---

## 9. Routing & Navigation

**RECOMMENDATION: smooth-scroll anchor navigation on a single route.** The IA is one editorial scroll narrative; multi-route navigation would fragment the catalog and break the count-up/entrance choreography.

- Implement scrolling via `Scrollable.ensureVisible(curve: MotionTokens.scrollCurve)` against per-section `GlobalKey`s (or `scrollable_positioned_list`). `NavigationCubit.scrollTo(SectionId)` is consumed by the section host.
- Keep **one** `go_router` instance with a single `/` route so the app is router-ready, with `PathUrlStrategy` for clean web URLs. Update the browser hash on scroll (`/#work`) via `RouteInformationProvider` for shareable section links without page reloads.
- A deep-link affordance `/work/:appId` (opening a detail dialog/sheet) is a **future** addition, not v1.
- Add a `404.html` copy of `index.html` to `build/web` so deep links/refreshes don't 404 on GitHub Pages.

---

## 10. Assets

### 10.1 Directory layout

```
assets/
  docs/
    Ahmed_Maher_cv.pdf            # copied from repo root
    Ahmed_Maher_Portfolio.pdf     # copied from repo root
  data/
    apps.json                     # 37 apps -> AppProject (local data source); raw store ids only
    profile.json                  # Profile / skills / experience / education / stats / contact
  translations/
    en.json                       # easy_localization source (UI chrome + per-app taglines)
    ar.json                       # Arabic mirror (key-parity enforced)
  icons/
    app_store.svg
    google_play.svg
  images/
    og-image.png                  # 1200x630 social share card (also place og-cover.png in web/)
    avatar.png                    # profile photo (placeholder until provided)
    projects/
      _placeholder.png            # neutral fallback icon used when iconAsset is null
      sphoto.png                  # add real icons over time, keyed by AppProject.id
      ...
```

**`apps.json` shape** (raw ids, not URLs):
```jsonc
{
  "index": 1,
  "id": "edu-market",
  "name": "Edu Market",
  "category": "education",
  "tagline": "Education marketplace — buyer + seller flows",
  "platforms": ["android", "ios"],
  "storeLinks": { "googlePlay": "com.raiseright.edumarketapp", "appStore": "6749850424" },
  "featured": true
}
```

### 10.2 PDFs → download buttons

Both PDFs are bundled under `assets/docs/`. For a true **download** (not just open-in-tab) on Flutter Web, the cleanest path is to **also copy the two PDFs into `web/docs/`** and point an anchor / `launchUrl` at `docs/Ahmed_Maher_cv.pdf` with the HTML `download` attribute (web-served files use relative URLs and do **not** go in the `assets:` block). Keep the `assets/docs/` copies for any future in-app PDF preview. The download repository method returns `Either<Failure, Unit>` so a launch failure surfaces as a `Failure` (dartz), consistent with the global rules.

### 10.3 Images / icons (placeholders now, real later)

`AppProject.iconAsset` is nullable. When null, cards render `assets/images/projects/_placeholder.png` (neutral, theme-tinted) plus the app's first letter. To add a real icon later: drop `projects/<id>.png` in, set `iconAsset` in `apps.json` — no code change. Screenshots follow `projects/<id>_1.png` (optional, for a detail sheet).

### 10.4 Branding / favicon / app icon

Add `web/og-cover.png` (1200×630) referenced by OG/Twitter meta. Replace the default Flutter `web/favicon.png`, `web/icons/Icon-192.png`, `Icon-512.png`, maskable variants, and `web/manifest.json` (`name`, `short_name`, `description`, `theme_color`, `background_color`) to brand as "Ahmed Maher — Flutter Team Lead".

### 10.5 `pubspec.yaml` assets block

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/docs/Ahmed_Maher_cv.pdf
    - assets/docs/Ahmed_Maher_Portfolio.pdf
    - assets/data/apps.json
    - assets/data/profile.json
    - assets/translations/en.json
    - assets/translations/ar.json
    - assets/icons/
    - assets/images/
    - assets/images/projects/
```

> Fonts come via `google_fonts` (no manual font declaration). The two PDFs are **also** copied into `web/docs/` (outside the `assets:` block) for native browser downloads.

---

## 11. SEO, Web Config & Performance

> Flutter Web renders to canvas — text inside the canvas is **not** in the DOM and is **not crawled**. SEO therefore depends on (a) the static `<head>` tags + JSON-LD below and (b) `Semantics` exposed to the accessibility tree.

### 11.1 `web/index.html` `<head>`

> **Bilingual note:** set `<html lang="en" dir="ltr">` in the template and flip `lang`/`dir` at runtime when the locale switches to `ar` (`dir="rtl"`) so crawlers and the canvas get the right direction. Add `hreflang` alternates (`en`, `ar`, `x-default`) alongside the canonical link.

```html
<head>
  <base href="$FLUTTER_BASE_HREF">
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <title>Ahmed Maher — Flutter Team Lead | 37 Published Apps</title>
  <meta name="description" content="Ahmed Maher, Flutter Team Lead based in 6th October City, Egypt. 37 cross-platform apps shipped to the App Store and Google Play across e-commerce, booking, games and business. 5+ years Flutter, 15 years data engineering.">
  <meta name="author" content="Ahmed Maher">
  <meta name="keywords" content="Ahmed Maher, Flutter, Flutter Team Lead, Dart, mobile developer, cross-platform, App Store, Google Play, portfolio, Egypt">
  <link rel="canonical" href="https://ahmedmaher.dev/">
  <meta name="theme-color" media="(prefers-color-scheme: dark)" content="#0A0C10">
  <meta name="theme-color" media="(prefers-color-scheme: light)" content="#F7F8FA">
  <meta name="robots" content="index, follow">

  <!-- Open Graph -->
  <meta property="og:type" content="profile">
  <meta property="og:title" content="Ahmed Maher — Flutter Team Lead | 37 Published Apps">
  <meta property="og:description" content="37 cross-platform apps shipped to App Store & Google Play. Flutter Team Lead, 5+ years Flutter, 15 years data engineering.">
  <meta property="og:url" content="https://ahmedmaher.dev/">
  <meta property="og:image" content="https://ahmedmaher.dev/og-cover.png">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta property="og:site_name" content="Ahmed Maher">
  <meta property="profile:first_name" content="Ahmed">
  <meta property="profile:last_name" content="Maher">

  <!-- Twitter / X -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="Ahmed Maher — Flutter Team Lead | 37 Published Apps">
  <meta name="twitter:description" content="37 cross-platform apps shipped to App Store & Google Play. Flutter Team Lead.">
  <meta name="twitter:image" content="https://ahmedmaher.dev/og-cover.png">

  <!-- iOS / PWA -->
  <meta name="mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
  <meta name="apple-mobile-web-app-title" content="Ahmed Maher">
  <link rel="apple-touch-icon" href="icons/Icon-192.png">
  <link rel="icon" type="image/png" href="favicon.png"/>
  <link rel="manifest" href="manifest.json">

  <!-- Preconnect for google_fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

  <!-- JSON-LD: Person -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Person",
    "name": "Ahmed Maher",
    "jobTitle": "Flutter Team Lead",
    "email": "mailto:Ahclever2006@gmail.com",
    "telephone": "+201155728617",
    "url": "https://ahmedmaher.dev/",
    "image": "https://ahmedmaher.dev/og-cover.png",
    "knowsLanguage": ["ar", "en"],
    "address": { "@type": "PostalAddress", "addressLocality": "6th October City, Giza", "addressCountry": "EG" },
    "alumniOf": { "@type": "CollegeOrUniversity", "name": "Cairo University" },
    "knowsAbout": ["Flutter", "Dart", "Clean Architecture", "Mobile Development", "REST APIs", "Firebase", "Data Engineering"],
    "worksFor": { "@type": "Organization", "name": "Baramjk" }
  }
  </script>
</head>
```

> Replace `https://ahmedmaher.dev/` with the real custom domain, or with `https://<user>.github.io/clever_portfolio/` if no custom domain. Generate `og-cover.png` (1200×630) and drop it in `web/`.

### 11.2 `manifest.json`

```json
{
  "name": "Ahmed Maher — Flutter Team Lead",
  "short_name": "Ahmed Maher",
  "start_url": ".",
  "display": "standalone",
  "background_color": "#0A0C10",
  "theme_color": "#0A0C10",
  "description": "Flutter Team Lead — 37 cross-platform apps shipped to App Store and Google Play.",
  "orientation": "portrait-primary",
  "prefer_related_applications": false,
  "icons": [
    { "src": "icons/Icon-192.png", "sizes": "192x192", "type": "image/png" },
    { "src": "icons/Icon-512.png", "sizes": "512x512", "type": "image/png" },
    { "src": "icons/Icon-maskable-192.png", "sizes": "192x192", "type": "image/png", "purpose": "maskable" },
    { "src": "icons/Icon-maskable-512.png", "sizes": "512x512", "type": "image/png", "purpose": "maskable" }
  ]
}
```

### 11.3 Renderer — **RECOMMENDATION: `auto` (default), pin CanvasKit if needed**

| Renderer | Pros | Cons |
|---|---|---|
| **auto** (3.41 default) | Best balance; consistent typographic rendering; no per-device tuning | CanvasKit ~1.5–2MB wasm first-load |
| **canvaskit** (forced) | Pixel-accurate fonts/animations; identical across browsers | Larger initial download, slower first paint |
| **html** | — | Removed in current Flutter; do not target |

Ship **`auto`**; optimize first-load with CanvasKit caching + a loading splash + deferred sections (§11.5). Force `--web-renderer canvaskit` only if rendering inconsistency is observed.

**Font loading:** for production, bundle the weight subset (`google_fonts` asset mode — add the `.ttf`s to `assets/google_fonts/` and set `GoogleFonts.config.allowRuntimeFetching = false`) so first paint isn't blocked on fonts.gstatic and the build is deterministic offline. Keep `preconnect` as a fallback.

**Loading splash:** inject a minimal inline splash in `index.html` (dark `#0A0C10` + mono `> loading…` with a pulsing emerald dot) shown until `FlutterLoader` reports `appRunner` ready, then fade out — matching the terminal aesthetic instead of a blank canvas.

### 11.4 Accessibility

- `Semantics` on every meaningful node: hero headline as `header`; nav links as labeled buttons; each app row/card with `label: '<App name>, <category>, available on <platforms>'`; store buttons labeled `Open <App> on the App Store / Google Play`; theme toggle labeled `Switch to dark/light theme`; filter pills with `selected:` state.
- **Contrast:** body/onSurface combos meet AA; category hues AA-checked (light ~4.5:1 on white, dark brightened on `#10141A`); never rely on hue alone — every category also shows its mono text tag.
- **Keyboard & focus:** `FocusTraversalGroup` per section in DOM order; all interactive elements Tab-reachable; visible emerald focus ring on cards/rows/buttons/inputs; anchors + Index toggle activatable by Enter/Space; Escape closes the mobile drawer.
- **Reduced motion** respected (§3.5); respect text scaling (no fixed-height text containers).

### 11.5 Performance

- Below-the-fold sections code-split with `deferred as` imports (`Featured`, `Experience`, `Contact`) loaded after first frame, so Hero + Index paint fast.
- The Index list is virtualized (`ListView.builder`); grid uses a lazy `SliverGrid`. Off-screen items gated via `VisibilityDetector`.
- Bundle fonts (§11.3); icon tree-shaking + `--release` compression.
- **Lighthouse targets:** Performance ≥ 90 desktop / ≥ 80 mobile (CanvasKit-adjusted), Accessibility ≥ 95, Best Practices ≥ 95, SEO ≥ 95. Optionally track with `lighthouse-ci`.

---

## 12. Deployment & CI

**Primary: GitHub Pages via GitHub Actions.** Repo `clever_portfolio` → project page `https://<user>.github.io/clever_portfolio/`, so the build **must** set the base href.

```bash
# Local dev
flutter pub get
flutter run -d chrome

# Production build for GitHub Pages (project site)
flutter build web --release --base-href "/clever_portfolio/"

# If using a CUSTOM DOMAIN (served at root):
flutter build web --release --base-href "/"
```

> **Custom domain:** to serve at `ahmedmaher.dev`, build with `--base-href "/"`, add a `CNAME` file (`ahmedmaher.dev`) into `build/web` during the workflow, set the DNS records to GitHub Pages, and update `canonical`/OG/JSON-LD URLs.

### `.github/workflows/deploy.yml`

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
          flutter-version: 3.41.4
      - name: Install dependencies
        run: flutter pub get
      - name: Codegen (freezed / json_serializable / injectable)
        run: dart run build_runner build --delete-conflicting-outputs
      - name: Design-token gate
        run: bash scripts/check_design_tokens.sh
      - name: Analyze
        run: flutter analyze
      - name: Test
        run: flutter test   # includes l10n key-parity (en/ar) + cubit/widget tests
      - name: Build web
        # For a custom domain served at root, change to --base-href "/"
        run: flutter build web --release --base-href "/clever_portfolio/"
      # Uncomment for a custom domain:
      # - name: Add CNAME
      #   run: echo "ahmedmaher.dev" > build/web/CNAME
      - name: SPA 404 fallback
        run: cp build/web/index.html build/web/404.html
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: build/web

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

> Enable **Settings → Pages → Source: GitHub Actions**. (Classic alternative: `peaceiris/actions-gh-pages@v4` pushing `build/web` to a `gh-pages` branch.)

### Documented alternative: Firebase Hosting

```bash
npm install -g firebase-tools
firebase login
firebase init hosting          # public dir: build/web, configure as SPA (rewrite all -> /index.html)
flutter build web --release    # base-href "/" — Firebase serves at root
firebase deploy --only hosting
```
`firebase.json`:
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [{ "source": "**", "destination": "/index.html" }]
  }
}
```
CI alternative: swap the `deploy` job for `FirebaseExtended/action-hosting-deploy@v0` with a `FIREBASE_SERVICE_ACCOUNT` secret.

---

## 13. Testing

Run with `flutter test` (also gated in CI above).

**Unit — use case & base contract** (`test/core/`, `test/features/.../domain/`):
- `usecase_test.dart` — `NoParams` equality; base contract shape.
- `get_projects_test.dart` — mock `ProjectsRepository` (mocktail); `GetProjects(NoParams())` unwraps `Either` correctly (success → `Right<List<AppProject>>` of 37; failure → `Left<Failure>`).

**Unit — model + repository with mocked data source returning `Either`** (`test/features/.../data/`):
- `projects_repository_impl_test.dart` — mock `ProjectsLocalDataSource`: on success → parsed models → `Right` with 37 entries; on thrown `AssetException` → `Left(AssetFailure)`.
- `app_project_model_test.dart` — pure `fromJson`: platform inference and conditional store-link parsing (`googlePlay`/`appStore` → nullable URLs via `store_link_builder`).

**Cubit tests** (`bloc_test`):
- `projects_cubit_test.dart` — load emits `Loading → Loaded(37)`; `setCategory(games)` narrows `visible`; platform toggle filters; search narrows; `toggleViewMode` flips list↔grid.
- `contact_cubit_test.dart` — validation `Left(ValidationFailure)` path; submit success/failure.
- `locale_cubit_test.dart` — toggles en↔ar and persists the choice.

**Localization**:
- `l10n_parity_test.dart` — asserts `en.json` and `ar.json` have **identical key sets** (guards the no-orphan-key rule); optionally that every `AppStrings` const resolves in both.

**Widget tests** (`test/presentation/`):
- `hero_section_test.dart` — title/summary render; primary "View Work" + ghost "Download Resume" present and tappable.
- `index_section_test.dart` — 37 rows by default (list); category pill (e.g. *Games*) reduces visible rows; platform toggle filters; search narrows; List↔Grid toggle swaps view. Pump with a fake `ProjectsCubit` seeded from fixtures.
- `nav_bar_test.dart` — desktop shows anchors; below 600 shows hamburger + opens drawer; theme toggle dispatches `ThemeCubit.toggle()`.
- `project_card_test.dart` — store buttons render **only** when the link exists (iOS-only app shows App Store button, no Play button).

**Golden tests (optional)** (`test/golden/`):
- Project card + Index list row in both `AppTheme.light`/`dark`; guards no-hardcode theming + category-hue accent. Seed with `--update-goldens`; keep CI golden run behind a `--tags golden` flag (font-rendering flakiness across platforms).

---

## 14. Implementation Roadmap

Phased so the site is buildable/runnable after every milestone.

### M0 — Project setup, deps, cleanup
- [ ] Branch from default; confirm Flutter 3.41.4 / Dart 3.11.1 toolchain.
- [ ] Add all §2 `dependencies` + `dev_dependencies` to `pubspec.yaml`; `flutter pub get`.
- [ ] Declare assets in `pubspec.yaml` (§10.5); create `assets/{data,docs,icons,images,images/projects}`.
- [ ] Copy `Ahmed_Maher_cv.pdf` + `Ahmed_Maher_Portfolio.pdf` from repo root into `assets/docs/` **and** `web/docs/`.
- [ ] Remove the default counter `lib/main.dart`; add `bootstrap.dart` + minimal `PortfolioApp` shell that boots and shows an empty themed `Scaffold`.
- [ ] Add `very_good_analysis` to `analysis_options.yaml`; add `scripts/check_design_tokens.sh` (no-hardcode + `.sp/.w/.h/.r` + start/end RTL + `App*`-widget + `.tr()` gate) and run it in CI.
- [ ] Create `assets/translations/en.json` + `ar.json` (seed UI keys); declare both in the `assets:` block.
- [ ] Verify `flutter run -d chrome` boots the empty app.

### M1 — Theming + design system
- [ ] `app_color_scheme.dart` — light + dark `ColorScheme` from §3.1 hex.
- [ ] `app_text_theme.dart` — `TextTheme` via google_fonts per §3.2 type scale (weight subset).
- [ ] ThemeExtensions: `AppSpacing`, `AppRadii`, `CategoryColors` (9 hues × 2 themes), `MotionTokens`; `theme_extensions.dart` context getters.
- [ ] `app_theme.dart` — `AppTheme.light`/`dark` with all component themes (buttons, card, chip, input, appbar) + extensions registered.
- [ ] `ThemeCubit` (extends `BaseCubit`) + Freezed `ThemeState` (dark-first) + `Get/SaveThemeMode` (SharedPreferences); wire `AnimatedTheme`/`themeMode`.
- [ ] Build atomic widgets in `core/widgets/`: `AppButton` (primary/ghost), `AppTextField`, `AppTextLink`, `AppFilterChip`, `AppPlatformChip`, `AppSkillChip`.
- [ ] Seed `AppStrings` i18n keys + `en.json`/`ar.json`; pick the Arabic typeface in `app_text_theme.dart`.
- [ ] Quick theme-toggle demo screen verifies light↔dark cross-fade and no-hardcode compliance.

### M2 — Core + architecture scaffolding
- [ ] `core/abstract/base_cubit.dart` (`BaseCubit<T>`); `core/usecase/usecase.dart` (`UseCase`, `SyncUseCase`, `NoParams`), `error/failures.dart`, `error/exceptions.dart`, `utils/typedefs.dart`.
- [ ] `core/responsive/`: `app_breakpoints.dart`, `responsive.dart` (`context.bp`), `responsive_layout.dart`, `screen_util_init.dart` (ScreenUtilInit boundary).
- [ ] `core/network/`: `dio_client.dart`, `api_endpoints.dart`, logging interceptor.
- [ ] `core/di/`: `injection.dart` + `register_module.dart`; run `build_runner` to generate `injection.config.dart` (+ `*.freezed.dart` / `*.g.dart`).
- [ ] `core/localization/`: `LocaleCubit`; wrap app in `EasyLocalization` (bootstrap) + wire `MaterialApp` locale delegates + navbar language toggle.
- [ ] `core/router/`: single `/` GoRouter + `PathUrlStrategy`; `app_routes.dart`.
- [ ] `core/utils/store_link_builder.dart`; `constants/app_assets.dart` + `app_strings.dart`.
- [ ] `SectionScaffold` + `FolioLabel` + `RevealOnScroll` + `TerminalStatusStrip` + `GlassNavContainer` shells.
- [ ] Verify DI graph resolves and app still boots.

### M3 — Data layer + content
- [ ] Author `assets/data/apps.json` (37 apps, raw store ids, featured flags) from §6.3, and `assets/data/profile.json` (profile, skills, experience, education, stats, contact).
- [ ] Domain entities + enums for all features (§6.1).
- [ ] `projects` feature: Freezed + `json_serializable` model (`fromJson`/`toEntity`), local data source, repository impl, `GetProjects`/`FilterProjects`/`GetFeaturedProjects`.
- [ ] `profile`, `experience`, `contact` (local) features: same pattern; `contact` adds remote data source + `SendMessage` over `DioClient`.
- [ ] Cubits (all extend `BaseCubit`, Freezed states): `ProjectsCubit`, `ProfileCubit`, `ExperienceCubit`, `ContactCubit`, `NavigationCubit`, `LocaleCubit`. Run `build_runner` for state/model codegen.
- [ ] Tests: use-case, repository (mocktail `Either`), model `fromJson`, `ProjectsCubit` (bloc_test). Green.

### M4 — Sections build
- [ ] `00` Glass navbar + nav links + theme toggle + **language toggle (EN ⇄ ع)** + Download CV + mobile drawer.
- [ ] `01` Hero (eyebrow, headline, summary, CTAs, terminal status strip, dot-grid + radial glow).
- [ ] `02` Stats band (count-up metrics 37 / 5+ / 15 / 8).
- [ ] `03` About (pull quote + `career.log` timeline).
- [ ] `04` Skills matrix (grouped glass chips).
- [ ] `05` The Index — sticky filter bar + platform toggle + search; default list (01-37) + card grid via `AnimatedSwitcher`; store-aware buttons.
- [ ] `06` Featured spotlight (Edu Market, Sphoto, Falta Game) split cards + dual store buttons.
- [ ] `07` Experience role cards; `08` Education line; `09` Contact panel + Dio-wired form; `10` Footer/colophon (typeface credit, back-to-top, current year).
- [ ] Wire anchor scroll (`NavigationCubit.scrollTo` + hash sync).
- [ ] Route all user-facing copy through `AppStrings.*.tr()`; fill `en.json` + `ar.json` (UI chrome + per-app taglines).

### M5 — Responsive + motion polish
- [ ] Breakpoint behavior across mobile/tablet/desktop/wide (grid columns, gutters, folio collapse, drawer).
- [ ] Fluid type clamps; verify hero `clamp(48→88)`.
- [ ] Entrance reveals (480ms stagger), hairline `scaleX` openers, counters (1200ms), card lift/accent-line, list-row shift+recolor, nav glass-on-scroll, view-toggle layout animation.
- [ ] `prefers-reduced-motion` gating (opacity-only fallback; freeze caret/dot).
- [ ] **RTL pass:** switch to Arabic, verify every section mirrors (start/end), folio/index/accent-line sides flip, Arabic typeface renders; fix stragglers.
- [ ] Widget tests: hero, index filtering, navbar/drawer, project card store-link conditionals. Green.

### M6 — SEO / a11y / performance
- [ ] Replace `web/index.html` `<head>` (§11.1) + `web/manifest.json` (§11.2); add `web/og-cover.png`; rebrand favicon/icons.
- [ ] Loading splash injected; bundle google_fonts subset (`allowRuntimeFetching = false`).
- [ ] `Semantics` labels on all interactive/meaningful nodes; focus traversal + visible focus rings; Escape closes drawer.
- [ ] Verify AA contrast (incl. category hues); confirm hue is never the sole signal.
- [ ] `deferred as` split for Featured/Experience/Contact; virtualized Index list/grid.
- [ ] Run Lighthouse; meet targets (A11y/SEO ≥ 95).

### M7 — Deploy
- [ ] Create `.github/workflows/deploy.yml` (§12); enable Pages → Source: GitHub Actions.
- [ ] First build with `--base-href "/clever_portfolio/"`; add `404.html` SPA fallback.
- [ ] Confirm live site, store links open correctly, both themes, downloads work.
- [ ] (If custom domain) add `CNAME`, DNS records, switch base href to `/`, update canonical/OG/JSON-LD.
- [ ] (Optional) document Firebase Hosting alternative.

---

## 15. Future Enhancements

- **More locales / localized SEO.** EN + AR + RTL ship in **v1** (§7.1). Future: additional locales (e.g. French for North-African/Gulf clients), localized `<title>`/meta + `hreflang`, and locale-aware OG images.
- **Blog / writing.** A `/blog` route (markdown-driven) for Flutter/architecture posts to reinforce the team-lead positioning.
- **Live store ratings via Dio.** Fetch live ratings/install counts per app from a small backend (the `DioClient` is already wired) and display them on cards/rows.
- **Analytics.** Privacy-friendly analytics (e.g. Plausible) to track section engagement and store-link clicks.
- **Contact form backend.** Stand up the actual `ApiEndpoints.baseUrl` endpoint (serverless function / Formspree) the `SendMessage` use case already targets; until then, mailto fallback.
- **App screenshots / case studies.** Real app icons (`projects/<id>.png`) + screenshots + per-app detail sheets at `/work/:appId` (the deferred deep-link route), turning featured apps into mini case studies.

---

## 16. Open Decisions for the User

- **Deployment target** — confirm **GitHub Pages** (primary plan) vs Firebase Hosting.
- **Custom domain** — use `ahmedmaher.dev` (or another)? Determines base href (`/` vs `/clever_portfolio/`) and canonical/OG/JSON-LD URLs.
- **App screenshots / icons** — provide real app icons + screenshots now, or ship with letter/placeholder tiles and add later?
- **Arabic / RTL scope** — plan defaults to **EN + AR + full RTL in v1** (matches your house stack). Confirm, or ship **EN-only** first and add AR later?
- **Contact form** — wire a real Dio-backed endpoint (which provider?), or ship a `mailto:` fallback for v1?
- **Responsive layer** — plan uses **`flutter_screenutil`** as the mandated "sizeHelper" (matches your Rolli stack; no package literally named `sizeHelper` exists on pub.dev). Flag if you intend a different package.
- **Developer store pages** — provide the App Store / Google Play developer-profile URLs (currently placeholders) for the contact/footer links.