# Rules

This directory contains detailed reference rules for generated knowledge
workspaces.

The runtime entrypoints are the Agent skills under `skills/**`. A normal agent
should start from one active skill, work against the current workspace
artifacts, and open these rules only when the skill names a specific
progressive-disclosure trigger.

These files are human/agent-facing reference protocols, not machine-readable
schemas. Machine-readable contracts live under `contracts/schemas/` and
validator code.

## Directory Map

```text
rules/
  source/  optional extraction handoff, source-type profiles, generated data
  wiki/    wiki surface, semantic grounding, and source-to-wiki coverage
  claims/  evidence, claims, modality, support, contradiction review
  review/  review queue lifecycle
```

Workflow runtime now lives in:

```text
skills/llm-wiki-distill/SKILL.md
skills/llm-wiki-source-packet/SKILL.md
skills/llm-wiki-wiki-round/SKILL.md
skills/llm-wiki-quality-gate/SKILL.md
```

## When To Read Rules

Open these modules only when the active skill needs the extra detail:

| Need | Rule |
| --- | --- |
| Use manual, Agent/MCP, MinerU, Poppler, LibreOffice, or custom extraction output | `rules/source/extractor-adapter-protocol.md` |
| Check PDF, PPTX, DOCX, image, table, dataset, or mixed-media packet shape | `rules/source/source-type-packet-profiles.md` |
| Mark OCR, captions, chart summaries, table repairs, formula recognition, or inferred structure | `rules/source/generated-fields-review-routing.md` |
| Decide page destination, index behavior, overview refresh, or wiki log update | `rules/wiki/wiki-surface-workflow.md` |
| Explain source-to-wiki coverage, semantic richness, grounding, omissions, deferrals, and anchor disposition | `rules/wiki/source-wiki-coverage-protocol.md` |
| Select evidence, extract important claims, or route claim uncertainty | `rules/claims/evidence-claim-workflow.md` |
| Review claim support, generated evidence, modality state, unsupported statements, or contradictions | `rules/claims/claim-modality-contradiction-review-protocol.md` |
| Manage review item lifecycle, blocking level, carry-forward, stale review, or dismissal | `rules/review/review-queue-workflow.md` |

Do not load every rule for a normal round. The intended loading order is:

```text
active SKILL.md
-> active workspace artifacts
-> one detailed rule only when needed
-> validators/checkers for evidence
```

## Semantic Ownership

Each concept should have one owner. Skills own workflow runtime. Detailed rules
own specialized reference semantics. Schemas and validators own
machine-checkable contracts.

| Concept | Owner |
| --- | --- |
| end-to-end round runtime, planning, staged work, log, commit, push | `skills/llm-wiki-distill/SKILL.md` |
| source packet runtime, inventory, metadata, anchors, gaps, packet review | `skills/llm-wiki-source-packet/SKILL.md` |
| optional extractor/backend handoff shape | `rules/source/extractor-adapter-protocol.md` |
| source-type packet minimum profiles | `rules/source/source-type-packet-profiles.md` |
| generated field kinds, trust levels, and packet review routing | `rules/source/generated-fields-review-routing.md` |
| wiki construction runtime, semantic draft, grounding pass, construction analysis, source/chapter updates | `skills/llm-wiki-wiki-round/SKILL.md` |
| wiki routing, source/chapter surface, index, overview, and wiki log edge cases | `rules/wiki/wiki-surface-workflow.md` |
| source/wiki coverage units, semantic richness, grounding states, dispositions, importance, omission reasons | `rules/wiki/source-wiki-coverage-protocol.md` |
| evidence selection, claim extraction, claim review routing | `rules/claims/evidence-claim-workflow.md` |
| claim support, generated-evidence, modality, unsupported statement, contradiction semantics | `rules/claims/claim-modality-contradiction-review-protocol.md` |
| compare, validation, review, and closure runtime | `skills/llm-wiki-quality-gate/SKILL.md` |
| review item lifecycle and blocking levels | `rules/review/review-queue-workflow.md` |
| machine-readable field shapes and enum validation | `contracts/schemas/**` and `llm_wiki_tools/**` |

Other files may reference an owner, but should not copy the full lifecycle or
status table.
