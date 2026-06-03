# Source Inventory

Use this inventory before source-packet writing. Keep one row per raw source or
deck.

| source_id | raw_path | source_kind | raw_sha256 | added_at | status | packet_path | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| deck-example | raw/sources/example.pptx | pptx | pending | YYYY-MM-DD | new | raw/derived/deck-example/source.md | Replace this row. |

## Status Values

- `new`: source has been added but not packeted
- `processed`: source packet exists and is usable
- `changed`: raw source hash changed after prior packet writing
- `ignored`: source is intentionally out of scope
- `failed`: extraction failed and needs review

## Inventory Notes

- Keep `source_id` stable and lowercase.
- Use path-like IDs when useful, such as `course/module-01`.
- Record `raw_sha256` when the source is local and hashable.
- If hashing or extraction is deferred, explain why in `notes`.
