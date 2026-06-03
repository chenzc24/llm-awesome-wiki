# Add Plan Cleanup Rule

## Goal

Add an Agent rule requiring periodic cleanup of completed `plan/` entries. The
rule should preserve useful history by summarizing completed plans, then remove
or archive the detailed per-target folders so `plan/` does not become a
maintenance burden.

## Expected Files

- `AGENTS.md`
- `plan/log.md`
- `plan/users/chenzc24/2026-06-03-add-plan-cleanup-rule/plan.md`

## Implementation Steps

1. Add a plan hygiene rule to `AGENTS.md`.
2. Make the rule explicit: summarize completed daily/stage plans, keep the
   compressed summary in `plan/log.md` or a future archive, then clean the
   detailed completed plan folders.
3. Update `plan/log.md` after validation.

## Validation

- Run `git diff --check`.
- Search `AGENTS.md` for plan cleanup language.
- Run `git status --short --branch`.

## Commit

Intended commit message:

```text
Add plan cleanup rule
```
