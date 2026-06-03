# Document Two-Person Worksplit

## Goal

Create a newcomer-friendly explanation of the two-person pre-skill/tools work
split, with background, owner boundaries, first-round rhythm, branch guidance,
and minimum milestones.

## Expected Files

- `docs/collaboration/README.md`
- `docs/collaboration/two-person-pre-skill-tools-worksplit.md`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- this plan file

## Owned Files

- `docs/collaboration/**`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-03-document-two-person-worksplit/**`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `tools/**`
- `docs/phase-plans/**`
- `docs/top-level-design/**`
- `llm_wiki/**`
- `plan/users/chenzc24/2026-06-03-phase-1-3-workspace-kernel-golden-path/**`

## Shared Contract Dependencies

None. This is explanatory collaboration guidance only. It should not change
schemas, workflow rules, tools, templates, or phase plans.

## Implementation Steps

1. Add a collaboration docs directory.
2. Add a newcomer-friendly two-person work-split guide.
3. Update personal and global maintenance logs.
4. Validate docs and working tree state.

## Validation Steps

- Run targeted `rg` checks for:
  - `Contracts + Validation Owner`
  - `Workflow + Tool Surface Owner`
  - `pre-skill/tools`
  - `feat/contracts-validation`
  - `feat/workflow-tool-surface`
  - `daily sync`
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Commit with message `Document two-person pre-skill tools worksplit` and push
`main` to `origin/main`.
