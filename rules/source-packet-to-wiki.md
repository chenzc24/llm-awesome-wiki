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
   - produce an analysis note or report before generation begins

2. Generation stage:
   - write or update wiki pages
   - update `wiki/index.md`
   - update `wiki/log.md`
   - emit review/report items instead of silently resolving uncertain claims

Do not collapse these stages. A raw source should not be turned directly into
final wiki pages without a source packet and an analysis pass.

## Analysis Output

The analysis stage should record:

- source packets read
- candidate concepts, entities, comparisons, and synthesis updates
- claims worth preserving as claim records
- evidence anchors that support important claims
- contradictions or uncertain interpretations
- pages to create, update, or leave unchanged
- review items needed before acceptance

The analysis output may be a report, a plan entry, or a structured note. It
must be visible in the workspace diff.

## Generation Output

The generation stage should produce only accepted workspace artifacts:

- wiki page creates or updates
- `wiki/index.md` update
- `wiki/log.md` update
- review item or report updates
- claim/evidence records when the workspace uses them

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

## Acceptance Criteria

- every new or changed wiki page cites at least one source identity when it
  contains sourced knowledge
- index and log are updated in the same round
- unresolved semantic judgment appears in review output
- generation does not introduce duplicate pages for existing concepts
- a compare or lint report records whether the round may advance
