# Phase 6.0 Validation Tooling Rebaseline

Phase 6.0 rebaselines Phase 6 after the no-harness decision.

Phase 6 is the workspace validation and checker tooling layer. It inspects
workspace artifacts produced by Phases 2 through 5 and reports whether they
match the workflow protocols, schemas, references, and closure rules.

It is not a raw document extraction harness.

## Reason For Rebaseline

Earlier planning used "construction tools" broadly enough to include source
packet adapter commands, optional media extractors, OCR runners, and caption
runners. That language is too broad for the current architecture.

The system has since made a sharper decision:

- Phase 2 defines the source packet protocol that any extractor can satisfy.
- Optional extractors, MCPs, MinerU, Poppler, LibreOffice, manual workflows, or
  custom scripts may produce packet artifacts.
- The workspace source packet is the durable source of truth.
- This repository should validate source packet outputs, not own every
  extractor backend or parser harness.

Phase 6 therefore implements the executable maintenance layer for the
knowledge-construction workflow: validators, linters, checkers, report
validators, and fixture runners.

Phase 6 does not run extractors. It validates the source packet outputs that
extractors, agents, manual workflows, or custom scripts leave in the workspace.

## Phase 6 Scope

Phase 6 should implement tools that check workspace artifacts:

- schema validity
- source inventory consistency
- source packet metadata and anchor validity
- generated-field marking
- known gap and review routing presence
- wiki frontmatter and source-reference lint
- link and index consistency
- compare report structure and status consistency
- review queue lifecycle consistency
- validation note and closure packet consistency
- round closure decision consistency
- scenario fixture pass/fail behavior

These tools may read raw files for deterministic file identity checks, such as
path existence and hash validation. They should not parse raw binary content as
their main job.

## Non-Goals

Phase 6 does not:

- implement a PDF/PPTX/DOCX parser harness
- run MinerU
- wrap MCP extractor backends
- run OCR or VLM captioning
- implement media extraction
- produce source packets as its core responsibility
- generate wiki pages
- resolve semantic review
- start downstream knowledge-to-`skill + tool` generation

If a future project wants adapter orchestration, it should be treated as a
separate optional adapter project. Its output must still pass the Phase 6
source packet validators.

## Tool Families

Recommended Phase 6 tool families:

- `workspace-check`: orchestrate selected validators and emit a summary report
- `source-inventory-check`: validate inventory rows, paths, hashes, duplicate
  IDs, and packet status links
- `source-packet-check`: validate packet metadata, anchors, generated fields,
  known gaps, review routing, and source-type profile expectations
- `wiki-lint`: validate frontmatter, links, index membership, overview status,
  and wiki log references
- `claim-audit`: validate important claim support and generated-evidence
  review routing
- `compare-report-check`: validate compare status, coverage tables, review
  handoff, and failure visibility
- `review-queue-check`: validate review item lifecycle, blocking level,
  carried-forward fields, stale state, and dismissal reasons
- `round-closure-check`: validate `close-pass`, `close-with-review`, and
  `do-not-close` against compare, review, validation, index, overview, and log
  state
- `fixture-runner`: run scenario fixtures that prove validators catch expected
  passes and failures

## Source Packet Boundary

Phase 6 may check source packet outputs. It should not own source packet
production.

Allowed:

- verify source packet files exist
- verify metadata fields and enum values
- verify anchors parse
- verify raw paths stay under `raw/sources/`
- verify raw hashes when local files are available
- verify generated fields are declared
- verify known gaps and review routing are present for partial or failed
  extraction
- verify backend-local IDs are not the only citation identity

Not allowed as Phase 6 core work:

- invoke an extractor backend
- convert PDF/PPTX/DOCX/image/table files
- run OCR or VLM captioning
- repair adapter output semantically
- decide that generated evidence is source truth

## Phase 6 Sequence

Recommended sequence:

