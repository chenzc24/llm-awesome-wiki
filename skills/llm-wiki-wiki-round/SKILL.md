---
name: llm-wiki-wiki-round
description: Wiki construction runtime skill for LLM Awesome Wiki. Use when an agent needs to move from source packets and optional evidence/claim maps into wiki construction analysis, source pages, chapter pages, overview refresh, index updates, wiki log updates, or wiki-facing round plans.
---

# LLM Wiki Wiki Round

## Role

Use this subskill for source-packet-to-wiki construction rounds.

This skill owns the normal runtime from source packets to accepted wiki
updates. It is not a raw extractor and not a deterministic wiki generator.

Detailed rules are loaded only when needed:

- `rules/wiki/wiki-surface-workflow.md` for page routing, source/chapter
  surface, overview, index, and wiki log edge cases
- `rules/wiki/source-wiki-coverage-protocol.md` for document/PPT rounds,
  broad source ranges, source outline, coverage planning, omission, or anchor
  disposition
- `rules/claims/evidence-claim-workflow.md` when important claims need explicit
  support, conflict tracking, or review routing

## Inputs

- round plan with fixed source packet set or wiki area
- `purpose.md`, `schema.md`, `wiki/overview.md`, and `wiki/index.md`
- selected source packets and relevant existing wiki pages
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
7. Write visible wiki construction analysis before page generation. It should
   record packets read, existing pages inspected, source outline or coverage
   plan, page decisions, important claims, supporting anchors, contradictions,
   and review items.
8. Generate accepted artifacts only after analysis:
   - source page or chapter page creates/updates
   - overview refresh or no-change reason
   - index update when accepted pages change
   - wiki log entry
   - review item or claim/evidence update when needed
9. Keep source pages short and source-facing. Put distilled readable knowledge
   in chapter pages.
10. Preserve uncertainty. Do not silently resolve conflicts or unsupported
   claims inside polished prose.

## Boundaries

Do not write final wiki prose directly from raw binary files. Do not create
research object pages by default. Do not use claim/evidence maps as the primary
reading surface. Do not advance a round because the generated page looks clean.

## Outputs

- wiki construction analysis, usually under `reports/`
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
- document/PPT rounds record `distillation_depth` and a source outline or
  coverage plan
- full-round document/PPT closure does not rely on broad source ranges without
  topic-level or anchor-level disposition
- index, overview, and log status is explicit
- unresolved judgment appears in review output
- one source chapter has not been fragmented into unnecessary object pages
