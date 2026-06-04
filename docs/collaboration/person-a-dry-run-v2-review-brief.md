# Person A Dry-Run V2 Review Brief

This brief hands Person A a current-system dry-run target:

```text
workspace/local/adctoolbox-ch1-dry-run-v2
```

The workspace uses the same historical ADCtoolbox `ch1.pdf` material as the
older `adctoolbox-ch1-dry-run`, but it follows the current default design:
source/chapter-oriented wiki pages, explicit construction analysis, validation
note, and no default research-profile directories.

## Why V2 Exists

The older dry run is useful as history, but it reflects an earlier structure
that included many optional wiki directories:

```text
concepts/
entities/
comparisons/
queries/
synthesis/
```

The current system direction is lighter for large PPT/PDF corpora:

```text
raw/sources/
raw/derived/<source-id>/
wiki/sources/
wiki/chapters/
wiki/overview.md
wiki/index.md
wiki/log.md
reports/
plan/
```

Person A should use v2 to check whether the machine-readable contracts and
validators can enforce this lighter default without redesigning Person B's
workflow prose.

The local v2 workspace includes a copied `contracts/schemas/**` directory so
`python -m llm_wiki_tools workspace-check --mode all` can run as it would inside
an instantiated knowledge workspace.

## What Person A Should Review

### Source Inventory And Packet

- `raw/source-inventory.md`
- `raw/derived/adctoolbox-ch1/metadata.json`
- `raw/derived/adctoolbox-ch1/source.md`

Review questions:

- Are the required fields for a partial PDF/PPT-style packet sufficient?
- Should `known_gaps`, `review_required`, and `review_reason` be mandatory for
  every partial packet?
- Should generated visual/chart anchors always require review?
- Should derived artifact references be checked from the packet directory and
  workspace root?

### Wiki Construction

- `reports/wiki-construction-analysis.md`
- `wiki/sources/adctoolbox-ch1.md`
- `wiki/chapters/ch1-introduction.md`
- `wiki/overview.md`
- `wiki/index.md`
- `wiki/log.md`

Review questions:

- Can validators verify that construction analysis exists before accepted wiki
  pages?
- Can `wiki-lint` check that accepted source/chapter pages are indexed?
- Can `wiki-lint` avoid requiring optional research-profile pages?
- Should the absence of `concepts/entities/comparisons/queries/synthesis` be a
  positive fixture expectation for document/PPT corpora?

### Round Closure

- `reports/validation/first-round-validation-note.md`

Review questions:

- Is `do-not-close` the correct expected state when compare is not enabled?
- Should a fixture also cover `close-with-review` for partial but acceptable
  source packets?
- Can `round-closure-check` distinguish missing compare from unresolved visual
  review?

## Person A Expected Output

Person A should not rewrite the workflow rule first. The expected next outputs
are:

- one or more committed fixtures derived from v2
- validator/checker changes in `llm_wiki_tools/**`
- schema changes under `contracts/schemas/**` only when fields are stable
- mismatch notes for Person B if a rule or template cannot be checked cleanly

## Non-Goals

- Do not implement a PDF/PPT extractor harness.
- Do not make MinerU, OCR, VLM, MCP, or LibreOffice a required dependency.
- Do not reintroduce research-profile wiki directories as the default.
- Do not treat v2 as a stable knowledge release.
