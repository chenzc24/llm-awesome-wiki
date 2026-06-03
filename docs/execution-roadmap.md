# Execution Roadmap

This roadmap turns the core philosophy into staged work. The first version only
creates the documentation and directory skeleton. Later versions can add
scripts, tests, and VSCode integration.

## Phase 1: Bootstrap The Workflow

Goal: make the repository self-describing and safe for agents.

Deliverables:

- `AGENTS.md` with required working discipline
- `docs/core-philosophy.md`
- `docs/llm_wiki-reference.md`
- `docs/knowledge-to-executable.md`
- `plan/README.md`
- `plan/log.md`
- `tools/README.md`
- `templates/README.md`

Acceptance:

- a new agent can understand the project direction without prior chat context
- the repository documents how to plan, log, commit, and push changes
- `llm_wiki/` is clearly marked as a reference submodule

## Phase 2: Initialization Protocol

Goal: define how a new knowledge distillation project starts.

Planned work:

- define a standard project skeleton
- create a raw source inventory format
- require an initial broad read of raw material
- generate an initial overview and skeleton index before deep distillation
- define the first Git checkpoint after initialization

Expected outputs:

- initialization checklist
- source inventory template
- `wiki/overview.md` template
- `wiki/index.md` template

## Phase 3: Round-Based Distillation

Goal: prevent one-shot knowledge base generation.

Planned work:

- define one distillation round as a bounded target
- require each round to name source inputs, expected wiki outputs, and review
  criteria
- update `wiki/log.md` and `plan/log.md` after each round
- use Git commits as stable checkpoints

Expected outputs:

- round plan template
- round completion checklist
- log entry format

## Phase 4: Compare Gate

Goal: compare distilled knowledge against raw knowledge before continuing.

Planned checks:

- source coverage: each source has a status and mapped output pages
- claim coverage: important claims have source references
- omission check: high-value raw facts not yet represented
- contradiction check: conflicting claims require query or review items
- link check: no broken `[[wikilink]]` references
- schema check: required frontmatter exists

Acceptance:

- no round is considered complete only because the model says it is complete
- unresolved judgment is moved into review or todo records

## Phase 5: VSCode-Native Workflow

Goal: make the repository pleasant to maintain without Obsidian.

Planned work:

- recommend VSCode extensions for markdown, YAML, search, and tasks
- define workspace settings that do not create lock-in
- provide CLI-friendly search and lint scripts
- keep all authoritative state in files

Expected outputs:

- `.vscode/` recommendations if needed
- markdown task conventions
- local script entrypoints

## Phase 6: Knowledge To Executable

Goal: turn distilled knowledge into implementation artifacts.

Planned work:

- define executable spec templates
- map wiki claims and decisions into tests or scripts
- create templates for prototypes and experiments
- add validation feedback loops from code back into wiki

Expected outputs:

- spec templates
- test plan templates
- experiment protocol templates
- generated-code review rules

## Phase 7: Long-Term Maintenance

Goal: keep the workflow healthy as sources and outputs grow.

Planned work:

- scheduled lint/check routines
- stale source detection
- stale claim detection
- dedup and merge process
- periodic overview refresh
- review queue cleanup

Expected outputs:

- maintenance checklist
- recurring audit plan
- long-term log format
