#!/usr/bin/env bash
set -uo pipefail
LEDGER="memory/goal-ledger.tsv"; VIOLATIONS=0
for g in goals/*.md; do
  [ -e "$g" ] || continue
  grep -q '^status: retired' "$g" && continue
  pred=$(grep '^predicate:' "$g" | cut -d' ' -f2-); name=$(basename "$g" .md)
  start=$(date +%s)
  if command -v timeout >/dev/null; then timeout 60 bash -c "$pred" >/dev/null 2>&1; elif command -v gtimeout >/dev/null; then gtimeout 60 bash -c "$pred" >/dev/null 2>&1; else bash -c "$pred" >/dev/null 2>&1; fi
  if [ $? -eq 0 ]; then r=pass
    sed -i.bak "s/^status:.*/status: satisfied/; s/^last-pass:.*/last-pass: $(date +%F)/" "$g"
  else r=FAIL; VIOLATIONS=$((VIOLATIONS+1)); sed -i.bak "s/^status:.*/status: VIOLATED/" "$g"; fi
  rm -f "$g.bak"
  echo -e "$(date +%Y-%m-%dT%H:%M:%S%z)\t$name\t$r\t$(( $(date +%s) - start ))" >> "$LEDGER"
done
[ "$VIOLATIONS" -gt 0 ] && { grep -l '^status: VIOLATED' goals/*.md; exit 1; }
echo "all standing goals hold"
