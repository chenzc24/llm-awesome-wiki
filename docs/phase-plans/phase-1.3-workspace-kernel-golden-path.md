# Phase 1.3 Workspace Kernel Golden Path

Phase 1.3 closes the gap between "the workspace kernel has directories and
rules" and "a developer can manually complete the first document/PPT
distillation round."

The goal is not automation. The goal is a clear, copyable, repo-local path that
works in VSCode, Git, CLI, and Agent workflows.

## Status Before Phase 1.3

Phase 1 created the kernel substrate. Phase 1.1 aligned rules, templates,
contracts, and validation. Phase 1.2 corrected the default profile so the
kernel serves document and PPT corpora before optional research-wiki page
types.

What remains is first-use clarity. A new workspace owner should not have to
infer the shape of the first round from abstract rules alone.

## Golden Path

The first manual round should follow this path:

```text
copy workspace kernel
-> configure purpose.md and schema.md
-> create a first-round plan
-> add raw sources
-> write source inventory
-> write source packet
-> create overview and index skeleton
-> create source and chapter pages
-> record validation note
-> update logs
-> commit
```

For Phase 1.3, compare gate remains visible but not implemented. The first
round may record `compare gate not enabled` in its validation note instead of
pretending a compare result exists.

## Deliverables

- workspace-kernel first-use README
- first-round plan template
- source inventory template
- source packet template
- overview, source page, and chapter page templates
- first-round validation-note template
- validator checks for the golden-path files

## Non-Goals

- no raw converter
- no source inventory CLI
- no wiki generator
- no compare gate implementation
- no downstream skill/tool generation
- no active root-level `raw/`, `wiki/`, `reports/`, or `schema.md`

## Completion Criteria

- a copied workspace kernel has enough templates to start a first manual round
- the first round can preserve document/PPT source and chapter structure
- compare is represented as an explicit deferred check, not as a fake pass
- `python -m llm_wiki_tools validate-kernel` checks the golden-path files
- root repository validation stays clean
