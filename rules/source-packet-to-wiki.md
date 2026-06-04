# Source Packet To Wiki

Wiki writing starts from source packets and, when important claims are in
scope, the evidence/claim layer. It does not start directly from raw files. The
wiki is a maintained synthesis layer; it must remain traceable to source
packets and evidence records.

This rule owns the action flow from source packet input to construction
analysis and accepted wiki updates. For page routing, source/chapter surface,
index, overview, and wiki log rules, follow `wiki-surface-workflow.md`. For
round-level sequencing, follow `distillation-rounds.md`.

## Two-Stage Flow

0. Routing stage:
   - read `wiki-surface-workflow.md`
   - read `wiki/index.md`, `wiki/overview.md`, and existing source/chapter
     pages
   - decide whether the input belongs in overview, source page, chapter page,
     report/review, optional synthesis, or optional research page
   - record the reason when routing is not obvious

1. Analysis stage:
   - read the source packet and existing `wiki/index.md`
   - read the claim/evidence map and review queue when they exist
   - identify source structure, chapters, claims, contradictions, and open
     review points
   - decide which existing pages need updates and which new pages are needed
   - create review items for human judgment
   - produce an analysis note or report before generation begins

2. Generation stage:
   - write or update wiki pages
   - update `wiki/index.md`
   - update `wiki/log.md`
   - refresh `wiki/overview.md` when corpus map, coverage, or chapter
     structure changed
   - emit review/report items instead of silently resolving uncertain claims

Do not collapse these stages. A raw source should not be turned directly into
final wiki pages without a source packet, routing decision, and analysis pass.

## Routing Output

The routing stage should record:

- source packets and claim/evidence maps inspected
- existing wiki pages inspected
- target page type
- target path or page to update
- whether a new page is needed or an existing page should be updated
- review/report output needed instead of page prose
- reason for optional synthesis or research pages, when used

## Analysis Output

The analysis stage should record:

- source packets read
- evidence and claim records or maps read when available
- candidate source/deck notes, chapter updates, and optional synthesis updates
- claims worth preserving as claim records
- evidence anchors that support important claims
- contradictions or uncertain interpretations
- pages to create, update, merge, leave unchanged, report-only, or defer
- review items needed before acceptance

The analysis output may be a report, a plan entry, or a structured note. It
must be visible in the workspace diff.

Preferred report shape:

```text
reports/wiki-construction-analysis.md
```

Generated workspaces may use
`templates/workspace-kernel/reports/wiki-construction-analysis.template.md` as
the starting point.

## Generation Output

The generation stage should produce only accepted workspace artifacts:

- wiki page creates or updates
- `wiki/overview.md` update when scope, coverage, or chapter structure changed
- `wiki/index.md` update
- `wiki/log.md` update
- review item or report updates
- claim/evidence records when the workspace uses them

## Page Output Minimum

Every generated wiki page should include:

- YAML frontmatter with `type`, `title`, `sources`, `created`, and `updated`
- source references pointing to source packet or raw source identities
- body content with stable headings
- relevant cross-links using the workspace's link convention
- explicit uncertainty or conflict notes when needed

Source pages should remain short source notes. Chapter pages should carry the
main distilled knowledge. Claim/evidence maps should support page writing but
should not become page bodies.

Source and chapter page templates should be treated as page-writing contracts:
fill the useful sections, leave irrelevant sections empty only with a reason,
and avoid adding audit fields that already belong in source packets or reports.

## Agent Rules

- Prefer updating existing pages over creating duplicate pages.
- Apply page routing before writing page prose.
- Do not remove sourced claims unless the reason is recorded.
- Do not create important wiki claims without source packet anchors, evidence
  references, or review items.
- Do not use claim/evidence records as a replacement for readable
  source/chapter pages.
- Do not rely on the model's self-assessment as the final quality gate.
- Do not advance a distillation round until compare and lint checks are
  recorded.
- Put unresolved semantic judgment into review items.

## Handoff

The next step is a compare gate: source coverage, claim coverage, index health,
broken links, contradictions, omissions, and review queue status.

If the compare gate is not enabled, the validation note should say
`compare gate not enabled`. Do not record that as `pass`.

The validation note should also record overview, index, and log status. If no
overview or index update was needed, record why.

## Acceptance Criteria

- every new or changed wiki page cites at least one source identity when it
  contains sourced knowledge
- every wiki update has a routing decision or an obvious route from the round
  plan
- construction analysis is visible before page generation begins
- overview refresh is recorded when corpus map, coverage, or chapter structure
  changed
- index and log are updated in the same round
- validation records overview/index/log status
- unresolved semantic judgment appears in review output
- generation does not fragment one source chapter into unnecessary object pages
- a compare or lint report records whether the round may advance
