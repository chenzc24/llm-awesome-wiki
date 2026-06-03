# Two-Person Pre-Skill/Tools Worksplit

This guide explains how two people can work in parallel on LLM Awesome Wiki
before the downstream skill/tool layer begins.

It is written for a newcomer who has just opened the repository and needs to
understand where to help without stepping on another person's work.

## Background

LLM Awesome Wiki is being built as a Git-first knowledge engineering system.
The system should eventually support this path:

```text
raw resources
-> source packets
-> evidence and claim records
-> wiki pages
-> compare and review gates
-> construction tools and reports
-> stable knowledge release
-> downstream skills, tools, tests, templates, and code
```

The downstream skill/tool layer is intentionally later. Before that layer, the
repository needs reliable foundations:

- machine-checkable contracts
- source packet and claim schemas
- workflow rules that humans and agents can follow
- workspace templates
- validation commands
- compare and review report formats

If two people both try to "build the system" broadly, they will edit the same
files and create conflicts. The safer split is to create two long-term owner
lines.

## The Two Owner Lines

### Person A: Contracts + Validation Owner

Person A answers this question:

> Can the system be checked by machines?

This owner defines the data contracts and the validation path. Their work makes
sure the repository can tell whether a source inventory, source packet, claim,
review item, or compare report is structurally valid.

Owned files:

- `contracts/schemas/**`
- `tools/validate-kernel/**`
- `tests/**`
- `tests/fixtures/**`

Primary responsibilities:

- define and maintain `source-inventory` schema
- define and maintain `source-packet` schema
- define and maintain `evidence-record`, `claim-record`, and `review-item`
  schemas
- define and maintain `compare-report` schema
- build or extend the kernel validator
- create small fixture examples
- check schema consistency
- report workflow/schema mismatches to Person B

What Person A should not own by default:

- prose workflow rules under `rules/**`
- workspace templates under `templates/workspace-kernel/**`
- tool README and CLI behavior prose under `tools/*/README.md`
- phase-plan prose under `docs/phase-plans/**`

Person A can read those files, but should submit notes or proposals when the
change belongs to Person B's owned area.

### Person B: Workflow + Tool Surface Owner

Person B answers this question:

> Can a human or agent understand what to do next?

This owner defines the work surface: the rules, templates, phase plans, and tool
interface descriptions that make the system usable.

Owned files:

- `rules/**`
- `templates/workspace-kernel/**`
- `tools/*/README.md`
- `docs/phase-plans/**`

Primary responsibilities:

- explain the `raw-to-source-packet` workflow
- explain the `source-packet-to-wiki` workflow
- maintain distillation round rules
- maintain compare gate prose and review workflow
- keep workspace kernel templates useful
- describe CLI inputs, outputs, failure modes, and reports in tool READMEs
- break phase plans into clear deliverables
- report missing schema fields or validation needs to Person A

What Person B should not own by default:

- JSON Schemas under `contracts/schemas/**`
- validator implementation under `tools/validate-kernel/**`
- test fixtures under `tests/**`

Person B can read those files, but should not change them without coordination
with Person A.

## Why This Split Works

The split reduces conflict because the two owners mostly edit different files.
It also creates a healthy dependency:

- Person A makes the contracts precise enough to validate.
- Person B makes the workflow clear enough to execute.
- Person A can catch missing fields in the workflow.
- Person B can catch schemas that are hard for humans and agents to use.

The goal is not to isolate the two people completely. The goal is to make their
interfaces explicit.

## First Round Rhythm

Do not start by building complex tools. First make the interfaces stable.

### Step 1: Person A Locks The Minimum Schemas

Person A should first stabilize the minimum schema set:

- `source-inventory`
- `source-packet`
- `claim-record`
- `compare-report`

The goal is not perfection. The goal is a small set of fields that the workflow
can safely reference.

Useful questions for Person A:

- What fields identify a source?
- What fields prove where a claim came from?
- How does a source packet point back to raw material?
- How does a compare report say pass, fail, or needs review?
- Which fields are required now, and which can wait?

### Step 2: Person B Writes The Minimum Workflow

Person B should simultaneously stabilize the minimum workflow:

- `raw-to-source-packet`
- `source-packet-to-wiki`
- `compare-gate-contract`

The goal is a clear paper path from raw resources to wiki-ready material, not a
fully automated converter.

Useful questions for Person B:

- What does a human or agent do first?
- What files are inputs and outputs?
- What is allowed to be model-generated?
- What must be deterministic?
- What must be reviewed by a human?
- Which schema fields does the workflow depend on?

### Step 3: Daily Sync

The daily sync should be short. Only check the interface between the two tracks.

Ask three questions:

- Did any schema field get renamed?
- Does any workflow reference a field that does not exist?
- Can the validator check the fields the workflow says are required?

If the answer to any question is "yes, there is a mismatch", do not patch
around it silently. Record the mismatch in a plan note, issue, review comment,
or integration plan.

### Step 4: End Of First Round

After the first round:

- Person A builds or extends `validate-kernel`.
- Person B writes the tool README / CLI specs.

This timing matters. CLI behavior is easier to describe after the schemas and
workflow names are stable.

## Recommended Branches

Use two long-lived feature branches during the first parallel round:

- Person A: `feat/contracts-validation`
- Person B: `feat/workflow-tool-surface`

The branch names describe ownership, not job title. If the same human switches
roles later, the branch names can change.

## File Ownership Rules

Default ownership:

| Area | Owner |
| --- | --- |
| `contracts/schemas/**` | Person A |
| `tools/validate-kernel/**` | Person A |
| `tests/**` | Person A |
| `tests/fixtures/**` | Person A |
| `rules/**` | Person B |
| `templates/workspace-kernel/**` | Person B |
| `tools/*/README.md` | Person B |
| `docs/phase-plans/**` | Person B, unless Coordinator reserves a file |
| `docs/top-level-design/**` | Coordinator |
| `plan/log.md` | merge owner or Coordinator |
| `llm_wiki/**` | read-only for everyone unless explicitly requested |

If a task needs to edit a file outside the owner's area, update the task plan
first. Do not make opportunistic edits to someone else's owned files.

## Minimum Milestones

### Milestone 1: Interfaces Exist

Person A:

- schemas can express source packets, claims, and compare reports

Person B:

- rules describe the path from raw resource to wiki-ready material

Acceptance:

- workflow prose can point to real schema fields
- schema fields have enough meaning for a human to use them

### Milestone 2: Validation And Tool Surfaces Exist

Person A:

- `validate-kernel` can check schema/template basics

Person B:

- `tools/*/README.md` explains CLI inputs, outputs, reports, and failure modes

Acceptance:

- a new agent can tell which command or future command owns each check
- validator expectations do not contradict workflow prose

### Milestone 3: Tiny Fixture Walkthrough

Both people:

- choose one tiny fixture, such as one Markdown source or one small PDF
- walk through the paper path:

```text
inventory
-> source packet
-> claim record
-> wiki draft
-> compare report
```

Acceptance:

- every artifact has an expected location
- every handoff has a schema or template
- every unresolved judgment has a review path

## What To Avoid

Avoid these failure modes:

- both people editing architecture documents at the same time
- both people editing schemas at the same time
- writing complex converters before the source packet contract is stable
- writing tool implementations before the CLI behavior is described
- using `llm_wiki/` as an implementation dependency
- letting agent names become user namespaces

The best two-person setup is simple:

- one person guards machine-checkable contracts
- one person guards workflow and tool surfaces
- both people synchronize at the interface between those two worlds
