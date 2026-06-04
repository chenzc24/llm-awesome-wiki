# Source Packet To Evidence

Evidence selection starts from source packets, not raw files and not final wiki
pages.

Use this rule after a source packet has stable anchors and before important
claims are promoted into wiki pages or compare gates.

## Purpose

Turn packet anchors into compact support units for later claims.

Required path:

```text
source packet
-> selected anchors
-> evidence records or evidence map
-> claim extraction or review routing
```

Evidence is the audit bridge between a packet anchor and a claim. It should
help an agent or reviewer answer, "What exactly supports this claim?"

## Inputs

Required inputs:

- source packet path
- packet metadata or frontmatter
- anchor index
- extracted content blocks
- generated-field markings
- known gaps and review routing from Phase 2

Optional inputs:

- rendered page or slide references
- media artifacts
- packet lint report
- prior claim/evidence map
- review decisions

## Evidence Outputs

Evidence may be recorded as structured records, a report table, or a generated
map. Until Person A hardens schemas and tools, the recommended workspace
surface is:

```text
reports/review/claim-evidence-map.md
```

Minimum evidence facts:

- `evidence_id`
- source packet path or source identity
- source reference in `<source_id>#<anchor_id>` form
- evidence kind
- short excerpt or summary
- generated state
- confidence or review state
- notes only when needed for review

Evidence should not repeat raw hash, extraction backend, full packet metadata,
or all extracted text unless that information is directly relevant to the
claim under review.

## Evidence Kinds

Use practical workflow labels such as:

- `text`
- `table`
- `figure`
- `chart`
- `formula`
- `ocr`
- `caption`
- `summary`
- `inference`
- `review-decision`

These labels are workflow terms. If enum validation is needed, hand it to
Person A instead of editing schemas directly.

## Anchor Requirements

Evidence must cite workspace anchors, not only backend-local IDs.

Preferred form:

```text
<source_id>#<anchor_id>
```

Examples:

```text
adc-ch1#slide-003
adc-ch1#page-012
adc-ch1#table-002
```

If a backend artifact has its own ID, record it as a note or artifact reference
only after mapping it to a workspace anchor.

## Selection Rules

Select evidence when an anchor supports:

- a definition, procedure, parameter, formula, design rule, or warning
- a comparison between methods, tools, stages, or concepts
- a numerical value, threshold, sequence, or acceptance condition
- a source conflict or correction
- a review decision
- a later wiki statement that should be auditable

Do not create evidence for every sentence. For large PPT or document corpora,
prefer evidence for the statements that later wiki pages, compare reports, or
executable specs may rely on.

## Generated Evidence

Evidence is generated or generated-derived when it depends on:

- OCR text
- image captions
- chart summaries
- table repairs
- formula recognition
- inferred reading order
- visual descriptions
- agent extraction notes
- normalized values
- inferred headings
- cross-file summaries

Generated evidence must stay visible in the evidence map.

Important claims based on generated evidence must be routed to review unless a
review decision has accepted the generated content for the current use.

## What Is Not Evidence

The following should not be treated as evidence by default:

- a model's confidence statement without source support
- a polished wiki paragraph with no packet anchor
- a source packet heading that does not support a knowledge statement
- extraction backend metadata unrelated to the claim
- a raw file path without an anchor
- a generated caption that is not marked as generated

## Review Triggers

Create or update a review item when:

- the anchor is missing, unstable, or too broad
- the evidence is generated and important
- the evidence summary is more specific than the source anchor
- a skipped modality affects the claim
- evidence from multiple anchors conflicts
- the source packet has `review_required: true` for the relevant anchor

## Acceptance Criteria

- important evidence cites `<source_id>#<anchor_id>`
- generated evidence is visible
- evidence is concise and does not duplicate full source packets
- uncertain evidence creates review output
- the evidence map supports later claim extraction without becoming a wiki page
