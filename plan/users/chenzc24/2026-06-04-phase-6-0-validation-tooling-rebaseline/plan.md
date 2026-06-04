# Phase 6.0 Validation Tooling Rebaseline Plan

## Goal

Rebaseline Phase 6 after the no-harness decision. Phase 6 should become the
workspace validation and checker tooling layer: validators, linters, report
checkers, closure checkers, and fixture runners that inspect workspace
artifacts produced by earlier phases.

Phase 6 should not implement a PDF/PPTX/DOCX parser harness, source packet
adapter runner, OCR/VLM runner, MinerU wrapper, MCP extractor wrapper, or
downstream `skill + tool` codebase.

## Dirty-State Note

Start state was clean:

```text
## main...origin/main
```

Reference submodules were unchanged:

```text
ef4aa39c1dcc0102082374e977e2d722b9d392c0 MinerU (heads/master)
a5ee5ec3c7cc180f0f5abfb9d266fe87573171bd llm_wiki (v0.4.18)
```

## Owned Files

- `docs/top-level-design/system-architecture-plan.md`
- `docs/execution-roadmap.md`
- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/phase-2-raw-resource-conversion.md`
- `docs/phase-plans/phase-2.6-tool-surface-specs.md`
- `docs/phase-plans/README.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `docs/collaboration/two-person-pre-skill-tools-worksplit.md`
- `tools/README.md`
- `tools/source-packet-convert/README.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `tests/fixtures/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Add Phase 6.0 rebaseline phase-plan documentation.
2. Update top-level architecture so Layer/Phase 6 is validation and checker
   tooling, not harness tooling.
3. Update collaboration docs so Person A and Person B responsibilities reflect
   checker-first Phase 6 work.
4. Update tool README prose to demote `source-packet-convert` from Phase 6 core
   implementation and emphasize output validation.
5. Update personal and global logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- targeted `rg` for:
  - `Phase 6.0`
  - `Validation Tooling`
  - `checker`
  - `not a harness`
  - `does not run extractors`
  - `source packet outputs`
  - `workspace artifacts`
  - `Phase 7`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Rebaseline phase six as validation tooling
```
