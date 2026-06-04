# Source Packet Lint Tool

Future tool family for checking source packets against Phase 2 protocols.

Phase 2.6 defined the behavior surface only. Phase 6.3 implements the
checker-only validator:

```bash
python -m llm_wiki_tools source-packet-lint \
  --workspace . \
  --inventory raw/source-inventory.md \
  --report reports/source-packet-lint-report.md
```

The checker validates existing packet outputs. It does not run conversion
adapters or repair packet content.

## Purpose

The tool should answer:

```text
Is this source packet usable for later evidence, wiki, and alignment work?
```

It checks source packets after inventory and conversion:

```text
raw/derived/<source-id>/
-> deterministic checks
-> source packet lint report
```

## Command Shape

The intended behavior is:

```bash
source-packet-lint check \
  --workspace . \
  --inventory raw/source-inventory.md \
  --packet raw/derived/course/module-01 \
  --report reports/source-packet-lint-report.md
```

Expected modes:

- `check`: validate one packet directory
- `scan`: validate every packet referenced by inventory
- `report`: write a lint report without modifying packet files

## Inputs

- workspace root
- source inventory file
- packet directory or inventory-selected packet set
- Phase 2 rules and accepted schema/validator behavior, when available
- optional source-type profile selection

## Outputs

- source packet lint report
- pass, fail, or needs-review status
- deterministic failure list
- review-required list
- anchor, generated field, known gap, and derived artifact warnings

The tool should avoid silent semantic rewrites. Any future auto-fix behavior
must be separately planned and logged.

## Checks

The tool should check:

- metadata file exists
- `source.md` exists
- `source_id`, `raw_path`, `raw_sha256`, `source_kind`,
  `extraction_backend`, `extraction_method`, `extraction_status`, and
  `extraction_version` are present when required by accepted contracts
- packet path matches `raw/derived/<source-id>/`
- workspace anchors exist and can be cited as `<source_id>#<anchor_id>`
- backend-local references are not the only anchor identity
- source-type profile expectations are met or represented as `known_gaps`
- generated content is listed in `generated_fields`
- generated anchors or generated portions are distinguishable from
  source-derived content
- `review_required` has useful `review_reason`
- failed or partial packets preserve visible gaps and review routing
- derived artifact paths stay inside approved workspace paths

## Deterministic Behavior

The tool should deterministically:

- parse packet metadata
- inspect `source.md` for anchors
- compare packet path to inventory
- check required files
- check known enum-like status values when accepted
- report missing fields, missing anchors, broken artifact references, and
  review-routing omissions

The tool should not use a model to decide whether packet content is true.

## Failure Modes

The tool should report:

- missing packet directory
- missing metadata
- missing `source.md`
- no anchors unless extraction failed visibly
- generated fields present without visible generated markers
- unsupported source-type expectations without known gaps
- `review_required` without `review_reason`
- broken derived artifact references
- inventory and packet mismatch

## Exit-Code Expectations

Future implementation should use:

- `0`: packet lint passes
- `1`: deterministic lint failure
- `2`: review is required but no deterministic failure occurred
- `3`: tool configuration or runtime error

These exit codes are proposals until Person A accepts validator behavior.

## Non-Goals

The source packet lint tool should not:

- parse raw PDFs, PPTX, DOCX, images, tables, or charts
- run adapters or extractors
- decide final knowledge truth
- extract claims
- generate wiki pages
- implement compare gates
- edit schemas
