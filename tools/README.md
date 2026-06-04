# Tools

This directory is reserved for repo-local tooling. The first tool layer belongs
to knowledge-base construction: maintenance, lint, search, compare gates,
source inventory, and claim audit. These are construction tools, not the later
downstream domain `skill + tool` codebase.

Phase 1 and Phase 1.1 provide skeletons and one workspace-kernel validator.
They do not implement the full raw conversion, wiki lint, compare, or claim
audit toolchain.

## Planned Tool Families

- `validate-kernel`: verify that this system repo contains a reusable kernel
  rather than live workspace output.
- `source-inventory`: scan raw sources, record path/hash/type/status, and
  identify unprocessed or changed material.
- `source-packet-convert`: coordinate manual, agent, MCP, local CLI, or
  extractor-backed workflows that produce source packets.
- `source-packet-lint`: check packet metadata, anchors, generated fields, known
  gaps, review routing, and source-type expectations.
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

## Phase 2 Tool Surface

The Phase 2 construction tool trio is:

```text
source-inventory
-> source-packet-convert
-> source-packet-lint
```

These tool specs define behavior only. They do not implement commands, run
extractors, update schemas, or create fixtures.

## Tool Principles

- Tools should run from the repository root.
- Outputs should be deterministic where possible.
- Tools should write explicit reports rather than silently changing wiki pages.
- Any tool that mutates tracked files must be called from a planned target and
  recorded in `plan/log.md`.
- Tools should support VSCode and CLI workflows without requiring Obsidian.
