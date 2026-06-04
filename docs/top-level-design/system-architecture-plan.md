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
humans working in VSCode and CLI environments. Its default profile is
document/PPT corpus distillation: preserve source structure, rebuild
agent-readable chapter-oriented knowledge that humans can review, and keep
coverage auditable. It should support the full path:

```text
raw resources
-> source inventory and source packets
-> evidence and claim records
-> maintained source and chapter pages
-> construction tools and reports
   (inventory, lint, compare, review, claim audit)
-> stable knowledge release
-> downstream executable specs
-> domain skills, domain tools, tests, templates, and code artifacts
-> validation feedback into the knowledge base
```

The system is not only a wiki surface. It is an engineering workflow for making
knowledge traceable, reviewable, and eventually executable.

The first quality axis is **raw-wiki alignment**: important wiki knowledge
should remain traceable to raw source material through stable source identity,
source packet anchors, and alignment reports. Simplicity is not the end goal;
artifact economy is the discipline that keeps this alignment maintainable.

The research-wiki structure used by `llm_wiki`--entities, concepts, queries,
comparisons, and synthesis pages--is an optional profile, not the default
minimum. It is useful when a corpus becomes a long-running research graph, but
can be too fragmented for large PPT decks that should remain readable by source
and chapter.

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
- Do not merge source packet production, wiki distillation, and downstream code
  generation into one large pass.
- Do not let LLMs be the parser of record for binary documents, hashes, paths,
  file identity, or final validation.
- Do not treat verbose audit artifacts as the default wiki surface.
- Do not create duplicate truth sources for the same operational fact across
  inventory, metadata, packets, wiki pages, reports, and logs.

## Cross-Cutting Invariants

These invariants apply across all phases.

### Raw-Wiki Alignment

The core construction path is:

```text
raw source
-> stable source identity
-> source packet anchors
-> agent-readable wiki references
-> alignment reports
-> review or correction
```

The system succeeds when an agent can scan and use the wiki, and a human
reviewer can still trace important claims back to source anchors without
reading every audit file manually.

### Artifact Economy

Every artifact should have a primary audience and a clear source-of-truth role.
Audit files may be verbose, but the wiki layer should stay concise,
agent-readable, and human-reviewable. Logs record events, reports record
decisions and blockers, and packets record source anchors. Repeating the same
fields everywhere is a system risk because it increases model burden and makes
validators chase conflicting copies.

For the full principle, see
`docs/top-level-design/artifact-economy-and-raw-wiki-alignment.md`.

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
raw/derived/              # generated packets, metadata, extracted text, media
wiki/                     # maintained agent-readable distilled knowledge
wiki/chapters/            # primary agent-readable chapter layer
wiki/sources/             # optional short source notes
wiki/synthesis/           # optional cross-source conclusions
reports/alignment/        # raw-wiki alignment checks
reports/coverage/         # source, anchor, and modality coverage
reports/review/           # unresolved human judgment
reports/validation/       # short round outcomes
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

### Layer 2: Source Packet Protocol And Raw-Wiki Alignment Substrate

This layer defines how heterogeneous source files become accessible, auditable
source packets. It is a protocol and alignment substrate, not a project-owned
PDF/PPTX/DOCX parser harness.

Key output:

```text
raw/derived/<source-id>/source.md
raw/derived/<source-id>/media/
raw/derived/<source-id>/metadata.yml
```

The source packet protocol must preserve provenance, page or slide anchors,
extracted media references, generated captions, OCR status, parsing failures,
and confidence notes.

This layer is the raw side of raw-wiki alignment. Its job is not to produce a
beautiful Markdown article. Its job is to create stable source identities and
anchors that later wiki pages can cite.

Optional extractors can satisfy the protocol: local CLI tools, MCPs, MinerU,
Poppler-style PDF tools, LibreOffice-style office tools, manual extraction, or
custom scripts. The workspace packet remains the source of truth, not the
internal output layout of any one extractor.

### Layer 3: Evidence And Knowledge IR

The intermediate representation should be more structured than prose. It should
capture source packets, chapter anchors, claims, methods, decisions, evidence
links, and open review items. Concepts, entities, and comparisons may be added
when the workspace selects a research-wiki profile.

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

The wiki is the maintained agent-readable, human-reviewable knowledge layer. It
should summarize, connect, and organize knowledge while preserving traceability
back to source packets and evidence records.

The wiki should not duplicate the audit layer. It should reference source
anchors for important claims while staying structured enough for agents to scan
and clear enough for humans to review.

Expected outputs:

- `wiki/index.md`
- `wiki/overview.md`
- `wiki/log.md`
- `wiki/sources/*.md`
- `wiki/chapters/*.md`
- optional `wiki/synthesis/*.md`
- optional research-profile page types such as `concept`, `entity`,
  `comparison`, and `query`

