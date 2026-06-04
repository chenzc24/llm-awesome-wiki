# Phase 6.4 Wiki Lint And Navigation

Phase 6.4 validates the maintained wiki surface after source packet and wiki
construction work has produced pages.

It checks that the wiki remains navigable, source-aware, and maintainable
without turning the checker into a page generator or semantic reviewer.

## Scope

Phase 6.4 owns:

- `wiki-lint command`
- `workspace-check --mode wiki` integration
- special file checks for `wiki/index.md`, `wiki/overview.md`, and
  `wiki/log.md`
- content page frontmatter checks
- wikilink and local Markdown link resolution
- index membership and stale index link checks
- overview/log maintenance-surface checks

Phase 6.4 does not own:

- wiki page generation
- automatic link repair
- source packet generation
- raw binary parsing
- compare report validation
- claim audit
- review queue validation
- round closure decisions
- semantic truth review

## Deterministic Checks

`wiki-lint` should fail when:

- `wiki/` does not exist
- `wiki/index.md`, `wiki/overview.md`, or `wiki/log.md` is missing
- a content page lacks frontmatter
- required frontmatter fields are missing
- a wikilink cannot be resolved
- a local Markdown link cannot be resolved
- an index link points to a missing page or file
- `overview.md` is not discoverable from the index
- an active content page is missing from the index

The active content-page set excludes:

- `wiki/index.md`
- `wiki/overview.md`
- `wiki/log.md`
- `README.md`
- `*.template.md`

## Review Findings

`wiki-lint` should return `needs-review` rather than `fail` when structure is
valid but maintenance judgment is needed:

- content page has no outgoing links
- `wiki/overview.md` appears to have missing or renamed minimum sections
- `wiki/log.md` has no dated entry heading
- page type does not match the conventional directory, such as a non-`chapter`
  page under `wiki/chapters/`
- frontmatter dates use placeholders or nonstandard date shapes

These findings are visible but do not require the checker to rewrite pages.

## Workspace Integration

`workspace-check --mode wiki` invokes:

```text
wiki-lint
```

`workspace-check --mode all` runs schema, source, and wiki checks, then reports
later validator families as not implemented until their phases land.

## Completion Criteria

Phase 6.4 is complete when:

- the Phase 6.4 phase plan exists
- `wiki-lint command` exists and emits Phase 6 reports and exit codes
- `workspace-check --mode wiki` invokes wiki lint
- README and Phase 6 docs describe checker-only behavior
- a temporary smoke workspace with index, overview, log, source page, and
  chapter page passes `wiki-lint` and `workspace-check --mode wiki`
- no page generation or automatic repair is introduced

## Next Phase

Phase 6.5 should validate compare, review, claim, and validation-note report
surfaces.
