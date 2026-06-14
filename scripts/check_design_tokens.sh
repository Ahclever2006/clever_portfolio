#!/usr/bin/env bash
#
# check_design_tokens.sh — design-system / RTL / i18n compliance gate.
#
# Mirrors the hard rules in CLAUDE.md "Design System (non-negotiable)" and
# .claude/settings.json `instructions`. Scans only the layers where the rules
# apply: lib/features/ and lib/core/widgets/. ThemeData/token definitions
# (lib/core/theme/, lib/app/) are intentionally exempt — that is where raw
# values legitimately live.
#
# ERRORS (exit 1):
#   - Color(0x..) / Colors.*  (Colors.transparent allowed; suppress: // ignore-color)
#   - raw fontSize: literal    (must use .sp)
#   - raw SizedBox width/height literal (must use .w / .h)
#   - BorderRadius.circular(<number>) (use .r or AppRadius)
#   - EdgeInsets.only(left:|right:) / Alignment.*Left|Right (use start/end; suppress: // ignore-rtl)
# WARNINGS (do not fail the build):
#   - raw ElevatedButton / OutlinedButton / TextFormField (prefer App* widgets)
#   - user-visible Text('literal') without .tr() (mark intentional: // no-tr)
#
# No `set -u`: macOS bash 3.2 treats expanding an empty array as "unbound".
# The empty-array guard before grep keeps it from hanging on stdin.
set -o pipefail

SCAN_DIRS=("lib/features" "lib/core/widgets")
errors=0
warnings=0

# Collect existing target files.
files=()
for d in "${SCAN_DIRS[@]}"; do
  if [ -d "$d" ]; then
    while IFS= read -r f; do files+=("$f"); done < <(find "$d" -name '*.dart' -type f)
  fi
done

if [ "${#files[@]}" -eq 0 ]; then
  echo "✅ check_design_tokens: no files in ${SCAN_DIRS[*]} yet — nothing to check."
  exit 0
fi

# Files for the "prefer App* widget" rule — it targets FEATURE code, not the
# App* wrapper definitions that legitimately wrap Material widgets.
feat_files=()
if [ -d "lib/features" ]; then
  while IFS= read -r f; do feat_files+=("$f"); done < <(find "lib/features" -name '*.dart' -type f)
fi

# $1 = grep -E pattern, $2 = message, $3 = suppression marker, $4 = level
#   (error|warn), $5 = scope (all|features)
check() {
  local pattern="$1" msg="$2" suppress="${3:-}" level="${4:-error}" scope="${5:-all}"
  local -a scan
  if [ "$scope" = "features" ]; then scan=("${feat_files[@]}"); else scan=("${files[@]}"); fi
  [ "${#scan[@]}" -eq 0 ] && return 0
  local hits
  hits=$(grep -nE "$pattern" "${scan[@]}" 2>/dev/null || true)
  [ -n "$suppress" ] && hits=$(echo "$hits" | grep -vE -- "$suppress" || true)
  hits=$(echo "$hits" | sed '/^$/d')
  if [ -n "$hits" ]; then
    if [ "$level" = "warn" ]; then
      echo "🟡 WARN: $msg"
      warnings=$((warnings + 1))
    else
      echo "🔴 ERROR: $msg"
      errors=$((errors + 1))
    fi
    echo "$hits" | sed 's/^/    /'
  fi
}

# --- ERRORS ---
check 'Color\(0x' 'hardcoded Color(0x..) — use AppColors / colorScheme' '// ignore-color'
check 'Colors\.[A-Za-z]' 'Colors.* — use AppColors / colorScheme (Colors.transparent ok)' 'Colors\.transparent|// ignore-color'
# Numeric checks anchor on a trailing , ) or space so values ending in a unit
# method (.sp / .w / .h / .r) are NOT flagged (e.g. `16.sp` is fine).
check 'fontSize:[[:space:]]*[0-9][0-9.]*[,) ]' 'raw fontSize literal — use AppTypography with .sp'
check 'SizedBox\((width|height):[[:space:]]*[0-9][0-9.]*[,) ]' 'raw SizedBox size — use .w / .h'
check 'BorderRadius\.circular\([0-9][0-9.]*[,) ]' 'raw BorderRadius.circular — use .r or AppRadius'
check 'EdgeInsets\.only\([^)]*(left|right):' 'EdgeInsets.only(left/right) — use start/end (EdgeInsetsDirectional)' '// ignore-rtl'
check 'Alignment\.[a-zA-Z]*(Left|Right)' 'Alignment.*Left/Right — use AlignmentDirectional start/end' '// ignore-rtl'

# --- WARNINGS ---
check '(ElevatedButton|OutlinedButton|TextFormField)\(' 'raw Material widget in features/ — prefer App* (AppButton / AppTextField)' '// allow-raw' warn features
check "Text\((['\"])" 'Text() with a literal — ensure .tr() (mark intentional with // no-tr)' '// no-tr' warn

echo ""
echo "check_design_tokens: $errors error(s), $warnings warning(s) across ${#files[@]} file(s)."
[ "$errors" -gt 0 ] && exit 1
exit 0
