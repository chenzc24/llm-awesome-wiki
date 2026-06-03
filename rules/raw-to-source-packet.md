# Raw To Source Packet

Raw sources are immutable workspace inputs. An agent or tool may read them and
derive packets from them, but must not rewrite the original files as part of
distillation.

## Purpose

Create a faithful, auditable packet before wiki writing begins. The packet is
the bridge between heterogeneous raw files and later claim/evidence records.

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
- `status`: `new`, `processed`, `changed`, `ignored`, or `failed`

If the hash cannot be computed, record why in metadata and mark the packet as
`manual-review` or `partial`.

## Required Outputs

Each processed source should produce a derived packet under
`raw/derived/<source-id>/`:

- `source.md`: readable extracted content with anchors
- `metadata.json` or `metadata.yml`: source identity, hash, extraction status,
  tool version, modalities, and known gaps
- optional `media/`: extracted images, tables, charts, or attachments

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

## Agent Rules

- Do not send binary source files directly into wiki writing when a structured
  packet is feasible.
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

- every processed source has a source identity
- every packet has metadata and at least one anchor unless extraction failed
- extraction gaps are explicit
- generated captions, OCR, and inferences are distinguishable from source text
- failed or partial packets create review items or report entries
