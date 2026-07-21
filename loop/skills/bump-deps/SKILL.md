---
name: bump-deps
description: Update one outdated dependency to its latest compatible version
when: triage reports outdated dependencies with published security or patch releases
---

## Steps
1. Run `npm outdated`. Pick ONE patch or minor bump (never major).
2. Update it, install, and run the full test suite.
3. Note the version change in IMPLEMENTATION.md.

## Never
- Never bump a major version. Queue those for a human.
- Never bump more than one package per run.
- Never modify lockfile resolution overrides.

## done_when
- package.json shows the new version
- guardrails/verify.sh exits 0
