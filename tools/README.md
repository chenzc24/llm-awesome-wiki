# Tools

This directory is reserved for future repo-local tooling. The first tool layer
belongs to knowledge-base construction: maintenance, lint, search, compare
gates, source inventory, and claim audit. These are construction tools, not the
later downstream domain `skill + tool` codebase.

The first version of the workflow only documents tool direction; it does not
implement runnable scripts yet.

## Planned Tool Families

- `source_inventory`: scan raw sources, record path/hash/type/status, and
  identify unprocessed or changed material.
- `wiki_lint`: check frontmatter, broken links, orphan pages, missing index
  entries, and required maintenance files.
- `coverage_compare`: compare raw source inventory against distilled wiki
  pages and report missing coverage.
- `claim_audit`: map important wiki claims to source references and flag
  unsupported claims.
- `search_index`: provide CLI-friendly keyword or hybrid search over raw and
  distilled content.
- `todo_sync`: consolidate compare, lint, and review outputs into actionable
  plan or todo files.

## Tool Principles

- Tools should run from the repository root.
- Outputs should be deterministic where possible.
- Tools should write explicit reports rather than silently changing wiki pages.
- Any tool that mutates tracked files must be called from a planned target and
  recorded in `plan/log.md`.
- Tools should support VSCode and CLI workflows without requiring Obsidian.
