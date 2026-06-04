# Source Packet Convert Tool

Future tool family for producing workspace source packets from ready inventory
rows.

Phase 2.6 defines the behavior surface only. It does not implement the command,
run extractors, call models, or write parser code.

## Purpose

The tool should answer:

```text
How does a ready source become a valid source packet?
```

It coordinates or describes conversion from:

```text
ready inventory row
-> manual workflow, Agent/MCP, local CLI, MinerU-like backend, or custom adapter
-> raw/derived/<source-id>/
-> conversion report
```

The durable output is the workspace source packet, not the adapter backend's
private output.

## Future Command Shape

The exact command name is not final. The intended behavior is:

```powershell
source-packet-convert plan `
  --workspace . `
  --inventory raw/source-inventory.md `
  --source-id course/module-01 `
  --packet raw/derived/course/module-01 `
  --report reports/source-packet-convert-report.md
```

Expected modes:

- `plan`: inspect inventory and report what conversion would need
- `convert`: run or coordinate the selected adapter and write a packet
- `check-output`: verify that adapter output left the required packet files

## Inputs

- workspace root
- source inventory file, normally `raw/source-inventory.md`
- `source_id`
- raw source path from inventory
- raw hash state from inventory
- source kind from inventory
- selected adapter or manual workflow, when any
- target packet directory under `raw/derived/<source-id>/`
- optional adapter configuration

## Outputs

- `metadata.yml` or `metadata.json`
- `source.md`
- optional `media/`
- optional `review.md` or `gaps.md`
- optional backend artifacts referenced from metadata or anchors
- conversion report listing status, generated fields, known gaps, derived
  artifacts, and review routing

The tool should never silently rewrite raw source files.

## Adapter Behavior

Supported adapter shapes are behavior categories, not required implementations:

- manual workflow
- Agent/MCP workflow
- local CLI workflow
- MinerU-like backend
- custom script

Adapters may create detailed outputs, but backend-local IDs and files must map
to workspace anchors and packet artifacts. The backend does not own
`source_id`, packet identity, or final wiki knowledge.

## Deterministic Behavior

The tool should deterministically:

- read the inventory row for `source_id`
- reject missing or duplicate source IDs
- check that `raw_path` stays under `raw/sources/`
- check that packet output path matches `raw/derived/<source-id>/`
- check whether required packet files exist after conversion
- report generated field kinds, `known_gaps`, `review_required`, and
  `review_reason`

Adapter execution itself may be manual, model-assisted, or backend-specific.
The report should separate deterministic checks from adapter-produced content.

## Failure Modes

The tool should report:

- missing inventory row
- inventory status not ready for conversion
- raw source missing or hash state unstable
- adapter configuration missing or unsupported
- adapter produced no packet
- packet metadata missing or incomplete
- source anchors missing
- backend-local references not mapped to workspace anchors
- generated content not marked in `generated_fields`
- `review_required` without useful `review_reason`

Failure must be visible. Partial or failed conversion should leave status,
known gaps, and review routing when possible.

## Exit-Code Expectations

Future implementation should use:

- `0`: conversion output is valid for the requested mode
- `1`: deterministic failure
- `2`: review is required but no deterministic failure occurred
- `3`: tool configuration or runtime error

These exit codes are proposals until Person A accepts validator behavior.

## Non-Goals

The source packet convert tool should not:

- implement PDF, PPTX, DOCX, image, table, or chart parsers
- require MinerU, MCP, GPU, hosted APIs, or model servers
- generate final wiki pages
- extract claims
- decide whether generated content is source-equivalent
- implement compare gates
- edit schemas
