# Source Wiki Coverage Protocol

This rule defines how a compare report records source-to-wiki coverage.

Use it during Phase 5 compare work after source packets and wiki construction
artifacts exist. It is a workflow protocol, not a coverage algorithm and not a
schema.

## Purpose

Coverage should explain the disposition of source material.

It should not force agents to copy every source paragraph, slide, or table into
the wiki.

For document and PPT corpora, the default target remains readable
source/chapter wiki pages. Coverage reports protect raw-wiki alignment without
turning the wiki into a second source packet.

## Mandatory For Document And PPT Rounds

Document and PPT rounds must name their `distillation_depth` before accepted
wiki prose is generated:

| depth | meaning |
| --- | --- |
| `full-round` | the fixed source scope is expected to be distilled at the right level of detail |
| `selective` | only named source units are in scope and all deferrals are explicit |
| `overview-only` | the round builds a map or first-pass overview and must not claim full distillation |

For `full-round` and `selective` document/PPT work, the wiki construction
analysis must include a source outline or coverage plan before final prose.
The compare report must then include anchor disposition rows for core and
unknown source units.

Broad source ranges such as `p002-p020` or `slides 4-14` are not enough to
claim coverage for core material unless the important topics inside the range
are named and given dispositions. Broad ranges are acceptable for
`overview-only` rounds only when the validation note records the limited depth
and the follow-up round or deferral condition.

Do not close a `full-round` document/PPT distillation as `pass` when core source
units are only summarized at a coarse level, cited by a broad range, or missing
from the anchor disposition table.

## Required Inputs

- round plan and fixed source scope
- source inventory
- source packet metadata
- source packet anchors
- wiki construction analysis
- current source pages
- current chapter pages
- current `wiki/overview.md`
- current `wiki/index.md`
- current review or validation reports

When an input is missing, record the missing input in the compare report. Do
not assume it passed.

## Coverage Units

Choose the smallest useful unit for the source type:

- PPTX: slide anchors, important chart/table/image anchors, or meaningful slide
  groups
- PDF: page anchors, section anchors, figure/table anchors, or meaningful page
  groups
- DOCX: heading anchors, table anchors, figure anchors, or section groups
- image: file or region anchors
- table/dataset: table, sheet, row-range, column, or section anchors
- mixed media: member-file or section anchors

Do not over-split decorative or low-value source material. Do not under-split
important charts, tables, formulas, diagrams, or claim-bearing sections.

## Disposition Values

Use these dispositions in compare reports:

| disposition | meaning |
| --- | --- |
| `covered` | represented in an accepted wiki page or report at the right level of detail |
| `weak` | represented, but too shallow, overgeneralized, poorly sourced, or risky |
| `deferred` | intentionally left for a later planned round |
| `omitted` | intentionally excluded from wiki construction for a recorded reason |
| `out-of-scope` | outside the round's fixed input or workspace purpose |
| `review` | routed to human review before wiki acceptance |
| `blocked` | cannot be judged because required input, extraction, anchor, or context is missing |

Do not use `covered` for content that merely appears in the source packet.
Coverage is about the relationship between source material and accepted wiki or
round reports.

Do not use `covered` for a broad source range when only the range label is
cited. The covered row should name the topic or anchor group and point to the
wiki target where that content is actually represented.

## Importance Values

Use importance values to keep large sources reviewable:

| importance | meaning |
| --- | --- |
| `core` | important for wiki understanding, review, or later execution |
| `supporting` | useful context or explanation |
| `reference` | lookup, appendix, bibliography, source identity, or supporting detail |
| `decorative` | safe visual or layout material with no knowledge value in scope |
| `unknown` | needs review before importance can be decided |

Core source material needs a disposition. Decorative material may be grouped
and omitted when the reason is recorded.

## Omission Reasons

Acceptable omission reasons:

