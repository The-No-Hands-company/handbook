#!/usr/bin/env bash
# Fails when the published brand drifts from its source:
#  - a generated logo SVG differs from what the master produces,
#  - an icon is missing or the wrong size,
#  - a colour pair brand.md promises falls below its contrast level (pairs listed below; keep them in step with brand.md),
#  - brand.md lacks a section, or the README does not list it.
set -euo pipefail
ROOT="${ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "$ROOT"
fail=0; bad(){ echo "FAIL: $*"; fail=1; }

# 1. generated SVGs match the master
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
python3 scripts/build-brand.py --svg-only --out "$tmp" >/dev/null || bad "build-brand.py failed"
for f in "$tmp"/logo/*.svg; do
  rel="logo/$(basename "$f")"
  if [ ! -f "brand/$rel" ]; then bad "brand/$rel missing (run scripts/build-brand.py)"
  elif ! cmp -s "$f" "brand/$rel"; then bad "brand/$rel differs from the master (edit tnhc-sign.svg and rebuild; never hand-edit a generated file)"; fi
done

# 2. every icon exists at its size
icons=$(PYTHONDONTWRITEBYTECODE=1 python3 -c '
import importlib.util, sys
spec = importlib.util.spec_from_file_location("b", "scripts/build-brand.py"); b = importlib.util.module_from_spec(spec); spec.loader.exec_module(b)
for rel, s in b.PNGS.items(): print(rel, s)') || bad "could not read the icon list from build-brand.py"
[ -n "$icons" ] || bad "build-brand.py lists no icons"
while read -r rel size; do
  [ -n "$rel" ] || continue
  [ -f "brand/$rel" ] || { bad "brand/$rel missing"; continue; }
  got=$(magick identify -format '%wx%h' "brand/$rel" 2>/dev/null || echo none)
  [ "$got" = "${size}x${size}" ] || bad "brand/$rel is $got, expected ${size}x${size}"
done <<< "$icons"
if [ -f brand/icons/favicon.ico ]; then
  sizes=$(magick identify -format '%w ' brand/icons/favicon.ico 2>/dev/null | tr ' ' '\n' | sort -n | xargs)
  [ "$sizes" = "16 32 48" ] || bad "brand/icons/favicon.ico holds sizes '$sizes', expected '16 32 48'"
else bad "brand/icons/favicon.ico missing"; fi

# 3. contrast of every colour pair brand.md promises
python3 - <<'PY' || fail=1
def lum(h):
    c = [int(h[i:i + 2], 16) / 255 for i in (1, 3, 5)]
    c = [x / 12.92 if x <= 0.03928 else ((x + 0.055) / 1.055) ** 2.4 for x in c]
    return 0.2126 * c[0] + 0.7152 * c[1] + 0.0722 * c[2]
def ratio(a, b):
    a, b = lum(a), lum(b)
    return (max(a, b) + 0.05) / (min(a, b) + 0.05)
# (foreground, background, minimum): text 7:1 (AAA), muted and accent 4.5:1 (AA)
PAIRS = [
    ("#EDEDED", "#030303", 7), ("#EDEDED", "#0D0D0D", 7),
    ("#A8A8A8", "#030303", 4.5), ("#A8A8A8", "#0D0D0D", 4.5),
    ("#CCFF00", "#030303", 4.5), ("#CCFF00", "#0D0D0D", 4.5), ("#030303", "#CCFF00", 4.5),
    ("#0A0A0A", "#F4F4F0", 7), ("#0A0A0A", "#FFFFFF", 7),
    ("#55554F", "#F4F4F0", 4.5), ("#55554F", "#FFFFFF", 4.5), ("#0A0A0A", "#CCFF00", 4.5),
]
import os, sys
extra = os.environ.get("BRAND_EXTRA_PAIR")  # test hook: "fg bg min"
if extra:
    fg, bg, m = extra.split(); PAIRS.append((fg, bg, float(m)))
bad = [f"{fg} on {bg} is {ratio(fg, bg):.2f}:1, needs {m}:1" for fg, bg, m in PAIRS if ratio(fg, bg) < m]
for b in bad: print("FAIL: contrast", b)
sys.exit(1 if bad else 0)
PY

# 4. brand.md and the README
if [ -f brand.md ]; then
  for h in "## Logo" "## Colour" "## Typeface" "## Names" "## Files"; do
    grep -qx "$h" brand.md || bad "brand.md lacks the section '$h'"
  done
else bad "brand.md missing"; fi
grep -q 'brand.md' README.md || bad "README.md does not list brand.md"

[ "$fail" = 0 ] && echo PASS || exit 1
