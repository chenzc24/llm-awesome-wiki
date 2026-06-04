# Person B Workflow Closure Review

This review closes the current Person B workflow-surface question around source
packet profiles and wiki construction.

Conclusion: Person B has already defined the main workflow prose needed for
source packet profiles and wiki construction. The remaining work is not another
round of workflow design. The remaining work is mostly Person A contract,
fixture, validator, and checker hardening based on the existing rules.

## Review Scope

This review covers:

- raw-to-source-packet workflow prose
- source-type packet profile prose
- source-packet-to-wiki workflow prose
- wiki routing, merge, overview, index, log, and validation expectations
- Person A handoff for fixtures and validators

It does not review extractor implementation, downstream `skill + tool`
generation, or full production-readiness of every validator.

## Completed Person B Surfaces

Person B has already defined the source packet and wiki construction surfaces
at the workflow level.

Key completed runtime and rules:

- `skills/llm-wiki-source-packet/SKILL.md`
- `rules/source/source-type-packet-profiles.md`
- `skills/llm-wiki-wiki-round/SKILL.md`
- `rules/wiki/wiki-surface-workflow.md`
- `skills/llm-wiki-distill/SKILL.md`
- `rules/wiki/source-wiki-coverage-protocol.md`

Key completed phase plans and reviews:

- `docs/phase-plans/phase-2.2-source-packet-protocol.md`
- `docs/phase-plans/phase-2.4-source-type-packet-profiles.md`
- `docs/phase-plans/phase-2-closure-handoff.md`
- `docs/phase-plans/phase-4-wiki-construction-engine.md`
- `docs/phase-plans/phase-4.3-wiki-construction-round-protocol.md`
- `docs/phase-plans/phase-4.4-overview-index-log-maintenance.md`
- `docs/phase-plans/phase-4-closure-review.md`
- `docs/phase-plans/phase-5-closure-review.md`
- `docs/phase-plans/phase-6-closure-review.md`

## Design Review

| Question | Review result |
| --- | --- |
| Are PPT/PDF source packet profiles defined? | Yes. `rules/source/source-type-packet-profiles.md` defines PDF page anchors, PPTX slide anchors, rendered artifact references, generated-field markers, known gaps, and review routing. |
| Is extractor implementation required by the system? | No. Extractors, MCPs, MinerU, OCR, VLM, LibreOffice, Poppler, manual workflows, and custom scripts are optional inputs. The system validates their packet outputs. |
| Is wiki construction defined as raw-to-wiki generation? | No. The workflow requires source packet input, routing, construction analysis, page create/update/merge decisions, index/log updates, and validation or review handoff. |
| Does the workflow require a deterministic wiki generator? | No. Wiki prose still needs human or LLM reading, synthesis, and judgment. The system constrains the process and checks artifacts. |
| Is the default wiki surface clear? | Yes. Document and PPT corpora default to overview, index, chapters, and short source pages rather than fragmented concept/entity pages. |
| Is Person A able to start useful work? | Yes. Person A can now turn stable workflow surfaces into schemas, validators, fixtures, and checker hardening. |

## Closure Findings

1. Source packet profiles are not a Person B gap.

   The profile prose already defines minimum packet expectations for PDF,
   PPTX, DOCX, image, table, dataset, and mixed media sources. For PPT/PDF
   work, the missing piece is not more prose; it is fixture-backed validation
   that checks whether a concrete packet satisfies the profile.

2. Extractor or adapter execution is explicitly out of core scope.

   The project should not implement a default PDF/PPTX parser harness just to
   close this workflow layer. External extraction outputs are acceptable when
   they leave a valid source packet with stable anchors, generated markers,
   gaps, derived artifact references, and review routing.

3. Wiki construction is workflow-constrained, not fully tool-generated.

   The system should not promise automatic wiki generation. It should require
   an agent or human to read source packets, write construction analysis, decide
   page routing, draft or merge wiki pages, update overview/index/log, and then
   run checks.

4. The remaining workflow issue was operational consolidation.

   `skills/llm-wiki-wiki-round/SKILL.md` now owns the required runtime path.
   Phase 4 remains the historical design record. Future Person B edits should
   be small: tighten templates, add examples, or clarify handoff wording when
   Person A fixtures expose ambiguity.

5. The next implementation value is Person A validation.

   The highest-value next work is a representative source packet fixture and a
   wiki construction fixture. These should prove that the rules can support a
   realistic PPT/PDF-style source without implementing an extractor.

## Person A Handoff

Person A should treat the following as ready for contract and fixture work.

### Source Packet Profile Fixtures

Create fixtures that represent valid and invalid packet outputs, especially:

- valid PPTX packet with slide anchors, slide order, visible text, rendered
  slide references, generated chart or image interpretation markers, and review
  routing for uncertain visual interpretation
- invalid PPTX packet missing slide anchors
- invalid PPTX packet with generated chart summary not marked as generated
- valid PDF packet with page anchors, page text or explicit text gaps, rendered
  page references, and review routing for OCR or visual interpretation
- invalid PDF packet that smooths missing page extraction into summary prose
  without known gaps

These fixtures should not run a parser. They should contain the packet files an
external parser, agent, or manual workflow would leave behind.

### Wiki Construction Fixtures

Create fixtures for the source-packet-to-wiki flow:

- valid construction round with routing decision, construction analysis, one
  chapter update, index update, wiki log entry, and validation note
- invalid round that writes chapter prose without construction analysis
- invalid round that creates an accepted page but omits it from `wiki/index.md`
- invalid round that changes coverage but leaves `wiki/overview.md` stale
- needs-review round with generated evidence or ambiguous visual interpretation
  carried into review instead of silently accepted

### Validator Hardening

Harden validators around stable, checkable behavior:

- `source-packet-lint`: source-type profile checks for PPTX and PDF anchors,
  generated markers, known gaps, and derived artifact references
- `wiki-lint`: construction analysis presence when pages change, index
  membership, overview/log freshness, and source reference shape
- `report-check`: claim/evidence and review handoff structures
- `round-closure-check`: construction analysis, overview, index, log, compare,
  and review state consistency
- `fixture-runner`: end-to-end workspace scenarios that combine source packet,
  wiki, report, and closure checks

## Person B Follow-Up

Person B should not start another broad redesign. Useful follow-up is limited
to:

- add a concrete source packet example to templates only if Person A needs one
- tighten wording where a validator exposes ambiguous terms
- update `llm_wiki_tools/README.md` if implemented command behavior changes
- clarify construction-analysis template fields if fixtures show mismatch

Person B should not:

- treat the workflow as an extractor harness
- treat the workflow as a wiki generator
- implement extractor harnesses
- make MinerU, OCR, VLM, MCP, or LibreOffice required
- write a deterministic wiki generator
- move claim/evidence audit tables into default wiki page bodies
- reopen the source/chapter default wiki surface unless fixture failures prove
  it is insufficient

## Closure Decision

Person B workflow surface is closed enough for Person A implementation.

The next useful work is:

```text
existing rules and templates
-> representative source packet fixtures
-> wiki construction fixtures
-> validator hardening
-> end-to-end fixture runner scenarios
```

This keeps the system aligned with the core design:

```text
LLM or human performs reading and synthesis.
The repository supplies protocol, templates, checks, reports, and closure
discipline.
```
