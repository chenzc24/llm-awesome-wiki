# Wiki Index Contract

`wiki/index.md` is the primary navigation entry for agents and humans. It is
content-oriented, not chronological. The chronological record belongs in
`wiki/log.md`.

## Required Behavior

- Read `wiki/index.md` before answering questions or modifying wiki pages.
- Update `wiki/index.md` after every accepted wiki page creation, deletion, or
  major retitle.
- Inspect `wiki/index.md` during every wiki construction round, even when no
  update is needed.
- Group entries by page type or domain-specific category.
- Keep each entry short enough for quick scanning.
- Treat missing index entries as lint findings.
- Treat stale entries as validation findings.

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

## Default Sections

The default index is document-corpus oriented:

- Overview
- Sources Or Decks
- Chapters
- Reports And Review
- Optional Synthesis

These are index sections, not mandatory folders. Domain workspaces may rename
or add sections, but should preserve a clear navigation route from source
material to chapter pages and review reports.

## Optional Research Sections

Research-style workspaces may add sections such as:

- Concepts
- Entities
- Comparisons
- Synthesis
- Open Questions

These sections are optional. They should be introduced when they improve
long-term reuse, cross-source synthesis, or review, not merely because a term
appears in a source.

## Reading-Surface Rules

The index should make the default reading path obvious:

```text
overview
-> chapters
-> source notes
-> active reports or review queues
```

Index accepted pages and important active reports. Do not index every raw file,
every source packet anchor, every evidence row, or every claim row. Those
belong in inventories, source packets, claim/evidence maps, or reports.

Source or deck pages should be grouped separately from chapter pages because
they serve different readers. Source pages explain what a source is and where
its packet and chapters are. Chapter pages carry the main distilled knowledge.

## Validation Targets

- every indexed page exists
- every non-special wiki page appears in the index
- index links are not broken
- accepted page creates, deletes, merges, moves, and retitles are reflected
- source or deck summary pages are grouped separately from chapter pages
- claim/evidence reports are linked only when they are active review or
  validation surfaces
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
- source/deck pages, chapter pages, reports, and optional research-profile
  pages are not mixed into the wrong section without a recorded reason
- the validation note records whether index changes were made or why no index
  change was needed
