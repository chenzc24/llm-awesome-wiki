# Phase 5.2 Source Wiki Coverage And Omission Protocol

Phase 5.2 defines how compare reports record source-to-wiki coverage and
omissions.

This stage answers: for a source packet or anchor in the round, how does the
workspace show whether it is represented, deferred, omitted, routed to review,
or blocked by a gap?

## Scope

Phase 5.2 owns:

- source packet coverage status
- anchor disposition language
- wiki page coverage status
- weak coverage and omission recording
- intentional scope exclusions
- source-to-wiki traceability tables
- validation-note coverage summary expectations

Phase 5.2 does not own:

- claim coverage details
- modality coverage details
- contradiction analysis
- review queue workflow details
- link checker implementation
- compare CLI implementation
- schema or validator changes
- fixtures
- wiki page generation or rewriting

## Core Principle

Coverage is not copying.

For document and PPT corpora, a covered source section does not need to appear
as a mirrored paragraph in the wiki. Coverage means the compare report can
explain the source material's disposition.

Allowed dispositions:

- `covered`: represented in an accepted source, chapter, synthesis, or research
  page at the right level of detail
- `weak`: represented, but too shallow, overgeneralized, poorly sourced, or
  risky for agent use
- `deferred`: intentionally left for a later planned round
- `omitted`: intentionally excluded from wiki construction for a recorded
  reason
- `out-of-scope`: outside the round's fixed input or declared workspace purpose
- `review`: routed to human review before wiki acceptance
- `blocked`: cannot be judged because required source packet, anchor,
  extraction, or context is missing or broken

## Source-To-Wiki Flow

```text
source packet in round
-> anchor or source section in scope
-> disposition
-> wiki target, report target, review item, or scope note
-> compare status impact
```

Do not jump from "not in wiki" to `fail`. The report must first distinguish
intentional omission, planned deferral, review routing, weak coverage, and
actual coverage failure.

## Source Coverage Questions

For each source packet in scope, the report should answer:

- is the packet present?
- is packet metadata present?
- does the packet expose anchors for the source structure?
- what source range is in scope for this round?
- which parts are represented in wiki pages?
- which parts are intentionally left only in the source packet?
- which parts are deferred?
- which parts are omitted and why?
- which parts are blocked by extraction, modality, or review gaps?

For a 30-slide PPT, the report should not require 30 wiki sections. It should
require a visible disposition for each slide or meaningful slide group.

## Anchor Disposition

Use anchor-level disposition when the source has stable anchors.

Recommended table fields:

- `source_ref`
- `location`
- `content_kind`
- `importance`
- `disposition`
- `wiki_target`
- `report_or_review_target`
- `status_impact`
- `notes`

Importance values are workflow hints, not final schema:

- `core`: important for the wiki or later execution path
- `supporting`: useful context or explanation
- `reference`: source identity, bibliography, appendix, or lookup material
- `decorative`: safe to omit unless the workspace purpose says otherwise
- `unknown`: needs review before importance can be decided

## Wiki Page Coverage

For each accepted wiki page changed or inspected by the round, the report
should answer:

- which source packets or anchors does the page cite?
- which source areas does the page claim to cover?
- which important claims or sections are weakly covered?
- which source areas are intentionally not covered by this page?
- which review items affect page acceptance?

Chapter pages can aggregate many anchors. Source pages should stay short and
should not become source packets.

## Omission Rules

An omission is acceptable only when it is explicit.

Acceptable omission reasons:

- `decorative`: decorative or non-informational material
- `duplicate`: duplicated source material covered elsewhere
- `out-of-scope`: outside workspace purpose or round scope
- `low-value`: not useful for agent reading, review, or downstream work
- `deferred`: scheduled for a later round
- `blocked`: extraction or review gap prevents safe use
- `superseded`: replaced by a newer or more authoritative source

Unsafe omissions:

- important source content omitted without reason
- generated visual interpretation used while the original visual anchor is
  omitted
- slide, page, table, or chart omitted because the model skipped it
- omitted content that contradicts accepted wiki prose
- omitted content that affects an important claim but has no review item

## Status Impact

Coverage findings should affect compare status as follows:

- `pass`: all core in-scope source material is covered, explicitly omitted,
  or nonblocking carried-forward review with reason and next action
- `needs-review`: coverage depends on human judgment, generated visual/table
  interpretation, ambiguous scope, or unresolved importance
- `fail`: core in-scope source material is missing, anchors are absent without
  gap records, important omissions are unexplained, or wiki pages claim
  coverage they do not support

Weak coverage may be `needs-review` or `fail` depending on whether it blocks
round acceptance.

## Artifact Economy

The default compare report should carry source/wiki coverage. Do not create a
separate coverage report by default just because the table is uncomfortable.

Create a detailed `reports/coverage/` report only when:

- the source set is too large for one concise compare report
- multiple rounds need to share the same coverage matrix
- deterministic tooling later produces coverage output
- the compare report links to the detailed report and keeps the final decision
  summary

## Person A Handoff

Potential Person A needs after Phase 5.2:

- coverage status enum
- source disposition enum
- omission reason enum
- importance enum or equivalent workflow category
- validator rule that `covered` rows include a wiki or report target
- validator rule that `omitted`, `deferred`, `out-of-scope`, `review`, and
  `blocked` rows include a reason
- validator rule that `fail` appears when core in-scope anchors have no
  disposition
- fixture for a 30-slide PPT with grouped slide coverage
- fixture for omitted decorative slide content
- fixture for omitted important chart without reason
- fixture for deferred source group with target round

Person B should keep these as workflow needs until Person A accepts schema and
validator ownership.

## Completion Criteria

Phase 5.2 is complete when:

- the phase plan defines source/wiki coverage and omission semantics
- a source/wiki coverage rule exists
- compare gate rule includes disposition and omission semantics
- compare report template has explicit source, anchor, wiki, weak coverage,
  omission, and scope-exclusion fields
- validation note template can summarize coverage status and omissions
- Phase 5 main plan identifies Phase 5.3 as the next claim/modality/
  contradiction target
