# Phase 4 Closure Review

Phase 4 is complete from the Person B workflow-surface side when the
source-packet-to-wiki workflow is understandable, auditable, bounded, and ready
for compare-gate design.

Phase 4 does not implement wiki generation, wiki-lint, compare gates, schemas,
validators, fixtures, or downstream `skill + tool` artifacts.

## Completed Workflow Surface

Phase 4 defines this path:

```text
source packet and claim/evidence input
-> page routing decision
-> wiki construction analysis
-> source or chapter page create/update/merge decision
-> overview, index, and log maintenance
-> validation note or review handoff
-> later compare gate
```

Completed Person B outputs:

- main Phase 4 plan in `docs/phase-plans/phase-4-wiki-construction-engine.md`
- wiki page routing rule
- source and chapter page template hardening
- wiki construction analysis template
- repeatable wiki construction round protocol
- overview, index, and log maintenance rule
- workspace source, chapter, overview, index, log, and validation note template
  updates
- Person A validation handoff proposals for wiki page, index, overview, log,
  link, and report checks

## Design Review

| Design principle | Phase 4 result |
| --- | --- |
| VSCode/Git-first | Wiki construction uses repo-local Markdown pages, reports, logs, and plans. |
| Agent-first | Rules state the reading order, routing decisions, required analysis, generation outputs, forbidden shortcuts, and review handoffs. |
| Portable | No Obsidian, desktop app, hosted API, MCP, GPU, or specific extractor is required. |
| Incremental | Wiki pages are built in planned rounds with fixed input sets, not in one large generation pass. |
| Avoid model self-evaluation | Rounds must record validation status, unresolved review, and compare-gate absence instead of self-declaring pass. |
| Raw-wiki alignment | Wiki pages cite source packets and evidence anchors rather than raw files or unsupported prose alone. |
| Artifact economy | Source packets, claim/evidence maps, construction analysis, wiki pages, reports, and logs each keep distinct jobs. |
| Source/chapter default | Document and PPT corpora keep `wiki/chapters/*` as the main distilled reading surface and `wiki/sources/*` as short source notes. |
| Generated-content visibility | Uncertain OCR, captions, chart summaries, generated evidence, and semantic judgment route to review instead of silent acceptance. |
| Person A/B boundary | Workflow and template needs are recorded here; `contracts/schemas/**`, validators, tools, and fixtures remain Person A or later implementation work. |

## Review Findings

1. The default wiki should remain source/chapter-oriented.

   Reason: for large PDF/PPT corpora, a fragmented concept/entity/comparison
   tree is harder to read and easier to make incomplete. Source and chapter
   pages preserve the structure humans expect while still allowing optional
   synthesis or research pages later.

2. Wiki construction needs a visible analysis artifact before prose.

   Reason: page routing, merge decisions, review routing, and page omissions
   are too important to hide inside final wiki text. Construction analysis
   gives the later compare gate something concrete to inspect.

3. Claim/evidence maps support wiki writing but should not become the wiki.

   Reason: audit maps are good for validation and review, but they are too
   granular to be the default reading surface for agents or humans.

4. Overview, index, and log maintenance is part of round closure.

   Reason: if overview, index, or log drift, a copied workspace may appear
   complete while accepted pages are hard to find, stale, or untraceable.

5. Phase 4 cannot be considered deterministically enforced yet.

   Reason: Person B has defined the workflow surface, but page frontmatter,
   source references, index integrity, broken links, and log parseability still
   need schemas, validators, fixtures, or tool checks.

6. Phase 5 should focus on compare gates, not another wiki-page redesign.

   Reason: the wiki construction surface is now coherent enough to test. The
   next gap is quality gating: source coverage, claim coverage, omissions,
   contradictions, broken links, stale entries, and review queue status.

## Person A Handoff

Recommended Person A review areas:

- wiki page frontmatter validation for `overview`, `source`, `chapter`, and
  optional `synthesis` or `research` page types
- required page fields such as `type`, `title`, `sources`, `created`, and
  `updated`
- source reference shape and citation form such as `<source_id>#<anchor_id>`
- source page validation: short note, packet reference, related chapter links,
  and no duplicated source packet body
- chapter page validation: source-backed sections, visible uncertainty, and no
  embedded claim/evidence table as the primary body
- construction analysis report validation for routing decisions, page actions,
  merge decisions, deferred content, and review handoff
- index validation: every accepted wiki page is indexed, active reports are
  linked, sections are valid, and stale entries are removed
- broken link checks between overview, index, source pages, chapter pages,
  reports, and review queues
- overview validation: refresh reason, last refreshed date, current coverage,
  known gaps, and links to active review or validation reports
- wiki log validation: parseable date, entry type, changed paths, summary,
  validation note, and review carry-forward
- validation note requirements for overview status, index status, log status,
  compare-gate status, stale-entry checks, and unresolved review

Person B should not edit `contracts/schemas/**`, validator code, tests, or
fixtures as part of this closure unless a later task explicitly assigns that
work.

## Suggested Person A Fixtures

Useful fixture scenarios:

- valid round that updates one source page and one chapter page
- round that updates a chapter page but forgets to update `wiki/index.md`
- round that changes corpus coverage but leaves `wiki/overview.md` stale
- round that writes page prose without construction analysis
- source page that duplicates source packet metadata or full packet text
- chapter page with sourced knowledge but no source packet references
- chapter page that embeds a claim/evidence table as the main body
- index with a stale link after a page move
- overview with active review reports omitted
- wiki log entry with missing validation note reference
- validation note that records `compare gate not enabled` instead of `pass`
- optional synthesis page created before source and chapter pages are stable

## Remaining Non-Goals

Phase 4 closure does not start:

- raw source conversion
- source packet generation
- claim extraction
- wiki page generation from real source packets
- schema implementation
- validator implementation
- fixture creation
- wiki-lint implementation
- compare gate implementation
- downstream executable `skill + tool` work

## Next Phase Boundary

The next Person B workflow phase should be Phase 5: compare gates and review
workflow.

Phase 5 should consume Phase 4 wiki construction outputs and define how a round
records source coverage, claim coverage, broken links, stale index entries,
omissions, contradictions, unresolved judgment, pass/fail/needs-review status,
and whether the round may advance.

Phase 5 should not redesign the default wiki surface unless compare findings
show that the source/chapter reading path is insufficient.
