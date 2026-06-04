# Workspace Check

`workspace-check` is the Phase 6 checker orchestrator surface.

It validates workspace artifacts by running selected checker families. In Phase
6.1, only the runtime skeleton exists. Business validators are listed as future
slots and reported as `not-implemented`.

## Purpose

Answer:

```text
Can this workspace be checked by the Phase 6 validation tooling runtime?
```

Later Phase 6 subphases will add checks for schemas, source inventory, source
packets, wiki pages, compare reports, review queues, validation notes, round
closure, and fixtures.

## Command

```powershell
powershell -ExecutionPolicy Bypass -File tools/workspace-check/workspace-check.ps1 `
  -Workspace . `
  -Mode smoke `
  -Report reports-validation-smoke.md
```

## Inputs

- `-Workspace`: path to the workspace or system repository being checked
- `-Mode`: `smoke`, `all`, `schemas`, `source`, `wiki`, `reports`, `closure`,
  or `fixtures`
- `-Report`: Markdown report path

## Outputs

- Markdown report with tool metadata, status, exit code, checks run, checks not
  implemented, findings, and next actions
- process exit code following `tools/shared/report-conventions.md`

## Phase 6.1 Behavior

The skeleton checks:

- workspace path exists
- report path can be written
- mode is recognized

The skeleton reports future validators as `not-implemented`.

## Non-Goals

`workspace-check` does not:

- run extractors
- parse PDF/PPTX/DOCX/image/table files
- run OCR or VLM captioning
- generate source packets
- generate wiki pages
- resolve semantic review
- silently rewrite workspace artifacts

## Exit Codes

- `0`: skeleton smoke run completed
- `1`: deterministic validation failure
- `2`: review required without deterministic failure
- `3`: configuration or runtime error
