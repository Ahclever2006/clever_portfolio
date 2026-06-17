---
name: clever_portfolio
description: Ahmed Maher's Flutter Web portfolio — 42 shipped apps indexed as a production terminal.
colors:
  # Dark theme (default canvas)
  d-bg: "#0A0C10"
  d-surface: "#10141A"
  d-surface-variant: "#161B22"
  d-surface-elevated: "#1B222B"
  d-ink: "#E6EDF3"
  d-ink-secondary: "#C9D1D9"
  d-muted: "#8B97A5"
  d-outline: "#222A33"
  d-outline-strong: "#303A45"
  d-primary: "#3DF5A3"
  d-primary-hover: "#56FFB4"
  d-primary-pressed: "#2BD98C"
  d-on-primary: "#04130C"
  d-secondary: "#5AA2FF"
  d-accent-soft: "#0F2A20"
  d-code-text: "#7EE3B8"
  d-folio: "#5A6470"
  d-warning: "#E3B341"
  d-danger: "#FF6B6B"
  # Light theme
  l-bg: "#F7F8FA"
  l-surface: "#FFFFFF"
  l-surface-variant: "#EEF1F4"
  l-ink: "#0B0F14"
  l-ink-secondary: "#1A2129"
  l-muted: "#5B6571"
  l-outline: "#D7DCE2"
  l-outline-strong: "#BCC4CD"
  l-primary: "#0E8F6E"
  l-accent-soft: "#D6F2E8"
  l-secondary: "#1F6FEB"
  l-folio: "#9AA4B0"
  # Category hues — dark palette (used only for index dots, filter pills, tag text)
  cat-ecommerce: "#3DF5A3"
  cat-games: "#FB923C"
  cat-booking: "#22D3EE"
  cat-business: "#5AA2FF"
  cat-food: "#FBBF24"
  cat-services: "#60A5FA"
  cat-medical: "#2DD4BF"
  cat-education: "#A78BFA"
  cat-travel: "#38BDF8"
typography:
  display:
    fontFamily: "Space Grotesk, sans-serif"
    fontSize: "64px"
    fontWeight: 600
    lineHeight: 1.02
    letterSpacing: "-1.5px"
  display-section:
    fontFamily: "Space Grotesk, sans-serif"
    fontSize: "36px"
    fontWeight: 600
    lineHeight: 1.1
    letterSpacing: "-0.5px"
  title:
    fontFamily: "Space Grotesk, sans-serif"
    fontSize: "22px"
    fontWeight: 600
    lineHeight: 1.25
    letterSpacing: "-0.2px"
  eyebrow-mono:
    fontFamily: "JetBrains Mono, monospace"
    fontSize: "14px"
    fontWeight: 500
    lineHeight: 1.3
    letterSpacing: "0.5px"
  body:
    fontFamily: "Inter, sans-serif"
    fontSize: "17px"
    fontWeight: 400
    lineHeight: 1.65
  body-small:
    fontFamily: "Inter, sans-serif"
    fontSize: "15px"
    fontWeight: 400
    lineHeight: 1.55
  label:
    fontFamily: "Inter, sans-serif"
    fontSize: "13px"
    fontWeight: 500
    lineHeight: 1.3
    letterSpacing: "0.3px"
  folio-mono:
    fontFamily: "JetBrains Mono, monospace"
    fontSize: "12px"
    fontWeight: 500
    lineHeight: 1.2
    letterSpacing: "0.5px"
  caption-mono:
    fontFamily: "JetBrains Mono, monospace"
    fontSize: "12px"
    fontWeight: 400
    lineHeight: 1.4
rounded:
  pill: "999px"
  card: "16px"
  chip: "8px"
  input: "10px"
  button: "10px"
spacing:
  xs: "4px"
  sm: "8px"
  md: "16px"
  lg: "24px"
  xl: "40px"
  xxl: "64px"
  section-desktop: "78px"
  section-mobile: "46px"
  gutter-mobile: "24px"
  gutter-desktop: "64px"
  max-content-width: "1200px"
  grid-gap: "20px"
