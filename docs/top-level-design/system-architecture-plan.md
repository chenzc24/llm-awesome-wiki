# LLM Awesome Wiki System Architecture Plan

This document is the top-level design plan for building the new LLM Awesome
Wiki system. It is not a plan to operate `llm_wiki`, and it is not merely a
knowledge-base generation recipe. The goal is to design a repo-native system
that turns raw material into auditable knowledge, then into executable
construction checks, and later into downstream specifications, skills, tools,
tests, and maintained engineering artifacts.

`llm_wiki/` is a pinned reference submodule. It can inform implementation
patterns, but the root repository defines a new system with its own architecture,
quality gates, and execution path.

## Product Thesis

LLM Awesome Wiki is a Git-first knowledge engineering system for agents and
humans working in VSCode and CLI environments. It should support the full path:

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

The system is not only a reading surface. It is an engineering workflow for
making knowledge traceable, reviewable, and eventually executable.

## Product Form

The system is repo-native rather than app-native. It has three distinct forms:

- **System repo**: this repository. It maintains the philosophy, architecture,
  rules, contracts, templates, tool source, and tests.
- **Workspace kernel**: the copyable set of local files produced by the system
  repo. It includes workspace `AGENTS.md`, `purpose.md`, `schema.md`, rules,
  contracts, template directories, and construction-tool entrypoints.
- **Knowledge workspace repo**: an independent user repository created from the
  kernel. This is where `raw/`, `wiki/`, `reports/`, and workspace-local
  validation live.

The intended usage surface is the knowledge workspace repository itself. Users
open that repository in VSCode and work with Git, CLI tools, and agents against
repo-local files. The system should not require a desktop app, Obsidian vault,
background service, or external wrapper as the source of truth.

## System Non-Goals

- Do not make Obsidian a required dependency.
- Do not wrap or depend on the `llm_wiki` desktop application.
- Do not turn this system repository into an active knowledge workspace.
- Do not treat graph visualization as a quality gate.
- Do not rely on model self-evaluation as the only acceptance signal.
- Do not merge source conversion, wiki distillation, and downstream code
  generation into one large pass.
- Do not let LLMs be the parser of record for binary documents, hashes, paths,
  file identity, or final validation.

## Architecture Layers

### Layer 1: Workspace Kernel Producer

The root repository is the system substrate. It produces a workspace kernel
that can be copied or scaffolded into independent knowledge workspace
repositories. It owns architecture documents, workflow rules, reusable machine
contracts, construction tools, tests, and deterministic validation entrypoints.
It should not itself become an active knowledge workspace.

Expected responsibilities:

- enforce Git-first workflow discipline
- define canonical workspace directories and schemas as reusable contracts
- keep generated raw resources immutable once a workspace is instantiated
- keep generated derived artifacts reviewable and diffable
- expose CLI-friendly validation commands
- make every major state transition visible in files

System repository directories:

```text
contracts/                # reusable machine contracts, including JSON Schema
docs/                     # architecture, phase plans, and project guidance
plan/                     # target plans and maintenance log
rules/                    # workspace workflow rules and index/gate contracts
tools/                    # construction tool source and entrypoints
templates/                # reusable workspace, page, report, and spec templates
tests/                    # validation for tools, templates, and schemas
examples/                 # small generated-workspace fixtures only
```

Generated workspace directory contract:

```text
raw/sources/              # immutable source files
raw/derived/              # source packets and extracted media
wiki/                     # maintained distilled knowledge
reports/                  # compare, coverage, lint, review outputs
contracts/                # copied or referenced schema/config contracts
tools/                    # deterministic construction tools
templates/                # reusable plans, pages, reports, specs
skills/                   # reserved for downstream domain skills
tests/                    # validation for construction tools and downstream artifacts
```

The generated workspace contract is what the system should scaffold for users.
Those directories should not be created at the root of this system repository
except inside `examples/` or test fixtures.

The first version is copy-first: a developer can copy
`templates/workspace-kernel/` into a new repository and then work entirely from
that repository. A future scaffold command may automate the copy and later sync
kernel updates, but daily use must remain local to the workspace repo.

### Layer 2: Raw Resource Conversion

This layer turns heterogeneous source files into accessible, auditable source
packets. It is one subsystem of LLM Awesome Wiki, not the whole system.

Key output:

```text
raw/derived/<source-id>/source.md
raw/derived/<source-id>/media/
raw/derived/<source-id>/metadata.yml
```

