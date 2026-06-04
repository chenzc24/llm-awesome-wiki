# Clarify Protocol And Contract Ownership

## Goal

Clarify the relationship between workflow protocols, operational rules,
machine-readable contracts, and templates in the top-level design and
collaboration split.

The immediate reason is that `protocol` and `contract` have started to blur in
Phase 2 work. The repository should say clearly that Person B owns
human/agent-facing protocols and workflow surfaces, while Person A owns
machine-readable contracts, validators, and fixtures.

## Dirty-State Note

Initial `git status --short --branch` was clean on `main...origin/main`.

Initial `git submodule status` showed:

- `MinerU/` pinned at `ef4aa39`
- `llm_wiki/` pinned at `a5ee5ec`

No dirty paths were present.

## Owned Files

- `docs/top-level-design/system-architecture-plan.md`
- `docs/top-level-design/README.md`
- `docs/collaboration/two-person-pre-skill-tools-worksplit.md`
- `docs/collaboration/person-a-contracts-validation-by-phase.md`
- `docs/collaboration/person-b-workflow-surface-by-phase.md`
- `plan/users/chenzc24/2026-06-04-clarify-protocol-contract-ownership/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `tools/**`
- `tests/**`
- `tests/fixtures/**`
- `docs/phase-plans/**`
- `MinerU/**`
- `llm_wiki/**`

## Shared Dependencies

- Phase 2.1 through Phase 2.3 protocol language
- Existing Person A/B ownership split
- Top-level artifact economy and raw-wiki alignment boundaries

## Expected Changes

- Add a top-level vocabulary section that distinguishes:
  - workflow protocol / operational rule
  - machine-readable contract
  - template
  - quality gate semantics versus validator implementation
- Update collaboration split so Person A/B duties map to those terms.
- Clarify that some historical `rules/*-contract.md` names are operational
  rules, not Person A-owned machine contracts.
- Keep schema, validator, templates, tools, and phase plans unchanged.

## Validation

- `git diff --check`
- targeted `rg` for protocol, machine-readable contract, operational rule,
  template, Person A, Person B, schema, validator, and ownership language
- `git submodule status`
- `git status --short --branch`

## Commit Intent

Commit and push to `main` with:

```text
Clarify protocol and contract ownership
```
