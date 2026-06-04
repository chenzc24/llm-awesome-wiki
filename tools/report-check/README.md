# Report Check Tool

Checker for compare, claim/evidence, review queue, and validation-note report
surfaces.

Phase 6.5 implements the checker-only validator:

```powershell
powershell -ExecutionPolicy Bypass -File tools/report-check/report-check.ps1 `
  -Workspace . `
  -ReportsDir reports `
  -Report reports/report-check-report.md
```

## Purpose

Answer:

```text
Are report surfaces structurally valid enough to support review and later round
closure checks?
```

## Checks

- compare report sections, status, check matrix, and pass/blocker consistency
- claim/evidence map sections, source refs, claim status, and evidence IDs
- review queue lifecycle statuses, blocking levels, and carried-forward state
- validation note status, compare status, and closure decision fields
- visible review findings when report rows still look like placeholders

## Non-Goals

`report-check` does not:

- extract claims from wiki pages or raw files
- decide semantic truth
- generate compare reports
- resolve review items
- close rounds
- generate wiki pages
