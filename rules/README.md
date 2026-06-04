# Rules

This directory contains operational rules for generated knowledge workspaces.
It is organized for progressive disclosure: start from the default path, then
open specialized modules only when the round needs them.

These files are human/agent-facing workflow protocols, not machine-readable
schemas. Machine-readable contracts live under `contracts/schemas/` and
validator code.

Files named `*-contract.md` in this directory are operational rules unless
they live under `contracts/schemas/**` or validator-owned paths.

## Directory Map

```text
rules/
  workflow/  default round sequence and closure decisions
  source/    optional extraction handoff, source-type profiles, generated data
  wiki/      wiki surface and source-to-wiki coverage
  claims/    evidence, claims, modality, support, contradiction review
  review/    review queue lifecycle
```

## Default Golden Path

A normal document/PPT distillation round should start with these six
entrypoints:

1. `rules/workflow/maintenance-workflow.md`: plan, edit, validate, log,
   commit, and push.
2. `rules/workflow/distillation-rounds.md`: keep the round scoped, staged,
   and reviewable.
3. `rules/workflow/raw-to-source-packet.md`: turn raw sources into auditable
   source packets.
4. `rules/workflow/source-packet-to-wiki.md`: move from packets to wiki construction
   analysis and accepted wiki updates.
5. `rules/workflow/compare-gate-contract.md`: record source/wiki, claim,
   modality, review, and navigation findings before advancement.
6. `rules/workflow/round-closure-workflow.md`: decide `close-pass`,
   `close-with-review`, or `do-not-close`.

This path is enough for the first pass through most document/PPT workspaces.
It preserves source/chapter readability without forcing every source into a
research graph.

## When To Read More

Open these modules only when the round needs the extra detail:

| Need | Rule |
| --- | --- |
| Use manual, Agent/MCP, MinerU, Poppler, LibreOffice, or custom extraction output | `rules/source/extractor-adapter-protocol.md` |
| Check PDF, PPTX, DOCX, image, table, dataset, or mixed-media packet shape | `rules/source/source-type-packet-profiles.md` |
| Mark OCR, captions, chart summaries, table repairs, formula recognition, or inferred structure | `rules/source/generated-fields-review-routing.md` |
| Select evidence, extract important claims, or route claim uncertainty | `rules/claims/evidence-claim-workflow.md` |
| Decide page destination, index behavior, overview refresh, or wiki log update | `rules/wiki/wiki-surface-workflow.md` |
| Explain source-to-wiki coverage, omissions, deferrals, and anchor disposition | `rules/wiki/source-wiki-coverage-protocol.md` |
| Review claim support, generated evidence, modality state, unsupported statements, or contradictions | `rules/claims/claim-modality-contradiction-review-protocol.md` |
| Manage review item lifecycle, blocking level, carry-forward, stale review, or dismissal | `rules/review/review-queue-workflow.md` |

## Semantic Ownership

Each workflow concept should have one owner file. Other rules may reference
the concept, but should not redefine the full table or lifecycle.

| Concept | Owner |
| --- | --- |
| workspace planning, logs, commits, validation discipline | `rules/workflow/maintenance-workflow.md` |
| round sequencing, overview-first initialization, staged work packages | `rules/workflow/distillation-rounds.md` |
| source identity, inventory status, packet metadata, extraction status, anchors | `rules/workflow/raw-to-source-packet.md` |
| optional extractor/backend handoff shape | `rules/source/extractor-adapter-protocol.md` |
| source-type packet minimum profiles | `rules/source/source-type-packet-profiles.md` |
| generated field kinds, trust levels, and packet review routing | `rules/source/generated-fields-review-routing.md` |
| evidence selection, claim extraction, claim review routing | `rules/claims/evidence-claim-workflow.md` |
| packet-to-wiki action flow | `rules/workflow/source-packet-to-wiki.md` |
| wiki routing, source/chapter surface, index, overview, and wiki log | `rules/wiki/wiki-surface-workflow.md` |
| compare report decision surface and `pass`/`fail`/`needs-review` semantics | `rules/workflow/compare-gate-contract.md` |
| source/wiki coverage units, dispositions, importance, omission reasons | `rules/wiki/source-wiki-coverage-protocol.md` |
| claim support, generated-evidence, modality, unsupported statement, contradiction semantics | `rules/claims/claim-modality-contradiction-review-protocol.md` |
| review item lifecycle and blocking levels | `rules/review/review-queue-workflow.md` |
| round closure decisions and advancement | `rules/workflow/round-closure-workflow.md` |
