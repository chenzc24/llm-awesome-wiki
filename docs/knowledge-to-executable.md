# Knowledge To Executable

LLM Wiki helps agents maintain knowledge. This project extends that idea toward
execution in two layers. The first layer is part of knowledge-base construction:
maintenance, lint, search, compare gates, source inventory, and claim audit. The
second layer is downstream: a stable distilled wiki may later drive an
executable codebase or capability library, especially `skill + tool` artifacts
that agents can use.

This document is a direction-setting document, not a finished design. The
construction executable layer should be designed before the downstream
knowledge-to-code path. Do not attempt to implement both layers in one pass.

## Pipeline

```text
raw source
-> source packet
-> semantic draft
-> grounding pass
-> source-anchored agent-readable wiki
-> raw-wiki alignment reports
-> construction executable layer
-> structured knowledge units
-> executable specs
-> downstream skill + tool codebase
-> implementation artifacts
-> validation
-> feedback into the wiki
```

## Two Execution Layers

In this project, "executable" does not only mean application code. It means
validated operations that can be run by a human, a CLI, or an agent. There are
two layers with different jobs.

## Layer A: Knowledge-Construction Executable Layer

This layer belongs to the knowledge-base construction stage. Its purpose is to
make distillation, maintenance, and comparison more reliable.

Primary targets:

- source inventory: path, hash, type, processing status, and ownership
- wiki lint: frontmatter, broken links, orphan pages, stale index entries
- compare gates: source coverage, claim coverage, omissions, contradictions
- claim audit: map important claims to source references
- search helpers: CLI-friendly search over raw and distilled content
- todo/review sync: turn lint and compare outputs into actionable tasks

This layer should be built before the downstream skill/tool mainline. It is the
quality infrastructure for the knowledge base itself.

## Layer B: Downstream Knowledge-To-Code Layer

This layer starts after the wiki has enough stability and traceability. Its
purpose is to turn distilled knowledge into executable capabilities.

Primary targets:

- agent skills: instructions, triggers, examples, and usage constraints
- tools: scripts, CLIs, MCP servers, API wrappers, validators, and generators
- tests: checks that prove generated behavior matches distilled knowledge
- templates: reusable project, prompt, config, and code skeletons
- prototypes or app code: implementation artifacts derived from wiki decisions

The future goal is a repository where distilled knowledge can drive a
maintained downstream `skills/` and `tools/` codebase rather than stopping at
markdown.

## Layer 1: Raw Source

Raw sources are the evidence layer. They may include papers, articles, manuals,
codebases, meeting notes, design docs, datasets, or prior chats. Agents may read
and index these files, but they should not rewrite them.

Expected future artifacts:

- `raw/sources/`
- `raw/assets/`
- source inventory with path, hash, type, status, and notes

## Layer 2: Distilled Wiki

The wiki is the maintained knowledge layer. The default shape is
document-corpus oriented: source summaries, chapter pages, an overview, and
reports/review links. For a large PPT corpus, preserving source order and
chapter structure is more important than eagerly splitting everything into
entities and concepts. Research-style pages can be enabled later when the
workspace needs them.

Wiki construction should be semantic-first and audit-grounded. Source packets
provide anchors and provenance, but they are not the semantic ceiling. A
construction round may use raw or rendered source views, external extraction
output, and high-density reading notes to prepare a semantic draft. The
accepted wiki page must then ground important knowledge to source anchors,
evidence records, accepted review decisions, or explicit review items.

Expected future artifacts:

- `wiki/index.md`
- `wiki/overview.md`
- `wiki/log.md`
- `wiki/sources/`
- `wiki/chapters/`
- optional `wiki/synthesis/`
- optional research-profile areas such as `wiki/concepts/`,
  `wiki/entities/`, `wiki/comparisons/`, and `wiki/queries/`

The wiki layer should be agent-readable first and human-reviewable second. It
should not consume or repeat every audit artifact. Important claims should cite
source packet anchors, but operational facts such as raw hashes, extraction
versions, and full packet metadata should remain in the audit layer unless they
are directly relevant to agent use or human review.

Useful but ungrounded semantic content should not silently become accepted
wiki knowledge, and it should not be discarded merely because the current
source packet is lossy. Treat it as candidate-derived content and route it to a
grounding or review step.

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

## Layer 5: Downstream Skill And Tool Codebase

The downstream execution target is a `skill + tool` codebase. Skills capture
agent behavior and domain procedures; tools provide deterministic operations
that should not be left to model judgment.

Candidate future structure:

- `skills/`: agent-facing capabilities, instructions, examples, and boundaries
- `tools/`: runnable scripts, validators, search helpers, compare gates, and
  generators
- `tests/`: verification for tools and generated artifacts
- `templates/`: reusable project, prompt, code, and report templates
- `examples/`: small reference projects showing the workflow end to end

This layer should be designed after the distillation workflow is stable enough
to provide reliable inputs, and after the construction executable layer is in
place.

Downstream skill and tool work should consume stable agent-readable knowledge,
source-backed claims, and executable specs. It should not directly consume the
full raw audit layer as its normal input, because that would turn construction
noise into implementation noise.

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

## Staged Work

The construction executable layer should come first:

1. Define the source inventory, lint, compare, and claim-audit reports.
2. Build deterministic tools for source inventory, lint, compare, and claim
   audit.
3. Connect compare and validation results back into wiki maintenance.
4. Add agent rules that require these tools during distillation rounds.

Only after that should the downstream knowledge-to-code mainline begin:

1. Define what counts as a downstream executable output.
2. Design the minimal `skill + tool` repository structure.
3. Add skill templates that tell agents when and how to call domain tools.
4. Map stable wiki decisions and methods into one narrow executable scenario.
5. Only then explore generated application code or larger automation.

## First Principles

- A wiki page is not finished until its important claims can be traced.
- An agent-readable wiki page is not improved by repeating every audit field.
- One fact should have one source of truth, with references instead of
  competing copies.
- A plan is not ready until it can drive execution.
- Generated code is not accepted until it is validated.
- Validation results should update the knowledge base, not disappear into chat.
