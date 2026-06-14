# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

**clever_portfolio** — Ahmed Maher's personal **Flutter Web portfolio** (single-page, dark-first).
It showcases **37 published apps** (App Store / Google Play) plus the CV of a Flutter Team Lead.

**`plan.md` (repo root) is the single source of truth for the build** — design system, Clean
Architecture layout, data models, the full 37-app content inventory, theming, SEO, deployment, and
a phased roadmap (M0–M7). Read it before implementing anything; this file is the quick reference.

Source content lives in two PDFs at the repo root — `Ahmed_Maher_cv.pdf` and
`Ahmed_Maher_Portfolio.pdf` — which are transcribed into `assets/data/profile.json` and
`assets/data/apps.json` and copied into `assets/docs/` (+ `web/docs/` for browser download).

State of the repo:
- **`lib/main.dart` is still the default `flutter create` counter sample** — the real entry point,
  `bootstrap()`, and `MaterialApp` wiring are not built yet. Start from `plan.md` → **M0**.
- **Build target is Flutter Web.** The scaffolded Android/iOS/desktop platforms are ignored.
- Flutter is **3.41.4** (stable); Dart SDK constraint is **`^3.11.1`**.
- **This is not a git repository yet** — run `git init` (and add a GitHub remote) before wiring the
  GitHub Pages CI in `plan.md` §12.

## Commands

```bash
flutter pub get                                  # install/update packages
flutter analyze                                  # lint + static analysis (run before commits)
dart format lib/ test/                           # format (also auto-runs via PostToolUse hook)
flutter test                                     # all tests
flutter test test/features/projects/...          # a single file
flutter test --name "filters by category"        # a single test by name
flutter run -d chrome                             # run the web app locally
flutter build web --release --base-href "/clever_portfolio/"   # GitHub Pages project build
dart run build_runner build --delete-conflicting-outputs       # freezed + json_serializable + injectable codegen
bash scripts/check_design_tokens.sh              # design-token / RTL / .tr() compliance gate (CI)
```

Prefer the **dart-flutter MCP tools** (`mcp__dart-flutter__analyze_files`, `pub`, `run_tests`,
`hot_reload`, `list_devices`, `list_running_apps`) over shelling out — that is what the MCP
server's own instructions ask for.

## Architecture

Clean Architecture with strict layering: **data → domain ← presentation**. The presentation layer
must **not** import from data (a `PostToolUse` hook prints `🏗️ Architecture violation` when it
sees `import '.../data/'` inside a `/presentation/` file). Per-feature folders follow
`features/<name>/{data,domain,presentation}/...`; `core/` holds cross-cutting concerns (theme,
responsive, di, router, network, error, usecase, localization, widgets). Full tree in `plan.md` §5.1.

Core decisions:

- **State:** **Cubit + Freezed** state classes. Every cubit extends **`BaseCubit<T>`**
  (`lib/core/abstract/base_cubit.dart`) — it guards `emit` against `isClosed`; **do not subclass
  `Cubit<T>` directly**.
- **Use cases:** generic **`UseCase<Output, Params>`** + `NoParams`, returning
  **`Either<Failure, T>`** (Dartz). `SyncUseCase` for pure in-memory transforms (e.g. filtering).
- **DI:** `get_it` + `injectable` (codegen). **Navigation:** `go_router` — one `/` route +
  smooth-scroll anchors, `PathUrlStrategy` for clean URLs.
- **Network:** `Dio` wrapped to return `Either<Failure, T>`. Static content is **local-first** —
  bundled JSON assets (`apps.json` / `profile.json`) parsed in the data-source layer. Dio is
  **reserved for the one real network surface** (the contact form) + future remote content.
- **Localization:** `easy_localization` reading `assets/translations/en.json` + `ar.json`. **RTL is
  a first-class concern.** Translation keys are `static const` on `AppStrings`
  (`lib/core/constants/app_strings.dart`) and used as `AppStrings.<key>.tr()` — never inline a bare
  key string. A `PostToolUse` hook key-parity-checks the two JSON files on every edit.
- **Responsive:** `flutter_screenutil` (`.w/.h/.sp/.r`) behind `core/responsive/` — this is the
  implementation of the global-rules "sizeHelper". Breakpoints: mobile `<600` / tablet `600–1024`
  / desktop `>1024` / wide `>1440`.
- **Codegen:** `freezed` (`*.freezed.dart`) + `json_serializable` (`*.g.dart`) + `injectable`
  (`injection.config.dart`), all via `build_runner`.

## Design System (non-negotiable)

