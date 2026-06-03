# Knowledge To Executable

LLM Wiki helps agents maintain knowledge. This project extends that idea toward
execution: distilled knowledge should eventually become an executable codebase
or capability library, especially `skill + tool` artifacts that agents can use.

This document is a direction-setting document, not a finished design. The
knowledge-to-code path is the next-stage mainline after workflow bootstrap and
must be explored in small phases. Do not attempt to implement the entire path in
one pass.

## Pipeline

```text
raw source
-> distilled wiki
-> structured knowledge units
-> executable specs
-> skill + tool codebase
-> implementation artifacts
-> validation
-> feedback into the wiki
```

## Meaning Of "Executable"

In this project, "executable" does not only mean application code. It means a
validated capability layer that can be run by a human, a CLI, or an agent.

Primary executable targets:

- agent skills: instructions, triggers, examples, and usage constraints
- tools: scripts, CLIs, MCP servers, API wrappers, validators, and generators
- tests: checks that prove generated behavior matches distilled knowledge
- templates: reusable project, prompt, config, and code skeletons
- prototypes or app code: implementation artifacts derived from wiki decisions

The future goal is a repository where distilled knowledge can drive a
maintained `skills/` and `tools/` codebase rather than stopping at markdown.

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

## Layer 5: Skill And Tool Codebase

The first major execution target should be a `skill + tool` codebase. Skills
capture agent behavior and domain procedures; tools provide deterministic
operations that should not be left to model judgment.

Candidate future structure:

- `skills/`: agent-facing capabilities, instructions, examples, and boundaries
- `tools/`: runnable scripts, validators, search helpers, compare gates, and
  generators
- `tests/`: verification for tools and generated artifacts
- `templates/`: reusable project, prompt, code, and report templates
- `examples/`: small reference projects showing the workflow end to end

This layer should be designed after the distillation workflow is stable enough
to provide reliable inputs.

## Layer 6: Implementation Artifacts

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

## Layer 7: Validation And Feedback

Execution must feed back into knowledge. When code, tests, or experiments
change the understanding of a topic, the wiki should be updated.

Validation signals:

- tests pass or fail
- scripts produce expected outputs
- lint detects structural issues
- compare gates find missing coverage
- human review resolves ambiguous judgment
- Git commits mark stable checkpoints

## Staged Mainline

The knowledge-to-code path should become its own staged workstream:

1. Define what counts as an executable output for this workflow.
2. Design the minimal `skill + tool` repository structure.
3. Build deterministic tools for source inventory, lint, compare, and claim
   audit.
4. Add skill templates that tell agents when and how to call those tools.
5. Connect compare and validation results back into wiki maintenance.
6. Only then explore generated application code or larger automation.

## First Principles

- A wiki page is not finished until its important claims can be traced.
- A plan is not ready until it can drive execution.
- Generated code is not accepted until it is validated.
- Validation results should update the knowledge base, not disappear into chat.