- `decorative`
- `duplicate`
- `out-of-scope`
- `low-value`
- `deferred`
- `blocked`
- `superseded`

Unsafe omissions:

- no reason recorded
- omitted item is core or unknown importance
- omission contradicts accepted wiki prose
- omitted item affects a supported claim
- generated interpretation is kept while the source anchor is omitted
- omitted item should have review routing but none exists

## Source Coverage Table

Use a table that can answer this question:

What happened to each source packet or source group in the round?

Recommended fields:

| field | purpose |
| --- | --- |
| `source_id` | stable source identity |
| `packet_path` | source packet path |
| `source_scope` | slides, pages, headings, or source group covered by the round |
| `coverage_unit` | slide, page, heading, anchor, group, table, image, etc. |
| `wiki_coverage` | wiki page, report path, review item, or none |
| `disposition` | coverage disposition |
| `reason` | required for non-covered dispositions |
| `status_impact` | `pass`, `needs-review`, `fail`, or `none` |

## Anchor Disposition Table

Use anchor-level rows when important anchors exist:

| field | purpose |
| --- | --- |
| `source_ref` | `<source_id>#<anchor_id>` |
| `location` | slide, page, heading, region, table, etc. |
| `content_kind` | text, chart, table, image, formula, code, diagram, etc. |
| `importance` | `core`, `supporting`, `reference`, `decorative`, or `unknown` |
| `disposition` | coverage disposition |
| `wiki_target` | accepted wiki page when covered |
| `report_or_review_target` | report or review item when not directly covered |
| `reason` | required for non-covered dispositions |
| `status_impact` | `pass`, `needs-review`, `fail`, or `none` |

For a 30-slide PPT, anchor disposition may group decorative or repeated slides,
but it must not hide important chart, table, formula, or claim-bearing slides.

## Wiki Page Coverage Table

Use wiki page coverage to check the other direction:

What source material does each accepted wiki page claim to cover?

Recommended fields:

| field | purpose |
| --- | --- |
| `wiki_page` | accepted wiki page path |
| `page_type` | source, chapter, synthesis, research, overview, etc. |
| `declared_source_scope` | sources or anchors the page claims to cover |
| `actual_source_refs` | source references present in the page |
| `coverage_gaps` | source areas missing or weak |
| `disposition` | `covered`, `weak`, `review`, or `blocked` |
| `status_impact` | `pass`, `needs-review`, `fail`, or `none` |

## Status Impact

Use `pass` only when source/wiki coverage is explainable and no blocking
coverage issue remains.

Use `needs-review` when:

- importance is unknown
- coverage depends on human interpretation
- weak coverage might be acceptable but needs judgment
- an omission reason is plausible but not confirmed
- source material is routed to review with a next action
- modality review is nonblocking but must be carried forward visibly

Use `fail` when:

- core in-scope anchors have no disposition
- core in-scope document/PPT topics are represented only by broad source ranges
  without topic-level or anchor-level disposition
- packet anchors are missing without a known gap
- wiki pages claim source coverage they do not support
- important omitted material has no reason
- important source material is neither covered, deferred, omitted, nor routed
  to review
- a `full-round` document/PPT distillation has weak core knowledge coverage

Separate knowledge coverage from modality review. A diagram, chart, OCR, or
formula review item may be carried forward as nonblocking only when the accepted
wiki knowledge does not depend on the unresolved interpretation. Weak or missing
core knowledge coverage is not the same thing as nonblocking modality review.

## Acceptance Criteria

- every in-scope source packet has a source coverage row
- every core in-scope anchor has a disposition
- every non-covered core or unknown anchor has a reason and status impact
- every accepted changed wiki page has wiki page coverage
- document/PPT `full-round` and `selective` work has a source outline or
  coverage plan before final prose
- validation notes record knowledge coverage status separately from modality
  review status
- omissions are explicit and reviewable
- deferred source material names a later round, condition, or next action
- compare status does not rely on model self-evaluation
