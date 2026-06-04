# Phase 2.5 Generated Fields And Review Routing

Phase 2.5 defines trust boundaries for generated or model-assisted content in
source packets.

Phase 2.1 defines inventory. Phase 2.2 defines the source packet shape. Phase
2.3 defines the adapter boundary. Phase 2.4 defines source-type packet
profiles. Phase 2.5 defines when generated packet content is allowed, how it is
marked, and when it must route to review.

This phase is still protocol-first. It does not implement validators, edit
schemas, write CLI README specs, generate wiki pages, extract claims, implement
compare gates, or run extractor backends.

## Position In Phase 2

Phase 2.5 covers this part of the packet workflow:

```text
source packet content
-> source-derived or generated classification
-> review routing
-> later evidence/claims/wiki handoff
```

This phase protects later claim and wiki stages from silently treating model or
tool output as original source knowledge.

## Generated Content Types

Generated or model-assisted content includes:

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

These values describe workflow meaning. Person B may propose them to Person A,
but they are not machine-readable enum requirements until accepted by the schema
and validator layer.

## Trust Levels

Use these trust levels in prose, packet notes, and review routing:

- `source-derived`: content directly present in the raw source.
- `extracted-with-tool`: content extracted by a tool without changing meaning,
  such as plain text extraction from a digital PDF.
- `generated`: content produced or changed by OCR, VLM, an agent, a model, or
  inference.
- `reviewed-generated`: generated content that a human or accepted review
  process has explicitly reviewed.
- `unsupported-or-unknown`: content that could not be reliably extracted or
  classified.

Generated content is not source-equivalent by default. It may help build the
packet, but downstream claims and wiki pages must know that the content was not
directly source-derived.

## Packet Marking Rules

Source packets may contain generated content, but they must label it.

Minimum packet behavior:

- list generated field kinds in packet metadata `generated_fields`
- mark generated anchors or generated portions inside `source.md`
- keep direct source text separate from generated interpretation when possible
- record `known_gaps` when unsupported or uncertain content matters
- set `review_required` and `review_reason` when generated content affects
  important knowledge

Do not hide generated content inside smoother source summaries. Do not move a
generated explanation into the agent-readable wiki as if it were direct source
text.

## Review Routing Rules

Set `review_required: true` when:

- generated content supports or changes an important knowledge statement
- OCR is low confidence or applied to important material
- image captions or visual descriptions carry domain meaning
- chart summaries infer values, trends, or causal statements
- table repairs add, normalize, reorder, or infer values
- formula recognition affects technical content
- inferred reading order changes how a page, slide, or diagram is understood
- agent extraction notes contain interpretation rather than extraction facts
- unsupported modalities are relevant to source coverage

Review notes should say what must be decided. They should not merely say that
the packet is imperfect.

## Claim And Wiki Handoff

Later claim and wiki stages may use generated content only with visible trust
state.

Handoff rules:

- Claims based on generated content should carry a generated-evidence marker or
  review state in later claim workflows.
- Wiki pages should cite packet anchors and avoid presenting unreviewed
  generated content as source-derived knowledge.
- Reviewed generated content may be used more confidently, but should still
  remain traceable to the generated packet anchor and review note.
- Unsupported or unknown content should become a known gap or review item
  instead of disappearing from coverage.

Phase 2.5 does not define final claim schemas or wiki page templates. It defines
the trust boundary those later stages must respect.

## Person A Handoff

Workflow needs that Person A may later validate:

- generated field kinds are recorded in packet metadata
- generated anchors or generated portions are distinguishable from direct source
  content
- `review_required: true` packets include a useful `review_reason`
- important generated content has review routing before claim/wiki handoff
- unsupported or unknown modalities appear in `known_gaps` or review items
- later claim/wiki references can preserve generated-evidence or review state

Person B should keep these as handoff proposals unless Person A accepts schema,
validator, or fixture changes.

## Non-Goals

Phase 2.5 should not:

- implement validators or schema changes
- define final claim schemas
- define final wiki page templates
- implement compare gates
- write CLI README specs
- run OCR, VLM, MinerU, MCP, or local extractor backends
- decide that generated content is source-equivalent by default
- edit `contracts/schemas/**`

## Completion Criteria

Phase 2.5 is complete when:

- generated content types are named
- trust levels distinguish source-derived, extracted, generated,
  reviewed-generated, and unsupported content
- packet marking rules are explicit
- review triggers are explicit
- claim/wiki handoff boundaries are explicit
- Person A has a schema/validator handoff list
- Phase 2.6 CLI specs remain deferred
