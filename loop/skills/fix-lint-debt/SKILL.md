---
name: fix-lint-debt
description: Reduce existing lint warnings in already-committed code
when: triage reports lint warnings and no higher-priority actionable item exists
---

## Steps
1. Run `npm run lint` and capture the full output.
2. Pick the file with the most warnings. Fix warnings in that ONE file only.
3. Re-run lint to confirm the count went down and nothing new appeared.
4. Run guardrails/verify.sh before finishing.

## Never
- Never edit the lint config to silence a rule.
- Never change behavior — fixes must be identical-behavior cleanups.
- Never touch more than one file per run.

## done_when
- `npm run lint 2>&1 | grep -c warning` is lower than before the run
- guardrails/verify.sh exits 0
