---
name: llm-wiki-wiki-round
description: Wiki construction runtime skill for LLM Awesome Wiki. Use when an agent needs to move from source packets plus raw/rendered/external reading into semantic drafts, grounding passes, wiki construction analysis, source pages, chapter pages, overview refresh, index updates, wiki log updates, or wiki-facing round plans.
---

# LLM Wiki Wiki Round

## Role

Use this subskill for semantic-first, audit-grounded wiki construction rounds.

This skill owns the normal runtime from fixed source scope to accepted wiki
updates. It is not a raw extractor and not a deterministic wiki generator.
Source packets are the audit baseline, not the semantic ceiling.

Detailed rules are loaded only when needed:

- `rules/wiki/wiki-surface-workflow.md` for page routing, source/chapter
  surface, overview, index, and wiki log edge cases
- `rules/wiki/source-wiki-coverage-protocol.md` for document/PPT rounds,
  broad source ranges, source outline, coverage planning, omission, or anchor
  disposition
- `rules/claims/evidence-claim-workflow.md` when important claims need explicit
  support, conflict tracking, or review routing

## Inputs

- round plan with fixed source packet set, raw/rendered source views, external
  reading notes, or wiki area
- `purpose.md`, `schema.md`, `wiki/overview.md`, and `wiki/index.md`
- selected source packets, direct source views when needed, and relevant
  existing wiki pages
- claim/evidence maps and review queues only when important claims or
  unresolved judgment are in scope

## Runtime

1. Confirm the fixed input set. Do not expand scope silently.
2. Read source packets before writing final page prose.
3. Read existing wiki pages in the target area.
4. Decide routing before generation:
   - create, update, merge, defer, leave unchanged, report-only, or
     needs-review
   - default to source/chapter pages for document and PPT corpora
   - create optional synthesis pages only when the plan explains why
5. Set `distillation_depth` before page generation:
   - `full-round`: the fixed source scope is expected to be distilled at the
     right level of detail.
   - `selective`: only named source units are in scope; deferrals are explicit.
   - `overview-only`: the round creates a navigation map or first-pass summary
     and must not claim full distillation.
6. For document/PPT corpora, write a source outline or coverage plan before
   final prose. It should list source units or grouped anchors, importance,
   intended wiki target, planned disposition, and reason or next action.
   Broad ranges such as `p002-p020` are only acceptable when the covered topics
   inside the range are named or the round is explicitly `overview-only`.
   When formulas or derivations carry the lesson's technical meaning, name
   them in the plan instead of hiding them inside a page-level row.
7. Write a visible semantic draft inside the wiki construction analysis before
   final page generation. It should preserve the source's real knowledge
   density: definitions, formulas, derivations, examples, tables, procedures,
   and implications that a high-quality direct reading would retain.
8. Run a grounding pass over the draft. For each important draft unit, record
   source anchors, evidence or claim references, accepted review decisions, or
   explicit review routing. If the source packet is lossy but the raw/rendered
   source or external notes contain useful content, mark it as
   candidate-derived until grounded or reviewed.
9. Generate accepted artifacts only after analysis and grounding:
   - source page or chapter page creates/updates
   - overview refresh or no-change reason
   - index update when accepted pages change
   - wiki log entry
   - review item or claim/evidence update when needed
10. Keep source pages short and source-facing. Put distilled readable knowledge
   in chapter pages.
11. Preserve uncertainty. Do not silently resolve conflicts or unsupported
   claims inside polished prose.

## Boundaries

Do not write accepted wiki prose directly from raw binary files without a
grounding pass. Do not let a lossy source packet suppress important semantic
content. Do not create research object pages by default. Do not use
claim/evidence maps as the primary reading surface. Do not advance a round
because the generated page looks clean.

## Outputs

- semantic draft and wiki construction analysis, usually under `reports/`
- grounding notes for important semantic units
- accepted source/chapter wiki page changes or explicit no-change decisions
- `wiki/overview.md` update or no-change reason
- `wiki/index.md` update when accepted pages change
- `wiki/log.md` entry
- review queue or claim/evidence updates when semantic judgment remains
- validation note or handoff to quality gate

## Validation

Run wiki checks when available:

```text
python -m llm_wiki_tools workspace-check --workspace . --mode wiki
```

If wiki checks are unavailable, record index, overview, log, link, and review
status manually in the validation note.

Minimum manual checks:

- every new or changed wiki page cites source identity or packet anchors when
  it contains sourced knowledge
- construction analysis exists before accepted page prose
- semantic draft was reviewed against source packets plus raw/rendered or
  external reading inputs when the packet is lossy
- accepted wiki knowledge has a grounding pass or explicit review routing
- document/PPT rounds record `distillation_depth` and a source outline or
  coverage plan
- full-round document/PPT closure does not rely on broad source ranges without
  topic-level or anchor-level disposition
- core formulas and derivations are represented, deferred, or marked as
  blocking/needs-review knowledge coverage, not only as generic visual review
- index, overview, and log status is explicit
- unresolved judgment appears in review output
- one source chapter has not been fragmented into unnecessary object pages
