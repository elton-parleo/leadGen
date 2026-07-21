---
name: triage-issues
description: Label, deduplicate, and structure open GitHub issues; changes metadata only
when: triage reports unlabeled or stale open issues
---

## Steps
1. List open issues: `gh issue list --limit 50 --json number,title,labels,createdAt`.
2. For each unlabeled issue, add exactly one type label (bug/feature/question/docs)
   and one priority label, based only on the issue text.
3. Find duplicates: same error message or same feature request. Comment on the newer
   one linking the older, label it `duplicate`. Do not close it.
4. For issues missing reproduction steps, post ONE comment using the repo's issue
   template asking for the missing fields.
5. Log a one-line summary per action in IMPLEMENTATION.md.

## Never
- Never close an issue. Closing is a human decision.
- Never comment opinions on priority or feasibility — labels only, questions only.
- Never touch issues labeled security — those are contract-sensitive; note and queue.
- Never process more than 15 issues per run.

## done_when
- Zero open issues without a type label (or the 15-issue cap was hit, noted in
  IMPLEMENTATION.md)
- No issues were closed: `gh issue list --state closed --json closedAt` shows
  nothing closed during the run window
