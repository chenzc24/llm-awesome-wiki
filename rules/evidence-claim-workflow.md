# Evidence And Claim Workflow

This rule owns the optional Phase 3 audit layer from source packet anchors to
evidence, claim candidates, support checks, and claim review routing.

Use it when a round creates important source-backed claims that affect wiki
acceptance, compare status, review, or downstream executable work. Do not use
it to turn every sentence into a claim record.

## Minimum Path

```text
source packet anchor
-> selected evidence
-> claim candidate
-> support check
-> supported, contested, unsupported, needs-review, or stale
-> wiki and compare handoff
```

Evidence and claims support the readable wiki. They do not replace
source/chapter pages.

## Inputs

Required inputs:

- source packet path
- packet metadata or frontmatter
- anchor index and extracted content blocks
- generated-field markings
- known gaps and review routing from Phase 2

Optional inputs:

- rendered page or slide references
- media artifacts
- packet lint report
- prior claim/evidence map
- prior review decisions

## Evidence Selection

Select evidence when an anchor supports a statement that later wiki pages,
compare reports, review decisions, or executable specs may rely on.

Good evidence targets include definitions, procedures, design rules, parameter
values, formulas, comparisons, warnings, source conflicts, review decisions, and
acceptance conditions.

Do not create evidence for every sentence.

## Evidence Output

Evidence may be recorded as structured records, a report table, or a generated
map. Until schemas and tools are hardened, use:

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
or all extracted text unless directly relevant to the claim under review.

Evidence kinds may include `text`, `table`, `figure`, `chart`, `formula`,
`ocr`, `caption`, `summary`, `inference`, and `review-decision`.

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

Do not treat the following as evidence by default:

- a model confidence statement without source support
- a polished wiki paragraph with no packet anchor
- a source packet heading that does not support a knowledge statement
- backend metadata unrelated to the claim
- a raw file path without an anchor
- an unmarked generated caption

## Claim Boundary

A claim is a knowledge statement important enough to preserve, cite, compare,
review, or use later.

Good claim candidates include definitions, procedures, design rules,
parameters, formulas, comparisons, mechanisms, limitations, requirements, and
open questions that block use.

Leave headings, navigation labels, topic lists, temporary summaries, extraction
notes, source-structure restatements, and low-value prose as context unless
they become important for review or downstream use.

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

These are workflow facts. Person A owns final machine-readable contracts.

Practical claim types include `definition`, `procedure`, `design-rule`,
`parameter`, `formula`, `comparison`, `mechanism`, `limitation`, `requirement`,
and `open-question`.

## Claim Status

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

A supported claim needs cited evidence or source references that support the
actual wording. If the claim adds scope, causality, values, ordering, or
interpretation not present in the evidence, narrow the claim or mark it
`needs-review`.

When one source anchor supports only part of a claim, split the claim, cite
additional evidence, or route the unsupported part to review.

## Generated Evidence

Evidence is generated or generated-derived when it depends on OCR text, image
captions, chart summaries, table repairs, formula recognition, inferred reading
order, visual descriptions, agent extraction notes, normalized values, inferred
headings, or cross-file summaries.

Generated evidence must stay visible in the evidence map.

Use `needs-review` when generated evidence carries an important claim,
especially OCR/caption text, chart trends or values, repaired table structure,
formula recognition, or agent interpretation. Reviewed generated evidence may
support a claim, but the claim should remain traceable to both the generated
anchor and review decision.

## Conflict And Review Routing

When evidence conflicts, do not choose a winner without review. Record each
source reference, mark the claim `contested` or `needs-review`, describe the
decision needed, and carry the state into compare or wiki work.

Create or update a review item when:

- the anchor is missing, unstable, or too broad
- the evidence summary is more specific than the source anchor
- a claim has no evidence
- evidence does not fully support claim wording
- generated evidence supports an important claim
- OCR, caption, chart, formula, or table repair uncertainty matters
- multiple anchors conflict
- skipped or omitted modality affects the claim
- source scope is unclear
- a claim has downstream engineering impact
- a previous review decision may be stale
- the packet has `review_required: true` for the relevant anchor

Review items should include review item ID, claim ID or text, source
references, evidence IDs when available, generated fields involved, current
status, exact decision needed, and suggested next action.

Unresolved review items must not disappear between rounds. Keep them open or
carried forward, reference them from the claim/evidence map, mention them in
validation, and prevent affected claims from being treated as fully supported.

## Artifact Economy

Claim records should not become duplicate wiki pages. Keep readable
explanations in source/chapter pages and use claim/evidence maps for support,
conflict, generated-evidence state, and review.

For large document and PPT corpora, the default is:

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
- contested claims remain visible
- unresolved review items carry forward
- claim records do not replace chapter-oriented wiki pages
