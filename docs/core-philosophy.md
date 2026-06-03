# Core Philosophy

This project is a portable LLM Wiki distillation workflow for VSCode, Git, and
code agents. It starts from the same broad insight as LLM Wiki: raw sources
should not merely be retrieved on demand; they should be distilled into a
persistent, structured, maintained knowledge base. The difference is the target
environment and the end state.

The goal here is not to build a better Obsidian vault. The default goal is also
not to force every corpus into a research-style graph of entities, concepts,
queries, comparisons, and synthesis pages. The default goal is to build a
repo-native document/PPT corpus workflow where source structure is preserved,
chapters are readable, coverage is auditable, and knowledge can eventually be
turned into executable engineering artifacts.

## Core Judgments

1. Structure alone is not enough.

   The referenced `llm_wiki` project has a strong structure: raw sources,
   wiki pages, index, log, overview, schema, purpose, lint, review, search, and
   graph analysis. Its default object model is useful for long-running
   research wikis, but can be too fragmented for large PPT or document corpora.
   The missing layer for this project is workflow discipline: initialization,
   chapter-preserving distillation, comparison gates, maintenance logs, and the
   path from knowledge to executable output.

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

7. Knowledge should support two execution layers.

   LLM Wiki partially solves the agent knowledge base problem: agents can find
   and maintain structured context. It does not fully design the next path:
   knowledge to executable work. This project separates that path into two
   layers.

   The first layer is the knowledge-construction executable layer: local tools
   for source inventory, lint, search, compare gates, claim audit, review
   queues, and maintenance logs. This layer belongs inside the knowledge-base
   construction stage. It makes distillation safer and less dependent on model
   self-evaluation.

   The second layer is the downstream knowledge-to-code layer: after the wiki
   is stable enough, distilled knowledge may drive `skill + tool` artifacts,
   agent skills, local tools, scripts, tests, templates, and code that can be
   run and validated. This is a later mainline and should not be implemented in
   one pass.

## Target Shape

The repository should eventually support this pipeline:

```text
raw source
-> source packet
-> chapter-oriented distilled wiki
-> construction tools for lint, compare, coverage, and maintenance
-> structured claims, decisions, methods, and optional research objects
-> executable specs
-> downstream skill + tool codebase, scripts, tests, templates, or app code
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
- Prefer source and chapter structure as the default reading surface; promote
  concepts, entities, comparisons, queries, and synthesis to optional profiles
  when the corpus actually needs them.
