# LLM Wiki Tools

This package is the runnable checker layer for the LLM Awesome Wiki system.

Run commands from a system repo or an instantiated knowledge workspace with:

```bash
python -m llm_wiki_tools <command>
```

## Commands

| Command | Purpose |
| --- | --- |
| `validate-kernel` | Check that the system repo has the required kernel, rule, template, skill, schema, and tooling files. |
| `schema-check` | Validate reusable schema contracts and expected structured fields. |
| `source-inventory-check` | Check an existing `raw/source-inventory.md` for path, hash, status, and packet consistency. |
| `source-packet-lint` | Check existing source packet metadata, anchors, generated fields, gaps, and review routing. |
| `wiki-lint` | Check existing wiki frontmatter, links, index membership, overview sections, and log headings. |
| `report-check` | Check compare reports, claim/evidence maps, review queues, and validation notes. |
| `round-closure-check` | Check whether recorded round closure decisions are consistent with reports, review state, index, overview, and log. |
| `fixture-runner` | Run fixture scenarios and compare expected exit codes and report statuses. |
| `workspace-check` | Orchestrate checker families with `--mode smoke`, `schemas`, `source`, `wiki`, `reports`, `closure`, `fixtures`, or `all`. |

## Common Usage

```bash
python -m llm_wiki_tools validate-kernel

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode all \
  --report reports/workspace-check.md

python -m llm_wiki_tools source-packet-lint \
  --workspace . \
  --report reports/source-packet-lint.md

python -m llm_wiki_tools wiki-lint \
  --workspace . \
  --report reports/wiki-lint.md
```

## Reports And Exit Codes

Every checker writes a Markdown report and exits with:

- `0`: pass
- `1`: deterministic validation failure
- `2`: review required without deterministic failure
- `3`: configuration or runtime error

## Boundaries

These tools validate existing workspace artifacts. They do not run extractors,
parse raw PDF/PPTX/DOCX/image/table content, generate source packets, generate
wiki pages, decide semantic truth, or resolve human review.

Workflow semantics live in `rules/`. Historical implementation plans live in
`docs/phase-plans/`.
