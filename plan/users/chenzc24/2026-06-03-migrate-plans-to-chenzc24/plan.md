# Migrate Existing Plans To chenzc24

## Goal

Move existing historical target plans into the `chenzc24` personal namespace and
remove the misleading `codex` user namespace. Clarify that execution agents such
as Codex are not user namespaces.

## Expected Files

- `AGENTS.md`
- `README.md`
- `plan/README.md`
- `plan/users/README.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- `docs/top-level-design/README.md`
- `docs/top-level-design/system-architecture-plan.md`
- historical target plan directories under `plan/users/chenzc24/`
- this plan file

## Owned Files

- `AGENTS.md`
- `README.md`
- `plan/README.md`
- `plan/users/README.md`
- `plan/users/chenzc24/**`
- `plan/users/codex/**`
- `plan/users/chenzc24/2026-06-03-*/**`
- `plan/log.md`
- `docs/top-level-design/README.md`
- `docs/top-level-design/system-architecture-plan.md`

## Read-Only Files

- `contracts/schemas/`
- `docs/phase-plans/`
- `llm_wiki/`

## Implementation Steps

1. Move root-level historical target plan directories into
   `plan/users/chenzc24/`.
2. Move the existing `plan/users/codex/` plan into `plan/users/chenzc24/` and
   remove the `codex` namespace.
3. Merge the useful `codex` personal log entry into
   `plan/users/chenzc24/log.md`.
4. Clarify in planning rules that users are human/co-worker identities, not
   executor agent names.
5. Update root documentation that still points to old root-level plan paths.
6. Update `plan/log.md`.

## Validation Steps

- Run targeted `rg` checks for:
  - `plan/users/codex`
  - `executor agent`
  - `plan/users/chenzc24/2026-06-03`
  - `plan/<date-goal-slug>`
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Commit with message `Migrate historical plans to chenzc24` and push `main` to
`origin/main`.
