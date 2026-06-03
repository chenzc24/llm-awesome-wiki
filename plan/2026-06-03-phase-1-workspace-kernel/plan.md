# Phase 1 Workspace Kernel Plan

## Goal

Implement the Phase 1 repository-kernel substrate as a copy-first,
VSCode-native workspace kernel. The system repository will define rules,
contracts, templates, tool entrypoints, and scenario-test guidance without
turning the root repository into an active knowledge workspace.

## Expected Files

- Update `README.md`.
- Update `docs/top-level-design/system-architecture-plan.md`.
- Add `docs/phase-plans/phase-1-workspace-kernel.md`.
- Add first-class workflow rules under `rules/`.
- Add reusable JSON Schema contracts under `contracts/schemas/`.
- Add copyable workspace kernel files under `templates/workspace-kernel/`.
- Add construction tool skeletons under `tools/`.
- Add scenario-test guidance under `tests/`.
- Update `plan/log.md`.

## Validation

- Run `git diff --check`.
- Run `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`.
- Run `rg --files -g "!llm_wiki/**"` and confirm expected files exist.
- Confirm no live root-level `raw/`, `wiki/`, `reports/`, or `schema.md` exists.
- Confirm `contracts/schemas/*.schema.json` parse as JSON.
- Confirm `templates/workspace-kernel/` is the only place this change creates
  template `raw/`, `wiki/`, and `reports/` directories.
- Confirm `llm_wiki/` has no content changes.

## Commit Intent

Commit message: `Add workspace kernel phase one substrate`

Push target: `origin/main`
