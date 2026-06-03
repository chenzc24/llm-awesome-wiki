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

## Required Outputs

Each processed source should produce a derived packet under
`raw/derived/<source-id>/`:

- `source.md`: readable extracted content with anchors
- `metadata.json` or `metadata.yml`: source identity, hash, extraction status,
  tool version, modalities, and known gaps
- optional `media/`: extracted images, tables, charts, or attachments

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
