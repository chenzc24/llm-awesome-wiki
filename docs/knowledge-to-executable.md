# Knowledge To Executable

LLM Wiki helps agents maintain knowledge. This project extends that idea toward
execution: distilled knowledge should be able to become specs, code, scripts,
tests, experiments, and reusable templates.

## Pipeline

```text
raw source
-> distilled wiki
-> structured knowledge units
-> executable specs
-> implementation artifacts
-> validation
-> feedback into the wiki
```

## Layer 1: Raw Source

Raw sources are the evidence layer. They may include papers, articles, manuals,
codebases, meeting notes, design docs, datasets, or prior chats. Agents may read
and index these files, but they should not rewrite them.

Expected future artifacts:

- `raw/sources/`
- `raw/assets/`
- source inventory with path, hash, type, status, and notes

## Layer 2: Distilled Wiki

The wiki is the maintained knowledge layer. It should contain source summaries,
entities, concepts, comparisons, decisions, methods, and synthesis pages. Each
important claim should remain traceable to raw sources.

Expected future artifacts:

- `wiki/index.md`
- `wiki/overview.md`
- `wiki/log.md`
- `wiki/sources/`
- `wiki/concepts/`
- `wiki/entities/`
- `wiki/comparisons/`
- `wiki/synthesis/`

## Layer 3: Structured Knowledge Units

Executable work needs more structure than prose. Distilled pages should feed
intermediate units that an agent or script can reason about.

Candidate units:

- claims with source references
- decisions with context and consequences
- requirements with acceptance criteria
- methods with inputs, outputs, and assumptions
- comparisons with selected options and rejected alternatives
- risks with mitigation and validation

## Layer 4: Executable Specs

Executable specs translate knowledge into implementation intent. They should be
precise enough for an agent or engineer to implement without re-reading every
source.

Candidate outputs:

- feature specs
- API contracts
- data schemas
- prompt contracts
- test plans
- experiment protocols
- migration plans

## Layer 5: Implementation Artifacts

The workflow should support generating or maintaining:

- scripts
- tests
- prototypes
- configuration templates
- agent prompts
- CI checks
- application code
- reproducible experiments

These artifacts should be derived from the wiki but validated as code.

## Layer 6: Validation And Feedback

Execution must feed back into knowledge. When code, tests, or experiments
change the understanding of a topic, the wiki should be updated.

Validation signals:

- tests pass or fail
- scripts produce expected outputs
- lint detects structural issues
- compare gates find missing coverage
- human review resolves ambiguous judgment
- Git commits mark stable checkpoints

## First Principles

- A wiki page is not finished until its important claims can be traced.
- A plan is not ready until it can drive execution.
- Generated code is not accepted until it is validated.
- Validation results should update the knowledge base, not disappear into chat.
