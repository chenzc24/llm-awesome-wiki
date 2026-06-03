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

## Status Semantics

- `pass`: deterministic checks passed and no blocking review item remains.
- `needs-review`: deterministic checks passed or partially passed, but human
  judgment is required before advancing.
- `fail`: required files, source coverage, claim coverage, index integrity, or
  link integrity are broken.

## Acceptance Rule

A distillation round may advance only when deterministic checks pass and human
review items are either resolved or explicitly carried forward.

Carried-forward review items must appear in the report with a reason and an
owner or next action. They are not silently cleared.

## Anti-Self-Evaluation Rule

The agent may summarize compare findings, but it must not be the only judge of
coverage quality. Prefer deterministic checks, source-to-claim tables, explicit
missing coverage lists, and human review queues.

## Non-Goals

- Do not generate domain skills or tools.
- Do not silently rewrite wiki pages.
- Do not delete claims without recording the source and reason.

## Minimum Checks

- source inventory exists or the report records why it is not yet available
- all processed source packets are represented in wiki source pages or listed
  as omitted
- every sourced wiki claim has a source identity or review item
- `wiki/index.md` resolves all normal page links
- report status is one of `pass`, `fail`, or `needs-review`
