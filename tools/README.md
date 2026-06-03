# Tools

This directory is reserved for repo-local tooling. The first tool layer belongs
to knowledge-base construction: maintenance, lint, search, compare gates,
source inventory, and claim audit. These are construction tools, not the later
downstream domain `skill + tool` codebase.

Phase 1 only provides skeletons and one workspace-kernel validator. It does
not implement the full raw conversion, wiki lint, compare, or claim audit
toolchain.

## Planned Tool Families

- `validate-kernel`: verify that this system repo contains a reusable kernel
  rather than live workspace output.
- `source-inventory`: scan raw sources, record path/hash/type/status, and
  identify unprocessed or changed material.
- `wiki-lint`: check frontmatter, broken links, orphan pages, missing index
  entries, and required maintenance files.
- `compare-gate`: compare raw source inventory against distilled wiki
  pages and report missing coverage.
- `claim-audit`: map important wiki claims to source references and flag
  unsupported claims.
- `search-index`: provide CLI-friendly keyword or hybrid search over raw and
  distilled content.
- `todo-sync`: consolidate compare, lint, and review outputs into actionable
  plan or todo files.
- `scaffold-workspace`: future copy/sync helper for workspace kernels.

## Tool Principles

- Tools should run from the repository root.
- Outputs should be deterministic where possible.
- Tools should write explicit reports rather than silently changing wiki pages.
- Any tool that mutates tracked files must be called from a planned target and
  recorded in `plan/log.md`.
- Tools should support VSCode and CLI workflows without requiring Obsidian.
