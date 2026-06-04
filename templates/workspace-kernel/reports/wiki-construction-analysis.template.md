# Wiki Construction Analysis

## Round

- Plan:
- Date:
- Status: `draft`, `ready-for-generation`, `needs-review`, or `blocked`
- Distillation depth: `full-round`, `selective`, or `overview-only`

## Inputs Read

- Source packets:
- Raw or rendered source views:
- External extraction output or high-density notes:
- Claim/evidence maps:
- Review queues:
- Existing overview:
- Existing index:
- Existing source pages:
- Existing chapter pages:

## Source Outline Or Coverage Plan

Required before final prose for document/PPT rounds unless the round is
explicitly `overview-only`.

| source_ref_or_range | location | topic_or_content | content_kind | importance | intended_wiki_target | planned_disposition | reason_or_next_action |
| --- | --- | --- | --- | --- | --- | --- | --- |
| source-id#anchor-id or source-id#p001-p003 | slide/page/section | Replace this row. | text/chart/table/image/formula/diagram | core/supporting/reference/decorative/unknown | wiki/chapters/replace-me.md | cover/defer/omit/review/block |  |

Broad page or slide ranges should name the important topics inside the range.
Do not use a broad range as a substitute for core source coverage.

## Semantic Draft

Draft the source's important knowledge before compressing it into final wiki
prose. This section may be denser than the accepted chapter page.

- Important definitions:
- Core formulas and variables:
- Derivation steps:
- Tables, charts, or examples:
- Procedures or methods:
- Practical implications:
- Candidate-derived content that needs grounding:

## Grounding Pass

For every important semantic unit above, record how it will be accepted,
narrowed, deferred, rejected, or routed to review.

| draft_unit | source_refs | grounding_state | wiki_target | review_or_reason |
| --- | --- | --- | --- | --- |
| formula/example/definition | source-id#anchor-id | grounded/candidate-derived/reviewed/deferred/rejected | wiki/chapters/replace-me.md |  |

Do not discard useful candidate-derived content silently. If source packets are
lossy, use raw/rendered views or external notes to identify the knowledge, then
ground it or route it to review.

## Routing Decisions

| input | route | target_path | action | reason |
| --- | --- | --- | --- | --- |
| source-id#anchor-id or source packet | chapter page | wiki/chapters/replace-me.md | create/update | Replace this row. |

Actions may include `create`, `update`, `merge`, `leave-unchanged`,
`report-only`, or `needs-review`.

## Page Plans

### Source Pages

| page | action | source_ids | packet_refs | notes |
| --- | --- | --- | --- | --- |
| wiki/sources/replace-me.md | create/update | source-id | raw/derived/source-id/source.md |  |

### Chapter Pages

| page | action | source_refs | claim_or_evidence_refs | notes |
| --- | --- | --- | --- | --- |
| wiki/chapters/replace-me.md | create/update | source-id#anchor-id | cl-001 or ev-001 |  |

## Merge And Duplicate Check

- Existing pages searched:
- Pages to update instead of duplicate:
- New pages justified:
- Pages intentionally left unchanged:

## Review Handoff

- Generated-evidence claims:
- Unsupported or contested claims:
- Page scope questions:
- Review queue updates needed:
- Review items carried forward:

## Generation Instructions

- Source pages should remain short source notes.
- Chapter pages should carry the main distilled knowledge.
- Claim/evidence maps support page writing but should not become page bodies.
- Unresolved judgment should remain visible in review sections or reports.

## Result

State whether generation may proceed, must wait for review, or is blocked.

## Round Closure Checklist

- Wiki pages created:
- Wiki pages updated:
- Wiki pages merged:
- Wiki pages deferred:
- Wiki pages left unchanged:
- `wiki/index.md` update needed:
- `wiki/log.md` update needed:
- Validation note path:
- Compare status:
- Knowledge coverage status:
- Modality review status:
