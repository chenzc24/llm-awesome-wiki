# Split Collaboration By Phase

## Goal

Add two detailed collaboration guides that split pre-skill/tool work by phase:
one guide for Person A / coworker as Contracts + Validation Owner, and one guide
for Person B / chenzc24 as Workflow + Tool Surface Owner.

## Expected Files

- `docs/collaboration/README.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `docs/collaboration/two-person-pre-skill-tools-worksplit.md`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- this plan file

## Owned Files

- `docs/collaboration/**`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-03-split-collaboration-by-phase/**`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `tools/**`
- `docs/top-level-design/**`
- `docs/phase-plans/**`
- `llm_wiki/**`

## Shared Contract Dependencies

- Phase definitions come from `docs/top-level-design/system-architecture-plan.md`.
- Person B is `chenzc24`.
- Person A is the coworker and owns contract/validation hardening.
- Phase 0 is already complete.
- Phase 1/1.1 contracts exist as a rough first draft and should be hardened by
  Person A rather than redesigned by Person B.

## Implementation Steps

1. Add a detailed Person A phase-by-phase responsibility guide.
2. Add a detailed Person B phase-by-phase responsibility guide.
3. Update the collaboration README and existing two-person overview to point to
   the detailed guides.
4. Update personal and global logs.

## Validation Steps

- Run targeted `rg` checks for:
  - `Phase 0`
  - `Phase 1/1.1`
  - `Person A`
  - `Person B`
  - `chenzc24`
  - `rough first draft`
  - `pre-skill/tool`
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Commit with message `Split collaboration responsibilities by phase` and push
`main` to `origin/main`.
