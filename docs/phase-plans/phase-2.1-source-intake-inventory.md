# Phase 2.1 Source Intake And Inventory

Phase 2.1 defines the first checkpoint after raw files enter a knowledge
workspace.

The goal is not extraction. The goal is to turn arbitrary files under
`raw/sources/` into a stable source inventory that later packet writers,
validators, and compare gates can trust.

## Position In Phase 2

Phase 2.1 covers this part of the pipeline:

```text
raw resource
-> source intake
-> source inventory
-> source packet
```

It stops before source-packet extraction. No PDF text extraction, OCR, VLM
captioning, PPTX parsing, DOCX parsing, claim extraction, wiki writing, or
compare gate execution belongs in this phase.

## Why This Phase Exists

Without a stable inventory, later tools and agents will guess:

- whether a file is new, changed, ignored, failed, or already processed
- what `source_id` should be cited by source packets and wiki pages
- whether a hash changed after extraction
- which files are intentionally out of scope
- which unsupported files need human review instead of silent skipping

Phase 2.1 makes those decisions explicit before extraction begins.

## Source Intake Workflow

The workflow is:

```text
copy or sync raw files into raw/sources/
-> scan or manually list candidate sources
-> assign stable source_id values
-> record raw path and source kind
-> compute hashes when possible
-> classify source status
-> decide whether each source is ready for packet writing
```

Every raw file that may affect the knowledge base should appear in the
inventory. Files may be marked `ignored`, but they should not vanish merely
because they are inconvenient.

## Source ID Rules

`source_id` is the stable workspace name for a source.

Rules:

- use lowercase ASCII when possible
- prefer path-like IDs for large corpora, such as `adc/ch1`
- keep IDs stable across extraction reruns
- do not include local machine-specific absolute paths
- do not encode temporary backend names, such as `mineru`, `ocr`, or `manual`
- when two files would get the same ID, append a meaningful disambiguator

Examples:

| Raw path | Suggested source_id |
| --- | --- |
| `raw/sources/adc/ch1.pdf` | `adc/ch1` |
| `raw/sources/lectures/week-02.pptx` | `lectures/week-02` |
| `raw/sources/specs/design-notes.docx` | `specs/design-notes` |

## Raw Path Rules

Inventory paths are workspace-relative paths under `raw/sources/`.

Rules:

- record paths with forward slashes in inventory tables
- preserve source folder meaning when it helps humans understand the corpus
- do not record absolute Windows, Linux, or macOS paths as source identity
- if a raw source is a directory, record the directory path and explain how its
  member files are treated
- if a file is copied from an external corpus, record the external origin in
  notes only when useful and non-sensitive

## Hash Rules

For local files, compute `raw_sha256` before packet writing.

Allowed hash states:

- a SHA-256 value for hashable local files
- `pending` when the file has not been hashed yet
- `not-hashable` when the source is a live URL, database query, or other
  non-file source
- `manifest` when a directory source uses a member-file manifest instead of one
  single file hash

If hashing is not complete, the source may be inventoried but should not be
treated as stable for repeatable extraction.

## Source Kind Rules

`source_kind` records the material kind before extraction.

Minimum expected values:

- `pdf`
- `pptx`
- `docx`
- `xlsx`
- `markdown`
- `webpage`
- `image`
- `dataset`
- `directory`
- `archive`
- `unknown`

Use `unknown` only when the file cannot be identified from extension, metadata,
or inspection. Unknown sources should normally require review before packet
writing.

## Status Values

Inventory status describes the source's processing state.

| Status | Meaning | Next action |
| --- | --- | --- |
| `new` | source is listed but no usable packet exists | choose extraction path |
| `ready` | source has identity, kind, and hash needed for packet writing | write packet |
| `processed` | usable source packet exists for the current hash | use packet downstream |
| `changed` | raw hash differs from the packeted version | re-run or review packet |
| `ignored` | source is intentionally out of scope | no packet unless scope changes |
| `failed` | intake or extraction failed | create review item or fix input |
| `needs-review` | deterministic intake cannot decide | human decision required |

`ready` is the normal handoff state from Phase 2.1 to packet writing.

## Status Transitions

Typical transitions:

```text
new -> ready -> processed
new -> ignored
new -> needs-review -> ready
new -> failed
processed -> changed
changed -> ready -> processed
```

Do not move a source to `processed` until a source packet exists and points back
to the same raw hash or manifest state.

## Unsupported Sources

Unsupported sources should be visible.

For each unsupported source, record:

- `source_id`
- `raw_path`
- detected or suspected `source_kind`
- status: `ignored`, `failed`, or `needs-review`
- reason in `notes`
- whether a future extractor or manual review could handle it

This prevents source coverage reports from confusing "not seen" with
"intentionally deferred."

## Manual Versus Tool-Generated Inventory

Phase 2.1 allows manual inventory maintenance.

When a future `source-inventory` tool exists, it should be able to:

- scan `raw/sources/`
- propose source IDs
- compute hashes
- detect new and changed files
- write or update inventory rows
- report unsupported files

Until then, a human or agent may edit the inventory template directly, as long
as IDs, paths, hashes, statuses, and notes are explicit.

## MinerU Reference Boundary

MinerU accepts file or directory input and can emit rich structured outputs.
That is useful later, but Phase 2.1 happens before any MinerU backend is chosen.

The workspace inventory should not record MinerU output paths as source
identity. If MinerU is used in a later phase, it is an extraction backend, not
the owner of the source namespace.

## Person A Handoff

Workflow needs for schema and validation:

- inventory rows should allow `ready` and `needs-review` statuses
- `raw_sha256` should allow `pending`, `not-hashable`, and `manifest` states
  in addition to real hashes
- `source_kind` should allow `directory`, `archive`, and `unknown`
- inventory rows should include `review_required` or an equivalent review flag
- inventory validation should reject duplicate `source_id` values
- inventory validation should flag paths outside `raw/sources/`
- inventory validation should warn when `processed` rows have missing
  `packet_path`
- inventory validation should warn when `ready` rows still have hash `pending`

Person B should keep these as handoff proposals unless Person A accepts the
schema or validator changes.

## Completion Criteria

Phase 2.1 is complete when:

- source intake rules explain source ID, raw path, hash, kind, status, and
  unsupported-source handling
- the workspace inventory template can be filled manually without guessing
- the future source-inventory tool README describes command purpose, inputs,
  outputs, reports, failure modes, and non-goals
- Person A has a concrete handoff list for schema and validator expectations
- no raw conversion tool has been implemented prematurely
