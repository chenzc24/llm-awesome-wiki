# Derived Source Packets

Store source packets here.

Recommended shape:

```text
raw/derived/<source-id>/
  metadata.yml
  source.md
  media/
  review.md optional
```

Required:

- `metadata.yml` or `metadata.json`
- `source.md`

Optional:

- `media/`
- `review.md` or `gaps.md`
- backend-specific derived artifacts

Metadata is the source of truth for packet identity, extraction backend,
status, generated fields, review routing, and known gaps.

`source.md` is anchored extracted/audit content. It is not the final
agent-readable wiki page.

Packets should preserve source identity, anchors, extraction status, generated
field markers, derived artifact references, and known gaps.
