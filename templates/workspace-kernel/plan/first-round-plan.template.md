# First Round Plan

## Goal

Describe the first document/PPT corpus distillation target in one paragraph.
The goal should be small enough to finish and commit.

## Corpus Scope

- Raw sources in scope:
- Source groups or deck sections in scope:
- Sources intentionally out of scope:

## Expected Outputs

- Source inventory:
- Source packets:
- Wiki overview or overview update:
- Source pages:
- Chapter pages:
- Reports or validation notes:

## Round Steps

1. Check `git status --short --branch`.
2. Confirm `purpose.md` and `schema.md` are usable for this corpus.
3. Add or verify raw files under `raw/sources/`.
4. Write or update the source inventory.
5. Create source packets with stable anchors.
6. Create or update `wiki/overview.md` and `wiki/index.md`.
7. Write source and chapter pages from source packets.
8. Record validation in `reports/`.
9. Update `wiki/log.md` and `plan/log.md`.
10. Commit the accepted round.

## Validation

- Source inventory has stable `source_id` values.
- Each processed source has a source packet or an explicit extraction gap.
- Wiki pages cite source packet anchors or source identities.
- `wiki/index.md` links every accepted page.
- Compare status is recorded as `compare gate not enabled` unless a real
  compare check exists.

## Review Items

- Open extraction gaps:
- Unsupported or weak claims:
- Human decisions needed:

## Commit Intent

Commit with message:

```text
Complete first workspace distillation round
```
