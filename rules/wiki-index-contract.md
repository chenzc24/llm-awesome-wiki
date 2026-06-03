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
