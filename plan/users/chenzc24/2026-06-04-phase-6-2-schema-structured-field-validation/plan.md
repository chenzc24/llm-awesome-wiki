# Phase 6.2 Schema And Structured-Field Validation Plan

## Goal

Implement the first real Phase 6 checker: schema and structured-field
validation. The checker should validate the reusable JSON Schema files under
`contracts/schemas/**` and confirm that the stable field names and enum values
needed by Phases 2 through 5 are present.

This stage validates schema contracts. It does not validate full workspace
artifact instances, implement source packet parsing, create fixtures, run
extractors, perform wiki lint, or implement compare/review/closure semantics.

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

- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/phase-6.2-schema-structured-field-validation.md`
- `docs/phase-plans/README.md`
- `contracts/schemas/source-inventory.schema.json`
- `contracts/schemas/source-packet.schema.json`
- `contracts/schemas/claim-record.schema.json`
- `contracts/schemas/compare-report.schema.json`
- `contracts/schemas/review-item.schema.json`
- `tools/README.md`
- `tools/schema-check/README.md`
- `tools/schema-check/schema-check.ps1`
- `tools/workspace-check/README.md`
- `tools/workspace-check/workspace-check.ps1`
- `tools/validate-kernel/validate-kernel.ps1`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- this plan file

## Read-Only Files

- `tests/**`
- `tests/fixtures/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Steps

1. Add Phase 6.2 phase-plan documentation.
2. Align the minimum schema fields/enums needed for schema-level checks:
   source inventory status, source packet generated/gap/review fields, claim
   support statuses, review lifecycle fields, and compare status fields.
3. Add `tools/schema-check/schema-check.ps1` and README.
4. Integrate `schema-check` into `workspace-check -Mode schemas` and `-Mode all`.
5. Update `validate-kernel.ps1` required paths for the new Phase 6 tool
   surface.
6. Update personal and global logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- `powershell -ExecutionPolicy Bypass -File tools/schema-check/schema-check.ps1 -Workspace . -Report schema-check-smoke.md`
- `powershell -ExecutionPolicy Bypass -File tools/workspace-check/workspace-check.ps1 -Workspace . -Mode schemas -Report workspace-schema-check-smoke.md`
- remove generated smoke reports before commit
- targeted `rg` for:
  - `Phase 6.2`
  - `schema-check`
  - `structured-field`
  - `source packet output`
  - `not a JSON Schema engine`
  - `does not validate workspace instances`
  - `does not run extractors`
- `git status --short --branch`
- `git submodule status`

## Commit Intent

Commit message:

```text
Add phase six schema checker
```
