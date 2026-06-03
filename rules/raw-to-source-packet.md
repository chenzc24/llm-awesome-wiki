# Raw To Source Packet

Raw sources are immutable workspace inputs. An agent or tool may read them and
derive packets from them, but must not rewrite the original files as part of
distillation.

## Purpose

Create a faithful, auditable packet before wiki writing begins. The packet is
the bridge between heterogeneous raw files and later claim/evidence records.

## Phase 2.1 Intake Gate

Source intake happens before packet writing.

Before an agent or tool writes `raw/derived/<source-id>/source.md`, the raw
source should appear in the workspace source inventory. The inventory row is
the first durable decision about the source:

- how the source is named in the workspace
- where the immutable raw file lives
- what kind of material it is
- whether the raw hash is known
- whether the source is ready for packet writing, ignored, failed, changed, or
  waiting for review

Do not let a parser backend, such as a PDF extractor or MinerU-style document
parser, create the source namespace implicitly. Backend outputs may inform the
packet, but the workspace inventory owns the stable `source_id`.

## Required Inputs

- raw source path under `raw/sources/`
- source identity
- source hash when available
- source kind, such as markdown, pdf, docx, pptx, webpage, image, audio, or
  dataset
- extraction method and version when a tool is used

## Source Identity

Each source must have a stable `source_id` before packet writing begins.

Minimum identity fields:

- `source_id`: stable workspace identifier, preferably path-like and lowercase
- `raw_path`: path under `raw/sources/`
- `raw_sha256`: file hash when the source is local and hashable
- `source_kind`: file or material kind
- `added_at`: date the source entered the workspace
- `status`: source inventory state

If the hash cannot be computed, record why in inventory notes. If packet
writing proceeds anyway, mark the packet as `manual-review` or `partial`.

### Source ID Rules

- Use lowercase ASCII when possible.
- Prefer path-like IDs for large corpora, such as `course/module-01`.
- Keep IDs stable across extraction reruns and backend changes.
- Do not include machine-specific absolute paths.
- Do not include temporary backend names such as `mineru`, `ocr`, or `manual`.
- Resolve collisions before packet writing begins.

### Raw Path Rules

- Record workspace-relative paths under `raw/sources/`.
- Use forward slashes in inventory rows and source packets.
- Preserve meaningful corpus folders.
- If a raw source is a directory, record the directory path and explain whether
  member files are packeted together or individually.
- External absolute paths may appear in notes only when useful and
  non-sensitive; they are not source identity.

### Hash Rules

For local files, compute `raw_sha256` before packet writing when possible.

Allowed hash states before packet writing:

- a SHA-256 value for hashable local files
- `pending` when hashing has not been performed yet
- `not-hashable` when the source is not a stable local file
- `manifest` when a directory source uses a member-file manifest

A source with hash state `pending` can be listed, but should not be treated as
stable for repeatable extraction.

### Inventory Status Values

Inventory status is separate from packet `extraction_status`.

| Status | Meaning |
| --- | --- |
| `new` | source is listed but not yet intake-ready |
| `ready` | source has identity, kind, and hash state needed for packet writing |
| `processed` | usable source packet exists for the current hash or manifest |
| `changed` | raw source changed after packet writing |
| `ignored` | source is intentionally out of scope |
| `failed` | intake or extraction failed |
| `needs-review` | deterministic intake cannot decide |

Only `ready`, `processed`, `changed`, `failed`, and `needs-review` sources
should normally have packet paths. A `processed` row must point to a packet.

## Required Outputs

Each processed source should produce a derived packet under
`raw/derived/<source-id>/`:

- `source.md`: readable extracted content with anchors
- `metadata.json` or `metadata.yml`: source identity, hash, extraction status,
  tool version, modalities, and known gaps
- optional `media/`: extracted images, tables, charts, or attachments

## Packet Eligibility

A source is eligible for packet writing when:

- it has a stable `source_id`
- `raw_path` points under `raw/sources/`
- `source_kind` is known or explicitly marked `unknown`
- hash state is recorded
- inventory status is `ready`, `changed`, or `needs-review`
- any uncertainty is visible in inventory notes

Packet writing may proceed from `needs-review` only when the packet also records
the uncertainty and creates a review item or report entry.

## Packet Metadata

`metadata.json` or `metadata.yml` must include:

- source identity fields
- extraction tool and version, or `manual` if produced by an agent
- extraction status: `complete`, `partial`, `failed`, or `manual-review`
- modalities present in the source
- generated fields, such as OCR text or image captions
- extraction gaps and failure notes

## Anchor Contract

`source.md` must preserve anchors that later claims can cite.

Minimum anchor fields:

- `anchor_id`
- human-readable label
- location, such as page, slide, section, timestamp, row, or filename
- extracted text or media reference when available

Anchors should be stable across re-runs when the underlying source has not
changed.

## Unsupported Sources

Unsupported files must be inventoried when they are part of the intended corpus.

For unsupported sources, record:

- source ID
- raw path
- suspected source kind
- status: `ignored`, `failed`, or `needs-review`
- reason in notes
- whether a future extractor or manual review could handle it

This keeps later coverage checks from confusing "not seen" with
"intentionally deferred."

## Agent Rules

- Do not send binary source files directly into wiki writing when a structured
  packet is feasible.
- Do not write a packet for a source that has no inventory row.
- Preserve page, slide, section, timestamp, or filename anchors.
- Mark extraction gaps explicitly instead of hiding them.
- Separate extracted facts from generated captions, OCR text, and inferred
  descriptions.
- Create review items when extraction is partial, ambiguous, or dependent on
  model judgment.

## Handoff

The next stage may use only source packets and their metadata as the direct
input for wiki construction. If a later round needs the raw file again, it must
record why in the workspace log or compare report.

## Acceptance Criteria

- every source considered for extraction has an inventory row
- every processed source has a source identity
- every processed source has a packet path
- every packet has metadata and at least one anchor unless extraction failed
- extraction gaps are explicit
- generated captions, OCR, and inferences are distinguishable from source text
- failed or partial packets create review items or report entries
