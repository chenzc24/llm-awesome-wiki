# Extractor Adapter Protocol

Extractor adapters are optional bridges between raw sources and source packets.
They may be manual workflows, agents, MCPs, local CLIs, MinerU, Poppler,
LibreOffice, custom scripts, or other backends.

An adapter is not the workspace owner. It must obey workspace inventory and
source packet rules.

## Purpose

Translate backend-specific extraction into the workspace source packet
protocol.

Required path:

```text
ready inventory row
-> optional adapter
-> valid source packet
```

Do not let an adapter create a parallel source namespace, skip the inventory,
or produce final wiki pages directly.

## Inputs

An adapter must start from a source inventory row that is ready or explicitly
reviewable.

Minimum inputs:

- `source_id`
- `raw_path`
- `raw_sha256` or recorded hash state
- `source_kind`
- inventory status
- target packet directory under `raw/derived/<source-id>/`

The adapter may read raw files and rules. It must not rewrite raw source files
as part of extraction.

## Outputs

An adapter must leave a Phase 2.2 source packet:

- `metadata.yml` or `metadata.json`
- `source.md`
- optional `media/`
- optional `review.md` or `gaps.md`
- optional backend artifacts referenced from metadata or anchors

The packet must be usable without re-running the backend for ordinary review,
wiki construction, evidence extraction, and alignment checks.

## Backend Declaration

Use existing source packet fields:

- `extraction_backend`
- `extraction_method`
- `extraction_version`
- `extraction_status`
- `generated_fields`
- `known_gaps`
- `review_required`
- `review_reason`
- `derived_artifacts`

Examples:

| Adapter shape | extraction_backend | extraction_method |
| --- | --- | --- |
| manual notes | `manual` | `manual-notes` |
| Agent/MCP workflow | `claude-mcp` or `codex-local` | tool or prompt path used |
| MinerU/local CLI | `mineru`, `poppler`, or `libreoffice` | backend mode or command family |

Do not introduce new required fields in workflow prose. When a field is needed
but not accepted by Person A, record it as a schema or validator handoff
proposal.

## Anchor Mapping

Backend-local references must map to workspace anchors.

Preferred citation form:

```text
<source_id>#<anchor_id>
```

Rules:

- Workspace anchors are the citation identity for later phases.
- Backend-local IDs may appear in notes or derived artifacts.
- Backend-local IDs must not be the only stable anchor identity.
- Prefer page, slide, heading, row, timestamp, or filename-based anchors.
- Split anchors when text, table, image, chart, formula, or code content may
  support different claims.
- If stable mapping is impossible, mark the packet `manual-review`.

## Generated And Unsupported Content

Generated or model-assisted content is allowed only when labeled.

Examples:

- OCR text
- image captions
- chart summaries
- table repairs
- formula recognition
- inferred reading order
- agent extraction notes

Unsupported or uncertain modalities must become known gaps or review items.
They must not disappear from the packet.

## Failure Protocol

Adapters must fail visibly.

An adapter has failed visibly only when the workspace records status, gaps, and
review routing.

When extraction fails or only partially succeeds:

- set `extraction_status` to `failed`, `partial`, or `manual-review`
- record `known_gaps`
- set `review_required`
- write `review_reason`
- preserve reliable anchors or derived artifacts when available
- avoid marking the source cleanly processed until the packet is usable

Silent skipping is not allowed.

## Typical Adapter Shapes

### Manual

A human or agent fills the source packet template after reading the raw source.

The packet should use `extraction_backend: manual` and name the manual method
or prompt version in `extraction_method` and `extraction_version`.

### Agent/MCP

An agent may use MCPs or private local tools to inspect raw files.

The private tool output is not the workspace source of truth. The adapter must
write the workspace source packet and reference supporting artifacts when
useful.

### MinerU/local CLI

MinerU, Poppler, LibreOffice, and similar tools may produce detailed outputs,
page renders, tables, or debug artifacts.

Those artifacts may support packet anchors and review. They are not required
dependencies and they do not become source identity.

## Non-Goals

This rule does not:

- implement an adapter
- require MinerU, MCP, GPU, hosted APIs, or model servers
- define PDF, PPTX, DOCX, image, table, or chart profiles
- define CLI command syntax
- generate wiki pages or claims
- edit schemas

## Acceptance Criteria

- adapter input starts from an inventory row
- adapter output is a valid source packet
- backend declaration is visible in packet metadata
- backend-local references map to workspace anchors
- generated fields and unsupported modalities are visible
- failure is recorded through status, gaps, and review routing
- manual, Agent/MCP, and MinerU/local CLI workflows can all use the same rule
