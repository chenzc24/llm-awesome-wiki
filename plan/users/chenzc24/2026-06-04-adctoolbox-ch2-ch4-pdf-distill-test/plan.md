# ADCtoolbox Ch2-Ch4 PDF Distillation Test

## Goal

Create a new ignored local workspace under `workspace/local/` and test the
current skill/rule/tool workflow on three ADCtoolbox PDF course decks:

- `ch2.pdf`
- `ch3.pdf`
- `ch4.pdf`

The work should exercise the source packet, wiki construction, report, and
validation flow without adding active raw/wiki artifacts to the system repo.

## Dirty-State Note

Starting status was clean:

```text
## main...origin/main
```

`workspace/local/` is ignored by `.gitignore`, so generated test artifacts there
will remain local workspace data.

## Owned Files

- `workspace/local/adctoolbox-ch2-ch4-pdf-distill-test/**` (ignored local test
  workspace)
- `plan/users/chenzc24/2026-06-04-adctoolbox-ch2-ch4-pdf-distill-test/plan.md`
- `plan/users/chenzc24/log.md`
- `plan/log.md`

## Read-Only Files

- `templates/workspace-kernel/**`
- `skills/**`
- `rules/**`
- `contracts/**`
- `llm_wiki_tools/**`
- `llm_wiki/**`
- `MinerU/**`

## Implementation Plan

1. Instantiate a workspace from `templates/workspace-kernel/`.
2. Copy the three PDF files into workspace `raw/sources/ADCtoolbox/ADC-basic/`.
3. Extract text from the PDFs into source packets under `raw/derived/`.
4. Create source inventory, overview, source pages, chapter pages, construction
   analysis, compare/validation notes, and logs.
5. Run available workspace checks and record results.

## Validation Plan

- `python -m llm_wiki_tools workspace-check --workspace <workspace> --mode source`
- `python -m llm_wiki_tools workspace-check --workspace <workspace> --mode wiki`
- `python -m llm_wiki_tools workspace-check --workspace <workspace> --mode reports`
- `python -m llm_wiki_tools workspace-check --workspace <workspace> --mode closure`
- `python -m llm_wiki_tools workspace-check --workspace <workspace> --mode all`
- `git status --short --branch`

## Commit Intent

Only plan/log maintenance files should be committed. The generated workspace is
ignored local test data.
