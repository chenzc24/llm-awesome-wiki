---
name: llm-wiki-wiki-round
description: Wiki construction routing skill for LLM Awesome Wiki. Use when an agent needs to move from source packets and optional evidence/claim maps into wiki construction analysis, source pages, chapter pages, overview refresh, index updates, wiki log updates, or wiki-facing round plans.
---

# LLM Wiki Wiki Round

## Role

Use this subskill for source-packet-to-wiki construction rounds.

This skill routes the work. The semantic source of truth is in `rules/`:

- start with `rules/source-packet-to-wiki.md`
- use `rules/wiki-surface-workflow.md` for routing, source/chapter surface,
  overview, index, and wiki log behavior
- use `rules/evidence-claim-workflow.md` only when important claims need
  explicit support or review
- use `rules/distillation-rounds.md` for round sequencing

## Sequence

1. Read the round plan, `purpose.md`, `schema.md`, `wiki/overview.md`, and
   `wiki/index.md`.
2. Read the fixed source packet set and relevant existing wiki pages.
3. Read claim/evidence maps and review queues only when important claims or
   unresolved judgment are in scope.
4. Record routing decisions before writing page prose.
5. Write visible wiki construction analysis.
6. Create, update, merge, defer, or leave unchanged source/chapter pages.
7. Refresh `wiki/overview.md` when scope, coverage, or chapter structure
   changed.
8. Update `wiki/index.md` and `wiki/log.md` for accepted wiki changes.

## Boundaries

Do not write final wiki prose directly from raw binary files. Do not create
research object pages by default. Do not use claim/evidence maps as the primary
reading surface.

## Validation

Run wiki checks when available:

```text
python -m llm_wiki_tools workspace-check --workspace . --mode wiki
```

If wiki checks are unavailable, record index, overview, log, link, and review
status manually in the validation note.
