# Phase 1.1 Workspace Kernel Closure Plan

## Goal

Close the Phase 1 workspace-kernel loop by making the rules, templates,
contracts, and validation entrypoints consistent enough for a developer or
agent to copy the kernel into a new knowledge workspace and understand the
first distillation round.

## Expected Files

- Update `README.md`.
- Update `docs/top-level-design/system-architecture-plan.md`.
- Add `docs/phase-plans/phase-1.1-workspace-kernel-closure.md`.
- Refine workflow rules under `rules/`.
- Refine minimum schema contract guidance under `contracts/schemas/`.
- Expand `templates/workspace-kernel/` with workspace-local plan, raw, wiki,
  reports, and log guidance.
- Update `tools/validate-kernel/validate-kernel.ps1`.
- Update `tests/README.md`.
- Update `plan/log.md`.

## Validation

- Run `git diff --check`.
- Run `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`.
- Parse `contracts/schemas/*.schema.json` with `ConvertFrom-Json`.
- Confirm root-level active workspace paths `raw/`, `wiki/`, `reports/`, and
  `schema.md` are absent.
- Confirm expected Phase 1.1 files exist with `rg --files -g "!llm_wiki/**"`.
- Confirm `llm_wiki/` has no content changes.

## Commit Intent

Commit message: `Close workspace kernel phase one loop`

Push target: `origin/main`
