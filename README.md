# LLM Awesome Wiki

LLM Awesome Wiki is a Git-first knowledge engineering system for humans and
agents working in VSCode and CLI environments.

The project is not an Obsidian vault and is not a wrapper around the
`llm_wiki` desktop app. Its default profile is a document/PPT corpus workflow:
preserve source structure, distill into chapter-oriented knowledge, and keep
coverage auditable. Research-wiki object types such as concepts, entities,
queries, comparisons, and synthesis pages are optional extensions, not the
default minimum structure.

## Thesis

The system should support this path:

```text
raw resources
-> extracted source packets
-> evidence and claim records
-> maintained source and chapter pages
-> construction tools and reports
   (inventory, lint, compare, review, claim audit)
-> stable knowledge release
-> downstream executable specs
-> domain skills, domain tools, tests, templates, and code artifacts
-> validation feedback into the knowledge base
```

The important separation is:

- **Construction executable layer**: tools and reports that maintain, compare,
  lint, and validate the knowledge base itself.
- **Downstream knowledge-to-code layer**: later `skill + tool` or code artifacts
  derived from stable, traceable knowledge.

Do not collapse these into one implementation pass.

## Current Status

The repository has completed its bootstrap stage:

- Agent working rules are defined in `AGENTS.md`.
- Core philosophy and architecture documents live under `docs/`.
- `llm_wiki/` is pinned as a reference submodule.
- Planning and maintenance records live under `plan/`.
- `llm_wiki_tools/` contains the runnable checker CLI and command index.
- `templates/` contains reusable workspace-kernel artifacts.

The current implementation target is **Phase 1.3: Workspace Kernel Golden
Path**.

## Phase 1: Workspace Kernel

Phase 1 establishes a copyable workspace kernel for generated knowledge
workspaces. The substrate has been committed and pushed. Phase 1.1 closed the
loop by aligning workflow rules, templates, contracts, and validation
entrypoints. Phase 1.2 made the default kernel document-corpus first instead of
research-wiki first. Phase 1.3 adds the golden path for a first manual
document/PPT distillation round. It is not a raw-resource converter and not a
wiki-generation engine.

The system repository is not the place where day-to-day knowledge distillation
happens. The intended use pattern is:

```text
system repo
-> copy or scaffold workspace kernel
-> independent knowledge workspace repo
-> VSCode + Git + CLI + Agent maintenance inside that repo
```

This keeps the workflow repo-local. The user opens the knowledge workspace
directly in VSCode; there is no required Obsidian vault, desktop application,
background service, or external tool wrapper.

Expected Phase 1 deliverables:

- canonical directory map
- workspace-kernel template
- workflow rules outside `docs/`
- source inventory schema
- source packet schema
- claim/evidence schema
- report schema
- plan and log templates
- first-round golden-path templates
- clear validation entrypoints for the workspace kernel

Phase 2 has not started. The next boundary is a closed workspace-kernel
workflow, not raw-resource conversion.

Phase 1 should not:

- turn this repository into an active knowledge workspace
- create live root-level `raw/`, `wiki/`, or `reports/` instance content
- convert PDFs, PPTX files, DOCX files, or other raw resources
- generate final wiki pages
- implement compare gate tooling
- create domain skills
- start downstream knowledge-to-code work

## Repository Layout

This repository is the **system repository**. It should contain the architecture,
templates, construction tools, tests, and reusable contracts used to create or
maintain other knowledge workspaces.

Current system repository areas:

```text
AGENTS.md                  # required rules for agents working in this repo
contracts/                 # reusable machine contracts, including JSON Schema
docs/                      # philosophy, architecture, and phase design docs
llm_wiki_tools/            # runnable Python checker CLI and command index
llm-wiki.md                # original LLM Wiki concept note
llm_wiki/                  # pinned reference submodule
plan/                      # target plans and maintenance log
rules/                     # repo-native workflow rules and contracts
tests/                     # validation guidance and future scenario fixtures
templates/                 # future reusable workflow templates
```

Potential future system repository areas:

```text
examples/                  # small fixture workspaces, never active project data
```

A generated knowledge workspace may contain:

```text
raw/sources/               # immutable source files
raw/derived/               # source packets and extracted media
wiki/                      # maintained source, chapter, and optional synthesis pages
reports/                   # compare, coverage, lint, review outputs
contracts/                 # copied or referenced schema/config contracts
tests/                     # validation for construction tools and artifacts
skills/                    # reserved for downstream domain skills
```

Do not treat the generated workspace layout as directories that must exist at
the root of this system repository. They should appear only in generated
projects, examples, or fixtures.

## Key Documents

- `AGENTS.md`: required workflow discipline for agents.
- `docs/top-level-design/system-architecture-plan.md`: top-level system plan.
- `docs/phase-plans/phase-1-workspace-kernel.md`: Phase 1 implementation
  target.
- `docs/phase-plans/phase-1.1-workspace-kernel-closure.md`: Phase 1.1 closure
  target.
- `docs/phase-plans/phase-1.2-document-corpus-default.md`: default
  document/PPT corpus profile correction.
- `docs/phase-plans/phase-1.3-workspace-kernel-golden-path.md`: first manual
  workspace round target.
- `docs/core-philosophy.md`: project principles and two execution layers.
- `docs/knowledge-to-executable.md`: construction tools vs downstream
  knowledge-to-code.
- `docs/llm_wiki-reference.md`: how to use `llm_wiki` as reference material.
- `rules/`: operational rules for generated workspaces. Start from
  `rules/README.md`, which exposes the default golden path before specialized
  modules.
- `contracts/schemas/`: reusable JSON Schema contracts.
- `templates/workspace-kernel/`: copyable repo-local workspace substrate.
- `llm_wiki_tools/README.md`: current checker command index.
- `plan/log.md`: maintenance history.

## Working Rules

Before modifying the repository:

1. Run `git status --short --branch`.
2. Confirm the root repository is clean.
3. Create a target-specific plan under
   `plan/users/<user>/<date-goal-slug>/plan.md`, or under
   `plan/shared/integration/<date-goal-slug>/plan.md` for shared integration.
4. Modify only the files named by the target plan.

After modifying:

1. Update `plan/log.md`.
2. Run the validation listed in the plan.
3. Commit with a clear message.
4. Push to `origin/main`, unless a different branch is explicitly requested.

See `AGENTS.md` for the full rules.

## Relationship To `llm_wiki`

`llm_wiki/` is a pinned reference submodule. It is useful for studying:

- source identity and ingest cache patterns
- two-stage source analysis and wiki generation
- image extraction and caption-first multimodal indexing
- frontmatter cleanup and source merging
- link lint, review queues, search, and graph-derived gap discovery

It is not the runtime, architecture, or product target of this repository.
Do not edit the submodule unless a plan explicitly asks to update the reference.

## How Developers Should Join

Start here:

1. Read this README.
2. Read `AGENTS.md`.
3. Read `docs/top-level-design/system-architecture-plan.md`.
4. Check `plan/log.md` for recent decisions.
5. For implementation work, create a new target plan before editing files.

Good early contributions are narrow Phase 1 tasks, such as:

- tightening workspace rules and acceptance criteria
- improving workspace kernel templates
- aligning schema contracts with the rules
- improving workspace-kernel validation
- documenting stable knowledge release criteria

Avoid broad tasks like "build the whole system" or "generate all wiki pages."
