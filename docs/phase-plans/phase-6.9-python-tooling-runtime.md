# Phase 6.9 Python Tooling Runtime

Phase 6.9 migrates the implemented Phase 6 checker tools from PowerShell
scripts to a Python CLI runtime.

The supported entrypoint is:

```bash
python -m llm_wiki_tools <command>
```

No `.ps1` compatibility wrappers are preserved.

## Reason

PowerShell was useful for bootstrapping the checker layer on Windows. It is not
the right long-term implementation language for this workflow because the tool
layer needs:

- portable execution across Windows, macOS, Linux, and CI
- shared parsing and report helpers
- maintainable Markdown, JSON, YAML-like frontmatter, path, and fixture logic
- a future path toward richer tests without coupling to a shell runtime

Python is the default runtime because it gives the project a small,
cross-platform, agent-friendly implementation surface while keeping dependencies
optional.

## Scope

Phase 6.9 owns:

- `pyproject.toml`
- `llm_wiki_tools/`
- `llm_wiki_tools/README.md`
- Python CLI command dispatch
- Python implementations of the existing Phase 6 checker commands
- deletion of implemented `.ps1` tool scripts
- README and Phase 6 command documentation updates
- kernel validation that rejects legacy PowerShell tool implementations

Implemented commands:

- `validate-kernel`
- `schema-check`
- `source-inventory-check`
- `source-packet-lint`
- `wiki-lint`
- `report-check`
- `round-closure-check`
- `fixture-runner`
- `workspace-check`

## Non-Goals

Phase 6.9 does not:

- add an extractor harness
- parse raw PDF/PPTX/DOCX/image/table content
- run MinerU, OCR, VLM, MCP, LibreOffice, or Poppler
- generate source packets
- generate wiki pages
- resolve semantic review
- start downstream knowledge-to-`skill + tool` generation
- introduce mandatory third-party Python dependencies

## Command Surface

Examples:

```bash
python -m llm_wiki_tools validate-kernel

python -m llm_wiki_tools schema-check \
  --workspace . \
  --report schema-check-report.md

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode fixtures \
  --report workspace-fixtures-report.md
```

CLI options use lowercase long names such as `--workspace`, `--report`,
`--mode`, `--fixture-root`, `--reports-dir`, and `--wiki-dir`.

## Validation

Phase 6.9 is complete when:

- no standalone root-level `tools/` directory remains
- `python -m py_compile llm_wiki_tools/cli.py llm_wiki_tools/__main__.py`
  passes
- `python -m llm_wiki_tools validate-kernel` passes
- `python -m llm_wiki_tools schema-check --workspace . --report phase6-schema-check-smoke.md` passes
- `python -m llm_wiki_tools fixture-runner --fixture-root tests/fixtures/phase6 --report phase6-fixture-runner-smoke.md` passes
- `python -m llm_wiki_tools workspace-check --workspace . --mode fixtures --report phase6-workspace-fixtures-smoke.md` passes
- generated smoke reports are removed
- active command documentation no longer points to PowerShell scripts
