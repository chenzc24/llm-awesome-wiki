# Phase 2 Closure And Person A Handoff

Phase 2 is complete from the Person B workflow-surface side.

Phase 2 defines the raw-to-source-packet protocol layer. It does not implement
tools, parsers, schemas, validators, fixtures, claim extraction, wiki
generation, compare gates, or downstream `skill + tool` artifacts.

## Completed Workflow Surface

Phase 2 produced a complete protocol path:

```text
raw source
-> source inventory
-> source packet
-> extractor adapter boundary
-> source-type packet expectations
-> generated-field and review routing
-> Phase 2 tool surface specs
```

Completed Person B outputs:

- Phase 2.1 source intake and inventory workflow
- Phase 2.2 source packet protocol
- Phase 2.3 extractor adapter protocol
- Phase 2.4 source-type packet profiles
- Phase 2.5 generated fields and review routing
- Phase 2.6 tool surface specs for `source-inventory`,
  `source-packet-convert`, and `source-packet-lint`

## Design Confirmation

Phase 2 satisfies the core design direction:

- VSCode/Git-first: all workflow state is repo-local and file-based
- Agent-first: rules describe what agents must read, produce, mark, and report
- portable: no Obsidian, desktop app, hidden state, GPU, hosted API, or MCP is
  required
- protocol-first: optional extractors are backend inputs, not workflow owners
- auditable: source IDs, raw paths, hashes, packet metadata, anchors, generated
  fields, known gaps, review routing, and reports are visible
- artifact economy: source packets are audit artifacts, not second wiki pages
- construction-tool layer: tool surfaces support inventory, conversion, and
  packet lint without starting downstream domain `skill + tool` work

## Person A Handoff

Person A should review Phase 2 as input for machine-readable contracts,
validators, and fixtures.

Recommended schema and validator review areas:

- source inventory row fields: `source_id`, `raw_path`, `source_kind`,
  `raw_sha256`, `added_at`, `status`, `packet_path`, `review_required`, and
  `notes`
- inventory status values: `new`, `ready`, `processed`, `changed`, `ignored`,
  `failed`, and `needs-review`
- source packet metadata fields: `source_id`, `raw_path`, `raw_sha256`,
  `source_kind`, `inventory_status_at_extraction`, `extraction_backend`,
  `extraction_method`, `extraction_version`, `extraction_status`,
  `modalities`, `generated_fields`, `known_gaps`, `review_required`,
  `review_reason`, `derived_artifacts`, `created`, and `updated`
- packet extraction status values: `complete`, `partial`, `failed`, and
  `manual-review`
- anchor shape and citation form: `<source_id>#<anchor_id>`
- backend-local IDs must not be the only anchor identity
- source-type packet profile expectations for PDF, PPTX, DOCX, image,
  table/dataset, and mixed media packets
- generated content marking for OCR text, image captions, chart summaries,
  table repairs, formula recognition, inferred reading order, visual
  descriptions, agent notes, normalized values, inferred headings, and
  cross-file summaries
- review routing: `review_required` should have a useful `review_reason`
- visible failure: partial or failed packets should preserve status, known
  gaps, and review routing
- tool report needs for `source-inventory`, `source-packet-convert`, and
  `source-packet-lint`
- proposed exit-code convention: `0` pass, `1` deterministic failure, `2`
  review required, `3` configuration or runtime error

Person B should not edit `contracts/schemas/**`, validator code, tests, or
fixtures as part of this handoff unless a later task explicitly assigns that
work.

## Suggested Person A Fixtures

Useful fixture scenarios:

- valid inventory row for a ready local PDF
- inventory row with duplicate `source_id`
- inventory row with `processed` status but missing `packet_path`
- valid source packet with metadata and page or slide anchors
- packet with no anchors and `extraction_status: complete`
- packet with generated fields but no generated anchor markers
- packet with `review_required: true` and blank `review_reason`
- packet using backend-local IDs without workspace anchor mapping
- PDF packet with missing page coverage and no known gap
- PPTX packet with slide order gaps
- DOCX packet with headings but no heading hierarchy
- table packet with large derived artifact reference
- partial adapter output that fails visibly

## Remaining Non-Goals

Phase 2 closure does not start:

- tool implementation
- schema implementation
- validator implementation
- fixture creation
- raw source conversion
- source packet generation
- claim extraction
- wiki generation
- compare gate implementation
- downstream executable `skill + tool` work

## Next Phase Boundary

The next Person B workflow phase is Phase 3: source packet to evidence and
claim workflow.

Phase 3 should not re-open raw conversion as its main task. It should consume
Phase 2 source packets and define:

- when a packet statement becomes a claim
- how evidence anchors support claims
- how generated evidence is marked
- when confidence or review routing is required
- how unresolved review items are handed to later compare and wiki stages

Before Phase 3 implementation, Person A can begin hardening Phase 2 contracts,
validators, and fixtures from this handoff.