components:
  button-primary:
    backgroundColor: "{colors.d-primary}"
    textColor: "{colors.d-on-primary}"
    rounded: "{rounded.button}"
    padding: "14px 28px"
  button-primary-hover:
    backgroundColor: "{colors.d-primary-hover}"
    textColor: "{colors.d-on-primary}"
    rounded: "{rounded.button}"
    padding: "14px 28px"
  button-ghost:
    backgroundColor: "transparent"
    textColor: "{colors.d-primary}"
    rounded: "{rounded.button}"
    padding: "14px 28px"
  chip-filter:
    backgroundColor: "{colors.d-surface-variant}"
    textColor: "{colors.d-ink-secondary}"
    rounded: "{rounded.chip}"
    padding: "6px 14px"
  chip-filter-active:
    backgroundColor: "{colors.d-accent-soft}"
    textColor: "{colors.d-primary}"
    rounded: "{rounded.chip}"
    padding: "6px 14px"
  chip-platform:
    backgroundColor: "{colors.d-surface-variant}"
    textColor: "{colors.d-muted}"
    rounded: "{rounded.pill}"
    padding: "4px 10px"
  card-app:
    backgroundColor: "{colors.d-surface}"
    textColor: "{colors.d-on-surface}"
    rounded: "{rounded.card}"
    padding: "20px"
  input-field:
    backgroundColor: "{colors.d-surface}"
    textColor: "{colors.d-ink}"
    rounded: "{rounded.input}"
    padding: "14px 16px"
---

# Design System: clever_portfolio

## 1. Overview

**Creative North Star: "The Signal Log"**

This is a production terminal with a live index. The canvas is deep carbon (`#0A0C10`), nearly black but with a faint blue-teal tint that tells you a screen is on, not paper is blank. One electric emerald (`#3DF5A3`) pulses through it as the sole signal color — the kind of green that means "process running," "build passing," "all 42 deployed." Everything else is structured neutral: layered surfaces in increasing lightness (`#10141A` → `#161B22` → `#1B222B`), monospaced folio numbers, and a restrained per-category hue system that tells you what domain an app is from without shouting.

The layout reads like a versioned release index — dense, scannable, authoritative. A recruiter or CTO landing cold should read seniority in under three seconds: a name, a count (42), a role, and an index they can filter. Typography does the heavy lifting: Space Grotesk in the 600-weight display carries mass and directness; Inter body text is a neutral reading surface; JetBrains Mono handles the engineering signals (folio numbers, index tags, version strings). The three fonts are chosen for this specific combination of roles — they are the committed brand voice, not defaults.

Both dark and light themes are first-class. The dark default is "deploy night" — a lead engineer watching CI at midnight. The light mode is "morning review" — the same engineer in a bright office. Both express the same character; neither is an afterthought.

**This system rejects:** pastel gradients and hero-metric SaaS templates; warm-neutral cream/sand canvas that reads as "AI-generated portfolio"; generic Dribbble-style card grids with icon + heading + body; glassmorphism used decoratively; eyebrow labels on every section; gradient text. The brand register is Bold · Inventive · Sharp, not safe and pleasing.

**Key Characteristics:**
- Dark-first, both themes fully specified
- One signal accent (electric emerald) used sparingly — its rarity is the point
- Per-category hues on index numbers, filter pills, and tag text only — never as fills or backgrounds
- JetBrains Mono as an engineering signal, not as decoration
- Motion is choreographed at section entry (staggered 60ms per item), then purely state-change thereafter (hover 160ms, button 120ms)
- Reduced-motion: all entrance animations collapse to a single opacity crossfade

## 2. Colors: The Signal Palette

One signal color, nine index hues, a deep neutral stack. Color is withheld deliberately so the emerald lands with force when it appears.

