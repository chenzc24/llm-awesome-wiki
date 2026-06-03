# `llm_wiki` Reference Boundary

The `llm_wiki/` directory is a pinned submodule and reference implementation.
It should be studied for ideas, not treated as the root workflow's runtime.

## What `llm_wiki` Already Does Well

The referenced project productizes the LLM Wiki pattern as a desktop
application. It includes:

- raw source ingestion into a maintained markdown wiki
- `purpose.md`, `schema.md`, `wiki/index.md`, `wiki/log.md`, and
  `wiki/overview.md`
- page types such as entities, concepts, sources, queries, comparisons, and
  synthesis
- two-step ingest: source analysis followed by wiki page generation
- source traceability through frontmatter
- `[[wikilink]]` enrichment and graph-based navigation
- structural and semantic lint
- review queues for missing pages, duplicates, contradictions, and suggestions
- search, optional embeddings, graph expansion, and knowledge graph insights
- deep research and web search integration
- multimodal image extraction and captioning
- local API and agent-skill integration
- Obsidian-compatible markdown output

These capabilities are valuable references for structure, terminology, and
future tool ideas.

Important boundary: `llm_wiki` gives agents access to a maintained knowledge
base, but it does not design the full path from that knowledge base to an
executable codebase. Its agent-skill integration is an access layer, not a
knowledge-to-code pipeline.

## What This Repository Does Differently

This repository is not trying to become the `llm_wiki` desktop app. The main
differences are:

- VSCode/Git/CLI are the primary environment.
- Obsidian is optional compatibility, not a dependency.
- The root workflow is designed as a portable repo template.
- Distillation is organized around explicit plans, logs, and compare gates.
- The intended output includes executable artifacts, not only browsable wiki
  pages.
- The next-stage mainline is a knowledge-to-code path that can produce and
  maintain `skill + tool` artifacts.
- Agent behavior is controlled by `AGENTS.md` and repo-local process files.

## Reference Usage Rules

- Do not edit `llm_wiki/` during normal root workflow changes.
- Do not copy large implementation blocks from `llm_wiki` into the root
  repository without a specific extraction plan.
- When borrowing an idea, document the adapted workflow in root-level docs or
  templates instead of depending on the desktop app.
- If the submodule pointer changes, record why in `plan/log.md`.

## Useful Ideas To Adapt Later

- two-stage ingest prompts
- source identity and hash-based source inventory
- structural lint for broken links and orphan pages
- review queues for unresolved human judgment
- graph-derived knowledge gaps
- image captioning as text-indexable source context
- local API patterns for agent access
- the idea of an agent skill as an access pattern, while redesigning it here as
  part of a broader executable `skill + tool` codebase

## Ideas Not To Inherit As Requirements

- Obsidian as the primary interaction model
- desktop app state as the authoritative workflow state
- graph visualization as a required quality gate
- model-only semantic lint as the final acceptance mechanism
- treating agent access to a wiki as equivalent to a full knowledge-to-code
  execution pipeline
