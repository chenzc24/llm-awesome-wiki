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
