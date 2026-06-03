# Source Inventory

Use this inventory before source-packet writing. Keep one row per raw source,
deck, document, directory, or intentionally ignored corpus item.

The inventory owns the stable `source_id`. Extractor backends and generated
outputs should not create their own source namespace.

| source_id | raw_path | source_kind | raw_sha256 | added_at | status | packet_path | review_required | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| adc/ch1 | raw/sources/adc/ch1.pdf | pdf | pending | YYYY-MM-DD | new |  | no | Example PDF source, not intake-ready yet. |
| lectures/week-02 | raw/sources/lectures/week-02.pptx | pptx | replace-with-sha256 | YYYY-MM-DD | ready | raw/derived/lectures/week-02/source.md | no | Ready for packet writing. |
| archive/raw-dump | raw/sources/archive/raw-dump.zip | archive | pending | YYYY-MM-DD | needs-review |  | yes | Archive requires manual scope decision before extraction. |

## Status Values

- `new`: source is listed but not yet intake-ready
- `ready`: source has identity, kind, and hash state needed for packet writing
- `processed`: source packet exists and is usable for the current hash
- `changed`: raw source hash changed after prior packet writing
- `ignored`: source is intentionally out of scope
- `failed`: intake or extraction failed and needs review
- `needs-review`: deterministic intake cannot decide

## Inventory Notes

- Keep `source_id` stable and lowercase.
- Use path-like IDs when useful, such as `course/module-01`.
- Record `raw_path` as a workspace-relative path under `raw/sources/`.
- Record `raw_sha256` when the source is local and hashable. Use `pending`,
  `not-hashable`, or `manifest` only when appropriate.
- Use `ready` as the normal handoff state into source-packet writing.
- `packet_path` can be blank for `new` or `ignored` rows. For `ready` rows it
  may point to the intended packet. For `processed` rows it must point to a
  usable packet for the current hash or manifest.
- If hashing, extraction, or scope decisions are deferred, explain why in
  `notes`.

## Source Kind Values

Expected values include:

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
or inspection. Unknown sources normally require review before packet writing.

## Review Guidance

Set `review_required` to `yes` when:

- source kind is `unknown`
- status is `needs-review` or `failed`
- the raw source is unsupported by current extraction methods
- a directory or archive needs a scope decision
- a hash cannot be computed but the source is still important
