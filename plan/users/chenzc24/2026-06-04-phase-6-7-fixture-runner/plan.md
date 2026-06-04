# Phase 6.7 Fixture Runner Plan

## Goal

Implement Phase 6.7 as scenario fixture validation for Phase 6 checkers.

This target adds a small fixture runner and minimal scenarios that prove the
validator layer can produce expected `pass`, `fail`, and `needs-review` exits.

It does not expand every checker into exhaustive tests, generate source
packets, run extractors, resolve semantic review, or build downstream skills.

## Dirty-State Note

Starting state was clean:

```text
## main...origin/main
```

Reference submodules are not part of this target.

## Owned Files

- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/phase-6.7-fixture-runner.md`
- `docs/phase-plans/README.md`
- `tools/README.md`
- `tools/fixture-runner/README.md`
- `tools/fixture-runner/fixture-runner.ps1`
- `tools/workspace-check/README.md`
- `tools/workspace-check/workspace-check.ps1`
- `tools/validate-kernel/validate-kernel.ps1`
- `tests/README.md`
- `tests/fixtures/README.md`
- `tests/fixtures/phase6/**`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- `plan/users/chenzc24/2026-06-04-phase-6-7-fixture-runner/plan.md`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/workspace-kernel/**`
- existing checker scripts except `workspace-check`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 6 checker exit codes and report conventions
- Existing Phase 6 checker scripts
- `workspace-check -Mode fixtures`

## Implementation Steps

1. Add Phase 6.7 phase-plan documentation.
2. Add `tools/fixture-runner/fixture-runner.ps1`:
   - discover scenario directories with `scenario.json`
   - copy each scenario workspace to a temp directory
   - run the configured checker
   - compare actual exit code and report status to expected values
   - emit one Markdown fixture-runner report
3. Add `tools/fixture-runner/README.md`.
4. Add minimum fixtures:
   - `wiki-lint-broken-link-fail`
   - `report-check-no-reports-needs-review`
   - `round-closure-close-pass-pass`
5. Integrate into `workspace-check -Mode fixtures` and `-Mode all`.
6. Update Phase 6 docs, tools README, tests docs, and `validate-kernel.ps1`.
7. Update maintenance logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- `powershell -ExecutionPolicy Bypass -File tools/fixture-runner/fixture-runner.ps1 -FixtureRoot tests/fixtures/phase6 -Report fixture-runner-smoke.md`
- `powershell -ExecutionPolicy Bypass -File tools/workspace-check/workspace-check.ps1 -Workspace . -Mode fixtures -Report workspace-fixtures-smoke.md`
- Remove generated smoke reports.
- Targeted `rg` for Phase 6.7, fixture-runner, pass/fail/needs-review, no
  extractor, no semantic review, and scenario language.
- `git status --short --branch`

## Commit Intent

- Commit main implementation as `Add phase six fixture runner`.
- Then update log entries with the implementation commit hash and commit that
  maintenance status.