### Primary

- **Electric Emerald** (`#3DF5A3` dark / `#0E8F6E` light): The sole active signal. Status dots, CTA buttons, focus rings, hover accent lines, active filter pills. Every other use of "green" is this or its pressed/hover variants. Its soft shell (`#0F2A20` dark / `#D6F2E8` light) is used as the selected-state background on filter chips and tag surfaces.
- **Emerald Hover** (`#56FFB4` dark / `#0B7559` light): Primary button hover and link hover state. Never used at rest.
- **Emerald Pressed** (`#2BD98C` dark / `#095F49` light): Active/pressed state. Provides tactile feedback without brightness.
- **On-Primary** (`#04130C` dark): Text rendered inside an emerald button. Near-black with a deep green cast — pairs perfectly with the bright accent without destroying the terminal mood.

### Secondary

- **Signal Blue** (`#5AA2FF` dark / `#1F6FEB` light): Secondary interactive elements. Used when a second accent is needed (e.g., external link icons, secondary CTA). Never competes with the emerald; both can coexist in one row if they are visually separated.

### Tertiary

Category hues (`cat-*`) form a nine-color index vocabulary. Each maps to one app category:

| Category | Dark hue | Light hue |
|---|---|---|
| E-Commerce | `#3DF5A3` | `#0E8F6E` |
| Games | `#FB923C` | `#C2410C` |
| Booking | `#22D3EE` | `#0E7490` |
| Business | `#5AA2FF` | `#1F6FEB` |
| Food | `#FBBF24` | `#B45309` |
| Services | `#60A5FA` | `#2563EB` |
| Medical | `#2DD4BF` | `#0D9488` |
| Education | `#A78BFA` | `#6D28D9` |
| Travel | `#38BDF8` | `#0891B2` |

**The Index Dot Rule.** Category hues touch only three surfaces: the small circular dot or leading bar on an app index row, the category filter chip text when active, and the small category tag on an app card. They are never used as card backgrounds, fill colors, gradient sources, or display text. Their role is wayfinding, not atmosphere.

### Neutral

The neutral stack is the system's foundation. Dark theme layers three distinct surface levels above the `#0A0C10` canvas:

- **Void Canvas** (`#0A0C10`): Page background. The darkest surface — the terminal screen itself.
- **Indexed Surface** (`#10141A`): Default card/panel background. The first tonal step up from canvas.
- **Elevated Surface** (`#161B22`): Hover state for rows, inner section backgrounds, secondary panels.
- **Lifted Surface** (`#1B222B`): Modals, dropdowns, tooltips. The maximum elevation.
- **Primary Ink** (`#E6EDF3`): Body text, headings on dark. High contrast against canvas.
- **Secondary Ink** (`#C9D1D9`): Supporting text, subtitles, card descriptions.
- **Muted** (`#8B97A5`): Timestamps, meta, folio labels. Still AA-compliant on `#10141A`.
- **Outline** (`#222A33`): Dividers, borders at rest.
- **Outline Strong** (`#303A45`): Focused borders, hover borders.
- **Folio** (`#5A6470` dark / `#9AA4B0` light): Index numbers in their resting state (unselected, un-hovered). Intentionally quieter than muted.

Light theme mirrors this structure: `#F7F8FA` canvas, `#FFFFFF` surface, `#EEF1F4` variant, with ink roles inverted to near-black.

**The One Signal Rule.** The electric emerald appears on ≤10% of any given screen in its full brightness. Seeing it means something is active, passing, or interactive. If it appears everywhere, it means nothing.

**The No-Fill Rule.** Category hues never fill areas larger than 24px × 24px (a dot, a short bar, a short text string). They are wayfinding marks, not palette colors.

## 3. Typography

**Display Font:** Space Grotesk (Google Fonts, with Cairo Arabic fallback)
**Body Font:** Inter (Google Fonts, with Cairo Arabic fallback)
**Signal / Mono Font:** JetBrains Mono (Google Fonts, with Cairo Arabic fallback)

