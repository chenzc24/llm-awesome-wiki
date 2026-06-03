# Simplify Workspace Maintenance For Single Maintainer Plan

## Goal

Revise `rules/maintenance-workflow.md` so generated knowledge workspaces assume
a single maintainer working with agents. Remove co-worker, coordinator,
ownership, and shared integration workflow rules from the workspace maintenance
contract.

## Expected Files

- Update `rules/maintenance-workflow.md`.
- Update `plan/log.md`.

## Validation

- Run `git diff --check`.
- Run targeted `rg` to confirm `rules/maintenance-workflow.md` no longer
  contains co-worker, coordinator, shared integration, or ownership rules.
- Run `git status --short --branch`.

## Commit Intent

Commit message: `Simplify workspace maintenance for single maintainer`

Push target: `origin/main`
