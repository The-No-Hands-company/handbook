#!/usr/bin/env bash
# Fails when the Charter is missing a required section, carries a placeholder,
# or contradicts the "nobody owns this" licensing.
set -euo pipefail
cd "$(dirname "$0")/.."
f=charter.md
[ -f "$f" ] || { echo "FAIL: $f missing"; exit 1; }
head -1 "$f" | grep -qx '# The No Hands Company Charter' || { echo "FAIL: title"; exit 1; }
for h in '## Our promises' '## Ownership and licences' '## Money' '## How we build' '## Who decides' '## Taking part'; do
  grep -qx "$h" "$f" || { echo "FAIL: missing section: $h"; exit 1; }
done
for bad in 'TODO' 'TBD' 'All rights reserved' '™'; do
  if grep -rIl --exclude-dir=.git --exclude=check-charter.sh -- "$bad" . >/dev/null; then echo "FAIL: found '$bad'"; exit 1; fi
done
grep -q 'https://tnhc.dev/phantom' "$f" || { echo "FAIL: Phantom status link missing"; exit 1; }
[ -f CODE_OF_CONDUCT.md ] && grep -q 'info@tnhc.dev' CODE_OF_CONDUCT.md || { echo "FAIL: Code of Conduct contact"; exit 1; }
grep -q 'Attribution 4.0 International' LICENSE || { echo "FAIL: LICENSE is not CC BY 4.0"; exit 1; }
[ -f privacy.md ] || { echo "FAIL: privacy.md missing"; exit 1; }
head -1 privacy.md | grep -qx '# Privacy status' || { echo "FAIL: privacy.md title"; exit 1; }
grep -q 'https://tnhc.dev/privacy' charter.md || { echo "FAIL: Charter does not link the privacy status page"; exit 1; }
if grep -qi 'data of any kind' charter.md; then echo "FAIL: Charter still claims no data of any kind"; exit 1; fi
for h in '## Our promises, and where they stand' '## What we keep, and why' '## What others can see'; do
  grep -qx "$h" privacy.md || { echo "FAIL: privacy.md missing section: $h"; exit 1; }
done
echo PASS
