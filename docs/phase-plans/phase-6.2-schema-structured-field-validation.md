# Phase 6.2 Schema And Structured-Field Validation

Phase 6.2 implements the first real Phase 6 checker: schema and
structured-field validation.

The checker validates the reusable schema contracts under `contracts/schemas/`
and confirms that the field names and enum values required by Phases 2 through
5 are present.

## Scope

Phase 6.2 owns:

- required schema file presence
- schema JSON parseability
- minimum schema metadata fields
- required field lists for key schemas
- enum presence for stable workflow statuses
- `schema-check` CLI surface
- `workspace-check -Mode schemas` integration

Phase 6.2 does not own:

- full JSON Schema validation engine behavior
- validation of real workspace artifact instances
- source inventory row validation against actual raw files
- source packet output validation against packet directories
- wiki lint
- compare report semantic validation
- review queue semantic validation
- round closure validation
- fixture runner
- extractor execution
- downstream knowledge-to-`skill + tool` generation

## Checker Boundary

`schema-check` is a contract-shape checker. It answers:

```text
Do the reusable schemas exist, parse as JSON, and expose the stable fields and
enum values the workflow depends on?
```

It is not a JSON Schema engine. It does not read or validate workspace artifact
instances yet. That work belongs to later Phase 6 subphases.

## Minimum Structured Fields

Phase 6.2 should check these minimum contract expectations:

- source inventory rows expose `source_id`, `raw_path`, `source_kind`,
  `raw_sha256`, `status`, `packet_path`, `review_required`, and `notes`
- source inventory status includes `new`, `ready`, `processed`, `changed`,
  `ignored`, `failed`, and `needs-review`
- source packet metadata exposes `source_id`, `raw_path`, `raw_sha256`,
  `source_kind`, `inventory_status_at_extraction`, `extraction_backend`,
  `extraction_method`, `extraction_version`, `extraction_status`,
  `modalities`, `generated_fields`, `known_gaps`, `review_required`,
  `review_reason`, `derived_artifacts`, and `anchors`
- source packet extraction status includes `complete`, `partial`, `failed`,
  and `manual-review`
- claim status includes `supported`, `weak`, `unsupported`, `contested`,
  `generated-derived`, `reviewed-generated`, `needs-review`,
  `not-in-scope`, and `stale`
- compare report status includes `pass`, `fail`, and `needs-review`
- review item status includes `open`, `in-review`, `resolved`, `dismissed`,
  `carried-forward`, `blocked`, and `stale`
- review item blocking level includes `blocking`, `nonblocking`, and
  `informational`

These checks are intentionally narrow. They prove that downstream validators
can rely on stable contract vocabulary before artifact-instance validation
begins.

## Completion Criteria

Phase 6.2 is complete when:

- the Phase 6.2 phase plan exists
- key schema contracts expose the minimum structured fields and enums
- `schema-check.ps1` exists and is runnable
- `workspace-check -Mode schemas` invokes schema checking
- `validate-kernel.ps1` requires the new checker paths
- smoke reports pass and are removed before commit
- Phase 6.3 is identified as source inventory and source packet checks