The conversion layer must preserve provenance, page or slide anchors, extracted
media references, generated captions, OCR status, parsing failures, and
confidence notes.

### Layer 3: Evidence And Knowledge IR

The intermediate representation should be more structured than prose. It should
capture claims, concepts, entities, methods, decisions, comparisons, evidence
links, and open review items.

Candidate record types:

- source packet
- evidence span
- claim
- concept
- entity
- method
- decision
- requirement
- comparison
- review item

This layer is what lets the system move from a wiki to executable specs later.

### Layer 4: Wiki Construction

The wiki is the maintained human-readable layer. It should summarize, connect,
and organize knowledge while preserving traceability back to source packets and
evidence records.

Expected outputs:

- `wiki/index.md`
- `wiki/overview.md`
- `wiki/log.md`
- `wiki/sources/*.md`
- `wiki/concepts/*.md`
- `wiki/entities/*.md`
- schema-defined custom page types

### Layer 5: Quality Gates

Quality gates turn subjective distillation into checkable workflow state.
They are part of the knowledge-construction executable layer, not downstream
skill or tool generation.

Required gate families:

- source inventory coverage
- source packet validity
- claim-to-source coverage
- modality coverage
- broken link and frontmatter lint
- omission reports
- contradiction reports
- human review queues
- stale source and stale claim checks

### Layer 6: Construction Tooling

Construction tools support the knowledge-building system itself.
This layer belongs to knowledge-base construction and maintenance. Its outputs
are reports, validations, and low-risk mechanical fixes, not domain skills or
downstream code artifacts.

Candidate tools:

- source inventory generator
- raw-resource converter
- media extractor
- OCR and caption runner
- source packet validator
- wiki page lint
- claim coverage reporter
- compare gate reporter
- review queue exporter

These tools should generate reports and low-risk mechanical fixes. They should
not silently rewrite high-value knowledge or resolve semantic judgment without
review.

### Layer 7: Knowledge-To-Executable Pipeline

After the knowledge base is stable enough, the system should generate or
maintain downstream executable artifacts. This layer starts after construction
tools, compare gates, source coverage, and claim coverage have produced a
stable knowledge release.

Candidate outputs:

- executable specs
- domain agent skills
- domain CLI tools
- validators
- generators
- tests
- templates
- experiments
- small application prototypes

This is a later mainline. It depends on stable source coverage, claim coverage,
and review discipline. It should not absorb construction tools such as source
inventory, wiki lint, compare gates, or claim audit; those belong to Layer 6.

### Layer 8: Developer And Agent Experience

The system should be pleasant to maintain from VSCode, Git, and CLI tools.

Expected experience:

- clear onboarding docs
- plan templates
- report templates
- deterministic commands
- search-friendly Markdown
- low-friction validation
- agent rules that constrain unsafe shortcuts
- no hidden desktop-app state as the source of truth

## Build Phases

### Phase 0: System Charter

Goal: define the system as a new LLM Awesome Wiki architecture, not a clone or
runtime dependency of `llm_wiki`.

Deliverables:

- top-level system design
- architecture vocabulary
- non-goals
- reference boundary for `llm_wiki`
- initial directory contracts

Validation:

- design docs are English-only
- `llm_wiki` is framed as reference material
- system phases include construction tooling before downstream executable
  artifacts, not only wiki pages

### Phase 1: Workspace Kernel

Goal: create the reusable rules, contracts, templates, and validation substrate
needed to instantiate generated knowledge workspaces.

Deliverables:

- canonical directory map
- workspace-kernel template
- workflow rules outside `docs/`
- source inventory schema
- source packet schema
- claim/evidence schema
- report schema
- plan and log templates
- root kernel validator

Validation:

- machine contracts are stored in `contracts/schemas/`
- templates are diffable
- a new agent can identify where each artifact belongs
- the root repository has no live `raw/`, `wiki/`, `reports/`, or `schema.md`
- root repository docs distinguish system repository files from generated
  workspace files

### Phase 1.1: Workspace Kernel Closure

Goal: make the Phase 1 substrate internally consistent before Phase 2 begins.
This is a closure pass over rules, templates, contracts, and validation.

Deliverables:

- first-round workflow contract
- workspace-local plan, raw, wiki, report, and log templates
- clarified pass, fail, and needs-review report language
- minimum schema alignment with the rules
- expanded kernel validator

