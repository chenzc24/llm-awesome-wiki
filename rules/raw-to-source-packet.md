# Raw To Source Packet

Raw sources are immutable workspace inputs. Agents and tools may read them and
derive packets, but must not rewrite original files as part of distillation.

This rule owns source identity, inventory state, packet metadata, extraction
status, and anchor requirements.

## Minimum Path

```text
raw/sources/*
-> source inventory row
-> raw/derived/<source-id>/metadata.yml or metadata.json
-> raw/derived/<source-id>/source.md
-> optional media/, review.md, gaps.md
-> later evidence, wiki, compare, and closure
```

Do not write final wiki pages directly from raw files when a structured source
packet is feasible.

## Source Inventory

Before packet writing, every source considered for extraction should have an
inventory row. The inventory owns the durable source namespace; extractor
backends must not create source IDs implicitly.

Minimum identity fields:

- `source_id`: stable workspace identifier, preferably path-like and lowercase
- `raw_path`: workspace-relative path under `raw/sources/`
- `raw_sha256`: SHA-256 value or recorded hash state
- `source_kind`: file or material kind
- `added_at`: date the source entered the workspace
- `status`: inventory state
- packet path when a packet exists or is expected

Source ID rules:

- Use lowercase ASCII when possible.
- Prefer path-like IDs for large corpora, such as `course/module-01`.
- Keep IDs stable across extraction reruns and backend changes.
- Do not include local absolute paths or temporary backend names.
- Resolve collisions before packet writing begins.

Raw path rules:

- Use workspace-relative paths under `raw/sources/`.
- Use forward slashes in inventory rows and source packets.
- Preserve meaningful corpus folders.
- If a source is a directory, say whether member files are packeted together or
  individually.

Allowed hash states:

- a SHA-256 value for hashable local files
- `pending`
- `not-hashable`
- `manifest` for directory sources with member-file manifests

A `pending` hash can be listed, but should not be treated as stable for
repeatable extraction.

Inventory status values:

| status | meaning |
| --- | --- |
| `new` | source is listed but not intake-ready |
| `ready` | source has identity, kind, and hash state needed for packet writing |
| `processed` | usable source packet exists for the current hash or manifest |
| `changed` | raw source changed after packet writing |
| `ignored` | source is intentionally out of scope |
| `failed` | intake or extraction failed |
| `needs-review` | deterministic intake cannot decide |

Only `ready`, `processed`, `changed`, `failed`, and `needs-review` sources
should normally have packet paths. A `processed` row must point to a packet.

## Packet Eligibility

A source is eligible for packet writing when:

- it has a stable `source_id`
- `raw_path` points under `raw/sources/`
- `source_kind` is known or explicitly `unknown`
- hash state is recorded
- inventory status is `ready`, `changed`, or `needs-review`
- uncertainty is visible in inventory notes

Packet writing may proceed from `needs-review` only when the packet also
records the uncertainty and creates review output.

## Required Packet Output

Each processed source should produce:

```text
raw/derived/<source-id>/
  metadata.yml or metadata.json
  source.md
  media/ optional
  review.md optional
  gaps.md optional
```

Optional backend-specific files may live under the packet directory, but they
do not become source identity. Reference them from metadata or anchors.

## Packet Metadata

`metadata.yml` or `metadata.json` is the source of truth for operational packet
facts and should include:

- `type`: `source-packet`
- `source_id`
- `raw_path`
- `raw_sha256`
- `source_kind`
- `inventory_status_at_extraction`
- `extraction_backend`
- `extraction_method`
- `extraction_version`
- `extraction_status`: `complete`, `partial`, `failed`, or `manual-review`
- `modalities`
- `generated_fields`
- `known_gaps`
- `review_required`
- `review_reason`
- `derived_artifacts`
- `created`
- `updated`

`source.md` may mirror a few identity fields for readability, but later wiki
pages should cite packet anchors instead of copying hashes, backend details, or
extraction logs.

## Anchor Contract

`source.md` must preserve stable anchors that later claims, wiki pages, and
compare reports can cite.

Preferred reference form:

```text
<source_id>#<anchor_id>
```

Minimum anchor fields:

- `anchor_id`
- `location`, such as page, slide, heading, section, timestamp, row, or
  filename
- human-readable `label`
- `content_kind`, such as text, title, table, chart, image, formula, code,
  list, note, or mixed
- whether the content is source-derived
- whether the anchor includes generated or model-assisted content
- media or derived artifact reference when available
- concise notes

Anchor ID rules:

- Prefer page, slide, heading, row, timestamp, or file-based prefixes.
- Do not rely on backend-local IDs as the only stable anchor name.
- Do not include local absolute paths.
- Split anchors when text, table, image, chart, or formula content may support
  different claims.

Minimum block shape:

```markdown
### p001 - Opening Definition

- Location: page 1
- Content kind: text
- Source-derived: yes
- Generated: no
- Media references:

Extracted text goes here.
```

## Generated Fields And Review

Generated or model-assisted content is allowed in source packets only when it
is labeled. Examples include OCR text, image captions, chart summaries, table
repairs, formula recognition, inferred reading order, and agent extraction
notes.

Follow `generated-fields-review-routing.md` for generated field kinds and trust
levels.

Set `review_required` when:

- extraction is `partial`, `failed`, or `manual-review`
- generated content affects important knowledge
- visual interpretation is important but not deterministic
- media mapping is uncertain
- anchor coverage is incomplete
- a source changed after packet creation

Review notes should state the reviewer decision needed.

## Unsupported Sources

Unsupported files must be inventoried when they are part of the intended
corpus. Record source ID, raw path, suspected kind, status, reason, and whether
future extraction or manual review could handle them. This keeps coverage
checks from confusing "not seen" with "intentionally deferred."

## Agent Rules

- Do not write a packet for a source that has no inventory row.
- Do not perform one-step raw-to-wiki writing when packet anchors are needed.
- Do not turn `source.md` into a final wiki page or polished chapter summary.
- Keep metadata as the source of truth for backend, status, generated fields,
  and known gaps.
- Preserve stable page, slide, section, timestamp, or filename anchors.
- Mark extraction gaps instead of hiding them.
- Separate extracted facts from generated captions, OCR text, and inferred
  descriptions.
- Create review output when extraction is partial, ambiguous, or dependent on
  model judgment.

## Handoff

Later stages should use source packets, metadata, and anchor references as
direct inputs. If a later round needs the raw file again, record why in the
workspace log, review note, or alignment report.

Wiki pages should cite packet anchors for important claims while remaining
agent-readable and human-reviewable. They should not duplicate packet hashes,
backend details, or full extraction logs unless those facts affect knowledge
confidence.

## Acceptance Criteria

- every source considered for extraction has an inventory row
- every processed source has stable identity and packet path
- every packet has metadata and at least one anchor unless extraction failed
- extraction gaps are explicit
- generated captions, OCR, and inferences are distinguishable from source text
- failed or partial packets create review items or report entries
- packet handoff gives later stages usable `<source_id>#<anchor_id>` citations
  without making source packets the wiki knowledge layer
