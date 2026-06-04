# Person B Phase Plan: Workflow And Tool Surface

This guide is for **Person B: Workflow + Tool Surface Owner**.

In the current team, Person B is `chenzc24`. Person B owns the parts that make
the system understandable and executable by humans and agents: rules, templates,
phase plans, and tool behavior prose.

Person B also owns the readable output surface. The workflow should keep
construction audit artifacts separate from human-readable wiki pages and should
avoid templates that make agents repeat the same operational facts across many
files.

## Background

LLM Awesome Wiki is being built as a new system. It can learn from `llm_wiki/`,
but `llm_wiki/` remains read-only reference material unless explicitly updated.

Phase 0 is complete. Person B already created the first Phase 1/1.1 contract
drafts, but those drafts are rough. From this point forward, Person B should not
keep polishing schemas directly as the main path. Person A should harden the
contract/validation side while Person B stabilizes workflow and tool surfaces.

This prevents both people from doing architecture work in the same files.

## Owned Area

Person B may edit:

- `rules/**`
- `templates/workspace-kernel/**`
- `tools/*/README.md`
- `docs/phase-plans/**`
- assigned files under `docs/collaboration/**`

Person B may read, but should not directly edit without coordination:

- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `tests/fixtures/**`
- `docs/top-level-design/**`
- `llm_wiki/**`

Person B should propose schema changes to Person A instead of directly changing
`contracts/schemas/**` during coworker work.

## Phase Responsibilities

| Phase | Person B responsibility | Expected output |
| --- | --- | --- |
| Phase 0 | Preserve completed architecture boundaries. | No routine edits; only Coordinator-level changes. |
| Phase 1 | Make the workspace kernel usable by humans and agents. | Rules, templates, phase plans, and first-use guidance. |
| Phase 1.1 | Close workflow ambiguity while Person A hardens contracts. | Term alignment notes, template cleanup, workflow corrections. |
| Phase 2 | Describe raw-resource-to-source-packet protocol. | Source inventory rules, packet protocol, extractor adapter protocol, source-type packet profiles, and handoff expectations. |
| Phase 3 | Describe source-packet-to-evidence/claim workflow. | Claim extraction, review routing, and generated-evidence rules. |
| Phase 4 | Describe source-packet-to-wiki workflow. | Page routing, source/chapter templates, index and overview rules. |
| Phase 5 | Describe compare gate and review workflow. | Pass/fail/needs-review prose and review handoff rules. |
| Phase 6 | Specify construction tool surfaces. | CLI README specs for inputs, outputs, reports, and failure modes. |
| Phase 7 | Not active until construction reports are stable. | Later downstream skill/tool workflow only after Phase 6. |
| Phase 8 | Later operations workflow. | Maintenance checklist and release/migration prose. |

## Phase 0: System Charter

Status: complete.

Person B should keep Phase 0 stable. Use it as a boundary document, not as a
daily editing surface.

Phase 0 says:

- this repository is the source of truth for LLM Awesome Wiki
- docs are English-only
- `llm_wiki/` is reference material
- generated workspaces are separate from the root system repository
- downstream executable artifacts come after construction tooling

Only update top-level design when acting as Coordinator after team sync.

## Phase 1: Workspace Kernel

Goal: make the workspace kernel understandable and copyable.

Person B owns:

- workflow rules outside `docs/`
- workspace-kernel templates
- plan and log templates
- phase-plan breakdown
- first-use guidance for agents and humans
- README-level explanation of where artifacts belong

Person B should make sure a newcomer can answer:

- where do raw inputs go?
- where do derived source packets go?
- where do wiki pages go?
- where do reports go?
- where do logs and plans go?
- which steps are manual for now?
- which future tools are only described, not implemented yet?

Person A dependency:

- If the workflow depends on a field, tell Person A clearly. Do not silently
  rename schema fields in prose.

## Phase 1.1: Workspace Kernel Closure

Goal: make Phase 1 internally consistent before Phase 2 begins.

Important context: Person B created a rough first draft of the Phase 1/1.1
contracts. That was useful bootstrapping work, but coworker parallelization
needs a cleaner boundary now. Person A should harden contracts and validation;
Person B should close workflow ambiguity.

