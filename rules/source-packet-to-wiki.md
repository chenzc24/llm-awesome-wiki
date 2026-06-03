# Source Packet To Wiki

Wiki writing starts from source packets, not directly from raw files. The wiki
is a maintained synthesis layer; it must remain traceable to source packets and
evidence records.

## Two-Stage Flow

1. Analysis stage:
   - read the source packet and existing `wiki/index.md`
   - identify concepts, entities, claims, contradictions, and open questions
   - decide which existing pages need updates and which new pages are needed
   - create review items for human judgment

2. Generation stage:
   - write or update wiki pages
   - update `wiki/index.md`
   - update `wiki/log.md`
   - emit review/report items instead of silently resolving uncertain claims

## Page Requirements

Every generated wiki page should include:

- YAML frontmatter with `type`, `title`, `sources`, `created`, and `updated`
- source references pointing to source packet or raw source identities
- body content with stable headings
- relevant cross-links using the workspace's link convention
- explicit uncertainty or conflict notes when needed

## Agent Rules

- Prefer updating existing pages over creating duplicate pages.
- Do not remove sourced claims unless the reason is recorded.
- Do not rely on the model's self-assessment as the final quality gate.
- Do not advance a distillation round until compare and lint checks are recorded.
- Put unresolved semantic judgment into review items.

## Handoff

The next step is a compare gate: source coverage, claim coverage, index health,
broken links, contradictions, omissions, and review queue status.
