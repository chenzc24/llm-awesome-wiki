# Fixture Runner Tool

Scenario runner for Phase 6 checker fixtures.

Phase 6.7 implements:

```powershell
powershell -ExecutionPolicy Bypass -File tools/fixture-runner/fixture-runner.ps1 `
  -FixtureRoot tests/fixtures/phase6 `
  -Report fixture-runner-report.md
```

## Purpose

Answer:

```text
Do small fixture workspaces produce the expected checker status and exit code?
```

## Scenario Contract

Each scenario directory contains:

- `scenario.json`
- `workspace/`

Minimum `scenario.json` fields:

- `name`
- `tool`
- `expected_exit_code`
- `expected_status`

Supported tools:

- `wiki-lint`
- `report-check`
- `round-closure-check`
- `workspace-check`

`workspace-check` scenarios must also set `mode`.

## Non-Goals

`fixture-runner` does not:

- run extractors
- parse raw binary documents
- generate source packets
- generate wiki pages
- resolve semantic review
- provide exhaustive test coverage for every checker