**Character:** Space Grotesk at 600 weight reads precise and slightly mechanical — engineered, not editorial. Inter is the neutral reading surface that disappears. JetBrains Mono is the only mono face because monospace is an engineering signal here, earned by context (folio numbers, version tags, index labels), not applied decoratively.

All sizes use `.sp` responsive scaling (flutter_screenutil) — the px values below are base 1:1 design targets.

### Hierarchy

- **Display Hero** (600, 64px → fluid up to ~88px, lh 1.02, ls −1.5px): The single hero headline. Ahmed's name + role. Used once per page.
- **Display Section** (600, 36px, lh 1.1, ls −0.5px): Section headings. "Work Index." "Profile." "Contact." Maximum 6 per page.
- **Title** (600, 22px, lh 1.25, ls −0.2px): App card titles, experience role titles. The primary label inside a content unit.
- **Eyebrow Mono** (JetBrains Mono 500, 14px, lh 1.3, ls +0.5px): Section identifiers used as deliberate brand system — not as an eyebrow above every heading, but as a named JetBrains Mono signal (e.g., "v3.41", "FLUTTER · DART", a formatted date). One deliberate use per section maximum.
- **Body** (400, 17px, lh 1.65): Primary prose. Max line length 65–75ch. Applies `text-wrap: pretty` equivalent in Flutter to reduce orphans.
- **Body Small** (400, 15px, lh 1.55): Supporting text in cards, bio snippets, tooltips.
- **Label** (Inter 500, 13px, lh 1.3, ls +0.3px): UI labels, button text, chip text, navigation items. Uppercase is prohibited here — labels are sentence-case or all-lowercase.
- **Folio Mono** (JetBrains Mono 500, 12px, lh 1.2, ls +0.5px): App index numbers (01–42). The app number displayed in the index list.
- **Caption Mono** (JetBrains Mono 400, 12px, lh 1.4): Timestamps, version strings, store metadata.

**The Mono Restraint Rule.** JetBrains Mono is used in three specific roles: folio numbers, eyebrow signals, and version/date metadata. It is never used for body text, headings, or button labels. Monospace is earned by context.

**The Arabic Parity Rule.** All three families fall back to Cairo for Arabic glyphs. Both EN and AR locales must render at identical hierarchy and weight — no fallback degradation. RTL layout uses `start`/`end` everywhere; never `left`/`right`.

## 4. Elevation

This system uses **tonal layering as structure** and **emerald glow as the single expressive elevation**. No general-purpose shadows.

Depth is expressed through four surface levels (`#0A0C10` → `#10141A` → `#161B22` → `#1B222B`). Each step up means "this content is closer to the user." Cards sit at level 1; hovered rows shift to level 2; modals use level 3. The layers are close enough in value to maintain a unified dark mood while clearly separating content planes.

The emerald glow (`#3DF5A340`, ~25% opacity) is the system's one shadow: it appears under primary CTA buttons on hover, under active filter pills, and as a diffuse ring around focused inputs. It never appears at rest. Its purpose is the same as the emerald accent — a signal that something is alive.

### Shadow Vocabulary

- **Accent Glow** (`box-shadow: 0 0 16px 0 #3DF5A340`): Applied on hover to primary buttons and active accent elements only. The glow radius is 16px; larger bleeds into neighboring content. Reduced-motion: glow appears instantly (no transition) instead of fading in.
- **Modal Lift** (`box-shadow: 0 8px 32px 0 rgba(0,0,0,0.48)`): Applied to modals and drawers to separate them from the tonal-layered page. Deep near-black shadow, not colored.

**The Flat-By-Default Rule.** Every surface is flat at rest. No resting shadows on cards, chips, inputs, or navigation. Shadows are state responses (hover, focus, elevation), not decorative.