### Layer 5: Quality Gates

Quality gates turn subjective distillation into checkable workflow state.
They are part of the knowledge-construction executable layer, not downstream
skill or tool generation.

Required gate families:

- raw-wiki alignment reports
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
- source packet adapter runner
- optional media extractor
- optional OCR and caption runner
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
- the default kernel preserves source/chapter structure before optional
  research-wiki object extraction
- Phase 2 remains explicitly not started

### Phase 2: Raw-Wiki Alignment Substrate

Goal: create the raw side of the raw-wiki alignment substrate by defining the
source packet protocol that all raw-resource processing must satisfy.

This phase answers the immediate `raw_resource -> .md` question. The answer is:
do not convert raw resources directly into final wiki pages. First produce a
source packet that is faithful, structured, auditable, and traceable. The
packet must expose source identities and anchors that future wiki pages and
alignment reports can cite.

Phase 2 does not require this repository to implement a PDF/PPTX/DOCX parser
harness. It defines what any extractor, MCP, local CLI, manual process, or
future adapter must leave behind in the workspace.

#### Source Packet Protocol

Each source packet should include:

- source identity inherited from inventory
- raw path
- raw hash or hash state
- source kind
- extraction backend or adapter identity
- extraction method and version
- extraction status
- page, slide, heading, section, timestamp, row, or media anchors
- extracted text or explicit extraction gaps
- extracted tables or companion data links
- extracted media references
- OCR, VLM, or agent-generated fields when needed
- known failures and review routing

Suggested source packet frontmatter:

```yaml
---
type: source-packet
source_id: papers/example-paper
raw_path: raw/sources/papers/example-paper.pdf
raw_sha256: "<sha256>"
source_kind: pdf
extraction_backend: optional-adapter-name
extraction_method: adapter-or-manual-method
extraction_version: v0
extraction_status: partial
modalities: [text, image, table]
generated_fields: [image_captions]
review_required: true
created: 2026-06-03
---
```

#### PDF Packet Profile

PDF packet requirements describe packet output, not parser implementation.

A PDF source packet should preserve:

- page-level anchors
- page count and page range metadata when available
- extracted page text or an explicit text-extraction gap
- scanned, text-poor, password-protected, empty, or failed pages
- rendered page references for visual-heavy pages when available
- table, chart, image, and figure anchors when available
- OCR text, page captions, or chart interpretations as generated fields
- review notes for important visual content that cannot be verified
  deterministically

#### PPTX Packet Profile

PPTX packet requirements describe packet output, not parser implementation.

A PPTX source packet should preserve:

- slide-level anchors
- slide order
- slide text or an explicit extraction gap
- speaker notes when available
- media references and their slide mapping when available
- rendered slide references for layout-heavy slides when available
- generated captions for meaningful visuals when used
- review notes for uncertain media-to-slide mapping

#### DOCX Packet Profile

DOCX packet requirements describe packet output, not parser implementation.

A DOCX source packet should preserve:

- heading anchors
- heading hierarchy
- paragraphs, lists, and tables when available
- small readable tables as Markdown when feasible
- large tables as companion CSV/TSV files or derived artifacts
- image references and captions when images carry information
- footnotes, comments, revisions, or unsupported structures when relevant

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
- important claims cite source packet anchors
- readable pages do not repeat packet metadata, hashes, and extraction logs
- existing pages are merged rather than overwritten
- cross-links are checked

### Phase 5: Compare Gates And Review Workflow

Goal: ensure that every round produces checkable quality signals, especially
raw-wiki alignment and coverage signals.
This phase is still part of knowledge-base construction.

Deliverables:

- alignment report template
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
These tools operationalize source packet production, maintenance, and compare
gates; they are not the downstream domain `skill + tool` codebase.

Deliverables:

- inventory command
- source packet adapter command
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

Protocol rules:

- Keep raw files immutable.
- Use deterministic extractors or optional adapters before model analysis when
  available.
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
- design the source packet adapter protocol
- define the PDF source packet profile for one fixture class
- add a claim coverage report template
- build the first compare gate command
- define the stable knowledge release criteria
- define executable spec templates

Too broad:

- build the entire LLM Awesome Wiki system
- convert all raw resources and generate all wiki pages
- implement knowledge-to-code before coverage gates exist

Every derived plan under `plan/users/<user>/<date-goal-slug>/plan.md` or
`plan/shared/integration/<date-goal-slug>/plan.md` should name:

- selected phase
- subsystem boundary
- expected files
- validation commands
- whether `llm_wiki/` is reference-only or touched
- commit intent