Person B should check:

- do rules and templates use the same terms?
- does the workflow mention fields that Person A has not accepted?
- do template paths match the directory map?
- do pass, fail, and needs-review mean the same thing everywhere?
- does the workspace preserve source/chapter structure before optional
  research-wiki object extraction?
- is Phase 2 still explicitly not started?

Expected Phase 1.1 outputs:

- updated workflow prose where schema terms changed
- template naming cleanup
- phase plan notes showing what is closed and what is deferred
- proposals to Person A for missing schema fields

Acceptance:

- a copied workspace kernel has obvious places for plans, raw inputs, source
  packets, wiki pages, reports, and logs
- Person A's validator expectations do not contradict Person B's workflow prose

## Phase 2: Raw Resource To Source Packet Protocol

Goal: describe the protocol that any human, agent, MCP, local CLI, or optional
extractor backend must follow when raw resources become source packets.

Person B owns the human/agent workflow and tool-surface protocol. The main rule
is:

```text
raw resource -> source inventory -> source packet -> evidence/claims -> wiki
```

Do not describe this as:

```text
raw resource -> final wiki page
```

Also do not describe Phase 2 as:

```text
raw resource -> project-owned PDF/PPTX/DOCX parsing harness
```

Person B should define protocol for:

- source intake and inventory
- raw path conventions
- when to hash raw files
- what a valid source packet must contain
- how optional extractors/adapters declare backend, method, and version
- how backend-specific outputs map into workspace packet anchors
- how partial packet output is recorded
- how generated OCR or VLM captions are marked
- how unsupported modalities are routed to review

Person B does not own the internal implementation of MinerU, Claude Code MCPs,
Codex tools, Poppler, LibreOffice, or custom parsers. Those are optional
extractor backends. Person B defines what they must leave behind in the
workspace.

Source-type packet profiles should define minimum packet expectations, not
parser implementations.

For PDF packets:

- require page-level anchors
- require text extraction result or an explicit text-extraction gap
- require rendered page references for visual-heavy material when available
- record scanned, password-protected, empty, or extraction-failed pages
- state when OCR or VLM captioning may be used

For PPTX packets:

- require slide-level anchors
- preserve slide order
- record slide text and speaker notes when possible
- record rendered slide references for layout-heavy slides when available
- record uncertain media-to-slide mapping

For DOCX packets:

- preserve heading hierarchy
- keep paragraphs, lists, tables, and footnote/comment notes when relevant
- convert small tables to Markdown
- link large tables as companion CSV/TSV files
- extract, reference, or route meaningful images to review

For image and table packets:

- distinguish extracted data from model-generated captions
- avoid treating captions as source-equivalent unless review accepts them
- record skipped decorative media when safe

Person A dependency:

- Person A owns the schema fields. Person B should maintain a handoff list of
  required fields, for example `source_kind`, `raw_sha256`, `extraction_status`,
  `extraction_backend`, `adapter`, `modalities`, `anchors`,
  `generated_fields`, `known_gaps`, and `review_required`.

## Phase 3: Evidence And Claim Layer

Goal: describe how source packets become traceable claims.

Person B owns:

- claim extraction workflow
- evidence selection rules
- generated-evidence warning rules
- confidence and review routing prose
- distillation round behavior

Person B should make the workflow answer:

- when is a statement a claim?
- when is a statement only summary context?
- which claims need source anchors?
- how are OCR-derived or caption-derived claims marked?
- when should the agent create a review item instead of deciding?
- how does a human resolve a review item?

Person A dependency:

- Person A defines claim and review schemas. Person B should report workflow
  needs as field proposals instead of editing schemas.

## Phase 4: Wiki Construction Engine

Goal: describe how claims and source packets become wiki pages.

Person B owns:

- `source-packet-to-wiki` workflow
- page routing rules
- source page template expectations
- chapter page template expectations
- overview and index update rules
- merge rules for existing pages
- wiki log expectations

Default page strategy:

