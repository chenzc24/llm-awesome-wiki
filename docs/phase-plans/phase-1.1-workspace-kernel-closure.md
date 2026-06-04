# Phase 1.1 Workspace Kernel Closure

Phase 1.1 closes the first workspace-kernel loop. Phase 1 created the substrate:
rules, contracts, templates, tool skeletons, and a validator. Phase 1.1 makes
those parts consistent enough that a developer or agent can copy the kernel into
a new knowledge workspace and understand the first distillation round.

This phase still does not implement raw conversion, wiki generation, compare
gate automation, or downstream skill/tool generation.

## Current State

- Phase 0 system positioning is complete.
- Phase 1 substrate is committed and pushed.
- The system repository is still a producer of workspace kernels, not an active
  knowledge workspace.
- The copyable kernel exists, but its rules, templates, contracts, and
  acceptance language need to be tightened.

## Closed Workflow

The minimum workspace flow is:

```text
create workspace
-> configure purpose.md and schema.md
-> add raw sources
-> create source inventory
-> create source packets
-> run a wiki distillation round
-> create compare/lint reports
-> update logs
-> commit accepted changes
```

Each step should have visible inputs, outputs, forbidden shortcuts, and a
recorded validation result.

## Completion Standard

Phase 1.1 is complete when:

- `rules/` describes the first round as an executable protocol.
- `templates/workspace-kernel/` contains enough local files for a copied
  workspace to start without guessing where plans, reports, raw inputs, derived
  packets, or wiki pages belong.
- `contracts/schemas/` has minimum fields that support the rules.
- the validator checks the expanded kernel structure.
- top-level docs clearly say Phase 2 has not started.

## Why Not Phase 2 Yet

Phase 2 is the raw-resource-to-source-packet protocol layer. Starting it before
the kernel is closed would risk building tools whose outputs are not yet
governed by clear workspace rules. Phase 1.1 keeps the next implementation step
smaller: make the workflow contract clear before writing converters or extractor
harnesses.

## Non-Goals

- Do not create root-level active `raw/`, `wiki/`, or `reports/`.
- Do not implement raw file parsers.
- Do not implement compare gate automation.
- Do not implement scenario test runners.
- Do not create domain skills or downstream tools.
