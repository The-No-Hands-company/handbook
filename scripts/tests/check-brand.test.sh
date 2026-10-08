#!/usr/bin/env bash
# Proves check-brand.sh catches each kind of drift, on a throwaway copy.
set -uo pipefail
HERE="$(cd "$(dirname "$0")/../.." && pwd)"
rc=0; ok(){ echo "ok - $1"; }; no(){ echo "NOT OK - $1"; rc=1; }
fresh(){ local d; d=$(mktemp -d); cp -r "$HERE"/. "$d"/; rm -rf "$d/.git"; echo "$d"; }
run(){ ROOT="$1" bash "$1/scripts/check-brand.sh" 2>&1; }

d=$(fresh); out=$(run "$d"); [ $? = 0 ] && ok "clean copy passes" || no "clean copy: $out"; rm -rf "$d"

d=$(fresh); sed -i 's/#EDEDED/#EEEEEE/' "$d/brand/logo/tnhc-lockup-dark.svg"
out=$(run "$d"); [ $? = 1 ] && echo "$out" | grep -q 'tnhc-lockup-dark.svg differs' && ok "hand-edited variant caught" || no "hand-edit: $out"; rm -rf "$d"

d=$(fresh); magick "$d/brand/icons/app-icon-192.png" -resize 100x100 "$d/brand/icons/app-icon-192.png"
out=$(run "$d"); [ $? = 1 ] && echo "$out" | grep -q 'app-icon-192.png is 100x100' && ok "wrong-size icon caught" || no "wrong size: $out"; rm -rf "$d"

d=$(fresh); out=$(BRAND_EXTRA_PAIR="#CCFF00 #F4F4F0 4.5" run "$d"); [ $? = 1 ] && echo "$out" | grep -q 'contrast #CCFF00 on #F4F4F0' && ok "low contrast caught" || no "contrast: $out"; rm -rf "$d"

d=$(fresh); sed -i '/^## Names$/d' "$d/brand.md"
out=$(run "$d"); [ $? = 1 ] && echo "$out" | grep -q "lacks the section '## Names'" && ok "missing section caught" || no "section: $out"; rm -rf "$d"

exit $rc
