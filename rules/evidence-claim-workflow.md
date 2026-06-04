# Evidence And Claim Workflow

This rule owns the Phase 3 workflow from source packet anchors to evidence,
claim candidates, claim support, and claim review routing.

It is optional for low-stakes descriptive notes, but required when a round
creates important source-backed claims that affect wiki acceptance, compare
status, review, or downstream executable work.

## Purpose

Turn selected packet anchors into compact support units, then into reusable and
checkable knowledge statements without making every sentence a claim record.

Required path:

```text
source packet
-> selected anchors
-> evidence records or evidence map
-> claim candidate
-> support check
-> status or review item
-> wiki and compare handoff
```

Evidence and claims are audit support for the readable wiki. They should not
replace source/chapter pages.

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
- prior review decisions

## Evidence Selection

Select evidence when an anchor supports:

- a definition, procedure, parameter, formula, design rule, or warning
- a comparison between methods, tools, stages, or concepts
- a numerical value, threshold, sequence, or acceptance condition
- a source conflict or correction
- a review decision
- a later wiki statement that should be auditable

Do not create evidence for every sentence. For large PPT or document corpora,
prefer evidence for statements that later wiki pages, compare reports, or
executable specs may rely on.

## Evidence Outputs

Evidence may be recorded as structured records, a report table, or a generated
map. Until schemas and tools are hardened, the recommended workspace surface is:

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
or all extracted text unless that information is directly relevant to the claim
under review.

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

## What Is Not Evidence

The following should not be treated as evidence by default:

- a model's confidence statement without source support
- a polished wiki paragraph with no packet anchor
- a source packet heading that does not support a knowledge statement
- extraction backend metadata unrelated to the claim
- a raw file path without an anchor
- a generated caption that is not marked as generated

## Claim Boundary

A claim is a knowledge statement important enough to preserve, cite, compare,
review, or use later.

Good claim candidates include:

- definitions
- procedures
- design rules
- parameter or numerical statements
- formula or calculation statements
- comparisons
- mechanism or causal statements
- limitations, warnings, or exceptions
- requirements and acceptance criteria
- unresolved questions that block use

Not every statement should become a claim. Leave these as context unless they
become important for review or downstream use:

- headings
- navigation labels
- topic lists
- temporary summaries
- extraction notes
- obvious restatements of source structure
- prose that helps a chapter read cleanly but does not assert reusable
  knowledge

## Minimum Claim Facts

Each claim should state:

- `claim_id`
- claim text
- claim type or role
- status
- supporting evidence IDs or source references
- generated-evidence state when relevant
- review item IDs when unresolved
- intended wiki or chapter target when known

These are workflow facts. Person A owns the final machine-readable contract.

## Claim Types

Use practical labels such as:

- `definition`
- `procedure`
- `design-rule`
- `parameter`
- `formula`
- `comparison`
- `mechanism`
- `limitation`
- `requirement`
- `open-question`

Prefer a small set. Do not create a taxonomy that forces a document/PPT corpus
into a fragmented research graph.

## Claim Status Rules

Use these meanings:

| status | meaning |
| --- | --- |
| `draft` | candidate claim exists but support is not checked |
| `supported` | evidence supports the claim for the current scope |
| `contested` | evidence conflicts or sources disagree |
| `unsupported` | evidence is missing or too weak |
| `needs-review` | deterministic checks cannot decide or human judgment is required |
| `stale` | source packet, source hash, or review decision changed after acceptance |

Do not mark a claim `supported` only because the model believes it is true.

## Support Rules

A supported claim needs at least one cited evidence item or source reference.

The cited evidence must support the actual wording of the claim. If the claim
adds scope, causality, values, ordering, or interpretation not present in the
evidence, mark it `needs-review` or narrow the claim.

When one source anchor supports only part of a claim, either:

- split the claim
- cite additional evidence
- mark the unsupported part for review

## Generated Evidence Rules

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

Claims based on generated evidence must preserve that state. Use
`needs-review` when:

- OCR or caption output carries the main claim
- a chart summary infers trend, causality, or values
- a repaired table changes values, labels, or ordering
- formula recognition affects the claim
- agent notes interpret rather than extract

Reviewed generated evidence may support a claim, but the claim should remain
traceable to both the generated anchor and the review decision.

## Conflict Rules

When evidence conflicts:

- do not choose a winner without review
- record each source reference
- mark the claim `contested` or `needs-review`
- describe the decision needed
- carry the unresolved state into later compare or wiki work

## Review Routing

Create or update a review item when:

- the anchor is missing, unstable, or too broad
- the evidence summary is more specific than the source anchor
- a claim has no evidence
- evidence does not fully support the claim wording
- generated evidence supports an important claim
- OCR, caption, chart, formula, or table repair uncertainty matters
- multiple source packet anchors conflict
- a skipped modality affects the claim
- source scope is unclear
- an omitted modality affects the claim
- a claim has downstream engineering impact
- a previous review decision may be stale
- the source packet has `review_required: true` for the relevant anchor

Review items should be short decision queues, not polished explanations.

## Review Item Content

A useful review item should include:

- review item ID
- claim ID or claim text
- source references in `<source_id>#<anchor_id>` form
- evidence IDs when available
- generated fields involved, if any
- current status
- exact decision needed
- suggested next action

Generated evidence can move from `needs-review` to accepted use only when the
review decision is explicit.

## Human Resolution And Carry Forward

When a human or accepted reviewer resolves a review item:

1. record the decision
2. update the related claim status
3. keep the evidence references visible
4. note any narrowed wording or rejected interpretation
5. carry the decision into the next wiki or compare round

Dismissed review items should explain why the concern no longer matters.

Unresolved review items must not disappear between rounds. If a round cannot
resolve an item:

- keep it `open` or `carried-forward`
- reference it from the claim/evidence map
- mention it in the round validation note
- prevent affected claims from being treated as fully supported

The review should state which generated field was reviewed, which source
reference it came from, what was accepted or rejected, and whether the claim
wording changed.

## Artifact Economy Rules

Claim records should not become duplicate wiki pages.

Keep claims concise. Put readable explanations in source/chapter wiki pages.
Use claim/evidence maps to preserve traceability, support, conflict, and review
state.

For large document and PPT corpora, the default flow is:

```text
chapter-readable wiki
+ selective claim/evidence audit map
```

not:

```text
every sentence
-> claim object
-> concept/entity graph
```

## Acceptance Criteria

- important evidence cites `<source_id>#<anchor_id>`
- generated evidence is visible
- evidence is concise and does not duplicate full source packets
- important claims cite evidence or become review items
- unsupported claims are not promoted as accepted knowledge
- generated-evidence state is preserved
- contested claims remain visible
- uncertain claims create review output
- review items identify the decision needed
- unresolved review items carry forward
- claim records do not replace chapter-oriented wiki pages
