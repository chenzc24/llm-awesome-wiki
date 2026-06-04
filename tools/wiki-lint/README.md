# Wiki Lint Tool

Checker for wiki structure and maintenance health.

Phase 6.4 implements the checker-only validator:

```powershell
powershell -ExecutionPolicy Bypass -File tools/wiki-lint/wiki-lint.ps1 `
  -Workspace . `
  -WikiDir wiki `
  -Report reports/wiki-lint-report.md
```

## Purpose

Answer:

```text
Is the wiki navigable, indexed, and structurally ready for later compare and
closure checks?
```

## Checks

- required special files: `wiki/index.md`, `wiki/overview.md`, `wiki/log.md`
- required content-page frontmatter
- broken wikilinks
- broken local Markdown links
- pages missing from `wiki/index.md`
- indexed pages that do not exist
- overview discoverability from the index
- no-outlink pages as review findings
- overview/log maintenance sections as review findings

## Non-Goals

`wiki-lint` does not:

- generate wiki pages
- rewrite links or frontmatter
- run compare gates
- validate claim truth
- inspect raw binary documents
- resolve semantic review