**Aesthetic:** *"Production Terminal — Indexed Edition"* — dark-first (light fully supported), one
electric-emerald signal accent, a JetBrains-Mono "engineer-signal" system, and the 37 apps framed
as a numbered, filterable release index (`01–37`). Full spec (palettes, type scale, components,
motion) in `plan.md` §3 & §7.

Tokens live in `ThemeData` + `ThemeExtension`s — widgets read **only** `Theme.of(context)`:
- Colors → `AppColors` / `colorScheme` (+ `CategoryColors` extension). Font sizes → `AppTypography`
  with `.sp`. Spacing → `AppSpacing`. Radius → `AppRadius`. Motion → `MotionTokens`.
- Prefer atomic widgets **`AppButton` / `AppTextField` / `AppFilterChip` / `AppPlatformChip` /
  `AppSkillChip`** over raw Material widgets.

Hard rules — mirrored in `.claude/settings.json` `instructions` and enforced by
`scripts/check_design_tokens.sh` (CI gate) inside `lib/features/` + `lib/core/widgets/`:

- **No** `Color(0x…)` / `Colors.*` (`Colors.transparent` is allowed) — use `AppColors`.
- **No** hardcoded `fontSize:` (use `.sp`), `SizedBox` sizes (use `.w`/`.h`), or
  `BorderRadius.circular(...)` (use `.r` / `AppRadius`).
- **No** `EdgeInsets.only(left:|right:)` / `Alignment.*Left|Right` — use `start`/`end` for RTL
  (suppress with `// ignore-rtl` + a written reason only).
- User-visible `Text(...)` uses `.tr()` (mark intentional exceptions `// no-tr`).
- Both light and dark `ThemeData` must be wired.

## Content & data

- All 37 apps are described in `assets/data/apps.json` storing **raw store ids only**;
  `core/utils/store_link_builder.dart` reconstructs the App Store / Google Play URLs, and
  cards/rows render a store button **only when that link exists**. CV/profile/skills/experience
  live in `assets/data/profile.json`. Never inline portfolio content in widgets.
- PDFs are bundled under `assets/docs/` and also copied to `web/docs/` so the "Download CV" button
  triggers a real browser download (web-served files are relative URLs, not `assets:` entries).

## Bootstrapping (one-time)

Turn the counter starter into the real portfolio by following `plan.md` §14 (M0 → M7): add the
dependency block (`plan.md` §2), declare assets, replace `lib/main.dart` with `bootstrap()`
(wrap the app in `EasyLocalization`) + `PortfolioApp`, scaffold `core/` + the `projects` / `profile`
/ `experience` / `contact` features, then build sections, polish responsive/motion/RTL, and deploy.
Run `build_runner` after adding any `@freezed` / `@JsonSerializable` / `@injectable` annotations.

## Deployment

GitHub Pages via `.github/workflows/deploy.yml` (`plan.md` §12): build with
`--base-href "/clever_portfolio/"` (or `"/"` + a `CNAME` for a custom domain) and add a `404.html`
SPA fallback. Requires `git init` + a GitHub remote first. Firebase Hosting is the documented
alternative.

## Hooks that will react to your actions

`.claude/settings.json` wires Claude Code hooks you should know about:

- **Blocked Bash:** `rm -rf`, `flutter clean`, `DROP`, `--force`, `truncate`, and any `git push` /
  `git rebase`. Ask the user to run these manually.
- **Blocked Edit/Write:** generated files (`*.g.dart`, `*.freezed.dart`, `*.mocks.dart`) — edit the
  source and rerun `build_runner`. Lock files (`pubspec.lock`, `Podfile.lock`, `.flutter-plugins`)
  — change `pubspec.yaml` and let pub regenerate.
- **Auto on every Dart edit:** `dart format`, `dart analyze` (reports errors/warnings inline), a
  >300-line decomposition warning, the architecture-violation check (presentation importing data),
  and — for `_test.dart` files — `flutter test` on just that file.
- **Auto on `pubspec.yaml` edit:** `flutter pub get`. On a file containing `part '*.freezed.dart'`
  or `part '*.g.dart'`: a reminder to run `build_runner`.
- **Auto on `en.json`/`ar.json` edit:** key-parity sync check between the two translation files.
- **Stop hook:** runs `dart analyze lib/`, counts unused imports, and prints the five largest Dart
  files. Treat its output as the final lint pass.
- **SessionStart:** prints the Flutter version, `git status`/`git log`, and TODO/FIXME counts.

## Commit & PR etiquette

`git push` and `git rebase` are hard-blocked — stage and commit locally; the user pushes. (Note the
repo is not initialized yet — `git init` before the first commit / CI setup.)
