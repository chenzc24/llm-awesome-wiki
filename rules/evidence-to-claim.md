# Evidence To Claim

Claim extraction starts from evidence and source packet anchors. It does not
start from raw files alone, and it should not silently happen inside final wiki
generation.

## Purpose

Turn selected evidence into reusable, checkable knowledge statements.

Required path:

```text
evidence map
-> claim candidate
-> support check
-> status or review item
-> wiki and compare handoff
```

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

## Status Rules

Use these meanings:

- `draft`: candidate claim exists but support is not checked.
- `supported`: evidence supports the claim for the current scope.
- `contested`: evidence conflicts or sources disagree.
- `unsupported`: evidence is missing or too weak.
- `needs-review`: deterministic checks cannot decide or human judgment is
  required.
- `stale`: source packet, source hash, or review decision changed after the
  claim was accepted.

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

Claims based on generated evidence must preserve that state.

Use `needs-review` when:

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

- important claims cite evidence or become review items
- unsupported claims are not promoted as accepted knowledge
- generated-evidence state is preserved
- contested claims remain visible
- claim records do not replace chapter-oriented wiki pages
