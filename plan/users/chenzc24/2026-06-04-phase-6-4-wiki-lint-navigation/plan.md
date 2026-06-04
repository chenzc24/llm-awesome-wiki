# Phase 6.4 Wiki Lint And Navigation Plan

## Goal

Implement Phase 6.4 as checker-only wiki lint and navigation validation.

This target validates existing `wiki/` artifacts:

- special files: `wiki/index.md`, `wiki/overview.md`, `wiki/log.md`
- content page frontmatter
- wikilink and Markdown local-link resolution
- index membership and stale index links
- overview/log maintenance surfaces

It does not generate wiki pages, rewrite links, perform compare gates, resolve
semantic review, or inspect raw binary sources.

## Dirty-State Note

Starting state was clean:

```text
## main...origin/main
```

Reference submodules are not part of this target.

## Owned Files

- `docs/phase-plans/phase-6-validation-tooling-rebaseline.md`
- `docs/phase-plans/phase-6.4-wiki-lint-navigation.md`
- `docs/phase-plans/README.md`
- `tools/README.md`
- `tools/wiki-lint/README.md`
- `tools/wiki-lint/wiki-lint.ps1`
- `tools/workspace-check/README.md`
- `tools/workspace-check/workspace-check.ps1`
- `tools/validate-kernel/validate-kernel.ps1`
- `plan/users/chenzc24/log.md`
- `plan/log.md`
- `plan/users/chenzc24/2026-06-04-phase-6-4-wiki-lint-navigation/plan.md`

## Read-Only Files

- `contracts/schemas/**`
- `rules/**`
- `templates/workspace-kernel/**`
- `tests/**`
- `docs/top-level-design/**`
- `docs/collaboration/**`
- `tools/source-inventory/**`
- `tools/source-packet-lint/**`
- `llm_wiki/**`
- `MinerU/**`

## Shared Dependencies

- Phase 6 shared report conventions and exit codes
- Phase 6.1 `workspace-check` orchestration
- Phase 6.2 schema checker remains unchanged
- Phase 6.3 source artifact checkers remain unchanged
- Wiki index, overview, and log rules
- Workspace wiki templates for expected page shapes

## Implementation Steps

1. Add Phase 6.4 phase-plan documentation.
2. Implement `tools/wiki-lint/wiki-lint.ps1`:
   - verify `wiki/`, `index.md`, `overview.md`, and `log.md`
   - discover active content pages while ignoring README and template files
   - parse simple frontmatter fields
   - check required page metadata
   - parse `[[wikilinks]]` and local Markdown links
   - check index links resolve
   - check every content page appears in index
   - check overview is discoverable from index
   - flag missing overview/log maintenance sections as review findings
3. Integrate `wiki-lint.ps1` into `workspace-check -Mode wiki` and
   `workspace-check -Mode all`.
4. Update tool READMEs, Phase 6 docs, and `validate-kernel.ps1`.
5. Update maintenance logs.

## Validation

- `git diff --check`
- `powershell -ExecutionPolicy Bypass -File tools/validate-kernel/validate-kernel.ps1`
- Create a temporary smoke workspace under the OS temp directory with:
  - `wiki/index.md`
  - `wiki/overview.md`
  - `wiki/log.md`
  - one chapter page with frontmatter
  - one source page with frontmatter
  - valid index and page links
- Run `wiki-lint.ps1` and `workspace-check.ps1 -Mode wiki` against that temp
  workspace.
- Remove or ignore generated smoke reports outside the repository.
- Targeted `rg` for Phase 6.4, wiki-lint, index membership, broken links, and
  no-page-generation language.
- `git status --short --branch`

## Commit Intent

- Commit main implementation as `Add phase six wiki lint checker`.
- Then update log entries with the implementation commit hash and commit that
  maintenance status.
