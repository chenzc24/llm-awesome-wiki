# Phase 1.3 Workspace Kernel Golden Path

## Goal

Make the copyable workspace kernel usable for a first manual document/PPT
distillation round. Phase 1.3 should turn the current rules and directory
substrate into a clear golden path without implementing raw converters,
wiki-generation tools, compare gate tooling, or downstream skill/tool output.

## Expected Files

- `README.md`
- `docs/phase-plans/phase-1.3-workspace-kernel-golden-path.md`
- `templates/workspace-kernel/README.md`
- `templates/workspace-kernel/plan/first-round-plan.template.md`
- `templates/workspace-kernel/raw/source-inventory.template.md`
- `templates/workspace-kernel/raw/source-packet.template.md`
- `templates/workspace-kernel/wiki/overview.template.md`
- `templates/workspace-kernel/wiki/sources/source-page.template.md`
- `templates/workspace-kernel/wiki/chapters/chapter-page.template.md`
- `templates/workspace-kernel/reports/first-round-validation-note.template.md`
- `tools/validate-kernel/validate-kernel.ps1`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- this plan file

## Owned Files

- `README.md`
- `docs/phase-plans/phase-1.3-workspace-kernel-golden-path.md`
- `templates/workspace-kernel/**`
- `tools/validate-kernel/validate-kernel.ps1`
- `plan/log.md`
- `plan/users/chenzc24/log.md`
- `plan/users/chenzc24/2026-06-03-phase-1-3-workspace-kernel-golden-path/**`

## Read-only Files

- `llm_wiki/**`
- `contracts/schemas/**`
- `rules/**`
- `docs/top-level-design/**`

## Shared Contract Dependencies

None. Phase 1.3 uses the existing rules and contracts. It adds usage templates
and validator checks only.

## Implementation Steps

1. Add a Phase 1.3 phase-plan document explaining the golden path and non-goals.
2. Update the root README status so Phase 1.3 is the active Phase 1 closure
   task after the document-corpus default correction.
3. Expand `templates/workspace-kernel/README.md` into a first-use entrypoint.
4. Add first-round plan, source inventory, source packet, wiki page, and
   validation-note templates.
5. Update `validate-kernel.ps1` to require the new golden-path files.
6. Update maintenance logs.

## Validation

- Run `git diff --check`.
- Run `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`.
- Run targeted `rg` checks for:
  - `Phase 1.3`
  - `golden path`
  - `source inventory`
  - `source packet`
  - `first-round`
  - `compare gate not enabled`
- Run `git status --short --branch`.
- Confirm `llm_wiki/` has no content changes.

## Commit Intent

Commit with message `Add workspace kernel golden path templates` and push
`main` to `origin/main`.
