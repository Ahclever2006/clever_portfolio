#!/usr/bin/env bash
#
# convert_screenshots_to_webp.sh — shrink the project screenshot corpus.
#
# The screenshots in assets/images/projects/ are raw phone captures (up to
# 2064x2752 / 3.7 MB) but are displayed at ~384 logical px — roughly 768 device
# px at DPR 2. PNG/JPG bytes are already compressed, so GitHub Pages' gzip does
# nothing for them: the visitor downloads them raw. Re-encoding to WebP at a
# display-appropriate width cuts the corpus by ~80% with no visible difference.
#
# Scope: ONLY the files listed under `screenshots` in assets/data/apps.json.
# App icons (`iconAsset`) are already correctly sized (44 files)
# and are deliberately left alone.
#
# The conversion is in-place and destructive by design — the originals stay
# recoverable from git history, and keeping both sets would defeat the point.
# Run it once, review `git status`, commit.
#
# Usage:
#   bash scripts/convert_screenshots_to_webp.sh              # convert
#   DRY_RUN=1 bash scripts/convert_screenshots_to_webp.sh    # report only
#   QUALITY=85 MAX_WIDTH=1440 bash scripts/convert_screenshots_to_webp.sh
#
# Requires: cwebp (brew install webp), python3, and sips (macOS) or
# ImageMagick's `identify` for source-width detection.

set -o pipefail

QUALITY="${QUALITY:-80}"
MAX_WIDTH="${MAX_WIDTH:-1080}"
DRY_RUN="${DRY_RUN:-0}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT" || exit 1

APPS_JSON="assets/data/apps.json"

if ! command -v cwebp >/dev/null 2>&1; then
  echo "❌ cwebp not found. Install it: brew install webp"
  exit 1
fi
if ! command -v python3 >/dev/null 2>&1; then
  echo "❌ python3 not found (needed to read/rewrite $APPS_JSON)."
  exit 1
fi
if [ ! -f "$APPS_JSON" ]; then
  echo "❌ $APPS_JSON not found — run this from the repo."
  exit 1
fi

# Source pixel width, or empty when it cannot be determined.
pixel_width() {
  if command -v sips >/dev/null 2>&1; then
    sips -g pixelWidth "$1" 2>/dev/null | awk '/pixelWidth:/ {print $2}'
  elif command -v identify >/dev/null 2>&1; then
    identify -format '%w' "$1" 2>/dev/null
  fi
}

bytes_of() { wc -c < "$1" | tr -d ' '; }

# Every screenshot path in apps.json, one per line. Icons are not in this list.
# `while read` rather than `mapfile` — macOS ships bash 3.2, which lacks it.
SHOTS=()
while IFS= read -r line; do
  [ -n "$line" ] && SHOTS+=("$line")
done < <(python3 -c "
import json
apps = json.load(open('$APPS_JSON'))
apps = apps if isinstance(apps, list) else apps.get('apps', [])
for a in apps:
    for s in a.get('screenshots') or []:
        print(s)
")

if [ "${#SHOTS[@]}" -eq 0 ]; then
  echo "❌ no screenshots listed in $APPS_JSON — nothing to do."
  exit 1
fi

echo "🖼  ${#SHOTS[@]} screenshots referenced · quality q$QUALITY · max width ${MAX_WIDTH}px"
[ "$DRY_RUN" = "1" ] && echo "   (DRY_RUN — nothing will be written)"
echo

before_total=0
after_total=0
converted=0
skipped=0
missing=0
failed=0

for src in "${SHOTS[@]}"; do
  if [ ! -f "$src" ]; then
    echo "  ⚠️  missing: $src"
    missing=$((missing + 1))
    continue
  fi

  src_bytes=$(bytes_of "$src")
  before_total=$((before_total + src_bytes))

  # Already WebP: count it, leave it.
  if [[ "$src" == *.webp ]]; then
    after_total=$((after_total + src_bytes))
    skipped=$((skipped + 1))
    continue
  fi

  dst="${src%.*}.webp"

  # Downscale only — never upscale a source that is already small.
  width=$(pixel_width "$src")
  resize_args=()
  if [ -n "$width" ] && [ "$width" -gt "$MAX_WIDTH" ] 2>/dev/null; then
    resize_args=(-resize "$MAX_WIDTH" 0)
  fi

  if [ "$DRY_RUN" = "1" ]; then
    after_total=$((after_total + src_bytes))
    converted=$((converted + 1))
    continue
  fi

  if ! cwebp -quiet -q "$QUALITY" "${resize_args[@]}" "$src" -o "$dst" 2>/dev/null; then
    echo "  ❌ convert failed: $src"
    after_total=$((after_total + src_bytes))
    failed=$((failed + 1))
    continue
  fi

  dst_bytes=$(bytes_of "$dst")
  after_total=$((after_total + dst_bytes))
  rm -f "$src"
  converted=$((converted + 1))
done

if [ "$DRY_RUN" != "1" ] && [ "$converted" -gt 0 ]; then
  # Point apps.json at the new extensions. Screenshots only — `iconAsset` is
  # untouched, and a path is only rewritten when the .webp actually exists.
  python3 - "$APPS_JSON" <<'PY'
import json, os, sys

path = sys.argv[1]
with open(path) as f:
    data = json.load(f)

apps = data if isinstance(data, list) else data.get('apps', [])
changed = 0
for a in apps:
    shots = a.get('screenshots')
    if not shots:
        continue
    for i, s in enumerate(shots):
        if s.endswith('.webp'):
            continue
        cand = s.rsplit('.', 1)[0] + '.webp'
        if os.path.isfile(cand):
            shots[i] = cand
            changed += 1

with open(path, 'w') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')
print(f"   apps.json: {changed} screenshot paths rewritten to .webp")
PY
fi

mb() { python3 -c "print(f'{$1/1048576:.2f} MB')"; }

echo
echo "   converted: $converted   already webp: $skipped   missing: $missing   failed: $failed"
echo "   before: $(mb "$before_total")"
echo "   after:  $(mb "$after_total")"
if [ "$before_total" -gt 0 ]; then
  python3 -c "print(f'   saved:  {($before_total-$after_total)/1048576:.2f} MB ({100*($before_total-$after_total)/$before_total:.1f}%)')"
fi

[ "$failed" -gt 0 ] && exit 1
exit 0