**The One Glow Rule.** The emerald glow is used on exactly one class of surface at any moment: the element the user is actively interacting with. Two glowing elements on screen simultaneously dilute the signal.

## 5. Components

### Buttons

Clinical and direct. No ornament, full commitment on the primary.

- **Shape:** Gently angular (10px radius — `{rounded.button}`)
- **Primary:** Electric emerald fill (`{colors.d-primary}`), near-black text (`{colors.d-on-primary}`), padding 14px × 28px. Label style (Inter 500, 13px).
- **Hover:** Brightened emerald (`{colors.d-primary-hover}`) + accent glow (`0 0 16px 0 #3DF5A340`). Transition: 160ms easeOut.
- **Pressed:** Deeper emerald (`{colors.d-primary-pressed}`), no glow. Transition: 120ms.
- **Ghost:** Transparent background, emerald text + 1px emerald border. Hover: `{colors.d-accent-soft}` fill. Used for secondary CTAs that must not compete with the primary.
- **Focus:** 2px emerald outline (`{colors.d-focus-ring}`) at 2px offset. Keyboard-visible; hidden on pointer focus.

### Chips

Three variants: filter (category/platform toggle), platform badge, skill badge.

- **Filter Chip:** 8px radius (`{rounded.chip}`), `{colors.d-surface-variant}` background, `{colors.d-ink-secondary}` text. Active: `{colors.d-accent-soft}` background, `{colors.d-primary}` text. Padding 6px × 14px. Label style.
- **Platform Chip:** Pill radius (`{rounded.pill}`), `{colors.d-surface-variant}` background, `{colors.d-muted}` text. No active state — display-only. Padding 4px × 10px. Caption mono style.
- **Skill Chip:** Same as platform chip but label style (Inter 500, 13px). Used in the profile/skills section.

**The Chip Grammar Rule.** Chips are the only components that use the pill radius. Everything else (cards, buttons, inputs) stays at ≤16px. Pill radius on non-chip components reads as a different design language.

### Cards / Containers

The app index card is the primary content surface. It must not compete with the content it frames.

- **Corner Style:** 16px radius (`{rounded.card}`) — gently curved, not soft
- **Background:** `{colors.d-surface}` (`#10141A`) — one tonal step above canvas
- **Hover State:** Background shifts to `{colors.d-surface-variant}` (`#161B22`). No shadow added at hover; tonal shift is the affordance.
- **Border:** `1px solid {colors.d-outline}` at rest. Transitions to `{colors.d-outline-strong}` on hover. No colored left-stripe borders — category identity is carried by the index dot, not a border stripe.
- **Internal Padding:** 20px (uniform — `{spacing.md}` base + `{spacing.sm}`)
- **Shadow Strategy:** None at rest. The card is a tonal surface, not a lifted object.

### Inputs / Fields

- **Style:** 10px radius (`{rounded.input}`), `{colors.d-surface}` background, 1px `{colors.d-outline}` border.
- **Focus:** Border transitions to `{colors.d-primary}` (1px → 1.5px). Accent glow applied (`0 0 12px 0 #3DF5A320`). Transition: 200ms easeOut.
- **Error:** Border color shifts to `{colors.d-danger}` (`#FF6B6B`). No background change.
- **Disabled:** Opacity 0.4, no pointer events. No special background or color change.
- **Placeholder:** Uses `{colors.d-muted}` (`#8B97A5`). This color is AA-compliant on `#10141A` (contrast ratio ≥4.5:1 verified).

### Navigation

The nav is fixed/sticky, transparent at top → `{colors.d-surface}` + blur at scroll. It does not compete with content.

- **Style:** Horizontal row, desktop; drawer or bottom bar, mobile.
- **Typography:** Label style (Inter 500, 13px), `{colors.d-ink-secondary}` default.
- **Hover:** Color transitions to `{colors.d-ink}` over 160ms. A 2px emerald underline hairline appears below the hovered item.
- **Active / Current section:** Emerald underline hairline stays visible. Text color `{colors.d-primary}`.
- **Theme toggle:** Appears in the nav as a ghost icon button, no label.

