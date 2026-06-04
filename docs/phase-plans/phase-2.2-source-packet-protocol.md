# Phase 2.2 Source Packet Protocol

Phase 2.2 defines the source packet protocol.

Phase 2.1 answered how a raw source enters inventory. Phase 2.2 answers what a
ready source must produce before evidence, claims, wiki pages, or raw-wiki
alignment reports can trust it.

This phase is still protocol-first. It does not implement a parser, run MinerU,
build an MCP adapter, or generate wiki pages.

## Position In Phase 2

Phase 2.2 covers this part of the pipeline:

```text
ready inventory row
-> source packet directory
-> packet metadata
-> packet anchors
-> generated fields, gaps, and review routing
-> later evidence/claims/wiki/alignment
```

The packet is the audit layer for one source. It supports the agent-readable
wiki layer, but it does not replace that layer.

## Purpose

A source packet is the stable workspace artifact that records:

- which raw source was processed
- which backend, method, or manual workflow processed it
- which anchors can be cited later
- which extracted content is directly source-derived
- which fields are generated or model-assisted
- which gaps or failures remain
- which review decisions are required before downstream confidence increases

The packet should be faithful and auditable, not elegant. The wiki should be
agent-readable and human-reviewable, not a second copy of packet metadata.

## Required Directory Shape

Every processed source should write a packet directory:

```text
raw/derived/<source-id>/
  source.md
  metadata.yml or metadata.json
  media/
  review.md optional
```

Required:

- `source.md`
- `metadata.yml` or `metadata.json`

Optional:

- `media/`
- `review.md`
- `gaps.md`
- backend-specific derived artifacts

Optional files should be referenced from metadata or `source.md`. They should
not create a second source namespace.

## File Responsibilities

### metadata.yml Or metadata.json

Metadata is the source of truth for operational packet facts.

It should own:

- `source_id`
- `raw_path`
- `raw_sha256` or hash state
- `source_kind`
- `inventory_status_at_extraction`
- `extraction_backend`
- `extraction_method`
- `extraction_version`
- `extraction_status`
- `modalities`
- `generated_fields`
- `known_gaps`
- `review_required`
- `review_reason`
- `derived_artifacts`
- creation and update dates

Do not require agent-readable wiki pages to repeat these fields.

### source.md

`source.md` is the readable extracted packet body. It should preserve source
order and anchors so later records and wiki pages can cite it.

It should contain:

- a concise packet title
- a short packet scope note
- source structure overview
- anchor table
- extracted content blocks by anchor
- media references where relevant
- explicit generated or inferred fields
- concise extraction gaps
- concise handoff notes

It should not become:

- a final wiki article
- a polished chapter summary
- a duplicate of full metadata
- a validation report
- a long process log

### media/

`media/` stores extracted or rendered derived artifacts:

- images
- page renders
- slide renders
- table CSV/TSV files
- chart screenshots
- other source-derived media

Media files are derived artifacts. They can be cited by anchors, but they do
not replace the raw source.

### review.md Or gaps.md

Use a separate review or gaps file only when the review state is too large for
concise `source.md` notes.

If the packet has only a few gaps, keep them in `source.md` and metadata.

## Metadata Protocol

Minimum metadata fields:

```yaml
type: source-packet
source_id: replace-me
raw_path: raw/sources/replace-me
raw_sha256: pending
source_kind: pdf
inventory_status_at_extraction: ready
extraction_backend: manual
extraction_method: manual
extraction_version: v0
extraction_status: partial
modalities: [text]
generated_fields: []
known_gaps: []
review_required: false
review_reason: ""
derived_artifacts: []
created: YYYY-MM-DD
updated: YYYY-MM-DD
```

`extraction_backend` records the executor or adapter family, such as `manual`,
`poppler`, `libreoffice`, `mineru`, `claude-mcp`, `codex-local`, or a custom
script name.

`extraction_method` records the specific method used, such as `manual-notes`,
`pdftotext`, `rendered-pages`, `office-xml`, or `adapter-output`.

`extraction_status` should be one of:

- `complete`
- `partial`
- `failed`
- `manual-review`

Status is about packet extraction, not inventory intake.

## Anchor Protocol

Anchors are the most important packet output. They are what later evidence,
claims, wiki pages, and alignment reports cite.

Minimum anchor fields:

- `anchor_id`
- `location`
- `label`
- `content_kind`
- `source_derived`
- `generated`
- `media_ref`
- `notes`

Example:

| anchor_id | location | content_kind | label | source_derived | generated | media_ref | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| p001 | page 1 | text | Opening definition | yes | no |  | Direct text extraction. |
| p002-fig1 | page 2 figure 1 | image | System block diagram | yes | caption | media/page-002-fig1.png | Caption needs review. |

Anchor ID rules:

- keep anchor IDs stable across reruns when the source has not changed
- use page, slide, heading, row, timestamp, or file-based prefixes when useful
- avoid backend-specific IDs as the only anchor name
- do not include local absolute paths
- split anchors when one location contains separate text, table, image, or
  chart content that may be cited independently

## Extracted Content Blocks

`source.md` should organize extracted content by anchor.

Minimum block shape:

```markdown
### p001 - Opening Definition

- Location: page 1
- Content kind: text
- Source-derived: yes
- Generated: no
- Media references:

Extracted text goes here.
```

For tables, charts, and images, the block should distinguish direct source
material from generated interpretation.

## Generated Fields

Generated or model-assisted fields are allowed, but must be labeled.

Examples:

- OCR text
- image captions
- chart summaries
- table repairs
- formula recognition
- inferred reading order
- agent extraction notes

Generated content is not source-equivalent by default. Claims based on
generated content should carry a generated-evidence marker or route to review
in later phases.

## Known Gaps

Known gaps should be explicit and compact.

Examples:

- page text extraction failed
- chart value extraction not verified
- slide media mapping uncertain
- table too large and exported as a derived artifact
- OCR confidence low
- password-protected page skipped
- source kind unsupported by current backend

Do not hide gaps by writing a smoother summary.

## Review Routing

Set `review_required` when:

- extraction is `partial`, `failed`, or `manual-review`
- generated content affects important knowledge
- visual interpretation is important but not deterministic
- media mapping is uncertain
- anchor coverage is incomplete
- a source has changed since packet creation

Review notes should say what a reviewer must decide, not merely that the packet
is imperfect.

## Relationship To Agent-Readable Wiki

The packet supports the wiki, but the packet is not the wiki.

Source packets should:

- preserve anchors and extraction facts
- expose source-derived content in source order
- mark generated fields and gaps
- provide concise handoff notes

Wiki pages should:

- cite packet anchors for important claims
- remain agent-readable and human-reviewable
- avoid copying packet hashes, backend details, and full extraction logs
- use packet gaps only when they affect knowledge confidence or review

## Person A Handoff

Workflow needs for schema and validation:

- validate required packet metadata fields
- validate `extraction_status` enum values
- validate anchor table or anchor record shape
- validate stable `raw_path` under `raw/sources/`
- warn when `generated_fields` are used but no generated anchors are marked
- warn when `review_required` is true but `review_reason` is blank
- warn when `source.md` has no anchors unless extraction failed
- allow `derived_artifacts` to reference backend-specific files without making
  them source identity

Person B should keep these as handoff proposals unless Person A accepts schema
or validator changes.

## Non-Goals

Phase 2.2 should not:

- implement PDF, PPTX, DOCX, image, or table extraction
- run MinerU
- implement MCP or adapter code
- write source-type packet profiles in detail
- generate wiki pages
- extract claims
- implement compare gates
- edit `contracts/schemas/**`

## Completion Criteria

Phase 2.2 is complete when:

- the packet protocol names required files and optional files
- metadata, `source.md`, media, gaps, and review responsibilities are clear
- anchor records have a minimum shape
- generated fields and known gaps are distinguishable from source-derived
  content
- the source packet template can be filled manually without guessing
- Person A has a concrete schema/validator handoff list
- the packet/wiki boundary protects the agent-readable wiki layer from audit
  noise
