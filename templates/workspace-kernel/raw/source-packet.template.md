---
type: source-packet
packet_version: 0.1
source_id: replace-me
raw_path: raw/sources/replace-me
raw_sha256: pending
source_kind: pptx
inventory_status_at_extraction: ready
extraction_backend: manual
extraction_method: manual-notes
extraction_version: v0
extraction_status: partial
modalities: [text]
generated_fields: []
known_gaps: []
review_required: true
review_reason: replace-me
derived_artifacts: []
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# Source Packet: Replace Me

This packet is the auditable bridge between the raw source and wiki pages.
Preserve source order and anchors. Mark generated captions, OCR, and inferred
descriptions explicitly.

For manual packets, the frontmatter above can act as packet metadata. For
generated packets, put the same fields in `metadata.yml` or `metadata.json` and
keep that metadata file as the source of truth.

This packet is the audit layer, not the agent-readable wiki article.

## Source Identity

- Source ID:
- Raw path:
- Source kind:
- Hash status:
- Inventory status at extraction:
- Extraction backend:
- Extraction method:
- Extraction version:
- Extraction status:

## Packet Scope

- What this packet covers:
- What it intentionally excludes:
- Raw resource structure:

## Anchor Index

List anchors before detailed extraction. Later evidence, claims, wiki pages,
and alignment reports should cite anchors as `<source_id>#<anchor_id>`.

| anchor_id | location | content_kind | label | source_derived | generated | media_ref | review_required | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| s001 | slide 1 | title | Opening title | yes | no |  | no | Replace this row. |

## Extracted Content Blocks

### s001 - Replace Anchor Label

- Location:
- Content kind:
- Source-derived:
- Generated:
- Media references:
- Review required:

Direct source-derived content goes here.

Generated or model-assisted content, if any, goes here and must be labeled.

## Known Gaps

- Missing slides/pages/sections:
- OCR or caption uncertainty:
- Tables, charts, or media needing review:
- Unsupported or skipped modalities:

## Review Routing

- Review required:
- Review reason:
- Reviewer decision needed:

## Handoff Notes

- Important citation anchors:
- Suggested wiki targets:
- Review items to create:
- Notes for evidence/claim extraction:
