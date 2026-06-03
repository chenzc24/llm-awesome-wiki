# Core Philosophy

This project is a portable LLM Wiki distillation workflow for VSCode, Git, and
code agents. It starts from the same broad insight as LLM Wiki: raw sources
should not merely be retrieved on demand; they should be distilled into a
persistent, structured, maintained knowledge base. The difference is the target
environment and the end state.

The goal here is not to build a better Obsidian vault. The goal is to build a
repo-native workflow where knowledge can be read, audited, transformed, tested,
committed, and eventually turned into executable engineering artifacts.

## Core Judgments

1. Structure alone is not enough.

   The referenced `llm_wiki` project has a strong structure: raw sources,
   wiki pages, index, log, overview, schema, purpose, lint, review, search, and
   graph analysis. The missing layer for this project is workflow discipline:
   initialization, round-based distillation, comparison gates, maintenance logs,
   and the path from knowledge to executable output.

2. VSCode and Git should be first-class.

   The canonical environment should be a normal repository opened in VSCode.
   The authoritative state should live in files that can be diffed, reviewed,
   linted, committed, branched, and pushed. Obsidian may be compatible, but it
   must not be required.

3. The workflow should be portable.

   A distilled knowledge base should move between machines and agents as a
   repository. It should not depend on hidden desktop app state, local plugin
   databases, or one specific note-taking interface.

4. Agents need executable rules, not only inspirational prose.

   Human-facing documents explain the method. Agent-facing documents constrain
   behavior: what to read first, when to write a plan, how to update logs, how
   to compare distilled output against raw sources, and when to stop for human
   review.

5. Distillation must be incremental and audited.

   A high-quality knowledge base should not be generated in one large pass.
   The intended flow is:

   - initialize the repository and raw source inventory
   - read raw material broadly enough to build an overview
   - create a skeleton index and project structure
   - distill in small rounds
   - compare each round against the original source material
   - log outcomes and plan the next round

6. Compare gates should reduce model self-evaluation.

   A model saying "this looks complete" is not enough. Compare gates should use
   checkable artifacts: source coverage, claim coverage, missing-source lists,
   broken links, frontmatter validity, unresolved contradictions, and explicit
   human review items.

7. Knowledge should lead to execution.

   LLM Wiki partially solves the agent knowledge base problem: agents can find
   and maintain structured context. It does not fully design the next path:
   knowledge to executable code. This project must explore that path directly.

## Target Shape

The repository should eventually support this pipeline:

```text
raw source
-> distilled wiki
-> structured claims, concepts, decisions, and methods
-> executable specs
-> scripts, tests, experiments, templates, or code
-> validation
-> feedback into the wiki
```

The wiki is therefore not only a place to read. It is a compiler target for
engineering work: a maintained intermediate representation between raw source
knowledge and executable artifacts.

## Design Biases

- Prefer plain files over hidden app state.
- Prefer deterministic checks over model-only judgment.
- Prefer small rounds over one-shot generation.
- Prefer Git commits as workflow checkpoints.
- Prefer VSCode and CLI ergonomics over Obsidian-specific affordances.
- Prefer reusable templates and scripts over one-off chat instructions.
- Prefer source traceability over polished summaries with unclear provenance.
