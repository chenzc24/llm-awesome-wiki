# Phase 6.3 Source Artifact Checkers

Phase 6.3 implements the first validators that inspect workspace artifacts
rather than system-repo contracts.

It validates the output surfaces from Phase 2:

```text
raw/source-inventory.md
raw/derived/<source-id>/source.md
raw/derived/<source-id>/metadata.yml or metadata.json
```

The goal is to catch deterministic source identity, packet, anchor, generated
field, gap, and review-routing problems before wiki writing or compare gates
depend on them.

## Scope

Phase 6.3 owns:

- `source-inventory-check`
- `source-packet-lint`
- `workspace-check -Mode source`
- report output and exit-code integration
- documentation that keeps these tools checker-only

Phase 6.3 does not own:

- source packet generation
- PDF/PPTX/DOCX/image parsing
- OCR, VLM, MinerU, MCP, or adapter execution
- semantic truth review
- wiki generation or wiki lint
- compare gate, review queue, or round closure validation
- schema changes

## Source Inventory Check

`source-inventory-check` validates a Markdown source inventory table.

Minimum deterministic checks:

- required table columns exist
- `source_id` values are present and unique
- `raw_path` values are workspace-relative and under `raw/sources/`
- local raw files exist for active inventory rows
- SHA-256 values match local files when a real hash is recorded
- inventory status values are known
- `review_required` values are parseable
- `processed` rows have `packet_path`
- packet paths are workspace-relative and under `raw/derived/`
- `failed` and `needs-review` rows visibly require review

Allowed hash states are:

- real 64-character SHA-256
- `pending`
- `not-hashable`
- `manifest`

`pending` is allowed for early rows, but it creates a review finding when the
row is `ready` or `processed`.

## Source Packet Lint

`source-packet-lint` validates source packet output after an extractor, agent,
manual workflow, or local script has produced it.

Minimum deterministic checks:

- packet path exists
- `source.md` exists
- packet metadata exists in `metadata.json`, `metadata.yml`, `metadata.yaml`,
  or `source.md` frontmatter
- required packet metadata fields are present
- `extraction_status` is one of `complete`, `partial`, `failed`, or
  `manual-review`
- `raw_path` is workspace-relative and under `raw/sources/`
- packet directory is compatible with `raw/derived/<source-id>/`
- anchor table exists for `complete` and `partial` packets
- anchor IDs are present and unique
- generated anchors are backed by `generated_fields`
- partial, failed, or manual-review packets expose `known_gaps` and review
  routing
- derived artifact references stay workspace-relative

The lint does not decide whether extracted content is semantically correct. It
only checks that uncertainty, generated content, and missing coverage are
visible enough for later evidence, wiki, and compare stages.

## Workspace Integration

`workspace-check -Mode source` runs:

```text
source-inventory-check
source-packet-lint
```

`workspace-check -Mode all` runs the already implemented schema check and these
source artifact checks, then reports later validators as not implemented until
their phases land.

Exit-code semantics follow Phase 6 shared conventions:

- `0`: deterministic checks pass
- `1`: deterministic validation failed
- `2`: review is required but no deterministic failure occurred
- `3`: configuration or runtime error

## Completion Criteria

Phase 6.3 is complete when:

- the Phase 6.3 phase plan exists
- source inventory check script and README are aligned
- source packet lint script and README are aligned
- `workspace-check -Mode source` invokes both source checkers
- generated reports follow shared conventions
- validation smoke runs cover a small workspace with inventory, raw file, and
  source packet artifacts
- no root-level live workspace output is introduced into the system repo

## Next Phase

Phase 6.4 should implement wiki lint and navigation checks:

- wiki page frontmatter
- source-reference strings
- broken links
- index membership
- overview/log maintenance references
