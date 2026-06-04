# Source Inventory Tool

Future tool family for scanning workspace `raw/sources/` files and maintaining
the source inventory used before source-packet writing.

Phase 2.1 defines the behavior surface only. It does not implement the command.
Phase 2.6 keeps this as one member of the Phase 2 tool trio:
`source-inventory`, `source-packet-convert`, and `source-packet-lint`.

Phase 6.3 implements the checker-only slice:

```powershell
powershell -ExecutionPolicy Bypass -File tools/source-inventory/source-inventory-check.ps1 `
  -Workspace . `
  -Inventory raw/source-inventory.md `
  -Report reports/source-inventory-check-report.md
```

The checker validates an existing inventory. It does not create or update raw
source rows.

## Purpose

The tool should answer:

```text
Which raw sources exist, what are their stable IDs, and are they ready for
source-packet writing?
```

It should not parse source content into packets. It should only inventory raw
sources and report intake decisions.

## Future Command Shape

The exact command name is not final. The intended behavior is:

```powershell
source-inventory scan `
  --workspace . `
  --raw raw/sources `
  --inventory raw/source-inventory.md `
  --report reports/source-inventory-report.md
```

Expected modes:

- `scan`: inspect `raw/sources/` and produce proposed inventory rows
- `check`: validate inventory consistency without changing files
- `update`: merge detected new/changed sources into an existing inventory

The Phase 6.3 checker implements only the validation part of `check`.

## Inputs

- workspace root
- raw source directory, normally `raw/sources/`
- existing inventory file, normally `raw/source-inventory.md`
- optional ignore patterns
- optional source ID mapping rules

## Outputs

- updated or proposed source inventory
- report listing new, changed, missing, ignored, failed, and unsupported sources
- warnings for duplicate IDs, paths outside `raw/sources/`, missing hashes, and
  processed rows without packet paths

The tool should never modify raw source files.

The tool should also not write source packets. `packet_path` may point to the
intended or existing packet, but packet creation belongs to
`source-packet-convert`.

## Inventory Row Fields

Minimum fields:

- `source_id`
- `raw_path`
- `source_kind`
- `raw_sha256`
- `added_at`
- `status`
- `packet_path`
- `review_required`
- `notes`

## Status Values

- `new`: source is listed but not yet intake-ready
- `ready`: source has identity, kind, and hash state needed for packet writing
- `processed`: usable packet exists for the current hash or manifest
- `changed`: raw source hash differs from the packeted version
- `ignored`: source is intentionally out of scope
- `failed`: intake or extraction failed
- `needs-review`: deterministic intake cannot decide

## Deterministic Behavior

The tool should deterministically:

- walk `raw/sources/`
- normalize workspace-relative paths
- compute SHA-256 hashes for local files
- detect changed hashes
- infer obvious source kinds from extension
- flag unsupported or unknown source kinds
- reject duplicate `source_id` values in check mode

The tool may propose source IDs, but a human or agent may revise them before
the inventory becomes the source namespace.

The tool should separate deterministic intake checks from human or
agent-assisted source ID decisions.

## Failure Modes

The tool should report:

- unreadable files
- paths outside `raw/sources/`
- duplicate source IDs
- missing raw files referenced by inventory rows
- hash mismatches
- `processed` rows without packet paths
- unsupported archive or directory inputs that need review

## Exit-Code Expectations

Future implementation should use:

- `0`: inventory is valid for the requested mode
- `1`: deterministic validation failed
- `2`: review is required but no deterministic failure occurred
- `3`: tool configuration or runtime error

These exit codes are a proposal until Person A accepts validator behavior.

## Non-Goals

The source inventory tool should not:

- extract PDF, PPTX, DOCX, image, table, or chart content
- call OCR or VLM backends
- run MinerU
- write source packets
- generate wiki pages
- decide whether generated captions are trustworthy

Those belong to later Phase 2 source-packet conversion work and later review
gates.

## Person A Handoff

Validator/schema needs raised by this tool surface:

- allow `ready` and `needs-review` inventory statuses
- allow `pending`, `not-hashable`, and `manifest` hash states
- support `review_required` or an equivalent review flag
- validate that `raw_path` stays under `raw/sources/`
- detect duplicate `source_id` values
- warn when `processed` rows have no `packet_path`
- warn when `ready` rows still have hash `pending`
