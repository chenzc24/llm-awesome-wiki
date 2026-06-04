# Tools

This directory is reserved for repo-local tooling. The first tool layer belongs
to knowledge-base construction: maintenance, lint, search, compare gates,
source inventory checks, and claim audit. These are validation/checker tools,
not the later downstream domain `skill + tool` codebase.

Phase 1 and Phase 1.1 provide skeletons and one workspace-kernel validator.
They do not implement the full raw conversion, wiki lint, compare, or claim
audit toolchain.

## Planned Tool Families

- `validate-kernel`: verify that this system repo contains a reusable kernel
  rather than live workspace output.
- `workspace-check`: Phase 6 checker orchestrator skeleton for validating
  workspace artifacts and emitting summary reports.
- `shared`: shared report and exit-code conventions for Phase 6 checker tools.
- `schema-check`: validate reusable schema contracts and stable structured
  field/enumeration vocabulary.
- `source-inventory`: scan raw sources, record path/hash/type/status, and
  identify unprocessed or changed material.
- `source-packet-convert`: Phase 2 behavior spec for planning or checking
  adapter handoff outputs; not a Phase 6 default harness implementation.
- `source-packet-lint`: check packet metadata, anchors, generated fields, known
  gaps, review routing, and source-type expectations.
- `wiki-lint`: check frontmatter, broken links, orphan pages, missing index
  entries, and required maintenance files.
- `compare-gate`: compare raw source inventory against distilled wiki
  pages and report missing coverage.
- `claim-audit`: map important wiki claims to source references and flag
  unsupported claims.
- `search-index`: provide CLI-friendly keyword or hybrid search over raw and
  distilled content.
- `todo-sync`: consolidate compare, lint, and review outputs into actionable
  plan or todo files.
- `scaffold-workspace`: future copy/sync helper for workspace kernels.

## Phase 2 Tool Surface

The Phase 2 tool-surface trio is:

```text
source-inventory
-> source-packet-convert
-> source-packet-lint
```

These tool specs define behavior only. They do not implement commands, run
extractors, update schemas, or create fixtures.

After the Phase 6 rebaseline, `source-packet-convert` should be treated as an
adapter-handoff planning/checking spec, not as the default Phase 6
implementation target. Phase 6 should validate source packet outputs rather
than owning extractor execution.

## Phase 6 Tool Surface

Phase 6 should prioritize checker tools:

```text
workspace-check
-> source-inventory-check
-> source-packet-check
-> wiki-lint
-> claim-audit
-> compare-report-check
-> review-queue-check
-> round-closure-check
-> fixture-runner
```

These tools inspect workspace artifacts and emit validation reports. They are
not a PDF/PPTX/DOCX parser harness, MinerU wrapper, OCR/VLM runner, or MCP
extractor wrapper.

Phase 6.1 originally introduced the runtime skeleton. After Phase 6.9, the
supported implementation is the Python CLI:

```bash
python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode smoke \
  --report reports-validation-smoke.md
```

Business validators are intentionally reported as `not-implemented` until later
Phase 6 subphases add them.

Phase 6.2 adds:

```bash
python -m llm_wiki_tools schema-check \
  --workspace . \
  --report schema-check-report.md

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode schemas \
  --report workspace-schema-check-report.md
```

`schema-check` validates reusable schema contracts only. It is not a full JSON
Schema engine and does not validate workspace artifact instances.

Phase 6.3 adds source artifact checks:

```bash
python -m llm_wiki_tools source-inventory-check \
  --workspace . \
  --report source-inventory-check-report.md

python -m llm_wiki_tools source-packet-lint \
  --workspace . \
  --report source-packet-lint-report.md

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode source \
  --report workspace-source-check-report.md
```

These checks inspect source inventory rows and source packet outputs. They do
not create inventory rows, generate packets, parse raw binary sources, or run
extractor backends.

Phase 6.4 adds wiki lint:

```bash
python -m llm_wiki_tools wiki-lint \
  --workspace . \
  --report wiki-lint-report.md

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode wiki \
  --report workspace-wiki-lint-report.md
```

`wiki-lint` validates existing wiki frontmatter, links, index membership,
overview sections, and log maintenance headings. It does not generate pages or
rewrite links.

Phase 6.5 adds report surface checks:

```bash
python -m llm_wiki_tools report-check \
  --workspace . \
  --report report-check-report.md

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode reports \
  --report workspace-report-check-report.md
```

`report-check` validates compare reports, claim/evidence maps, review queues,
and validation notes. It does not extract claims, decide semantic truth, rewrite
reports, or close rounds.

Phase 6.6 adds round closure checks:

```bash
python -m llm_wiki_tools round-closure-check \
  --workspace . \
  --report round-closure-check-report.md

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode closure \
  --report workspace-closure-check-report.md
```

`round-closure-check` validates recorded closure decisions across validation
notes, compare/review state, index, overview, and wiki log. It does not close
rounds or resolve review.

Phase 6.7 adds scenario fixtures:

```bash
python -m llm_wiki_tools fixture-runner \
  --fixture-root tests/fixtures/phase6 \
  --report fixture-runner-report.md

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode fixtures \
  --report workspace-fixtures-report.md
```

`fixture-runner` copies small scenario workspaces to a temp directory and checks
that tools return expected status and exit codes. It does not run extractors or
resolve semantic review.

Phase 6 closure uses these system-repo validation commands:

```bash
python -m llm_wiki_tools validate-kernel

python -m llm_wiki_tools schema-check \
  --workspace . \
  --report phase6-schema-check-smoke.md

python -m llm_wiki_tools fixture-runner \
  --fixture-root tests/fixtures/phase6 \
  --report phase6-fixture-runner-smoke.md

python -m llm_wiki_tools workspace-check \
  --workspace . \
  --mode fixtures \
  --report phase6-workspace-fixtures-smoke.md
```

`workspace-check --mode all` is for an instantiated knowledge workspace with
live `raw/`, `wiki/`, `reports/`, and source packet outputs. The system repo
intentionally lacks those live workspace artifacts, so Phase 6 closure validates
the system repo with kernel/schema checks and fixture workspaces.

## Phase 3 Tool Surface

Phase 3 adds behavior prose for:

```text
claim-audit
```

This tool surface checks whether important claims are supported by evidence
references, whether generated-evidence claims need review, and whether
unsupported or contested claims remain visible. It does not implement the tool
or generate wiki pages.

## Tool Principles

- Tools should run from the repository root.
- Outputs should be deterministic where possible.
- Tools should write explicit reports rather than silently changing wiki pages.
- Tools should validate source packet outputs rather than owning extractor
  internals.
- Any tool that mutates tracked files must be called from a planned target and
  recorded in `plan/log.md`.
- Tools should support VSCode and CLI workflows without requiring Obsidian.
