# Person A Phase Plan: Contracts And Validation

This guide is for the coworker acting as **Person A: Contracts + Validation
Owner**.

Person A owns the machine-checkable side of the pre-skill/tool system. The job
is not to redesign the whole architecture. The job is to make sure the workflow
can be validated by schemas, fixtures, tests, and stable CLI checks.

Person A also protects artifact economy from the schema side: contracts should
not force the same fact to be manually maintained in inventory, metadata,
packets, wiki pages, reports, and logs. Prefer one source of truth plus
references that validators can check.

## Background

LLM Awesome Wiki is a new Git-first knowledge engineering system. It uses
`llm_wiki/` only as read-only reference material unless the maintainer
explicitly requests submodule work.

Phase 0 is already complete. Phase 1 and Phase 1.1 exist, but the contracts
inside Phase 1/1.1 were created by Person B (`chenzc24`) as a rough first draft.
Your first responsibility is to harden that draft into a small, consistent,
machine-checkable contract set.

Do not begin by building a large converter or downstream skill/tool layer.
Before downstream artifacts can exist, the repository needs reliable schemas and
validation.

## Owned Area

Person A may edit:

- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `tests/fixtures/**`

Person A may read, but should not directly edit without coordination:

- `rules/**`
- `templates/workspace-kernel/**`
- `tools/*/README.md`
- `docs/phase-plans/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `llm_wiki/**`

When a workflow term is unclear, write a proposal or mismatch note for Person B
instead of patching Person B's owned files directly.

## Protocol And Contract Boundary

Person A owns machine-readable contracts, not workflow intent.

A machine-readable contract is a JSON Schema, validator behavior, fixture, or
deterministic check that can say whether an artifact is structurally valid. It
should stabilize fields, enum values, references, requiredness, and error
behavior.

Person B owns workflow protocols and operational rules: the prose that says how
a human or agent should move from one artifact to the next. Person A should use
those protocols as input, then decide which stable parts can become
machine-checkable contracts.

When a protocol needs a field that does not exist, either add it deliberately
inside the schema task or record why it is deferred. When a schema would require
new workflow behavior, record a mismatch for Person B instead of silently
changing Person B's rules or templates.

Historical files named `rules/*-contract.md` are not Person A-owned machine
contracts by default. Treat them as Person B-owned operational rules unless a
task explicitly asks Person A to translate part of them into schema, validator,
or fixture behavior.

## Phase Responsibilities

| Phase | Person A responsibility | Expected output |
| --- | --- | --- |
| Phase 0 | Read-only context. Confirm the system is not an `llm_wiki` clone. | No edits unless explicitly assigned. |
| Phase 1 | Stabilize the minimum workspace-kernel schemas. | Valid JSON Schemas and small fixtures. |
| Phase 1.1 | Harden the rough first draft contracts from Person B. | Aligned field names, required fields, validator coverage. |
| Phase 2 | Validate the raw-resource-to-source-packet protocol. | Schemas and fixtures for inventory rows, packet metadata, anchors, generated fields, gaps, and review routing. |
| Phase 3 | Define evidence, claim, and review contracts. | Traceable evidence and claim records with generated-field markers. |
| Phase 4 | Define wiki construction contracts. | Page/index frontmatter schemas and linkable source references. |
| Phase 5 | Define compare and review report contracts. | Pass/fail/needs-review report schema and fixture examples. |
| Phase 6 | Implement validation and checker tooling. | Workspace artifact validators, lint checks, closure checks, and scenario fixtures. |
| Phase 7 | Support only after validation/checker tooling is stable. | Downstream artifact schema inputs if requested later. |
| Phase 8 | Support operations checks later. | Stale-source or stale-claim validation only after earlier phases stabilize. |

## Phase 0: System Charter

Status: complete.

Use Phase 0 only to understand boundaries:

- design docs are English-only
- `llm_wiki/` is reference material, not a runtime dependency
- validation/checker tooling comes before downstream executable artifacts
- the root repository defines the portable workflow

Do not edit top-level architecture vocabulary unless the Coordinator assigns
that work.

## Phase 1: Workspace Kernel

Goal: make the workspace kernel structurally checkable.

Start with the smallest useful contract set:

- `source-inventory`
- `source-packet`
- `claim-record`
- `compare-report`

For each schema, Person A should decide:

- which fields are required now
- which fields are optional but reserved
- which enum values are allowed
- how identifiers are formatted
- how file paths are represented
- how generated fields are marked
- how validation errors should point to the bad field

Expected Phase 1 outputs:

- JSON Schemas under `contracts/schemas/**`
- one valid fixture per core schema
- one intentionally invalid fixture for common failure cases
- validator notes for fields that cannot be checked yet

Person B dependency:

- Person B will reference these field names from workflow rules and templates.
  Do not rename fields silently.

## Phase 1.1: Workspace Kernel Closure

Goal: close inconsistencies in the Phase 1 substrate before Phase 2 begins.

Important context: Person B (`chenzc24`) already made a rough first draft of
the Phase 1/1.1 contracts. Treat that draft as the starting point. Your job is
to turn it into a stable minimal contract, not to start an abstract redesign.

Person A should check:

- do rules, templates, and schemas use the same names for source inventory,
  source packet, compare gate, lint, review, and distillation round?
- do required fields match what the workflow says is required?
- can every template artifact point to the schema that validates it?
- does the validator fail clearly when an artifact is in the wrong location?
- are pass, fail, and needs-review represented consistently?

Expected Phase 1.1 outputs:

- aligned schema terms
- fixture examples that match workspace templates
- expanded `validate-kernel` checks for schema/template basics
- a short mismatch list for any workflow prose that Person B must update

Acceptance:

- the copied workspace kernel has obvious places for plans, raw inputs, derived
  packets, wiki pages, reports, and logs
- Phase 2 remains explicitly not started until the closure pass is stable

## Phase 2: Raw Resource To Source Packet Protocol

Goal: define the contracts that validate source packet protocol artifacts.

Person A does not need to implement a full converter, parser harness, or
extractor adapter first. Instead, define the artifact shapes that any human,
agent, MCP, local CLI, or optional extractor backend must eventually produce.

Required contract concerns:

- source identity
- raw path
- raw hash
- source kind
- extraction backend or adapter identity
- extraction method and version
- extraction status
- page, slide, section, or timestamp anchors
- extracted text
- extracted table references
- extracted media references
- OCR or VLM-generated captions
- extraction gaps and known failures
- generated-field markers

Source-type packet profile requirements:

- PDF packets can represent page anchors, rendered page references, OCR
  uncertainty, figure or chart references, and page-level gaps.
- PPTX packets can represent slide anchors, slide text, speaker notes, media
  references, rendered slide references, and uncertain media mapping.
- DOCX packets can represent heading anchors, hierarchy, paragraphs, lists,
  tables, comments, and unsupported structures when relevant.
- Image packets can represent extracted media identity, caption status, and
  review status.
- Table packets can represent inline Markdown tables when small and companion
  CSV/TSV links when large.

Model boundary:

- The LLM may help caption extracted media, clean OCR text, and draft summaries.
- The LLM should not be the authority for hashes, file identity, path
  normalization, page order, slide order, binary parsing, or final coverage
  checks.
- Optional extractors such as MinerU, Claude Code MCPs, Codex local tools,
  Poppler, LibreOffice, or custom scripts are adapter inputs. Person A validates
  their source packet outputs rather than implementing their internal harness.

Person B dependency:

- Person B owns `rules/raw-to-source-packet.md`, source packet protocol prose,
  adapter protocol prose, and source-type packet profiles. If the workflow
  needs a field that is missing from the schema, add it deliberately or record
  why it is deferred.

## Phase 3: Evidence And Claim Layer

Goal: make source-derived knowledge traceable before synthesis.

Person A should define:

- evidence span schema
- claim record schema
- review item schema
- confidence/provenance fields
- source packet anchor references
- generated-evidence markers for OCR, VLM captions, or model summaries
- unresolved judgment status values

Expected outputs:

- fixtures showing one direct text claim
- fixtures showing one OCR- or caption-derived claim
- fixtures showing one ambiguous claim routed to review

Acceptance:

- an important claim can be traced back to a source packet anchor
- generated evidence is visibly marked
- ambiguous claims cannot disappear silently

## Phase 4: Wiki Construction Engine

Goal: validate the artifacts that become wiki pages.

Person A should define or harden contracts for:

- source page frontmatter
- chapter page frontmatter
- concept or entity page frontmatter if enabled later
- overview page metadata
- wiki index entries
- source references and cross-links

Keep Phase 4 validation modest at first:

- frontmatter is parseable
- required `sources` references exist
- page type is valid
- generated pages do not omit required traceability fields

Person B dependency:

- Person B owns page routing rules and templates. If a template cannot be
  validated, report the exact missing field or ambiguous term.

## Phase 5: Compare Gates And Review Workflow

Goal: make quality gates checkable.

Person A should define:

- compare report schema
- claim coverage report shape
- modality coverage report shape
- omission report shape
- contradiction report shape
- review queue item schema

Status values should be explicit and small:

- `pass`
- `fail`
- `needs-review`

Acceptance:

- a round cannot close only because the model says it is complete
- skipped modalities are recorded
- unresolved semantic judgment is visible
- reports are stable enough to commit and review

## Phase 6: Validation And Checker Tooling

Goal: operationalize validation with deterministic and semi-deterministic
checker tooling.

Person A owns validator implementation, tests, and fixtures. Early work may
extend `tools/validate-kernel/**`, but Phase 6 should not be limited to root
kernel checks once workspace artifact validation begins.

Initial tool checks should cover:

- schema file validity
- fixture validity
- required template paths
- source packet field consistency
- compare report status values
- obvious broken references that can be checked without model judgment
- review queue lifecycle consistency
- round closure decision consistency

Do not build downstream domain skills here. Phase 6 tools are validation tools
for the LLM Awesome Wiki construction workflow itself.

Do not build a parser harness here. Optional extractors and adapter backends
are validated through their source packet outputs rather than through their
internal execution.

Person B dependency:

- Person B owns `tools/*/README.md` CLI behavior prose. Use those READMEs as the
  interface contract, and report mismatches when implementation and prose
  diverge.

## Phase 7: Downstream Executable Artifacts

Status: not active for the current split.

Person A may later help define schemas for executable specs, skill templates,
test derivation, or experiment protocols. Do not start this before Phase 6 can
produce stable reports.

## Phase 8: System Operations

Status: later maintenance phase.

Possible future validation work:

- stale source detection
- stale claim detection
- duplicate source detection
- migration report validation
- release checklist validation

Do not spend first-round effort here unless earlier phase contracts are already
stable.

## Daily Sync With Person B

Keep sync short and concrete:

- Did any schema field get renamed?
- Does any workflow rule reference a missing field?
- Does any template produce an artifact the validator cannot check?
- Are pass, fail, and needs-review represented the same way everywhere?
- Is a missing field a real contract need or just a workflow wording issue?

When there is a mismatch, record it. Do not patch across ownership boundaries
without updating the task plan.

## First Useful Task For Person A

The best first assignment is:

1. Open the rough Phase 1/1.1 contract drafts.
2. Pick `source-inventory`, `source-packet`, `claim-record`, and
   `compare-report`.
3. Make each schema minimally valid and internally consistent.
4. Add one valid fixture and one obvious invalid fixture per schema.
5. Extend `validate-kernel` only enough to check those fixtures.
6. Send Person B a mismatch list for workflow terms that need prose updates.

This keeps the coworker productive without forcing them to understand every
future phase at once.

## Artifact Economy Responsibility

When hardening schemas or validators, Person A should ask:

- Is this field the source of truth, or only a reference?
- Does this schema require an agent-readable wiki page to repeat audit metadata?
- Can validators check references instead of requiring copied values?
- Can verbose audit output be generated by tools rather than maintained by
  humans or LLMs?

If a workflow template encourages duplicate truth sources, record a mismatch
for Person B rather than expanding the schema to support the duplication by
default.
