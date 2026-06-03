# Phase 1.2 Document Corpus Default

This is a minimal correction to the Phase 1 workspace-kernel direction.

The default workspace kernel should serve large document and PPT corpora first.
It should preserve source structure, produce readable chapter-oriented wiki
pages, and make coverage auditable. Research-style page types borrowed from
`llm_wiki`--concepts, entities, comparisons, queries, and synthesis--remain
useful, but they are optional profiles rather than the default minimum.

## Default Profile

```text
raw sources
-> source packets with anchors
-> source/deck notes
-> chapter pages
-> overview
-> reports and review queue
```

## Optional Research Profile

Enable research-style objects only when the corpus benefits from them:

- concepts
- entities
- comparisons
- queries
- synthesis

These objects should not be generated just because a term appears in a source.
They should be introduced when they improve coverage, review, reuse, or later
execution.

## Completion Criteria

- top-level docs name document/PPT corpus as the default
- `wiki-index-contract.md` no longer requires research sections
- `templates/workspace-kernel/` defaults to source and chapter pages
- validator no longer requires optional research-profile folders
