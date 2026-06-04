# Phase 6.7 Fixture Runner

Phase 6.7 adds scenario fixtures for the Phase 6 checker layer.

The point is not exhaustive test coverage. The point is to prove the checker
runtime can run small, inspectable workspaces and distinguish `pass`, `fail`,
and `needs-review` outcomes.

## Scope

Phase 6.7 owns:

- `fixture-runner command`
- `workspace-check --mode fixtures` integration
- minimum Phase 6 scenario fixture layout
- at least one passing scenario
- at least one deterministic failing scenario
- at least one needs-review scenario

Phase 6.7 does not own:

- extractor harness tests
- raw binary parsing fixtures
- exhaustive coverage for every checker
- semantic review resolution
- source packet or wiki generation
- downstream `skill + tool` generation

## Scenario Shape

Each scenario directory contains:

```text
scenario-name/
  scenario.json
  workspace/
```

The runner copies `workspace/` into a temporary directory, runs the configured
checker, and compares actual exit code and report status against expected
values.

## Initial Scenario Set

Phase 6.7 starts with:

- `wiki-lint-broken-link-fail`
- `report-check-no-reports-needs-review`
- `round-closure-close-pass-pass`

These cover the three required checker outcomes:

- `fail`
- `needs-review`
- `pass`

## Workspace Integration

`workspace-check --mode fixtures` invokes:

```text
fixture-runner
```

`workspace-check --mode all` runs schema, source, wiki, report, closure, and
fixture checks.

## Completion Criteria

Phase 6.7 is complete when:

- the Phase 6.7 phase plan exists
- `fixture-runner command` exists and emits Phase 6 reports and exit codes
- `workspace-check --mode fixtures` invokes fixture running
- the minimum three scenarios pass fixture-runner expectations
- README and tests docs describe the scenario contract
- no extractor harness, raw parsing, semantic review, or generation behavior is
  introduced

## Next Phase

Phase 6.8 should perform Phase 6 closure review and define the Phase 7
knowledge-to-code boundary.
