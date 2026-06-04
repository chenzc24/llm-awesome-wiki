---
name: llm-wiki-distill
description: End-to-end runtime skill for LLM Awesome Wiki distillation. Use when an agent needs to plan or run a bounded workflow from raw source material through source packets, wiki construction, compare/review, validation, closure, and commit. This skill routes to narrower subskills only when a stage needs deeper execution detail.
---

# LLM Wiki Distill

## Role

Use this as the main runtime entrypoint for an end-to-end knowledge workspace
distillation round.

This skill owns the normal execution sequence. Detailed `rules/**` files are
reference material for artifact contracts, edge cases, and disputed decisions.
Do not load the full rules directory by default.

Do not use `docs/` as the operational workflow entrypoint. `docs/` are
maintenance and design records for this system repository.

## Preflight

1. Run `git status --short --branch`.
2. Read `AGENTS.md`, `purpose.md`, and `schema.md` when they exist in the
   active workspace.
3. Create or update the target plan before editing tracked files. The plan
   must name the goal, fixed input set, expected outputs, validation, review
   state, and commit intent.
4. Identify whether this is source intake, wiki construction, quality gate, or
   a multi-stage end-to-end round.

If the workspace is new, do an overview-first initialization before detailed
wiki writing. Create or update `wiki/overview.md`, a skeleton `wiki/index.md`,
and a staged distillation plan.

## Runtime

For a normal document or PPT corpus round:

```text
preflight and plan
-> fixed input set
-> source inventory
-> source packet
-> optional evidence/claim map for important claims
-> wiki construction analysis
-> source/chapter wiki updates
-> compare/review/validation
-> closure decision
-> log, commit, push
```

Keep the round bounded. Do not process a large corpus in one pass unless the
plan explicitly says the workspace is small enough.

Do not mix generated knowledge updates with system-rule or template edits in
the same workspace commit unless the plan explicitly selects that scope.

## Route Deeper

Load the smallest subskill set needed:

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

## Outputs

An accepted end-to-end round should leave:

- target plan or updated staged plan
- source inventory and source packet updates when raw sources were in scope
- wiki construction analysis when wiki pages changed
- accepted source/chapter wiki updates
- compare or validation report
- review queue updates when judgment remains unresolved
- closure decision
- workspace log entry and commit

The default wiki surface is source/chapter oriented. Do not create research
object pages or downstream skills/tools unless the plan explicitly selects that
scope.

## Progressive Disclosure

Open detailed `rules/**` only when the active subskill says the round needs
extra detail. Typical triggers are complex source types, generated visual or
OCR content, important claim support, modality conflicts, review queue
lifecycle, or failed validation.

`rules/README.md` is a reference index, not the default runtime path.

## Validation

Run the available checks that match the touched artifacts. Prefer:

```text
python -m llm_wiki_tools workspace-check --workspace . --mode all
```

If a checker is unavailable, record that state in the validation note. Missing
checker support is not a pass.

Before commit:

1. Review the intended diff.
2. Update the workspace log.
3. Commit only accepted `close-pass` or explicitly allowed
   `close-with-review` state.
4. Push to the configured branch when the workspace rules require it.