Validation:

- a copied workspace kernel has obvious places for plans, raw inputs, derived
  packets, wiki pages, reports, and logs
- rules and templates use the same terms for source inventory, source packet,
  compare gate, lint, review, and distillation round
- Phase 2 remains explicitly not started

### Phase 2: Raw Resource Conversion Subsystem

Goal: convert raw resources into source packets without losing provenance.

This phase answers the immediate `raw_resource -> .md` question. The answer is:
do not convert raw resources directly into final wiki pages. First convert each
resource into a source packet that is faithful, structured, and auditable.

#### Conversion Contract

Each source packet should include:

- source identity
- raw path
- raw hash
- source type
- extraction tool version
- extraction status
- page, slide, section, or timestamp anchors
- extracted text
- extracted tables or companion data links
- extracted media references
- OCR or VLM-generated captions when needed
- extraction gaps and known failures

Suggested source packet frontmatter:

```yaml
---
type: source-packet
source_id: papers/example-paper
raw_path: raw/sources/papers/example-paper.pdf
raw_sha256: "<sha256>"
source_kind: pdf
extraction_version: raw-resource-converter-v0
extraction_status: partial
modalities: [text, image, table]
generated_fields: [image_captions]
created: 2026-06-03
---
```

#### PDF Handling

PDF files need tool-assisted extraction before LLM analysis.

Pipeline:

1. Extract page-level text and preserve `## Page N` anchors.
2. Detect scanned or text-poor pages.
3. Run OCR or page-image captioning on pages without reliable text.
4. Extract embedded raster images when available.
5. Render full-page screenshots for vector diagrams, charts, or layout-heavy
   pages when image extraction is insufficient.
6. Caption figures and screenshots with a vision model when needed.
7. Record password protection, empty pages, OCR uncertainty, and extraction
   failures.

#### PPTX Handling

PPTX files should be treated as structured packages, not as opaque files.

Pipeline:

1. Parse slide text from slide XML.
2. Preserve `## Slide N` anchors.
3. Extract speaker notes if present.
4. Extract embedded media and map it to slides when possible.
5. Render slide screenshots for layout, arrows, charts, and visual hierarchy.
6. Caption meaningful images or screenshots; skip decorative icons when safe.
7. Preserve slide order and record uncertain media-to-slide mapping.

#### DOCX Handling

DOCX files should preserve document structure.

Pipeline:

1. Extract headings, paragraphs, lists, and tables.
2. Preserve heading hierarchy.
3. Convert small readable tables to Markdown tables.
4. Store large tables as companion CSV/TSV files and link them from the source
   packet.
5. Extract images from `word/media/*` and caption them when they carry
   information.
6. Record footnotes, comments, revisions, or unsupported structures when
   relevant.

#### Can The LLM Handle Multimodal Files?

The model can help after preprocessing. It should not be asked to read local
binary files blindly.

Use the LLM for:

- factual image captions after media extraction
- OCR cleanup with low-risk constraints
- entity, concept, method, and claim analysis
- source packet summarization
- wiki page drafting
- review item suggestions

Do not use the LLM as the authority for:

- file identity
- path normalization
- hashing
- page or slide order
- binary parsing
- table extraction
- OCR confidence
- final coverage checks

### Phase 3: Evidence And Claim Layer

Goal: convert source packets into explicit evidence and claim records before
large-scale synthesis.

Deliverables:

- evidence span format
- claim record format
- claim-to-source mapping
- confidence and provenance fields
- unresolved judgment queue

Validation:

- important claims point to source packet anchors
- generated captions and OCR-derived evidence are marked
- ambiguous claims are routed to review

### Phase 4: Wiki Construction Engine

Goal: generate and maintain wiki pages from source packets, claims, concepts,
and evidence records.

Deliverables:

- page routing rules
- source summary template
- concept/entity templates
- index update rules
- overview update rules
- wiki log format

Validation:

- generated pages contain parseable frontmatter
- `sources` fields remain traceable
- existing pages are merged rather than overwritten
- cross-links are checked

### Phase 5: Compare Gates And Review Workflow

Goal: ensure that every round produces checkable quality signals.
This phase is still part of knowledge-base construction.

Deliverables:

- compare report template
- claim coverage report
- modality coverage report
- omission report
- contradiction report
- review queue format

Validation:

- no round closes only because the model says it is complete
- unresolved semantic judgment is visible
- skipped modalities are explicitly recorded

