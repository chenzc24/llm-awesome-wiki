# Phase 6.6 Round Closure Checker

Phase 6.6 validates whether a recorded round closure decision is consistent
with the visible workspace state.

The validation note is the primary closure packet surface. The checker reads it
and cross-checks compare status, review state, index/overview/log support, and
referenced report discoverability.

## Scope

Phase 6.6 owns:

- `round-closure-check command`
- `workspace-check --mode closure` integration
- validation note closure-field checks
- `close-pass`, `close-with-review`, and `do-not-close` consistency checks
- referenced compare and review report path checks
- wiki log visibility check
- active report discoverability checks for close-with-review

Phase 6.6 does not own:

- closing rounds automatically
- rewriting validation notes
- resolving review items
- deciding semantic truth
- generating compare reports
- generating wiki pages
- scenario fixtures

## Deterministic Checks

`round-closure-check` should fail when:

- a validation note uses an invalid status, compare status, or closure decision
- a referenced compare or review report path does not exist
- `close-pass` is used without status `pass`
- `close-pass` is used without compare status `pass`
- `close-pass` lacks yes support for compare, review, index, overview, and log
  closure support fields
- `close-pass` carries blocking review
- `close-with-review` is used without status `needs-review`
- `close-with-review` is used without compare status `needs-review`
- `close-with-review` lacks carried-forward review reason or next action
- `do-not-close` claims the round can close or advance normally
- `compare gate not enabled` is used with `close-pass`

## Review Findings

The checker should return `needs-review` when:

- no validation notes exist yet
- wiki log does not visibly record the closure decision
- close-with-review active reports are not discoverable from the index
- close-pass uses review advancement fields in a confusing way

## Workspace Integration

`workspace-check --mode closure` invokes:

```text
round-closure-check
```

`workspace-check --mode all` runs schema, source, wiki, report, and closure
checks, then reports fixture validation as not implemented until Phase 6.7.

## Completion Criteria

Phase 6.6 is complete when:

- the Phase 6.6 phase plan exists
- `round-closure-check command` exists and emits Phase 6 reports and exit codes
- `workspace-check --mode closure` invokes closure checking
- README and Phase 6 docs describe checker-only behavior
- a temporary smoke workspace with validation note, compare report, review
  queue, index, overview, and log passes `round-closure-check` and
  `workspace-check --mode closure`
- no automatic round closure or semantic review resolution is introduced

## Next Phase

Phase 6.7 should add scenario fixtures and a fixture runner that prove the
validators catch expected pass, fail, and needs-review cases.
