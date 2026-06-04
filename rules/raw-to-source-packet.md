# Raw To Source Packet

Raw sources are immutable workspace inputs. An agent or tool may read them and
derive packets from them, but must not rewrite the original files as part of
distillation.

## Purpose

Create a faithful, auditable packet before wiki writing begins. The packet is
the bridge between heterogeneous raw files and later claim/evidence records.

The packet belongs to the audit layer. It should preserve source order,
anchors, extraction facts, generated fields, and known gaps. It should not
become a polished wiki article or a second knowledge surface.

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

- `metadata.json` or `metadata.yml`: metadata source of truth for identity,
  hash, extraction status, tool/backend version, modalities, generated fields,
  derived artifacts, review routing, and known gaps
- `source.md`: readable extracted/audit content with stable anchors
- optional `media/`: extracted images, page renders, slide renders, tables,
  charts, attachments, or other derived artifacts
- optional `review.md` or `gaps.md`: larger review notes that do not fit as
  concise packet notes

Recommended packet shape:

```text
raw/derived/<source-id>/
  metadata.yml
  source.md
  media/
  review.md optional
```

Optional backend-specific files may be stored under the packet directory, but
they do not become source identity. Reference them from metadata or anchors.

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

- `type`: `source-packet`
- `source_id`: stable workspace identifier inherited from inventory
- `raw_path`: workspace-relative path under `raw/sources/`
- `raw_sha256`: source hash or recorded hash state
- `source_kind`: source kind inherited from inventory
- `inventory_status_at_extraction`: inventory status when packet writing began
- `extraction_backend`: executor or adapter family, such as `manual`,
  `poppler`, `libreoffice`, `mineru`, `claude-mcp`, `codex-local`, or a
  custom script name
- `extraction_method`: specific method, such as `manual-notes`, `pdftotext`,
  `rendered-pages`, `office-xml`, or `adapter-output`
- `extraction_version`: backend, adapter, prompt, or manual protocol version
- `extraction_status`: `complete`, `partial`, `failed`, or `manual-review`
- `modalities`: source modalities seen or expected
- `generated_fields`: generated or model-assisted field kinds used in the
  packet
- `known_gaps`: compact list of failed, skipped, uncertain, or unsupported
  extraction areas
- `review_required`: boolean or `yes`/`no`
- `review_reason`: what a reviewer must decide when review is required
- `derived_artifacts`: files such as rendered pages, slide images, table CSVs,
  debug output, or backend output bundles
- `created`: packet creation date
- `updated`: last packet update date

Metadata is the source of truth for operational packet facts. `source.md` may
mirror a few identity fields for readability, but later wiki pages should cite
packet anchors instead of copying hashes, backend details, or extraction logs.

## Anchor Contract

`source.md` must preserve anchors that later claims can cite.

Minimum anchor fields:

- `anchor_id`
- `location`, such as page, slide, heading, section, timestamp, row, or
  filename
- human-readable `label`
- `content_kind`, such as text, title, table, chart, image, formula, code,
  list, note, or mixed
- whether the content is directly source-derived
- whether the anchor includes generated or model-assisted content
- media or derived artifact reference when available
- concise notes

Anchors should be stable across re-runs when the underlying source has not
changed.

Preferred reference form for later evidence, claims, wiki pages, and alignment
reports:

```text
<source_id>#<anchor_id>
```

Anchor ID rules:

- Use page, slide, heading, row, timestamp, or file-based prefixes when useful.
- Avoid backend-specific IDs as the only stable anchor name.
- Do not include local absolute paths.
- Split anchors when one location contains separate text, table, image, chart,
  or formula content that may need independent citation.

Minimum block shape in `source.md`:

```markdown
### p001 - Opening Definition

- Location: page 1
- Content kind: text
- Source-derived: yes
- Generated: no
- Media references:

Extracted text goes here.
```

For tables, charts, images, and formulas, distinguish direct source material
from generated interpretation.

## Generated Fields And Review Routing

Generated or model-assisted content is allowed inside source packets, but it
must be labeled.

Examples of generated fields:

- OCR text
- image captions
- chart summaries
- table repairs
- formula recognition
- inferred reading order
- agent-written extraction notes

Generated content is not source-equivalent by default. Claims based on
generated content should later carry a generated-evidence marker or route to
review.

Set `review_required` when:

- extraction is `partial`, `failed`, or `manual-review`
- generated content affects important knowledge
- visual interpretation is important but not deterministic
- media mapping is uncertain
- anchor coverage is incomplete
- a source changed after packet creation

Review notes should say what a reviewer must decide, not merely that the packet
is imperfect.

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
- Do not perform one-step raw-to-wiki writing when the source requires packet
  anchors.
- Do not turn `source.md` into a final wiki page or polished chapter summary.
- Keep metadata as the source of truth for backend, status, generated fields,
  and known gaps.
- Preserve page, slide, section, timestamp, or filename anchors.
- Mark extraction gaps explicitly instead of hiding them.
- Separate extracted facts from generated captions, OCR text, and inferred
  descriptions.
- Create review items when extraction is partial, ambiguous, or dependent on
  model judgment.

## Handoff

The next stage should use source packets, metadata, and anchor references as
the direct input for evidence, claim, wiki, and alignment work. If a later
round needs the raw file again, it must record why in the workspace log,
review note, or alignment report.

Wiki pages should cite packet anchors for important claims while remaining
agent-readable and human-reviewable. They should not duplicate packet hashes,
backend details, or full extraction logs unless that operational fact directly
affects knowledge confidence.

## Acceptance Criteria

- every source considered for extraction has an inventory row
- every processed source has a source identity
- every processed source has a packet path
- every packet has metadata and at least one anchor unless extraction failed
- extraction gaps are explicit
- generated captions, OCR, and inferences are distinguishable from source text
- failed or partial packets create review items or report entries
- packet handoff gives later stages usable `<source_id>#<anchor_id>` citations
  without making source packets the wiki knowledge layer
