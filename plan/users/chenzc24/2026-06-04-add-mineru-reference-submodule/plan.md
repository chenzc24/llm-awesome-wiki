# Add MinerU Reference Submodule

## Goal

Fork `opendatalab/MinerU` to the `chenzc24` GitHub account and add that fork as
a pinned reference submodule for Person B Phase 2 raw-resource conversion
planning.

## Dirty-State Note

The worktree was clean at start on `co-work/czc_personB`.

## Expected Files

- `.gitmodules`
- `MinerU`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-04-add-mineru-reference-submodule/plan.md`

## Owned Files

- `.gitmodules`
- `MinerU`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-04-add-mineru-reference-submodule/**`

## Read-only Files

- `llm_wiki/**`
- `docs/**`
- `rules/**`
- `templates/**`
- `tools/**`
- `contracts/**`
- `tests/**`

## Shared Contract Dependencies

None. `MinerU/` is added as read-only reference material for future Phase 2
workflow/tool-surface planning.

## Implementation Steps

1. Confirm GitHub CLI is authenticated as `chenzc24`.
2. Fork `opendatalab/MinerU` to `chenzc24/MinerU` if the fork does not already
   exist.
3. Add `https://github.com/chenzc24/MinerU.git` as submodule at `MinerU/`.
4. Update maintenance logs.
5. Validate submodule status, `.gitmodules`, diff cleanliness, and branch
   status.

## Validation

- Run `gh repo view chenzc24/MinerU`.
- Run `git submodule status`.
- Run `git config -f .gitmodules --get-regexp '^submodule\\.'`.
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Commit with message `Add MinerU reference submodule` and push
`co-work/czc_personB` to `origin/co-work/czc_personB`.
