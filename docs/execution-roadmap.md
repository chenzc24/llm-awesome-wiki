# Execution Roadmap

This roadmap turns the core philosophy into staged work. The first version only
creates the documentation and directory skeleton. Later versions can add
scripts, tests, VSCode integration, and downstream knowledge-to-code work.

There are two execution layers. The construction executable layer belongs inside
the knowledge-base construction stage: source inventory, lint, search, compare
gates, claim audit, and maintenance reports. The downstream knowledge-to-code
layer comes later: a stable knowledge base can produce or maintain `skill +
tool` artifacts. These two layers should not be collapsed into one task.

## Phase 1: Bootstrap The Workflow

Goal: make the repository self-describing and safe for agents.

Deliverables:

- `AGENTS.md` with required working discipline
- `docs/core-philosophy.md`
- `docs/llm_wiki-reference.md`
- `docs/knowledge-to-executable.md`
- `plan/README.md`
- `plan/log.md`
- `llm_wiki_tools/README.md`
- `templates/README.md`

Acceptance:

- a new agent can understand the project direction without prior chat context
- the repository documents how to plan, log, commit, and push changes
- `llm_wiki/` is clearly marked as a reference submodule

## Phase 2: Initialization Protocol

Goal: define how a new document/PPT corpus distillation project starts.

Planned work:

- define a standard project skeleton
- create a raw source inventory format
- require an initial broad read of raw material
- generate an initial overview and chapter-oriented skeleton index before deep
  distillation
- define the first Git checkpoint after initialization

Expected outputs:

- initialization checklist
- source inventory template
- `wiki/overview.md` template
- `wiki/index.md` template
- `wiki/chapters/` template

## Phase 3: Round-Based Distillation

Goal: prevent one-shot knowledge base generation while preserving source and
chapter structure.

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
- compare reports are treated as part of the knowledge-construction executable
  layer, not as downstream skill/tool generation

## Phase 5: Compare Gates And Review Workflow

Goal: make each distillation round produce checkable quality and review
signals before the workspace advances.

Planned work:

- define compare report status semantics
- record source/wiki coverage, omissions, weak coverage, and scope exclusions
- record claim, modality, unsupported statement, and contradiction findings
- keep unresolved judgment in review queues across rounds
- define round closure as `close-pass`, `close-with-review`, or `do-not-close`
- avoid model self-evaluation as the only quality signal

Expected outputs:

- compare gate report template
- review queue template
- validation note closure fields
- source/wiki coverage protocol
- claim/modality/contradiction review protocol
- round closure workflow

## Phase 6: Validation And Checker Tooling

Goal: implement deterministic and semi-deterministic checker tooling for the
workspace kernel.

Planned work:

- implement schema and structured-field checks
- implement source inventory and source packet output checks
- implement wiki frontmatter, link, index, overview, and log lint
- implement compare, review queue, claim audit, validation note, and closure
  report checks
- implement scenario fixtures and a fixture runner
- emit stable reports and exit codes for agent/human review

Expected outputs:

- workspace checker entrypoint
- source inventory checker
- source packet checker
- wiki lint checker
- compare report checker
- review queue checker
- round closure checker
- fixture runner

Phase 6 is not an extractor harness. It validates source packet outputs instead
of running MinerU, MCP extractors, OCR/VLM, or PDF/PPTX/DOCX parsers.

## Phase 7: Downstream Knowledge-To-Code Mainline Design And Foundation

Goal: design and begin the later mainline from a stable distilled knowledge
base to a downstream executable `skill + tool` codebase.

Planned work:

- define what downstream "executable" means beyond construction tooling
- separate skills, tools, tests, templates, and examples as distinct artifact
  classes
- decide how wiki claims, concepts, decisions, and methods become executable
  specs
- define executable spec templates
- create initial skill templates for agent behavior
- create initial tool templates for deterministic checks
- map wiki claims and decisions into tests or scripts in one narrow scenario
- create templates for prototypes and experiments only after the first
  skill/tool path is validated
- add validation feedback loops from code back into wiki

Expected outputs:

- knowledge-to-code design brief
- spec templates
- skill templates
- tool templates
- test plan templates
- experiment protocol templates
- generated-code review rules

## Phase 8: Long-Term Maintenance

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
