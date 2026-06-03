# Person B Phase Plan: Workflow And Tool Surface

This guide is for **Person B: Workflow + Tool Surface Owner**.

In the current team, Person B is `chenzc24`. Person B owns the parts that make
the system understandable and executable by humans and agents: rules, templates,
phase plans, and tool behavior prose.

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
| Phase 2 | Describe raw-resource-to-source-packet workflow. | PDF/PPTX/DOCX/image/table handling rules and handoff expectations. |
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

## Phase 2: Raw Resource Conversion Subsystem

Goal: describe how raw resources become source packets.

Person B owns the human/agent workflow. The main rule is:

```text
raw resource -> source packet -> evidence/claims -> wiki
```

Do not describe this as:

```text
raw resource -> final wiki page
```

Person B should define workflow for:

- source intake and inventory
- raw path conventions
- when to hash raw files
- what counts as successful extraction
- how partial extraction is recorded
- how generated OCR or VLM captions are marked
- how unsupported modalities are routed to review

For PDF:

- require page-level anchors
- require text extraction before model analysis
- require rendered pages for visual-heavy material
- record scanned, password-protected, empty, or extraction-failed pages
- state when OCR or VLM captioning may be used

For PPTX:

- require slide-level anchors
- preserve slide order
- extract slide text and speaker notes when possible
- render slide screenshots for layout-heavy slides
- record uncertain media-to-slide mapping

For DOCX:

- preserve heading hierarchy
- keep paragraphs, lists, tables, and footnote/comment notes when relevant
- convert small tables to Markdown
- link large tables as companion CSV/TSV files
- extract and caption meaningful images

For images and tables:

- distinguish extracted data from model-generated captions
- avoid treating captions as source-equivalent unless review accepts them
- record skipped decorative media when safe

Person A dependency:

- Person A owns the schema fields. Person B should maintain a handoff list of
  required fields, for example `source_kind`, `raw_sha256`, `extraction_status`,
  `modalities`, `anchors`, `generated_fields`, and `known_gaps`.

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
- raw-resource conversion command
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
