---
name: llm-wiki-source-packet
description: Source packet routing skill for LLM Awesome Wiki. Use when an agent needs to create, inspect, or validate source inventory rows, raw-source identity, source packets, extraction backend handoff, source-type packet profiles, generated fields, known gaps, or source packet review routing.
---

# LLM Wiki Source Packet

## Role

Use this subskill for the raw-to-source-packet stage only.

This skill routes the work. The semantic source of truth is in `rules/`:

- start with `rules/workflow/raw-to-source-packet.md`
- read `rules/source/extractor-adapter-protocol.md` only when an optional manual,
  Agent/MCP, local CLI, MinerU-like, or custom extraction backend is involved
- read `rules/source/source-type-packet-profiles.md` when source kind matters
- read `rules/source/generated-fields-review-routing.md` when OCR, captions, chart
  summaries, table repairs, formula recognition, or inferred structure appear

## Sequence

1. Confirm raw files are under `raw/sources/`.
2. Confirm each source has or needs an inventory row with stable source
   identity, kind, path, hash state, status, and packet path.
3. Create or inspect `raw/derived/<source-id>/metadata.yml` or
   `metadata.json`.
4. Create or inspect `raw/derived/<source-id>/source.md` with stable anchors.
5. Keep backend-local IDs subordinate to workspace anchors.
6. Mark generated fields and extraction gaps explicitly.
7. Route partial, failed, manual-review, or important generated content to
   review.

## Outputs

Expected outputs are source inventory state and source packets. This stage does
not write final wiki pages.

Use source references in later stages as:

```text
<source_id>#<anchor_id>
```

## Validation

Run source checks when available:

```text
python -m llm_wiki_tools workspace-check --workspace . --mode source
```

If source checks are unavailable, record the manual checks and unresolved
review items in the validation note.
