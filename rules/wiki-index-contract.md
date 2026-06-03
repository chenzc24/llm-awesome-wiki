# Wiki Index Contract

`wiki/index.md` is the primary navigation entry for agents and humans. It is
content-oriented, not chronological. The chronological record belongs in
`wiki/log.md`.

## Required Behavior

- Read `wiki/index.md` before answering questions or modifying wiki pages.
- Update `wiki/index.md` after every accepted wiki page creation, deletion, or
  major retitle.
- Group entries by page type or domain-specific category.
- Keep each entry short enough for quick scanning.
- Treat missing index entries as lint findings.

## Entry Shape

Use a stable Markdown list shape:

```text
- [[page-slug]] - one-line purpose or summary
```

The workspace may use standard Markdown links instead of wikilinks, but it must
choose one convention in `schema.md` and apply it consistently.

Each entry should identify only one primary page. If multiple pages are related,
link them from the page body or its `related` frontmatter rather than packing
multiple primary targets into one index line.

## Minimum Sections

- Overview
- Sources
- Concepts
- Entities
- Comparisons
- Synthesis
- Open Questions
- Review Queue

Domain workspaces may rename or add sections, but should preserve a clear
navigation route from source pages to synthesis pages.

## Validation Targets

- every indexed page exists
- every non-special wiki page appears in the index
- index links are not broken
- source summary pages are grouped separately from concept or synthesis pages
- stale entries are removed when pages are deleted

## Special Pages

The following pages are special and may be handled separately from normal
content-page indexing:

- `wiki/index.md`
- `wiki/log.md`
- `wiki/overview.md`

`overview.md` should still be discoverable from the index. `index.md` and
`log.md` do not need normal content entries.

## Pass Conditions

The index passes the minimum contract when:

- every content page has one index entry
- every index entry resolves to an existing page
- section names match the workspace schema
- source, concept, entity, comparison, query, and synthesis pages are not mixed
  into the wrong section without a recorded reason
