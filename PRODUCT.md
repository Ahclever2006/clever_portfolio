# Product

## Register

brand

## Users

Two equal audiences:

**Recruiters & hiring managers** — evaluating Ahmed Maher for a Flutter Team Lead role. They scan fast, skim for signal (shipped work, seniority, depth), and need to trust the engineer before they read the copy.

**Potential clients / freelance buyers** — businesses or startups considering Ahmed for contract or consulting work. They care about track record, breadth (42 live apps), and whether the portfolio itself proves he can deliver production-grade software.

Both arrive skeptical and leave convinced — or don't leave at all.

## Product Purpose

A single-page Flutter Web portfolio that frames 42 published App Store / Google Play apps as a versioned, filterable release index — numbered 01–42, scannable, credible. The portfolio doubles as a portfolio artifact: the codebase itself (Clean Architecture, sealed states, full token system) is evidence of how Ahmed writes production Flutter.

Success: visitor lands, immediately reads the seniority signal, finds the app that matches their domain, and reaches out or downloads the CV. No confusion, no filler.

## Brand Personality

Bold · Inventive · Sharp

Voice is direct, technically exact, and confident — never self-promotional or soft. Copy reads like documentation written by someone who ships. Aesthetic: "Production Terminal — Indexed Edition" — IDE precision meets editorial catalog calm, anchored by one electric-emerald accent and a dark-first canvas.

## Anti-references

- **Generic Dribbble/Behance portfolios** — pastel gradients, hero-metric templates, identical card grids, eyebrow labels on every section, numbered section scaffolding (01 About / 02 Process). These signal "AI-generated" and dilute credibility.
- **Saturated-AI cream / sand / warm-neutral body bg** — the whole warm-neutral band (OKLCH L 0.84–0.97, C < 0.06, hue 40–100) reads as template regardless of name.
- **Glassmorphism as decoration** — blurs and glass cards used as filler rather than purposefully.
- **Gradient text** — decorative background-clip text. Never here.

## Design Principles

1. **The codebase is the argument.** Every design choice (token system, architecture, tests) doubles as evidence of engineering judgment. The portfolio proves its own brief.
2. **Index, don't decorate.** 42 apps are the hero. The UI frames and surfaces them — it never competes with them. Restraint is the loudest signal.
3. **Seniority reads in seconds.** A recruiter or CTO landing cold must read "Team Lead, 42 shipped apps" before they scroll. Hierarchy and density carry that signal, not hero text.
4. **Dark-first, both themes first-class.** Dark is the default aesthetic; light is equally complete, not an afterthought. The cross-fade is intentional craft.
5. **Engineering grammar only.** One accent, per-category hues used sparingly, JetBrains Mono for signals, Space Grotesk for display. No decorative flourishes that don't carry information.

## Accessibility & Inclusion

- WCAG AA minimum (contrast ≥ 4.5:1 body, ≥ 3:1 large text).
- Keyboard navigable — all interactive elements reachable, focus ring visible.
- Reduced-motion gated: all entrance animations have a `prefers-reduced-motion` alternative (crossfade or instant).
- RTL first-class: Arabic (`ar`) is a supported locale; all layout uses start/end, no hardcoded left/right.
- No motion-gated content visibility: sections are visible by default, animations enhance — never gate.
