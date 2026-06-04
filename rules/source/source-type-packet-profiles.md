# Source-Type Packet Profiles

Source-type packet profiles define minimum expectations for source packets by
source kind. They do not implement parsers and they do not choose an extractor
backend.

Use this rule after source inventory and together with the source packet and
extractor adapter rules.

## Purpose

Make source packets preserve the structure that later evidence, wiki, and
alignment work need.

Every profile keeps the same parent path:

```text
raw source
-> source inventory
-> optional adapter
-> source-type packet profile
-> valid source packet
```

If a source type expectation cannot be met, record a known gap and use review
routing. Do not silently smooth the packet into a summary.

## Shared Rules

- Inventory owns `source_id`.
- Packet metadata owns backend, method, status, generated fields, known gaps,
  review routing, and derived artifacts.
- `source.md` owns extracted content and workspace anchors.
- Backend-local references must map to workspace anchors.
- Generated captions, OCR, visual summaries, inferred reading order, and table
  repairs are not source-equivalent by default.
- Unsupported or uncertain content must become known gaps or review items.

## PDF

PDF packets require page-level anchors when page structure is known.

Minimum profile:

- record page count and extracted page range when available
- create anchors such as `p001`
- extract page text or record a text-extraction gap
- reference rendered pages for visual-heavy pages when available
- record scanned, empty, password-protected, or extraction-failed pages
- split tables, charts, images, formulas, and code into separate anchors when
  they may support different claims
- mark OCR text, generated captions, chart summaries, and formula recognition
  as generated or model-assisted
- route low-confidence OCR, chart interpretation, and uncertain table
  extraction to review

## PPTX

PPTX packets require slide-level anchors and slide order.

Minimum profile:

- create anchors such as `s001`
- preserve slide order
- extract visible slide text or record a slide-text gap
- extract speaker notes when available, or record absence or unsupported status
- reference rendered slides for layout-heavy slides when available
- split important tables, charts, diagrams, images, formulas, and code into
  separate anchors when they may support different claims
- mark generated captions, chart summaries, inferred reading order, and visual
  interpretations as generated or model-assisted
- route uncertain media-to-slide mapping and important visual interpretation to
  review

## DOCX

DOCX packets require heading hierarchy when headings exist.

Minimum profile:

- create heading-based anchors when possible
- preserve paragraph, list, table, footnote, comment, and section order when
  relevant
- extract small tables as Markdown when feasible
- reference large tables as CSV, TSV, workbook, or another derived artifact
- extract, reference, or route meaningful images to review
- record unsupported comments, tracked changes, headers, footers, footnotes, or
  embedded objects when they affect source coverage
- mark generated captions, table repairs, inferred heading repair, and OCR as
  generated or model-assisted

## Image

Image packets must distinguish source-visible content from generated
interpretation.

Minimum profile:

- create file-level or region-level anchors
- record image file identity and derived artifact references
- mark OCR or manual transcription method for readable text
- mark generated captions, visual descriptions, chart summaries, and object
  recognition as generated or model-assisted
- route important unreviewed visual interpretation to review
- record decorative or intentionally skipped images when they are safely out of
  scope

## Table Or Dataset

Table and dataset packets must preserve tabular structure.

Minimum profile:

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

## Mixed Media

Mixed media packets must make scope explicit.

Minimum profile:

- record whether the packet covers one file, a directory, an archive, or a
  multi-file bundle
- create member-file or section anchors that preserve source structure
- state which member files were processed, skipped, failed, or routed to review
- preserve derived artifacts for media that cannot be represented directly in
  `source.md`
- mark generated captions, OCR, summaries, and inferred cross-file structure as
  generated or model-assisted
- route unsupported modalities, unclear file relationships, and incomplete
  bundle coverage to review

## Acceptance Criteria

- PDF packets expose page-level anchors or explicit page coverage gaps.
- PPTX packets expose slide-level anchors and slide order.
- DOCX packets preserve heading hierarchy when available.
- Image packets mark generated captions and visual interpretation.
- Table packets preserve structure or reference derived artifacts.
- Mixed media packets state scope and unprocessed member files.
- All source types preserve review routing when minimum expectations are not
  met.
