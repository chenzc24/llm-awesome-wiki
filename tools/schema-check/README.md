# Schema Check

`schema-check` validates reusable schema contracts under `contracts/schemas/`.

It is the Phase 6.2 checker for schema and structured-field validation.

## Purpose

Answer:

```text
Do the reusable schema contracts exist, parse as JSON, and expose the stable
fields and enum values required by the workflow?
```

## Command

```powershell
powershell -ExecutionPolicy Bypass -File tools/schema-check/schema-check.ps1 `
  -Workspace . `
  -Report schema-check-report.md
```

## Inputs

- `-Workspace`: repository or workspace root
- `-SchemaDir`: schema directory relative to the workspace, default
  `contracts/schemas`
- `-Report`: Markdown report path

## Outputs

- Markdown report with checked schema files, deterministic failures, and next
  actions
- process exit code following `tools/shared/report-conventions.md`

## Checks

The checker validates:

- required schema files exist
- schema files parse as JSON
- each schema has `$schema`, `$id`, `title`, `type`, and `properties`
- key schemas expose stable workflow fields
- key enum values from Phases 2 through 5 are present

## Non-Goals

`schema-check` is not a JSON Schema engine. It does not:

- validate workspace artifact instances
- check raw file hashes
- inspect source packet directories
- run extractors
- parse raw binary documents
- perform wiki lint
- validate compare semantics
- resolve review items