### Phase 6: Construction Tools

Goal: implement deterministic tooling for the repository workflow.
These tools operationalize source conversion, maintenance, and compare gates;
they are not the downstream domain `skill + tool` codebase.

Deliverables:

- inventory command
- raw-resource conversion command
- packet validation command
- link/frontmatter lint command
- compare gate command
- review export command

Validation:

- tools are runnable from the CLI
- tools produce stable outputs
- reports can be committed and reviewed

### Phase 7: Downstream Executable Artifacts

Goal: turn stable knowledge into executable engineering outputs.
This phase begins only after the construction tooling and compare gates can
produce a stable knowledge release.

Deliverables:

- executable spec templates
- downstream skill templates
- downstream domain tool templates
- tests derived from requirements or decisions
- experiment protocols
- feedback rules from execution results back into wiki pages

Validation:

- executable artifacts have tests or deterministic checks
- generated tools trace back to knowledge records
- failed validations create review or update tasks

### Phase 8: System Operations

Goal: keep LLM Awesome Wiki maintainable as sources and artifacts grow.

Deliverables:

- recurring maintenance checklist
- stale source detection
- stale claim detection
- dedup and merge process
- periodic overview refresh
- release and migration notes

Validation:

- maintenance work can be planned, committed, and reviewed
- stale or risky knowledge is surfaced before it becomes hidden debt

## Raw Resource To Markdown Rules

`raw_resource -> .md` means `raw resource -> source packet`, not `raw resource
-> final wiki article`.

Conversion rules:

- Keep raw files immutable.
- Use deterministic parsers before model analysis.
- Preserve page, slide, section, or timestamp anchors.
- Store extracted media separately and reference it with stable relative paths.
- Mark OCR, captions, and summaries as generated fields.
- Record extraction gaps instead of hiding them.
- Keep source packets faithful; perform synthesis in later phases.
- Never emit local absolute paths into committed Markdown.
- Use schemas to validate frontmatter and required metadata.

## LLM Responsibility Matrix

| Task | Deterministic tool required | LLM role | Human review |
| --- | --- | --- | --- |
| File identity, path, hash | yes | none | rare |
| PDF text extraction | yes | none or cleanup only | failed/low confidence |
| PPTX slide extraction | yes | none or cleanup only | failed/uncertain mapping |
| DOCX structure extraction | yes | none or cleanup only | failed/unsupported structures |
| OCR | yes | cleanup only | low confidence |
| Image/chart caption | media extraction first | factual VLM caption | important figures |
| Source packet generation | yes | formatting and concise generated notes | schema changes |
| Claim extraction | source packet required | primary assistant | ambiguous claims |
| Wiki drafting | evidence/claim context required | primary assistant | important claims |
| Compare gate | yes | assist with semantic gap discovery | unresolved issues |
| Downstream skill/tool or code generation | stable spec required | implementation assistant | failing validation |

## `llm_wiki` Reference Boundary

Use `llm_wiki` as a benchmark and source of patterns, not as the architecture of
this system.

Useful ideas to study:

- file type categorization
- stable source identity and slugging
- ingest cache keyed by source content
- two-stage source analysis and page generation
- image extraction and caption-first multimodal indexing
- frontmatter sanitization
- source array merging
- link lint and review queues
- search and graph-derived gap discovery

Ideas not to inherit as requirements:

- Tauri desktop app runtime
- Obsidian-centered workflow
- hidden desktop state as authoritative state
- graph visualization as required acceptance
- model-only semantic lint as final validation
- treating wiki access as equivalent to knowledge-to-code execution

When execution plans reference `llm_wiki`, they should state exactly which idea
is being studied and how it will be adapted into the root repository.

## Deriving Execution Plans

Concrete execution plans should choose one system phase or one narrow subsystem
slice.

Good execution targets:

- define the source inventory schema
- create the source packet template
- design the raw-resource converter interface
- implement PDF source packet conversion for one fixture class
- add a claim coverage report template
- build the first compare gate command
- define the stable knowledge release criteria
- define executable spec templates

Too broad:

- build the entire LLM Awesome Wiki system
- convert all raw resources and generate all wiki pages
- implement knowledge-to-code before coverage gates exist

Every derived `plan/<date-goal-slug>/plan.md` should name:

- selected phase
- subsystem boundary
- expected files
- validation commands
- whether `llm_wiki/` is reference-only or touched
- commit intent