### App Index Row (Signature Component)

The release index row is the system's primary information unit. It is dense, scannable, and typographically precise.

- **Structure (left to right):** Folio mono number (01–42) in `{colors.d-folio}` → category color dot (8px circle) → App name in Title style → category chip → platform chip(s) → store link button(s)
- **Row background:** Transparent at rest. Shifts to `{colors.d-surface-variant}` on hover.
- **Selected/expanded:** `{colors.d-accent-soft}` background, `{colors.d-primary}` folio number.
- **Divider:** `1px solid {colors.d-outline}` between rows. No divider above the first row.
- **Animation:** Rows stagger in on initial load: 60ms delay per row, 480ms easeOutCubic. Reduced-motion: single opacity fade for all rows simultaneously.

## 6. Do's and Don'ts

### Do:

- **Do** use `{colors.d-primary}` (Electric Emerald) for exactly one interactive role per screen: CTA buttons, active filter state, or status indicators — never all three simultaneously.
- **Do** express depth through tonal surface layers (`#0A0C10` → `#10141A` → `#161B22` → `#1B222B`). The layers are the architecture.
- **Do** use JetBrains Mono exclusively for folio numbers, version/date metadata, and single-line eyebrow signals. Never for body copy or headings.
- **Do** keep all eight WCAG AA contrast ratios in both themes. Body text (17px) must clear 4.5:1; large text (22px+) must clear 3:1. Muted text on `#10141A` clears 4.5:1 — verify every new surface.
- **Do** gate all entrance animations behind `prefers-reduced-motion`. The default reveal is: staggered fade-in + 16px vertical translate per item. Reduced-motion alternative: single opacity crossfade for the entire section.
- **Do** use `start`/`end` for all padding, margin, and alignment in Flutter widgets. Never `left`/`right` unless suppressed with `// ignore-rtl` and a written reason.
- **Do** render store buttons (App Store, Google Play) only when a store ID exists in `apps.json`. No empty/disabled store buttons.

### Don't:

- **Don't** use `border-left` greater than 1px as a colored accent stripe on any card, list row, or callout. The category identity signal is the index dot, not a side stripe. A side stripe is the single most common failure mode in this exact system.
- **Don't** use gradient text (`background-clip: text` + gradient). Text color is always a single solid token. Emphasis through weight or size.
- **Don't** use glassmorphism decoratively. Blur/backdrop-filter is reserved for one use: the sticky navigation on scroll.
- **Don't** use the warm-neutral body background band (OKLCH L 0.84–0.97, C < 0.06, hue 40–100). The light theme background is `#F7F8FA` — a cool-neutral with zero warmth tint. The portfolio rejects the cream/sand/parchment AI default.
- **Don't** create hero-metric layouts (large number, small label, supporting stats, gradient accent). The 42 apps are surfaced through the release index, not a hero stat block.
- **Don't** put eyebrow labels (small all-caps tracked text) above every section heading. JetBrains Mono eyebrow text is used once per section maximum, and only when it carries real technical information (a version number, a technology name, a formatted date) — never as section grammar.
- **Don't** use numbered section markers (01 / 02 / 03) outside the app release index. Numbers in the index are a deliberate semantic system; numbered section headings in About, Experience, or Contact are AI scaffolding.
- **Don't** place per-category hues on any surface larger than 24px × 24px. They are wayfinding dots, not palette colors.
- **Don't** hardcode any color, font size, or spacing value in a widget. All tokens flow from `Theme.of(context)`, `context.colors`, `context.brand`, `context.spacing`, `context.radii`.
- **Don't** use `Colors.*` in widgets (except `Colors.transparent`). Use `AppColors` in the theme layer only.
