# Tools

This directory is reserved for repo-local tooling. The first tool layer belongs
to knowledge-base construction: maintenance, lint, search, compare gates,
source inventory checks, and claim audit. These are validation/checker tools,
not the later downstream domain `skill + tool` codebase.

Phase 1 and Phase 1.1 provide skeletons and one workspace-kernel validator.
They do not implement the full raw conversion, wiki lint, compare, or claim
audit toolchain.

## Planned Tool Families

- `validate-kernel`: verify that this system repo contains a reusable kernel
  rather than live workspace output.
- `workspace-check`: Phase 6 checker orchestrator skeleton for validating
  workspace artifacts and emitting summary reports.
- `shared`: shared report and exit-code conventions for Phase 6 checker tools.
- `source-inventory`: scan raw sources, record path/hash/type/status, and
  identify unprocessed or changed material.
- `source-packet-convert`: Phase 2 behavior spec for planning or checking
  adapter handoff outputs; not a Phase 6 default harness implementation.
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

The Phase 2 tool-surface trio is:

```text
source-inventory
-> source-packet-convert
-> source-packet-lint
```

These tool specs define behavior only. They do not implement commands, run
extractors, update schemas, or create fixtures.

After the Phase 6 rebaseline, `source-packet-convert` should be treated as an
adapter-handoff planning/checking spec, not as the default Phase 6
implementation target. Phase 6 should validate source packet outputs rather
than owning extractor execution.

## Phase 6 Tool Surface

Phase 6 should prioritize checker tools:

```text
workspace-check
-> source-inventory-check
-> source-packet-check
-> wiki-lint
-> claim-audit
-> compare-report-check
-> review-queue-check
-> round-closure-check
-> fixture-runner
```

These tools inspect workspace artifacts and emit validation reports. They are
not a PDF/PPTX/DOCX parser harness, MinerU wrapper, OCR/VLM runner, or MCP
extractor wrapper.

Phase 6.1 implements only the runtime skeleton:

```powershell
powershell -ExecutionPolicy Bypass -File tools/workspace-check/workspace-check.ps1 `
  -Workspace . `
  -Mode smoke `
  -Report reports-validation-smoke.md
```

Business validators are intentionally reported as `not-implemented` until later
Phase 6 subphases add them.

## Phase 3 Tool Surface

Phase 3 adds behavior prose for:

```text
claim-audit
```

This tool surface checks whether important claims are supported by evidence
references, whether generated-evidence claims need review, and whether
unsupported or contested claims remain visible. It does not implement the tool
or generate wiki pages.

## Tool Principles

- Tools should run from the repository root.
- Outputs should be deterministic where possible.
- Tools should write explicit reports rather than silently changing wiki pages.
- Tools should validate source packet outputs rather than owning extractor
  internals.
- Any tool that mutates tracked files must be called from a planned target and
  recorded in `plan/log.md`.
- Tools should support VSCode and CLI workflows without requiring Obsidian.
