# Mark Repository Failed Plan

## Goal

Update the repository README to clearly mark this project as a failed artifact
so future readers do not treat it as a recommended workflow or active product.

## Dirty-State Note

Start state from `git status --short --branch`:

```text
## main...origin/main
```

The worktree is clean.

## Owned Files

- `README.md`
- `plan/users/chenzc24/2026-06-05-mark-repository-failed/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `docs/**`
- `rules/**`
- `skills/**`
- `templates/**`
- `contracts/**`
- `llm_wiki_tools/**`
- `tests/**`
- `llm_wiki/**`
- `MinerU/**`

## Expected Work

1. Add a prominent failure notice at the top of `README.md`.
2. Reframe the current content as historical design record, not recommended
   adoption guidance.
3. Keep the edit minimal and avoid deleting history.
4. Update maintenance logs.

## Validation

- `git diff --check`
- targeted `rg` confirming failure notice language
- `git status --short --branch`

## Commit Intent

Commit as:

```text
Mark repository as failed artifact
```

Then push `origin main`.
