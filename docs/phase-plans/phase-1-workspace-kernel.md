# Phase 1 Workspace Kernel

Phase 1 builds the reusable substrate that lets a future knowledge workspace
operate as a self-contained VSCode/Git/Agent repository. It does not build a
raw converter, wiki generator, compare gate engine, or downstream skill/tool
codebase.

## Goal

Create a copyable workspace kernel that can be placed into a new repository and
used locally. The generated workspace is the usage surface; this system
repository is the producer of rules, contracts, templates, and validation
entrypoints.

## Kernel Shape

The workspace kernel should provide:

- agent rules for Git-first maintenance
- `purpose.md` for project intent
- `schema.md` for workspace-local writing and structure rules
- `raw/`, `wiki/`, and `reports/` directories as workspace artifacts
- copied or referenced contracts under `contracts/`
- CLI-friendly construction tool entrypoints under `tools/`
- report and log conventions that are readable in plain Markdown

This keeps the workspace portable. A user should be able to open the generated
repository in VSCode and work without Obsidian, a desktop application, or hidden
service state.

## Phase 1 Deliverables

- First-class workflow rules under `rules/`.
- JSON Schema contracts under `contracts/schemas/`.
- A copy-first workspace template under `templates/workspace-kernel/`.
- Construction-tool skeletons under `tools/`.
- A root validator that confirms the system repo has not become an active
  workspace.
- Scenario-test guidance under `tests/`.

## Explicit Non-Goals

- Do not convert PDF, DOCX, PPTX, images, or web pages into source packets.
- Do not generate final wiki pages from raw material.
- Do not implement the compare gate engine.
- Do not implement vector search, graph visualization, MCP, or desktop APIs.
- Do not generate downstream domain skills or tools.
- Do not create live root-level `raw/`, `wiki/`, `reports/`, or `schema.md`.

## `llm_wiki` Reference Points

Phase 1 borrows ideas from `llm_wiki` without copying its product shape:

- `purpose.md` and `schema.md` as workspace-local intent and structure files
- `index.md` and `log.md` as navigation and maintenance anchors
- two-stage ingest: analysis before file generation
- structural lint and review queues as separate gate types
- scenario-driven tests for ingest, lint, review, and search behavior

The borrowed ideas are rewritten as repo-local contracts for VSCode/Git/Agent
workflows.

## Acceptance Criteria

- The system repo contains reusable contracts and templates, not live knowledge
  workspace output.
- The workspace kernel can be inspected and copied without running code.
- A new agent can tell which files belong to the system repo and which belong
  only inside an instantiated workspace.
- The validator passes from the repository root.
