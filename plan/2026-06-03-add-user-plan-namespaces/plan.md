# Add User Plan Namespaces

## Goal

Update planning and maintenance rules so multi-person work uses per-user plan
namespaces and personal logs, while phase-level plans remain separately managed
under `docs/phase-plans/`.

## Expected Files

- `AGENTS.md`
- `plan/README.md`
- `rules/maintenance-workflow.md`
- `rules/README.md`
- `docs/phase-plans/README.md`
- `plan/users/README.md`
- `plan/users/chenzc24/README.md`
- `plan/users/chenzc24/log.md`
- `plan/shared/README.md`
- `plan/shared/integration/README.md`
- `plan/log.md`
- this plan file

## Owned Files

- `AGENTS.md`
- `plan/README.md`
- `rules/maintenance-workflow.md`
- `rules/README.md`
- `docs/phase-plans/README.md`
- `plan/users/**`
- `plan/shared/**`
- `plan/log.md`
- `plan/2026-06-03-add-user-plan-namespaces/plan.md`

## Read-Only Files

- `contracts/schemas/`
- `docs/top-level-design/`
- `llm_wiki/`

## Implementation Steps

1. Define the new per-user planning paths in root agent rules.
2. Update plan directory documentation with user, shared, and global log roles.
3. Update workspace maintenance rules with the same namespace model.
4. Add README/log files for `chenzc24` and shared integration planning.
5. Add `docs/phase-plans/README.md` to mark phase plans as Coordinator-owned.
6. Update `plan/log.md`.

## Validation Steps

- Run targeted `rg` checks for:
  - `plan/users/<user>`
  - `plan/users/chenzc24/log.md`
  - `plan/shared/integration`
  - `docs/phase-plans`
  - `Coordinator-owned`
  - `plan/log.md`
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Commit with message `Add user plan namespaces` and push `main` to
`origin/main`.
