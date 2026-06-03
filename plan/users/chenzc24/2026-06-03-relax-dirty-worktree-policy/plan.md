# Relax Dirty Worktree Policy

## Goal

Update the agent maintenance rules so a dirty worktree does not automatically
block unrelated parallel work. Agents should stop only when existing dirty files
overlap with, or create unclear dependencies for, the current target's owned
files.

## Expected Files

- `AGENTS.md`
- `plan/README.md`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- this plan file

## Owned Files

- `AGENTS.md`
- `plan/README.md`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-03-relax-dirty-worktree-policy/**`

## Read-Only Files

- `contracts/schemas/`
- `rules/`
- `docs/top-level-design/`
- `docs/phase-plans/`
- `llm_wiki/`

## Shared Contract Dependencies

None. This is a repository workflow-rule update.

## Implementation Steps

1. Replace the root clean-worktree requirement with a dirty-state audit rule.
2. Require target plans to record dirty-state handling when the worktree is not
   clean.
3. Update planning documentation with the same policy.
4. Update maintenance logs.

## Validation Steps

- Run targeted `rg` checks for:
  - `dirty-state audit`
  - `Owned files`
  - `Read-only files`
  - `overlap`
  - `unrelated dirty`
- Run `git diff --check`.
- Run `git status --short --branch`.

## Commit Intent

Commit with message `Relax dirty worktree policy for parallel work` and push
`main` to `origin/main`.
