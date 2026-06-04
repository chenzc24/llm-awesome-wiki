---
name: llm-wiki-distill
description: End-to-end routing skill for LLM Awesome Wiki distillation. Use when an agent needs to run or plan the full workflow from raw source material through source packets, wiki construction, compare/review, validation, closure, and commit. This skill routes to the source-packet, wiki-round, and quality-gate subskills and treats rules as the semantic source of truth.
---

# LLM Wiki Distill

## Role

Use this as the main Agent entrypoint for an end-to-end knowledge workspace
distillation round.

This skill is a router. It does not redefine workflow semantics. Read
`rules/README.md` first, then open the subskill for the active stage.

Do not use `docs/` as the operational workflow entrypoint. `docs/` are
maintenance and design records for this system repository.

## Required Preflight

1. Run `git status --short --branch`.
2. Read `AGENTS.md`, `purpose.md`, `schema.md`, and `rules/README.md` when
   they exist in the active workspace.
3. Create or update the target plan before editing tracked files.
4. Identify the active stage:
   - source intake or packet work
   - wiki construction round
   - compare, review, validation, or closure
   - multi-stage end-to-end round

## Route

Use the smallest subskill set needed:

- Source intake, source inventory, source packet, adapter handoff, source-type
  packet profile, or generated-field review:
  `skills/llm-wiki-source-packet/SKILL.md`
- Source packet to wiki construction, construction analysis, source/chapter
  pages, overview, index, or wiki log:
  `skills/llm-wiki-wiki-round/SKILL.md`
- Compare report, review queue, source/wiki coverage, claim audit, validation
  note, or round closure:
  `skills/llm-wiki-quality-gate/SKILL.md`

Do not route every task through every subskill. Load the subskill only when its
stage is active.

## End-To-End Sequence

For a normal document/PPT corpus round:

```text
preflight and plan
-> source inventory
-> source packet
-> optional evidence/claim map
-> wiki construction analysis
-> source/chapter wiki updates
-> compare/review/validation
-> closure decision
-> log, commit, push
```

The default wiki surface is source/chapter oriented. Do not create research
object pages or downstream skills/tools unless the plan explicitly selects that
scope.

## Validation

Run the available checks that match the touched artifacts. Prefer:

```text
python -m llm_wiki_tools workspace-check --workspace . --mode all
```

If a checker is unavailable, record that state in the validation note. Missing
checker support is not a pass.
