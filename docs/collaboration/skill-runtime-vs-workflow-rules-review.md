# Skill Runtime Vs Workflow Rules Review

## Review Goal

This review closes the migration from `rules/workflow/**` as the runtime
entrypoint to `skills/**` as the runtime entrypoint.

The design decision is:

```text
skills/ = workflow guidance, runtime cards, and progressive disclosure
rules/  = detailed reference rules, artifact contracts, and edge-case semantics
tools/  = executable checks
docs/   = design records and collaboration decisions
```

`rules/workflow/**` was kept unchanged long enough to compare it against the
new skill runtime. The review below records whether each workflow rule has a
safe replacement before Stage 3 deletion.

## Review Method

Each workflow rule was checked for:

- runtime sequence
- active-stage inputs
- required outputs
- forbidden shortcuts
- acceptance or closure checks
- progressive-disclosure handoff to detailed rules
- contract material that should survive outside `rules/workflow/**`

## Summary Decision

The workflow runtime is now covered by the four skill entrypoints:

- `skills/llm-wiki-distill/SKILL.md`
- `skills/llm-wiki-source-packet/SKILL.md`
- `skills/llm-wiki-wiki-round/SKILL.md`
- `skills/llm-wiki-quality-gate/SKILL.md`

The remaining durable contracts are already covered by existing detailed
rules, schemas, and checker behavior:

- source packet structure: `contracts/schemas/source-packet.schema.json`,
  `contracts/schemas/source-inventory.schema.json`, source packet checker
  behavior in `llm_wiki_tools`
- source type, optional adapter, generated data: `rules/source/**`
- wiki surface and coverage: `rules/wiki/**`
- claim/evidence and modality review: `rules/claims/**`
- review queue lifecycle: `rules/review/**`
- compare and closure status values: `contracts/schemas/compare-report.schema.json`
  and `llm_wiki_tools` report/closure checkers, with runtime guidance in
  `skills/llm-wiki-quality-gate/SKILL.md`

Therefore `rules/workflow/**` no longer needs to remain as current runtime
entrypoints.

## File-By-File Parity

| Workflow rule | Replacement | Review result |
| --- | --- | --- |
| `rules/workflow/maintenance-workflow.md` | `AGENTS.md` for repository discipline; `skills/llm-wiki-distill/SKILL.md` for workspace runtime preflight, plan, validation, log, commit, and push | Covered. Its content is execution discipline, not a detailed rule contract. |
| `rules/workflow/distillation-rounds.md` | `skills/llm-wiki-distill/SKILL.md` for overview-first initialization, bounded rounds, fixed inputs, staged plans, and end-to-end sequence | Covered. Historical planning records remain in `docs/phase-plans/**`; runtime belongs in the skill. |
| `rules/workflow/raw-to-source-packet.md` | `skills/llm-wiki-source-packet/SKILL.md` for runtime; `contracts/schemas/source-inventory.schema.json`, `contracts/schemas/source-packet.schema.json`, `rules/source/**`, and source checkers for detailed shape and validation | Covered. Source identity, metadata, anchors, generated fields, gaps, and review routing remain represented in runtime plus schema/tool checks. |
| `rules/workflow/source-packet-to-wiki.md` | `skills/llm-wiki-wiki-round/SKILL.md`; `rules/wiki/wiki-surface-workflow.md`; `rules/claims/evidence-claim-workflow.md` when important claims are in scope | Covered. Routing, construction analysis, page output, index/overview/log handoff, and no raw-to-wiki shortcut are covered. |
| `rules/workflow/compare-gate-contract.md` | `skills/llm-wiki-quality-gate/SKILL.md`; `contracts/schemas/compare-report.schema.json`; report checker behavior; `rules/wiki/source-wiki-coverage-protocol.md`; `rules/claims/claim-modality-contradiction-review-protocol.md`; `rules/review/review-queue-workflow.md` | Covered. Runtime status semantics are in the skill; detailed coverage, claim, modality, and review semantics stay in reference rules and validators. |
| `rules/workflow/round-closure-workflow.md` | `skills/llm-wiki-quality-gate/SKILL.md`; closure checker behavior in `llm_wiki_tools`; review queue rule for carried-forward review | Covered. Closure decisions are quality-gate runtime and do not need a separate workflow rule entrypoint. |

## Progressive Disclosure Check

The new skills use this loading order:

```text
active SKILL.md
-> active workspace artifacts
-> detailed rules only when a named trigger appears
-> tools/checkers for validation evidence
```

This replaces the previous loading order:

```text
rules/README.md
-> rules/workflow/*.md
-> specialized rules
-> tools/checkers
```

The new order reduces default context and keeps workflow guidance in one place.

## Stage 3 Decision

Stage 3 should remove `rules/workflow/**` as current-facing files and update
current references to point at skills or detailed non-workflow rules.

Do not remove historical references from plans or logs. They are records of the
repository state at the time those tasks were performed.

Do not move workflow prose into `docs/`; docs are design records, not runtime
entrypoints.

## Residual Risk

The main risk is that an older external workspace may still reference
`rules/workflow/**`. This repository now treats skills as the canonical runtime,
so future workspace-kernel sync or migration notes should instruct users to
start from `skills/llm-wiki-distill/SKILL.md` and the active subskill.

This does not change schemas or checker behavior.
