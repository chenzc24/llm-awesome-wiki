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

Use `fail` when:

- core in-scope anchors have no disposition
- packet anchors are missing without a known gap
- wiki pages claim source coverage they do not support
- important omitted material has no reason
- important source material is neither covered, deferred, omitted, nor routed
  to review

## Acceptance Criteria

- every in-scope source packet has a source coverage row
- every core in-scope anchor has a disposition
- every non-covered core or unknown anchor has a reason and status impact
- every accepted changed wiki page has wiki page coverage
- omissions are explicit and reviewable
- deferred source material names a later round, condition, or next action
- compare status does not rely on model self-evaluation
