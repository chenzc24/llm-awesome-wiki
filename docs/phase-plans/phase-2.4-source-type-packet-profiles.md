# Phase 2.4 Source-Type Packet Profiles

Phase 2.4 defines minimum packet expectations for common source types.

Phase 2.1 defines inventory. Phase 2.2 defines the source packet shape. Phase
2.3 defines how optional adapters connect to that packet shape. Phase 2.4
defines what a packet should preserve for each source type so later evidence,
wiki, and alignment work can trust the raw side.

This phase is still protocol-first. It does not implement parsers, run MinerU,
write adapter code, write CLI README specs, edit schemas, generate wiki pages,
extract claims, or implement compare gates.

## Position In Phase 2

Phase 2.4 covers this part of the pipeline:

```text
source kind
-> source-type packet profile
-> valid source packet expectations
```

Profiles are minimum expectations. They tell humans, agents, and optional
adapters what a usable packet must preserve for a source type. They do not
choose the extractor backend.

## Profile Principle

Each source-type profile should answer:

- what source structure must be preserved
- what anchor shape is expected
- which direct source content should be extracted when available
- which visual, table, formula, media, or layout material should become
  derived artifacts or review items
- what unsupported or uncertain content must be recorded as known gaps
- when generated captions, OCR, VLM summaries, or agent notes must trigger
  review routing

The profile should not force verbose audit detail into the agent-readable wiki.
The source packet carries extraction detail; wiki pages cite packet anchors.

## Shared Requirements

Every source-type packet still follows Phase 2.2 and Phase 2.3:

- inventory owns `source_id`
- packet metadata owns backend, method, status, generated fields, known gaps,
  review routing, and derived artifacts
- `source.md` owns readable extracted content and workspace anchors
- adapter outputs must map backend-local references to workspace anchors
- unsupported or uncertain content becomes a known gap or review item

## PDF Profile

PDF packets should preserve page-level anchors.

Minimum expectations:

- record page count and extracted page range when available
- create page-level anchors such as `p001`
- extract page text when available, or record an explicit text-extraction gap
- reference rendered page artifacts for visual-heavy pages when available
- record scanned, empty, password-protected, or extraction-failed pages
- split tables, charts, images, formulas, and code into separate anchors when
  they may support different claims
- mark OCR text, generated captions, chart summaries, and formula recognition
  as generated or model-assisted
- route low-confidence OCR, chart interpretation, visual-heavy pages, and
  uncertain table extraction to review

PDF packets should not pretend a clean text dump covers the document when the
source contains important visual or tabular material.

## PPTX Profile

PPTX packets should preserve slide-level anchors and slide order.

Minimum expectations:

- create slide-level anchors such as `s001`
- preserve slide order and slide labels when available
- extract visible slide text when available, or record an explicit slide-text
  gap
- extract speaker notes when available, or record whether notes were absent or
  unsupported
- reference rendered slide artifacts for layout-heavy slides when available
- split important tables, charts, diagrams, images, formulas, and code into
  separate anchors when they may support different claims
- mark generated captions, chart summaries, inferred reading order, and visual
  interpretations as generated or model-assisted
- route uncertain media-to-slide mapping, dense diagrams, unreadable rendered
  text, and important visual interpretation to review

PPTX packets should not collapse a slide deck into one prose summary before the
packet stage.

## DOCX Profile

DOCX packets should preserve heading hierarchy.

Minimum expectations:

- create heading-based anchors when headings exist
- preserve paragraph, list, table, footnote, comment, and section order when
  relevant
- extract small tables as Markdown when feasible
- reference large tables as CSV, TSV, or another derived artifact when Markdown
  would become unreadable
- extract, reference, or route meaningful images to review
- record unsupported comments, tracked changes, headers, footers, footnotes, or
  embedded objects when they matter to source coverage
- mark generated captions, table repairs, inferred heading repair, and OCR as
  generated or model-assisted

DOCX packets should keep document structure visible enough for later wiki page
routing and claim extraction.

## Image Profile

Image packets should distinguish source-visible content from generated
interpretation.

Minimum expectations:

- create file-level or region-level anchors
- record image file identity and relevant derived artifact references
- preserve directly readable text only when extracted by OCR or manual
  transcription and mark the extraction method
- mark generated captions, visual descriptions, chart summaries, and object
  recognition as generated or model-assisted
- route important unreviewed visual interpretation to review
- record decorative or intentionally skipped images when they are safely out of
  scope

Image captions are not source-equivalent by default.

## Table Or Dataset Profile

Table and dataset packets should preserve tabular structure and provenance.

Minimum expectations:

- create table-level, sheet-level, row-range, or column anchors as needed
- record table title, sheet name, header rows, units, and source range when
  available
- preserve small tables in Markdown when readable
- reference large tables as CSV, TSV, workbook, or another derived artifact
- record formulas, calculated columns, merged cells, missing values, and unit
  ambiguity when relevant
- mark table repairs, inferred headers, normalized values, and generated
  summaries as generated or model-assisted
- route ambiguous units, broken formulas, inferred schema, and lossy conversion
  to review

Tables should not be flattened into prose when their structure is needed for
later evidence.

## Mixed Media Profile

Mixed media packets should make scope explicit.

Minimum expectations:

- record whether the packet covers one file, a directory, an archive, or a
  multi-file bundle
- create member-file anchors or section anchors that preserve source structure
- state which member files were processed, skipped, failed, or routed to review
- preserve derived artifacts for media that cannot be represented directly in
  `source.md`
- mark generated captions, OCR, summaries, and inferred cross-file structure as
  generated or model-assisted
- route unsupported modalities, unclear file relationships, and incomplete
  bundle coverage to review

Mixed media packets should not hide unprocessed member files inside a polished
summary.

## Person A Handoff

Workflow needs that Person A may later validate:

- source packets have anchors appropriate for their `source_kind`
- PDFs with known page count expose page-level anchor coverage or gaps
- PPTX packets preserve slide-level anchors and slide order
- DOCX packets preserve heading hierarchy when headings exist
- large tables and media references point to derived artifacts inside approved
  workspace paths
- generated captions, OCR, chart summaries, table repairs, and inferred
  structure are marked as generated fields
- review routing exists when source-type minimum expectations are not met

Person B should keep these as handoff proposals unless Person A accepts schema,
validator, or fixture changes.

## Non-Goals

Phase 2.4 should not:

- implement PDF, PPTX, DOCX, image, table, dataset, or mixed media parsers
- run MinerU or any other backend
- implement adapter code
- write CLI README specs
- generate wiki pages
- extract claims
- implement compare gates
- edit `contracts/schemas/**`

## Completion Criteria

Phase 2.4 is complete when:

- PDF, PPTX, DOCX, image, table/dataset, and mixed media profiles exist
- each profile names expected anchors, direct extraction, derived artifacts,
  generated fields, known gaps, and review routing
- the profiles remain backend-neutral
- the profiles do not advance Phase 2.5 generated-field policy beyond this
  source-type context
- the profiles do not advance Phase 2.6 CLI specs
