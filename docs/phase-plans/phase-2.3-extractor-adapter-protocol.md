# Phase 2.3 Extractor Adapter Protocol

Phase 2.3 defines how optional extractors connect to a workspace without
owning the workspace.

Phase 2.1 defines source inventory. Phase 2.2 defines the source packet that
must exist after extraction. Phase 2.3 defines the adapter boundary between
those two durable workspace contracts and any optional extraction backend.

This phase is still protocol-first. It does not implement a parser, run MinerU,
build an MCP adapter, write CLI README specs, create source-type packet
profiles, or edit schemas.

## Position In Phase 2

Phase 2.3 covers this part of the pipeline:

```text
ready inventory row
-> optional adapter
-> valid source packet
```

The adapter may be a human workflow, an agent, an MCP, a local CLI, MinerU, a
custom script, or another extractor. The adapter is not the workspace owner.

The workspace inventory owns `source_id`. The Phase 2.2 source packet owns
metadata, anchors, generated fields, known gaps, review routing, and derived
artifact references.

## Adapter Purpose

An extractor adapter translates one backend's behavior into the workspace
source packet protocol.

It should answer:

- what input source was processed
- which backend, method, version, or configuration produced the output
- how backend-local references map into stable workspace anchors
- which extracted content is directly source-derived
- which content is generated or model-assisted
- which modalities failed, were skipped, or require review
- where detailed backend artifacts live without becoming source identity

An adapter should make extraction auditable. It should not decide final wiki
knowledge, hide partial output, or let backend-specific files become the source
namespace.

## Required Inputs

Every adapter starts from a ready or reviewable source inventory row.

Required input facts:

- `source_id`
- `raw_path`
- `raw_sha256` or hash state
- `source_kind`
- inventory status
- intended packet directory under `raw/derived/<source-id>/`

The adapter may read the raw source and supporting workspace rules. It should
not rename the source, move the raw file, or create a new source namespace.

## Required Outputs

Every successful or partially successful adapter run must leave a source packet
that follows Phase 2.2:

- `metadata.yml` or `metadata.json`
- `source.md`
- optional `media/`
- optional `review.md` or `gaps.md`
- optional backend artifacts referenced from metadata or anchors

The adapter must write enough information for a later agent, validator, or
human reviewer to understand the source packet without invoking the backend
again.

## Backend Declaration

Use the Phase 2.2 packet fields to declare backend behavior:

- `extraction_backend`: backend or adapter family
- `extraction_method`: specific method used
- `extraction_version`: backend, adapter, prompt, or manual protocol version
- `extraction_status`: `complete`, `partial`, `failed`, or `manual-review`
- `generated_fields`: generated or model-assisted field kinds
- `known_gaps`: failed, skipped, unsupported, or uncertain extraction areas
- `review_required`
- `review_reason`
- `derived_artifacts`

Do not add new required schema fields in Phase 2.3. If the workflow needs a
new field, record it as a Person A handoff proposal.

## Anchor Mapping

Backend-local IDs may be useful, but they are not sufficient.

The adapter must map backend-local references into stable workspace anchors
that later records can cite as:

```text
<source_id>#<anchor_id>
```

Anchor mapping rules:

- Workspace anchors should be stable across reruns when the raw source has not
  changed.
- Backend-local IDs may appear in notes or derived artifacts, but they should
  not be the only anchor identity.
- Page, slide, heading, row, timestamp, or filename-based anchors are preferred
  when they match the source structure.
- Separate text, table, image, chart, formula, and code anchors when they may
  support different claims.
- If the backend cannot map an output to a stable source location, mark the
  packet `manual-review`.

## Failure Protocol

Adapters must fail visibly.

A failed or incomplete adapter run should still leave a packet or report that
states what happened when possible.

In other words, the backend has failed visibly only when the workspace records
status, gaps, and review routing.

Minimum visible failure behavior:

- set `extraction_status: failed`, `partial`, or `manual-review`
- record `known_gaps`
- set `review_required: true`
- write a useful `review_reason`
- preserve any reliable anchors or derived artifacts that were produced
- avoid marking the inventory row as cleanly processed until the packet is
  usable for the current hash or manifest

Silent skipping is not allowed. An unsupported modality should become a known
gap or review item, not disappear.

## Typical Adapter Shapes

### Manual Adapter

A human or agent reads the raw source and fills the source packet template.

Use:

- `extraction_backend: manual`
- `extraction_method: manual-notes` or a more precise manual method
- `extraction_version`: the rule or prompt version used

Manual adapters are acceptable for early workflows, but they must still preserve
anchors, generated fields, known gaps, and review routing.

### Agent/MCP Adapter

An agent may use its own MCP or internal tools to inspect PDFs, slides,
documents, images, or tables.

Use:

- `extraction_backend`: the agent or MCP family, such as `claude-mcp`,
  `codex-local`, or a custom adapter name
- `extraction_method`: the specific extraction path used
- `derived_artifacts`: any files the agent created that support review

The agent's private tool output is not the workspace source of truth. The
workspace source packet is.

### MinerU/local CLI Adapter

MinerU, Poppler, LibreOffice, or another local CLI may produce detailed
intermediate outputs.

Use:

- `extraction_backend`: the backend family, such as `mineru`, `poppler`, or
  `libreoffice`
- `extraction_method`: the specific mode, such as pipeline, VLM, `pdftotext`,
  rendered pages, or office XML
- `derived_artifacts`: detailed backend outputs, debug artifacts, page renders,
  slide renders, tables, or media files

These backends may inform anchors and packet content. They do not become a
required dependency, default workflow, or source identity.

## Person A Handoff

Workflow needs that Person A may later validate:

- required backend declaration fields are present when a packet is adapter-made
- `extraction_status` matches visible output
- generated fields are paired with generated anchor markers or review routing
- backend-local IDs are not used as the only anchor identity
- failed adapters produce known gaps and review reasons
- derived artifact paths stay inside the packet directory or another approved
  workspace path

Person B should keep these as handoff proposals unless Person A accepts schema,
validator, or fixture changes.

## Non-Goals

Phase 2.3 should not:

- implement PDF, PPTX, DOCX, image, table, or chart parsing
- run MinerU or any other backend
- implement MCP or adapter code
- write CLI README specs
- write source-type packet profiles
- generate wiki pages
- extract claims
- implement compare gates
- edit `contracts/schemas/**`

## Completion Criteria

Phase 2.3 is complete when:

- the adapter boundary is clear
- required inputs and outputs are explicit
- backend declaration uses Phase 2.2 fields
- backend-local references must map to workspace anchors
- failure must be visible through packet status, gaps, and review routing
- manual, Agent/MCP, and MinerU/local CLI examples exist
- the phase preserves Phase 2.4 and Phase 2.6 boundaries
