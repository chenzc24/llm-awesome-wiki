# Reports

Reports make validation visible.

Recommended subdirectories:

```text
reports/
  inventory/
  lint/
  compare/
  coverage/
  review/
  validation/
```

Reports should state `pass`, `fail`, or `needs-review` when they gate a
distillation round.

## Compare Reports

Use `reports/compare/<round-id>-compare-report.md` when a round needs a quality
gate before advancing.

The compare report is the default round decision surface. It should record
source coverage, source packet and anchor coverage, wiki page coverage, claim
coverage, modality coverage, link/index/overview/log checks, omissions,
contradictions, review items, carried-forward review, and final
`pass`/`fail`/`needs-review` status.

Keep one concise compare report as the default. Link to detailed coverage,
lint, claim-audit, or review reports only when the workspace needs more depth.

The compare report is not a wiki rewrite instruction and not a final synthesis
page.

## Claim And Evidence Reports

Use `reports/review/claim-evidence-map.md` or a similarly named report when a
round creates important source-backed claims.

The claim/evidence map is an audit artifact. It should record which source
packet anchors support important claims, where generated evidence is involved,
and which claims need human review.

It is not a second wiki page and should not repeat complete source packet
content.

Use `reports/review/review-queue.md` when unresolved judgment must carry across
rounds.

## Wiki Construction Reports

Use `reports/wiki-construction-analysis.md` or a similarly named report before
creating or updating wiki pages from source packets.

The construction analysis records routing decisions, existing pages inspected,
target pages, merge decisions, and review handoff. It is the visible bridge
between routing and page generation.

It should not be a polished wiki page or a duplicate source packet.