1. Phase 6.1: tool runtime skeleton and shared report conventions.
2. Phase 6.2: schema and structured-field validation.
3. Phase 6.3: source inventory and source packet checks.
4. Phase 6.4: wiki lint and navigation checks.
5. Phase 6.5: compare, review, claim, and validation note report checks.
6. Phase 6.6: round closure checker.
7. Phase 6.7: scenario fixtures and fixture runner.
8. Phase 6.8: Phase 6 closure review and Phase 7 boundary.

## Phase 6.1 Active Scope

Phase 6.1 adds the first checker runtime skeleton:

- shared report conventions
- shared exit-code semantics
- `workspace-check` README
- `workspace-check.ps1` smoke-run entrypoint
- explicit `not-implemented` slots for later validators

Phase 6.1 does not implement schema validation, source packet checks, wiki
lint, report validation, round closure validation, fixtures, extractor
execution, or downstream `skill + tool` work.

## Phase 6.2 Active Scope

Phase 6.2 adds schema and structured-field validation:

- `schema-check` README
- `schema-check.ps1`
- source inventory schema field and enum alignment
- source packet schema field and enum alignment
- claim, compare, and review enum alignment
- `workspace-check -Mode schemas` integration

Phase 6.2 checks reusable schema contracts only. It does not validate real
workspace artifact instances, inspect packet directories, run extractors, parse
raw binaries, perform wiki lint, validate compare semantics, or run fixtures.

## Phase 6.3 Active Scope

Phase 6.3 adds source artifact validation:

- `source-inventory-check.ps1`
- `source-packet-lint.ps1`
- `workspace-check -Mode source` integration
- source inventory path, hash, duplicate ID, status, review, and packet-path
  checks
- source packet metadata, anchor, generated field, known gap, review routing,
  and derived artifact checks

Phase 6.3 validates existing workspace artifacts. It does not scan raw content
into packets, run extractor backends, parse PDF/PPTX/DOCX/image content,
generate wiki pages, validate compare reports, or change schemas.

## Phase 6.4 Active Scope

Phase 6.4 adds wiki lint and navigation validation:

- `wiki-lint.ps1`
- `workspace-check -Mode wiki` integration
- special file checks for `wiki/index.md`, `wiki/overview.md`, and
  `wiki/log.md`
- content page frontmatter checks
- wikilink and local Markdown link resolution
- index membership and stale index link checks
- overview and log maintenance-surface checks

Phase 6.4 validates existing wiki artifacts. It does not generate pages,
rewrite links, run compare gates, validate report semantics, or resolve
semantic review.

## Phase 6.5 Active Scope

Phase 6.5 adds report surface validation:

- `report-check.ps1`
- `workspace-check -Mode reports` integration
- compare report structure and check-matrix consistency
- claim/evidence map source-ref and support consistency
- review queue lifecycle and blocking-level consistency
- validation-note compare status and closure-field consistency

Phase 6.5 validates existing Markdown reports. It does not extract claims,
decide semantic truth, generate compare reports, resolve review items, generate
wiki pages, or close rounds.

## Phase 6.6 Active Scope

Phase 6.6 adds round closure validation:

- `round-closure-check.ps1`
- `workspace-check -Mode closure` integration
- validation note closure-field checks
- `close-pass`, `close-with-review`, and `do-not-close` consistency checks
- referenced compare and review report path checks
- wiki log visibility and active report discoverability checks

Phase 6.6 validates recorded closure decisions. It does not close rounds,
rewrite validation notes, resolve review items, decide semantic truth, generate
reports, or generate wiki pages.

## Person A / Person B Boundary

Person A owns machine-readable schemas, validators, tests, and fixtures.

Person B owns workflow prose and tool behavior READMEs.

Phase 6 implementation should keep that split:

- Person B can update tool README specs and handoff language.
- Person A can implement validators and fixtures.
- Shared changes to top-level phase boundaries should be planned explicitly.

## Completion Criteria

Phase 6.0 is complete when:

- top-level architecture names Phase 6 as validation and checker tooling
- Phase 6 no longer implies a project-owned extractor harness
- tool README prose distinguishes output validation from conversion harnessing
- collaboration docs align Person A and Person B responsibilities with the
  checker-first Phase 6 direction
- Phase 7 remains the later downstream knowledge-to-`skill + tool` mainline
