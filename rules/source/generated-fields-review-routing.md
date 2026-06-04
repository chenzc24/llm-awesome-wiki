# Generated Fields And Review Routing

Generated or model-assisted content can help produce source packets, but it is
not source-equivalent by default.

Use this rule whenever a packet includes OCR, captions, summaries, repairs,
recognition, inferred structure, normalized values, or agent interpretation.

## Purpose

Keep source packets useful without letting generated content masquerade as raw
source knowledge.

Required path:

```text
generated content
-> explicit packet marking
-> review routing when needed
-> visible handoff to claim/wiki stages
```

## Generated Field Kinds

Common generated field kinds:

- `ocr_text`
- `image_caption`
- `chart_summary`
- `table_repair`
- `formula_recognition`
- `inferred_reading_order`
- `visual_description`
- `agent_extraction_note`
- `normalized_value`
- `inferred_heading`
- `cross_file_summary`

These labels are workflow protocol terms. If a tool or schema later needs enum
validation, Person B should hand the need to Person A instead of editing schema
files directly.

## Trust Levels

Use these trust levels when deciding packet notes and review routing:

- `source-derived`: directly present in the raw source.
- `extracted-with-tool`: extracted mechanically without changing meaning.
- `generated`: produced or changed by OCR, VLM, model output, an agent, or
  inference.
- `reviewed-generated`: generated content that has explicit human or accepted
  review.
- `unsupported-or-unknown`: not reliably extracted or classified.

Generated content is useful evidence context, but it is not direct source text
unless review accepts it as trustworthy for the current use.

## Packet Marking

When a packet contains generated content:

- list the generated field kind in `generated_fields`
- mark the generated anchor or generated portion in `source.md`
- keep generated interpretation separate from direct source extraction when
  possible
- record `known_gaps` when unsupported or uncertain content matters
- set `review_required` when generated content affects important knowledge
- write `review_reason` with the reviewer decision needed

Do not smooth generated content into source-derived prose.

## Review Triggers

Set `review_required: true` when:

- generated content supports an important claim candidate
- OCR is low confidence or applied to important text
- an image caption or visual description carries domain meaning
- a chart summary infers values, trends, comparisons, or causality
- a table repair changes, infers, normalizes, or reorders values
- formula recognition affects technical content
- inferred reading order changes the meaning of a page, slide, or diagram
- an agent extraction note interprets rather than extracts
- unsupported modalities affect source coverage

Review routing should be specific. Name the generated field, anchor, and
decision needed.

## Handoff Rules

Later stages should preserve generated-content state.

- Claims based on generated content should carry generated-evidence or review
  state in later claim workflows.
- Wiki pages should cite packet anchors and avoid presenting unreviewed
  generated content as source-derived knowledge.
- Reviewed generated content may be used, but it should remain traceable to the
  generated anchor and review note.
- Unsupported or unknown content should remain visible as `known_gaps` or
  review items.

This rule does not define the final claim schema or wiki template. It defines
the trust boundary those later stages must respect.

## Acceptance Criteria

- generated field kinds are visible in packet metadata or packet notes
- generated anchors are distinguishable from source-derived anchors
- important generated content has review routing
- `review_required` has a useful `review_reason`
- unsupported modalities become `known_gaps` or review items
- generated content is not treated as source-equivalent by default
