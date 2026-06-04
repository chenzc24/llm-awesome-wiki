---
name: llm-wiki-source-packet
description: Source packet runtime skill for LLM Awesome Wiki. Use when an agent needs to create, inspect, or validate source inventory rows, raw-source identity, source packets, extraction backend handoff, source-type packet profiles, generated fields, known gaps, or source packet review routing.
---

# LLM Wiki Source Packet

## Role

Use this subskill for the raw-to-source-packet stage only.

This skill is the normal runtime for source intake. It does not run a parser or
extractor harness. It defines the packet shape an agent or optional backend
must leave behind.

Detailed source rules are loaded only when needed:

- `rules/source/extractor-adapter-protocol.md` for optional manual, Agent/MCP,
  local CLI, MinerU-like, or custom extraction backend handoff
- `rules/source/source-type-packet-profiles.md` when PDF, PPTX, DOCX, image,
  table, dataset, or mixed-media minimum shape matters
- `rules/source/generated-fields-review-routing.md` when OCR, captions, chart
  summaries, table repairs, formula recognition, or inferred structure affect
  important knowledge

## Inputs

- raw files under `raw/sources/`
- source inventory or source list
- workspace `purpose.md` and `schema.md` when present
- optional backend output, manual notes, rendered media, OCR, or VLM output

Do not rewrite raw source files.

## Runtime

1. Confirm each considered source has an inventory row.
2. Assign or verify a stable `source_id`.
3. Record `raw_path`, `raw_sha256` or hash state, `source_kind`, intake status,
   and packet path.
4. Create or inspect:

```text
raw/derived/<source-id>/
  metadata.yml or metadata.json
  source.md
  media/ optional
  review.md optional
  gaps.md optional
```

5. In metadata, record `source_id`, `raw_path`, `raw_sha256`, `source_kind`,
   `extraction_backend`, `extraction_method`, `extraction_version`,
   `extraction_status`, `modalities`, `generated_fields`, `known_gaps`,
   `review_required`, `review_reason`, `derived_artifacts`, `created`, and
   `updated` when available.
6. In `source.md`, preserve stable anchors that later stages can cite:

```text
<source_id>#<anchor_id>
```

Each useful anchor should have location, label, content kind, source-derived
state, generated state, media or derived artifact reference when available, and
concise notes.

7. Keep backend-local IDs subordinate to workspace anchors.
8. Mark generated fields and extraction gaps explicitly.
9. Route partial, failed, manual-review, uncertain visual, changed-source, or
   important generated content to review.

## Outputs

Expected outputs are source inventory state and source packets. This stage does
not write final wiki pages.

Use source references in later stages as:

```text
<source_id>#<anchor_id>
```

## Boundaries

- Do not write final wiki pages directly from raw files when a source packet is
  feasible.
- Do not turn `source.md` into a polished chapter summary.
- Do not hide unsupported modalities or extraction gaps.
- Do not treat generated captions, OCR, chart summaries, formulas, or inferred
  structure as source-equivalent unless review accepts that state.
- Do not let an optional backend create the durable workspace source namespace.

## Validation

Run source checks when available:

```text
python -m llm_wiki_tools workspace-check --workspace . --mode source
```

If source checks are unavailable, record the manual checks and unresolved
review items in the validation note.

Minimum manual checks:

- every processed source has an inventory row and stable packet path
- every packet has metadata and at least one anchor unless extraction failed
- generated or model-assisted fields are visible
- partial, failed, or manual-review packets record gaps and review reason
- later stages can cite `<source_id>#<anchor_id>` without depending on backend
  internals
