# Compare Gate Contract

The compare gate checks whether distilled wiki knowledge still covers the
source material and claim records. It is a construction quality gate, not a
downstream skill/tool generator.

## Gate Inputs

- source inventory
- source packets
- claim and evidence records when available
- current wiki pages
- `wiki/index.md`
- current review queue

## Gate Outputs

The gate writes a report under `reports/compare/` or the workspace's configured
report directory. The report should include:

- source coverage
- source packet validity
- claim-to-source coverage
- omitted or weakly covered source sections
- broken or stale wiki links
- contradictory or unsupported claims
- unresolved review items
- pass, fail, or needs-review status

## Acceptance Rule

A distillation round may advance only when deterministic checks pass and human
review items are either resolved or explicitly carried forward.

## Anti-Self-Evaluation Rule

The agent may summarize compare findings, but it must not be the only judge of
coverage quality. Prefer deterministic checks, source-to-claim tables, explicit
missing coverage lists, and human review queues.

## Non-Goals

- Do not generate domain skills or tools.
- Do not silently rewrite wiki pages.
- Do not delete claims without recording the source and reason.
