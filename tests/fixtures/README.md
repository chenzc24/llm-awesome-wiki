# Fixtures

Future fixture workspaces should live here or under a dedicated scenario
subdirectory.

A fixture should include:

- initial workspace files
- input source or source packet
- simulated agent or LLM output when relevant
- expected files, reports, review items, or validation failures

Fixtures must remain small. They are examples for tool validation, not active
knowledge workspaces.

## Phase 6 Fixtures

Phase 6 fixtures live under `tests/fixtures/phase6/`.

Each scenario contains:

- `scenario.json`
- `workspace/`

The fixture runner copies `workspace/` to a temporary directory, runs the
configured checker, and compares actual exit code and report status against the
scenario expectations.

Current fixture scenarios cover:

- `source-packet-lint` profile validation for PDF/PPTX packets
- `wiki-lint` navigation failure behavior
- `report-check` pass, fail, and needs-review report surfaces
- `round-closure-check` close-pass and construction-analysis failure behavior

Fixture workspaces should remain small and inspectable. Use them to prove
checker behavior, not to store active knowledge bases or raw binary corpora.
