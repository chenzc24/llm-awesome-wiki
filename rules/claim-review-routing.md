# Claim Review Routing

Claim review routing makes unresolved judgment visible.

Use this rule when evidence selection or claim extraction cannot safely decide
whether a claim should be accepted.

## Purpose

Prevent agents from closing semantic uncertainty by self-evaluation.

Required path:

```text
weak or uncertain claim
-> explicit review item
-> human or accepted review decision
-> updated claim status
-> later wiki and compare handoff
```

## Review Item Triggers

Create or update a review item when:

- a claim has no evidence
- evidence does not fully support the claim wording
- generated evidence supports an important claim
- OCR, caption, chart, formula, or table repair uncertainty matters
- multiple source packet anchors conflict
- source scope is unclear
- an omitted modality affects the claim
- a claim has downstream engineering impact
- a previous review decision may be stale

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

Keep review items short. They are a queue for decisions, not a polished
explanation layer.

## Human Resolution

When a human or accepted reviewer resolves a review item:

1. record the decision
2. update the related claim status
3. keep the evidence references visible
4. note any narrowed wording or rejected interpretation
5. carry the decision into the next wiki or compare round

Dismissed review items should explain why the concern no longer matters.

## Carry-Forward Rules

Unresolved review items must not disappear between rounds.

If a round cannot resolve the review item:

- keep it `open` or `carried-forward`
- reference it from the claim/evidence map
- mention it in the round validation note
- prevent affected claims from being treated as fully supported

## Generated Evidence Review

Generated evidence can move from `needs-review` to accepted use only when the
review decision is explicit.

The review should state:

- which generated field was reviewed
- which source reference it came from
- what was accepted or rejected
- whether the claim wording changed

## Acceptance Criteria

- uncertain claims create review output
- review items identify the decision needed
- generated-evidence claims cannot become supported silently
- unresolved review items carry forward
- later wiki and compare stages can see the unresolved state
