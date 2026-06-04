# Workspace Check

`workspace-check` is the Phase 6 checker orchestrator surface.

It validates workspace artifacts by running selected checker families. Since
Phase 6.9, the supported runtime is the Python CLI.

## Purpose

Answer:

```text
Can this workspace be checked by the Phase 6 validation tooling runtime?
```

Later Phase 6 subphases will add checks for schemas, source inventory, source
packets, wiki pages, compare reports, review queues, validation notes, round
closure, and fixtures.

## Command

```bash
python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode smoke \
  --report reports-validation-smoke.md
```

## Inputs

- `--workspace`: path to the workspace or system repository being checked
- `--mode`: `smoke`, `all`, `schemas`, `source`, `wiki`, `reports`, `closure`,
  or `fixtures`
- `--report`: Markdown report path

## Outputs

- Markdown report with tool metadata, status, exit code, checks run, checks not
  implemented, findings, and next actions
- process exit code following `tools/shared/report-conventions.md`

## Phase 6.1 Behavior

The skeleton checks:

- workspace path exists
- report path can be written
- mode is recognized

The skeleton reports future validators as `not-implemented`.

## Phase 6.2 Behavior

`--mode schemas` invokes the `schema-check` command.

It validates reusable schema contract files and writes a `schema-check` report
next to the workspace-check report. It does not validate actual workspace
artifact instances.

## Phase 6.3 Behavior

`--mode source` invokes:

- `source-inventory-check`
- `source-packet-lint`

It validates source inventory rows and existing source packet outputs. It does
not create packets, run extractors, parse raw document content, or generate wiki
pages.

In Phase 6.3, `--mode all` began running schema and source checks before
reporting later validator families as `not-implemented`.

## Phase 6.4 Behavior

`--mode wiki` invokes the `wiki-lint` command.

It validates existing wiki frontmatter, links, index membership, overview
sections, and log maintenance headings. It does not generate pages or rewrite
links.

In Phase 6.4, `--mode all` began running schema, source, and wiki checks before
reporting later validator families as `not-implemented`.

## Phase 6.5 Behavior

`--mode reports` invokes the `report-check` command.

It validates compare reports, claim/evidence maps, review queues, and
validation notes. It does not extract claims, decide semantic truth, rewrite
reports, or close rounds.

In Phase 6.5, `--mode all` began running schema, source, wiki, and report
checks before reporting round closure and fixture validation as
`not-implemented`.

## Phase 6.6 Behavior

`--mode closure` invokes the `round-closure-check` command.

It validates recorded closure decisions across validation notes, compare/review
state, index, overview, and wiki log. It does not close rounds or resolve
review.

In Phase 6.6, `--mode all` began running schema, source, wiki, report, and
closure checks before reporting fixture validation as `not-implemented`.

## Phase 6.7 Behavior

`--mode fixtures` invokes the `fixture-runner` command.

It runs small scenario workspaces and checks expected exit codes and report
statuses. It does not run extractors or resolve semantic review.

`--mode all` currently runs schema, source, wiki, report, closure, and fixture
checks.

## Non-Goals

`workspace-check` does not:

- run extractors
- parse PDF/PPTX/DOCX/image/table files
- run OCR or VLM captioning
- generate source packets
- generate wiki pages
- resolve semantic review
- silently rewrite workspace artifacts

## Exit Codes

- `0`: skeleton smoke run completed
- `1`: deterministic validation failure
- `2`: review required without deterministic failure
- `3`: configuration or runtime error
