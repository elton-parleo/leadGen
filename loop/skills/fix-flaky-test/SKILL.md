---
name: fix-flaky-test
description: Stabilize one test that passes and fails intermittently without code changes
when: triage reports a CI run where a test failed, then passed on rerun with no diff between
---

## Steps
1. Identify the flaky test from CI history: same test, mixed results, identical commit.
2. Run the test alone 10 times locally: `npm test -- <test-file> ` in a loop. Record pass count.
3. Diagnose the ONE most likely cause: timing/sleep assumptions, shared state between
   tests, unordered collections, real network/clock/random dependency.
4. Fix the TEST'S determinism (inject fake timers, seed randomness, isolate state,
   await properly). If the flake exposes a real race in src/, STOP — write it up in
   IMPLEMENTATION.md and queue; that is a bug fix, not a flake fix.
5. Re-run the test 20 times. All 20 must pass.
6. Run guardrails/verify.sh before finishing.

## Never
- Never add retries, sleeps, or timeouts to mask the flake.
- Never delete, skip, or weaken the assertion. (CLAUDE.md law; that is a fail, always.)
- Never touch src/ — this skill fixes tests only.
- Never fix more than one flaky test per run.

## done_when
- The target test passes 20 consecutive local runs
- The diff touches only test files
- guardrails/verify.sh exits 0
