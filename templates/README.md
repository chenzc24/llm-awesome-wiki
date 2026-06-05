# Templates

This directory is reserved for reusable workflow templates. Phase 1 introduced
`workspace-kernel/`, the copy-first workspace skeleton for new knowledge
workspace repositories.

The skeleton is not the complete runtime bundle by itself. A complete workspace
kernel bundle also includes copied or synchronized `skills/`, `rules/`,
`contracts/schemas/`, and checker access from the system repo. See
`templates/workspace-kernel/KERNEL-MANIFEST.md`.

## Planned Template Families

- workspace skeletons and kernel bundle manifests for new distilled knowledge
  bases
- Agent prompt and instruction templates
- distillation round plan templates
- compare gate report templates
- executable spec templates
- test plan templates
- experiment protocol templates
- code generation review templates

## Template Principles

- Templates should be portable across repositories.
- Templates should make source traceability explicit.
- Templates should separate human-facing explanation from agent-facing rules.
- Templates should lead toward executable artifacts when appropriate.
- Templates should avoid Obsidian-only conventions as requirements.
- Templates may contain `raw/`, `wiki/`, and `reports/` because they are copied
  into generated workspaces; those directories should not exist as active root
  outputs in the system repository.