- preserve source/chapter readability for document and PPT corpora
- use overview/index pages to connect related material
- defer aggressive research-wiki object extraction until the default flow is
  reliable
- keep source references visible in generated pages

Person A dependency:

- Person A validates frontmatter and required references. If Person A reports a
  template cannot be validated, update the workflow/template side rather than
  weakening validation by default.

## Phase 5: Compare Gates And Review Workflow

Goal: make every round produce visible quality signals.

Person B owns prose for:

- compare gate behavior
- review queue behavior
- pass/fail/needs-review meanings
- omission and contradiction handling
- modality coverage expectations
- when a round is allowed to close

Use these meanings consistently:

- `pass`: the round meets the explicit checks for its current scope
- `fail`: the round has blocking problems that must be fixed before closure
- `needs-review`: deterministic checks cannot decide, or human judgment is
  required

Person B should avoid language that lets the model close a round by
self-evaluation alone.

Person A dependency:

- Person A owns compare report schemas. Person B should provide field needs and
  examples from workflow, especially for skipped modalities, unresolved
  judgments, and source coverage.

## Phase 6: Construction Tools

Goal: describe future CLI behavior before or alongside implementation.

Person B owns `tools/*/README.md` behavior specs.

Each tool README should specify:

- command purpose
- inputs
- outputs
- generated files
- reports
- failure modes
- exit-code expectations when known
- what the tool does deterministically
- what requires model assistance or human review

Construction tools are for building the LLM Awesome Wiki workflow itself:

- inventory command
- packet conversion or adapter command
- packet validation command
- link/frontmatter lint command
- compare gate command
- review export command

They are not downstream domain skills/tools yet.

Person A dependency:

- Person A implements validator behavior and tests. Person B should keep README
  language aligned with the implemented or planned validator surface.

## Phase 7: Downstream Executable Artifacts

Status: not active in the current split.

Person B should not start downstream skill/tool workflows until construction
tools and compare gates can produce a stable knowledge release.

Later Person B may own workflow prose for:

- executable spec templates
- downstream skill templates
- downstream domain tool templates
- experiment protocols
- feedback from execution results back into wiki pages

## Phase 8: System Operations

Status: later maintenance phase.

Person B may later own prose for:

- recurring maintenance checklist
- stale source review
- stale claim review
- dedup and merge process
- overview refresh
- release and migration notes

Do not spend first coworker effort here unless Phase 1 through Phase 6 are
stable enough to operate.

## Daily Sync With Person A

Keep sync focused on the interface:

- Did Person A rename any schema field?
- Does Person B's workflow mention a field that does not exist?
- Does Person A's validator reject a template Person B expects to be valid?
- Are pass, fail, and needs-review still consistent?
- Which ambiguity should become a schema field, and which should remain prose?

When Person B needs a contract change, write it as a proposal:

```text
Workflow need:
The raw-to-source-packet workflow needs to record OCR-derived captions.

Proposed field:
generated_fields: [ocr_text, image_caption]

Reason:
Reviewers need to distinguish directly extracted source text from generated
assistant output.
```

## First Useful Task For Person B

The best first assignment for Person B after handing contract hardening to
Person A is:

1. Freeze the current Phase 1/1.1 schema drafts as Person A's hardening input.
2. Update workflow prose only where terms are clearly inconsistent.
3. Write a short handoff list of fields the raw-to-source-packet workflow needs.
4. Keep `docs/phase-plans/**` focused on phase deliverables, not schema detail.
5. Expand `tools/*/README.md` only after the workflow names and schema fields
   are stable enough.

Person B's main job is clarity: make the path understandable, make ambiguity
visible, and keep humans and agents from guessing.

## Artifact Economy Responsibility

Person B should make sure every default artifact has a primary audience:

- source packets are for anchors, extraction gaps, and audit handoff
- wiki chapters are for readable distilled knowledge
- reports are for validation results, blockers, coverage, and review queues
- logs are for events, not knowledge summaries

When a template becomes verbose, Person B should decide whether the content is
needed for raw-wiki alignment. If it is not, remove it from the default
workflow or move it to an optional/generated audit artifact.
