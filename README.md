# LLM Awesome Wiki

LLM Awesome Wiki is a Git-first knowledge engineering system for humans and
agents working in VSCode and CLI environments.

The project is not an Obsidian vault and is not a wrapper around the
`llm_wiki` desktop app. It is a repo-native workflow for turning raw resources
into auditable knowledge, then eventually into validated engineering artifacts.

## Thesis

The system should support this path:

```text
raw resources
-> extracted source packets
-> evidence and claim records
-> maintained wiki pages
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
- `tools/` and `templates/` are placeholders for future construction tooling
  and reusable workflow artifacts.

The next major planning target is **Phase 1: Repository Kernel**.

## Phase 1: Repository Kernel

Phase 1 should establish the file and schema substrate for the system. It is the
system structure stage, not a raw-resource converter and not a wiki-generation
engine.

Expected Phase 1 deliverables:

- canonical directory map
- source inventory schema
- source packet schema
- claim/evidence schema
- report schema
- plan and log templates
- clear validation entrypoints for the repository kernel

Phase 1 should not:

- convert PDFs, PPTX files, DOCX files, or other raw resources
- generate final wiki pages
- implement compare gate tooling
- create domain skills
- start downstream knowledge-to-code work

## Repository Layout

Current and planned top-level areas:

```text
AGENTS.md                  # required rules for agents working in this repo
docs/                      # philosophy, architecture, and phase design docs
llm-wiki.md                # original LLM Wiki concept note
llm_wiki/                  # pinned reference submodule
plan/                      # target plans and maintenance log
tools/                     # future construction tools
templates/                 # future reusable workflow templates
```

Planned system directories from the architecture:

```text
raw/sources/               # immutable source files
raw/derived/               # source packets and extracted media
wiki/                      # maintained distilled knowledge
reports/                   # compare, coverage, lint, review outputs
schemas/                   # source, claim, page, and report schemas
tests/                     # validation for construction tools and artifacts
skills/                    # reserved for downstream domain skills
```

## Key Documents

- `AGENTS.md`: required workflow discipline for agents.
- `docs/top-level-design/system-architecture-plan.md`: top-level system plan.
- `docs/core-philosophy.md`: project principles and two execution layers.
- `docs/knowledge-to-executable.md`: construction tools vs downstream
  knowledge-to-code.
- `docs/llm_wiki-reference.md`: how to use `llm_wiki` as reference material.
- `plan/log.md`: maintenance history.

## Working Rules

Before modifying the repository:

1. Run `git status --short --branch`.
2. Confirm the root repository is clean.
3. Create a target-specific plan under `plan/<date-goal-slug>/plan.md`.
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

- defining the source inventory schema
- defining the source packet schema
- defining the report schema
- improving repository kernel templates
- documenting stable knowledge release criteria

Avoid broad tasks like "build the whole system" or "generate all wiki pages."
