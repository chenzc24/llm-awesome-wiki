# Person A Implementation Closure Review

This review closes the current Person A workstream for contracts, validators,
and fixtures before downstream Phase 7 skill/tool work begins.

Conclusion: Person A is complete as a first contract and validation layer. The
repository now has a small schema vocabulary, runnable Python checkers, and
representative fixtures that prove the checker layer can validate source
packet outputs and wiki construction closure without becoming an extractor
harness or wiki generator.

## Scope

This review covers:

- reusable schema contracts under `contracts/schemas/`
- checker implementation under `llm_wiki_tools/`
- scenario fixtures under `tests/fixtures/phase6/`
- the Person A handoff from Person B workflow closure

It does not cover raw binary parsing, MinerU execution, MCP adapter execution,
automatic source packet generation, automatic wiki generation, semantic truth
judgment, or downstream knowledge-to-`skill + tool` generation.

## Contract Shape

The contract layer intentionally stays small.

Current reusable schema families:

- source inventory
- source packet
- evidence record
- claim record
- wiki page
- wiki index
- compare report
- review item

No new schema family was added for this closure. That is deliberate: wiki
construction closure can be checked through the existing validation-note,
report, index, log, and source-packet surfaces. Adding a separate construction
schema now would create another artifact layer before real workspace pressure
proves it is needed.

## Implemented Checker Surface

Person A owns these runnable checks:

- `validate-kernel`
- `schema-check`
- `source-inventory-check`
- `source-packet-lint`
- `wiki-lint`
- `report-check`
- `round-closure-check`
- `fixture-runner`
- `workspace-check`

The checker surface is intentionally validation-only. It checks fields, paths,
enums, anchors, generated-field markers, links, reports, review routing, and
closure consistency. It does not write source packets or wiki pages.

## Closure Changes

This closure hardens two weak points from the Person B handoff.

### Source Packet Profile Validation

`source-packet-lint` now checks deterministic PDF/PPTX profile requirements:

- PPTX packets with complete or partial extraction must expose slide-level
  anchors such as `s001`.
- PDF packets with complete or partial extraction must expose page-level
  anchors such as `p001` or explicit known gaps.
- Generated content kinds such as `chart_summary`, `image_caption`, OCR text,
  visual descriptions, table repairs, and inferred reading order must be
  marked as generated and listed in `generated_fields`.
- Generated anchors without packet-level `generated_fields` are deterministic
  failures rather than soft review notes.

These checks validate packet outputs. They do not parse PPT/PDF files.

### Wiki Construction Closure Validation

`round-closure-check` now requires close-pass and close-with-review validation
notes to explicitly confirm:

- semantic draft reviewed
- grounding pass reviewed
- wiki construction analysis reviewed
- page routing decisions recorded
- page create/update/merge decisions recorded

This uses the existing validation-note template fields. It avoids adding a new
construction schema layer while still preventing a round from closing when wiki
prose was written without visible construction discipline.

## Fixture Evidence

New representative fixtures prove the intended behavior:

| Fixture | Tool | Expected result | Purpose |
| --- | --- | --- | --- |
| `source-packet-pptx-valid-pass` | `source-packet-lint` | pass | PPTX packet with slide anchors and marked generated chart interpretation |
| `source-packet-pptx-missing-slide-anchor-fail` | `source-packet-lint` | fail | PPTX packet without stable slide anchors |
| `source-packet-pptx-generated-unmarked-fail` | `source-packet-lint` | fail | generated visual interpretation hidden as ungenerated packet content |
| `source-packet-pdf-partial-review-pass` | `source-packet-lint` | pass | partial PDF packet with page anchor, known gap, and review routing |
| `round-closure-missing-construction-analysis-fail` | `round-closure-check` | fail | close-pass attempted without construction-analysis evidence |

The fixtures are packet and workspace artifacts, not raw extraction fixtures.
They represent what an external parser, agent, manual workflow, or optional
adapter would leave behind.

## Design Review

| Principle | Result |
| --- | --- |
| VSCode/Git-first | All contracts, fixtures, reports, and tools are repo-local files and Python CLI commands. |
| Agent-first | Checkers return status, exit code, failures, review findings, and next actions. |
| Minimal contracts | The closure reuses existing schema and validation-note surfaces instead of adding new layers. |
| Artifact economy | Source packet metadata owns extraction state; wiki pages do not repeat packet metadata; reports own gate decisions. |
| No harness | The system validates outputs from any extractor or manual process instead of owning PDF/PPT parsing. |
| No generator | Wiki construction remains human/LLM synthesis constrained by routing, grounding, reports, and closure checks. |
| Avoid self-evaluation | Pass/fail/needs-review outcomes depend on deterministic artifact evidence and explicit review routing. |

## Remaining Risks

- Markdown parsing is intentionally lightweight.
- Schema checking is field/vocabulary oriented, not a full JSON Schema engine.
- Fixture coverage is representative, not exhaustive.
- Claim truth still requires human or accepted review when semantics are
  judgment-heavy.
- Real PPT/PDF workspace pressure may reveal profile wording that Person B
  should clarify.

These are acceptable risks for the current Person A closure because the
requested layer is a compact validation substrate, not production extraction or
semantic automation.

## Closure Decision

Person A is closed for the current pre-Phase-7 system:

```text
contracts/schemas
-> llm_wiki_tools checkers
-> representative source/wiki/report fixtures
-> fixture-runner and workspace-check evidence
```

The next major line is not more Person A contract layering. It is either:

- use real workspace packets to add focused regression fixtures when failures
  appear, or
- start Phase 7 with a narrow downstream `skill + tool` target built from a
  checked wiki and reviewed claims.
