# Source Packet To Wiki

Wiki writing starts from source packets and, when important claims are in
scope, the evidence/claim layer. It does not start directly from raw files.

This rule owns the action flow from source packet input to construction
analysis and accepted wiki updates. Page routing, index, overview, and wiki log
behavior belong to `wiki-surface-workflow.md`; round sequencing belongs to
`distillation-rounds.md`.

## Minimum Path

```text
source packet
-> routing decision
-> wiki construction analysis
-> accepted wiki updates
-> index, overview, log, review, and validation updates
-> compare gate
```

## Stage 0: Routing

Before writing page prose:

- read `wiki-surface-workflow.md`
- read `wiki/index.md`, `wiki/overview.md`, and relevant existing pages
- inspect source packets and claim/evidence maps in scope
- decide target page type and target path
- decide whether to create, update, merge, leave unchanged, report-only, or
  needs-review
- record the reason for optional synthesis or research pages

## Stage 1: Analysis

Write visible construction analysis before generation begins. It should record:

- source packets read
- evidence and claim maps read when available
- existing wiki pages inspected
- candidate source/deck notes, chapter updates, and optional synthesis updates
- claims worth preserving as claim records
- evidence anchors that support important claims
- contradictions or uncertain interpretations
- review items needed before acceptance

Preferred report shape:

```text
reports/wiki-construction-analysis.md
```

Generated workspaces may use
`templates/workspace-kernel/reports/wiki-construction-analysis.template.md`.

## Stage 2: Generation

The generation stage should produce only accepted workspace artifacts:

- wiki page creates or updates
- `wiki/overview.md` update when scope, coverage, or chapter structure changed
- `wiki/index.md` update
- `wiki/log.md` update
- review item or report updates
- claim/evidence records when the workspace uses them

Do not silently resolve uncertain claims in page prose. Emit review or report
items instead.

## Page Output Minimum

Every generated wiki page should include:

- YAML frontmatter with `type`, `title`, `sources`, `created`, and `updated`
- source references pointing to source packet or raw source identities
- body content with stable headings
- relevant cross-links using the workspace link convention
- explicit uncertainty or conflict notes when needed

Source pages should remain short source notes. Chapter pages should carry the
main distilled knowledge. Claim/evidence maps support page writing but should
not become page bodies.

## Agent Rules

- Prefer updating existing pages over creating duplicates.
- Apply page routing before writing page prose.
- Do not remove sourced claims unless the reason is recorded.
- Do not create important wiki claims without source packet anchors, evidence
  references, or review items.
- Do not use claim/evidence records as a replacement for readable
  source/chapter pages.
- Do not rely on model self-assessment as the final quality gate.
- Do not advance a distillation round until compare and lint checks are
  recorded.

## Handoff

The next step is a compare gate for source coverage, claim coverage, index
health, broken links, contradictions, omissions, and review queue status.

If the compare gate is not enabled, the validation note should say
`compare gate not enabled`. Do not record that as `pass`.

The validation note should also record overview, index, and log status. If no
overview or index update was needed, record why.

## Acceptance Criteria

- every new or changed wiki page cites at least one source identity when it
  contains sourced knowledge
- every wiki update has a routing decision or an obvious route from the plan
- construction analysis is visible before page generation
- overview refresh or no-change reason is recorded
- index and log are updated in the same round when accepted pages change
- validation records overview/index/log status
- unresolved semantic judgment appears in review output
- generation does not fragment one source chapter into unnecessary object pages
- compare or lint report records whether the round may advance
