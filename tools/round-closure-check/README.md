# Round Closure Check Tool

Checker for round closure consistency.

Phase 6.6 implements the checker-only validator:

```bash
python -m llm_wiki_tools round-closure-check \
  --workspace . \
  --reports-dir reports \
  --wiki-dir wiki \
  --report reports/round-closure-check-report.md
```

## Purpose

Answer:

```text
Does the recorded closure decision match compare, review, validation, index,
overview, and log state?
```

## Checks

- validation note status, compare status, and closure decision values
- `close-pass` requires compare `pass`
- `close-with-review` requires compare `needs-review`
- `do-not-close` cannot claim normal advancement
- referenced compare and review report paths exist
- wiki log records closure decision
- active compare/review reports remain discoverable when closing with review

## Non-Goals

`round-closure-check` does not:

- close rounds automatically
- rewrite validation notes or wiki logs
- resolve review items
- decide semantic truth
- generate reports or wiki pages
