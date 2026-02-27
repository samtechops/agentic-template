# Agentic Coding Reference Guide

A comprehensive reference for Tactical Agentic Coding (TAC), codifying the
principles, patterns, and practices that make AI-assisted software engineering
reliable and repeatable. This guide is based on the TAC curriculum by
IndieDevDan.

This document is not loaded automatically. Read it when you need a deep
reference, or point your agent at specific sections when troubleshooting a
workflow.

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [The 12 Leverage Points of Agentic Coding](#2-the-12-leverage-points-of-agentic-coding)
3. [The 4-Layer Architecture](#3-the-4-layer-architecture)
4. [Key Principles](#4-key-principles)
5. [Practical Patterns](#5-practical-patterns)
6. [The 80-20 of Agentic Coding](#6-the-80-20-of-agentic-coding)
7. [Getting Started with This Template](#7-getting-started-with-this-template)

---

## 1. Introduction

Agentic coding is the practice of using AI agents as your primary code-writing
tool while you focus on direction, review, and validation. Instead of typing
code line by line, you describe what you need, provide the right context, and
let the agent produce the implementation.

This guide codifies the best practices that make that workflow reliable. It is
not theory -- it is a practical system refined through real-world usage across
many projects and codebases.

### Core Philosophy

The single most important mental shift in agentic coding is this: **adopt your
agent's perspective**. Before every prompt, every plan, every session, ask
yourself one question:

> "Does my agent have what it needs to succeed?"

Your agent is powerful but starts every session with a blank slate. It has no
memory of yesterday's work. It cannot see files you have not shown it. It does
not know your conventions unless you tell it. Every failure to produce correct
output traces back to a gap in what the agent could see, understand, or do.

When you internalize this perspective, you stop blaming the model and start
engineering the environment around it. That is what this entire guide teaches.

### The Goal

The goal is **one-shot agentic coding success** -- getting the right result on
the first try, without back-and-forth iteration. This is not wishful thinking.
When context, model, prompt, tools, documentation, types, architecture, tests,
and planning are all properly aligned, agents consistently succeed on the first
attempt. Every section of this guide contributes to making that possible.

---

## 2. The 12 Leverage Points of Agentic Coding

There are exactly 12 leverage points that determine whether an agentic coding
session succeeds or fails. They fall into two categories:

- **In-Agent (The Core Four)** -- internal to the agent itself
- **Through-Agent** -- external things the agent interacts with

Mastering all 12 is the path to one-shot success. Mastering even a few will
dramatically improve your results.

### The Core Four (In-Agent Leverage Points)

These four are intrinsic to every agent session. They are the foundation that
everything else builds on.

#### Leverage Point 1: Context

Context is everything your agent can see in its context window. This includes
`CLAUDE.md`, `README.md`, file contents it has read, conversation history, and
any documentation you provide. The context window is finite and everything in it
competes for attention.

The critical question is always: **can the agent see everything it needs?**

Common context failures:
- The agent does not know your project conventions because `CLAUDE.md` is empty
  or missing.
- The agent cannot find the right files because you did not describe where they
  are.
- The agent uses outdated patterns because it has no current documentation.
- The agent loses track of earlier instructions because the conversation has
  grown too long.

Best practices:
- Keep `CLAUDE.md` accurate and current. It is the first thing the agent reads.
- Use the `/prime` command to orient the agent at the start of a session.
- Reference specific file paths in your prompts so the agent reads the right
  files.
- For long sessions, summarize progress periodically to keep context focused.

#### Leverage Point 2: Model

The model is the AI powering your agent. Different models have different
capabilities in reasoning depth, code generation quality, instruction following,
and context window size.

Key considerations:
- Use the strongest available model for complex architectural decisions,
  multi-file refactors, and subtle bug fixes.
- Activate deeper reasoning with the instruction "THINK HARD" when facing
  complex problems. This is not a gimmick -- it triggers extended reasoning
  that produces meaningfully better analysis.
- Match the model to the task. Simple file edits do not require the same
  reasoning depth as designing a new authentication system.
- Be aware of context window limits. If you are working with many large files,
  you may need to break the work into smaller sessions.

#### Leverage Point 3: Prompt

The prompt is the medium through which you communicate with your agent. It is
the most valuable skill an engineer working with AI can develop. A mediocre
prompt given to a great model produces mediocre results. A great prompt given to
a good model produces great results.

Characteristics of effective prompts:
- **Clear**: unambiguous language, no room for misinterpretation.
- **Specific**: exact file paths, exact behavior descriptions, exact acceptance
  criteria.
- **Structured**: use headers, bullet points, and numbered steps -- not walls
  of prose.
- **Exemplified**: include examples of expected input and output when the
  format matters.
- **Scoped**: define what IS in scope and what is NOT in scope.

The commands in `.claude/commands/` are examples of well-structured prompts.
Study them. Notice how they use sections (Instructions, Relevant Files, Plan
Format) to organize information for the agent.

#### Leverage Point 4: Tools

Tools are what your agent can do. Reading files, writing files, executing shell
commands, searching the web -- these are all tools. An agent without the right
tools is like a carpenter without a hammer.

In this template, tool permissions are configured in `.claude/settings.json`.
The default configuration allows common read/write operations, git commands, and
web search while denying destructive operations like force push and recursive
delete.

Best practices:
- Review and extend `.claude/settings.json` when you add new stack-specific
  tools (test runners, linters, build commands, database CLIs).
- Allow commonly used tools explicitly so the agent does not have to ask for
  permission every time.
- Deny destructive operations to prevent accidents during autonomous runs.
- When the agent cannot complete a task, check whether it has the tools it
  needs before assuming the prompt was bad.

### Through-Agent Leverage Points

These eight leverage points exist outside the agent but are accessed through it.
They are the environment you engineer to make your agent effective.

#### Leverage Point 5: Documentation (ai_docs)

Agent-specific documentation is fundamentally different from human
documentation. Humans read tutorials with narrative explanations and gradual
concept building. Agents need **reference material**: API signatures, code
examples, common patterns, and gotchas.

The `ai_docs/` directory in this template is where you place agent-optimized
documentation for every library, framework, and API your project depends on.

What makes good ai_docs:
- Function and method signatures with parameter types and return types.
- Short, working code examples that match your project's conventions.
- Common patterns and idioms for your specific use case.
- Configuration and setup details specific to your project.
- Version numbers so the agent targets the correct API surface.

What to avoid:
- Long narrative history of the library.
- Exhaustive coverage of features you do not use.
- Files longer than ~500 lines. Agents work better with focused documents.

Sources for ai_docs content: official quickstart guides, API reference pages,
README files from packages, and working code from your own project.

Keep ai_docs current. Outdated documentation causes outdated code. When you
upgrade a library, update its ai_doc.

See `ai_docs/README.md` for a detailed example of what an ai_doc file looks
like.

#### Leverage Point 6: Types

Types are structured information that gives agents clear contracts and
expectations. Whether you use TypeScript interfaces, Python type hints with
Pydantic models, Go structs, or any other type system, types tell the agent
exactly what shape data should take.

Why types are a leverage point:
- Types eliminate ambiguity. An agent reading `User { id: string, email: string,
  role: "admin" | "member" }` knows exactly what to produce.
- Types catch errors at compile time or validation time, giving the agent a
  fast feedback loop.
- Types serve as documentation that cannot drift out of sync with the code.
- Types make refactoring safer because the agent can follow type errors to find
  every location that needs to change.

Practical advice:
- Define types for all data that crosses boundaries (API requests, API
  responses, database rows, configuration objects).
- Co-locate types with the code that uses them, or place shared types in a
  central types directory.
- When writing a plan or prompt, reference the relevant type definitions so the
  agent knows the exact contract.

#### Leverage Point 7: Architecture

Architecture is code-based navigation. It determines how easily your agent can
understand and move through your codebase. A well-organized codebase is a
massive leverage point because the agent spends less time searching and more
time building.

Architecture that helps agents:
- Consistent file naming conventions (e.g., `*.route.ts`, `*.service.ts`,
  `*.test.ts`).
- Clear directory structure with separation of concerns (routes, services,
  models, utils).
- Index files or barrel exports that show what a directory contains.
- Colocation of related files (a component and its test in the same directory
  or a predictable sibling directory).
- Small, focused files rather than large monolithic files.

Architecture that hurts agents:
- Deeply nested directories with no clear naming pattern.
- Large files that mix concerns (500+ line files with routes, business logic,
  and database queries).
- Inconsistent conventions across the codebase.
- Circular dependencies that make it hard to understand data flow.

When starting a new project, invest in architecture early. It pays dividends on
every subsequent agentic session.

#### Leverage Point 8: Tests

Tests are one of the highest-leverage points in agentic coding. If your agent
can run tests, it can validate its own work and self-correct. Without tests,
the agent can only claim it is done. With tests, it can prove it.

This creates a **closed-loop system**: the agent writes code, runs tests, sees
failures, fixes them, and runs tests again. This loop is the mechanism behind
autonomous self-correction.

Best practices:
- Every plan must include validation commands. See the plan templates in
  `specs/_templates/` -- they all end with a Validation Commands section.
- Make tests fast. If your test suite takes 10 minutes, the agent's feedback
  loop is 10 minutes. If it takes 10 seconds, the agent iterates quickly.
- Include both unit tests and integration tests. Unit tests catch logic errors.
  Integration tests catch wiring errors.
- Write tests for the agent to run, not just for CI. The agent should be able
  to execute `npm test` or `pytest` or whatever your test runner is.
- Add your test command to `CLAUDE.md` so the agent always knows how to
  validate.

The mantra: **never claim done without evidence.** The evidence is passing
tests and clean lint output.

#### Leverage Point 9: Planning

Planning is meta-work for agents. Instead of jumping straight into code, you
let the agent plan its approach first. Plans are scaled prompts -- a plan is a
specification, a PRD, a detailed set of instructions that the agent then
follows step by step.

Why planning matters:
- Planning forces the agent to research the codebase before writing code.
- Plans break complex work into ordered steps, reducing the chance of missed
  requirements.
- Plans can be reviewed by a human before execution, catching design mistakes
  before they become code mistakes.
- Plans create a record of intent that makes code review easier.

This template's plan-then-implement workflow uses three meta-prompt commands
(`/feature`, `/bug`, `/chore`) to generate plans and one higher-order prompt
(`/implement`) to execute them. This separation of planning from execution is
the 80-20 of agentic engineering.

Planning scales with complexity. A one-line fix does not need a plan. A new
authentication system absolutely does. Use judgment.

#### Leverage Point 10: AI Developer Workflows (ADWs)

AI Developer Workflows combine agentic prompts with deterministic code to
create reusable, scriptable workflows. They bridge the gap between interactive
agent sessions and automated pipelines.

The `programmable/` directory in this template demonstrates the pattern:

1. Write a prompt file (`programmable/prompt.md`) with structured instructions.
2. Use a shell script, TypeScript file, or Python script to read the prompt and
   pipe it to `claude -p` (the Claude CLI in print/non-interactive mode).
3. Capture the output and use it programmatically.

This pattern enables:
- CI/CD integration: run agentic workflows as part of your build pipeline.
- Batch operations: process multiple files or tasks with the same prompt.
- Scheduled automation: run agentic reviews or reports on a schedule.
- Composition: chain multiple agentic calls together in a script.

The three implementations (`programmable.sh`, `programmable.ts`,
`programmable.py`) show the same pattern in different languages. Choose
whichever fits your stack.

#### Leverage Point 11: Agentic Coding KPIs

What gets measured gets improved. Track these key performance indicators to
understand whether your agentic coding practice is improving:

**Longer agent runs**: Measure how long your agent works before requiring human
intervention. Early on, you may intervene every few minutes. As your context,
documentation, and prompts improve, agents should run for longer stretches
autonomously.

**Reduced iteration cycles**: Count how many back-and-forth exchanges it takes
to get the result you want. One-shot success means one exchange. If you are
averaging five rounds of correction, something in your leverage points needs
attention.

**Increased autonomous success rate**: Track what percentage of agent outputs
are correct on the first attempt. This is the ultimate KPI. Improvement here
means your entire system is working.

**Token efficiency**: Monitor token usage per completed task. More efficient
context (better ai_docs, cleaner prompts, focused plans) means lower token cost
for the same quality output.

Do not measure these obsessively. Check them periodically, identify the weakest
leverage point, and invest there.

#### Leverage Point 12: One-Shot Agentic Coding Success

This is not a separate technique -- it is the emergent result of mastering the
other 11 leverage points. When context is complete, the model is appropriate,
the prompt is clear, tools are available, documentation is current, types are
defined, architecture is navigable, tests provide feedback, plans are thorough,
workflows are automated, and KPIs are tracked, agents succeed on the first try.

One-shot success is the north star. Every investment in the other 11 leverage
points moves you closer to it.

---

## 3. The 4-Layer Architecture

The 12 leverage points tell you what to optimize. The 4-layer architecture
tells you how to organize those optimizations into a coherent system. Each layer
builds on the one below it, creating increasing levels of abstraction and
reusability.

### Layer 1: Skills (Raw Capabilities)

Skills are the atomic capabilities your agent uses to interact with the world.
Reading files, writing files, running shell commands, searching code -- these
are all skills.

**Build opinionated skills rather than generic ones.** A generic "search"
skill is less useful than a skill tuned for your codebase's conventions. A
generic "deploy" skill is less useful than one that knows your specific
infrastructure.

Design principles for skills:
- **CLIs over MCP servers for token efficiency.** A CLI command returns exactly
  the output you need. An MCP server may return a large response that consumes
  context window space. When both options exist, prefer the CLI.
- **Specialize for your use case.** A skill that knows your project's file
  structure, naming conventions, and test patterns is far more useful than a
  general-purpose equivalent.
- **Support headless operation.** Skills should work without interactive input
  so they can be used in automated workflows.
- **Enable parallel execution.** Where possible, design skills that can run
  concurrently without conflicts.

In this template, tool permissions in `.claude/settings.json` define which
skills are available. The default set covers file operations and git commands.
Add your stack-specific skills (test runners, linters, formatters, build tools)
as you need them.

### Layer 2: Sub-Agents (Scaling and Specialization)

Sub-agents take raw skills and package them into specialized roles. Instead of
one agent that does everything, you create focused agents that excel at specific
task classes.

Examples of sub-agent specialization:
- A code review agent that reads diffs and produces structured feedback.
- A test-writing agent that reads implementation files and generates test
  suites.
- A documentation agent that reads code and produces ai_docs.
- A migration agent that understands your ORM and generates schema changes.

Design principles for sub-agents:
- **Use consistent prompt structure.** Every sub-agent should follow the same
  template: Purpose, Variables, Instructions, Workflow, Report. Consistency
  makes sub-agents predictable and debuggable.
- **Scope narrowly.** A sub-agent that tries to do too much becomes unreliable.
  Better to have three focused sub-agents than one sprawling one.
- **Enable parallel work.** Sub-agents that operate on different files or
  different concerns can run simultaneously.

### Layer 3: Commands/Prompts (Orchestration)

Commands are how you invoke and orchestrate agents. This template uses Claude
Code's slash command system (`.claude/commands/`) to define reusable command
prompts.

There are two fundamental command patterns:

**Meta-prompts** are prompts that generate plans. The `/feature`, `/bug`, and
`/chore` commands in this template are meta-prompts. You give them a one-line
description and they generate a comprehensive, structured plan. A meta-prompt
is a prompt that builds a prompt.

**Higher-Order Prompts (HOPs)** are prompts that take other prompts as input.
The `/implement` command is a HOP -- it accepts a path to a plan file and
executes that plan step by step. HOPs separate planning from execution.

The meta-prompt to HOP workflow:
1. You type: `/feature add user authentication`
2. The meta-prompt generates: `specs/add-user-auth.md`
3. You review the plan and adjust if needed.
4. You type: `/implement specs/add-user-auth.md`
5. The HOP reads the plan and executes every step.

This separation is powerful because it creates a review checkpoint between
planning and execution. You catch design mistakes before they become code.

The classic agent command structure used across these commands:
- **Purpose**: what the command accomplishes.
- **Variables**: inputs the command accepts (typically `$ARGUMENTS`).
- **Instructions**: detailed rules for how the agent should behave.
- **Workflow**: the sequence of actions to perform.
- **Report**: what the agent should output when finished.

### Layer 4: Reusability (Task Runners)

The final layer wraps everything into a single, consistent interface. Task
runners (justfiles, Makefiles, npm scripts, shell scripts) act as the API
layer for all your agentic workflows.

Benefits of a task runner layer:
- All available commands are listed in a single place.
- Commands can accept variables to override defaults.
- Complex multi-step workflows are reduced to a single command.
- New team members can see every available workflow immediately.
- CI/CD systems can invoke the same commands developers use.

Example structure using a justfile:

```
# Planning
plan-feature desc:  claude "/feature {{desc}}"
plan-bug desc:      claude "/bug {{desc}}"
plan-chore desc:    claude "/chore {{desc}}"

# Execution
implement plan:     claude "/implement {{plan}}"

# Utilities
prime:              claude "/prime"
install:            claude "/install"
```

This layer transforms your agentic workflows from ad-hoc conversations into
a reproducible engineering system.

---

## 4. Key Principles

These principles are the distilled wisdom behind the 12 leverage points and
the 4-layer architecture. Return to them when you are unsure how to approach
an agentic coding problem.

### Adopt Your Agent's Perspective

Your agent is brilliant but blind. It has extraordinary reasoning and
code-generation capabilities, but every session starts with zero knowledge of
your project. It has not read your code. It does not know your conventions. It
cannot see your screen.

Before every session, ask: "With my agent's core four (context, model, prompt,
tools), is it possible to complete this task?" If the answer is no, fix the
gap before prompting. Adding context is cheaper than debugging bad output.

### Plans Are Scaled Prompts

A plan is not a separate artifact from a prompt -- it IS a prompt, scaled up
for high-impact work. A one-line prompt handles a one-line change. A
multi-section plan with phases, steps, and validation commands handles a
multi-file feature.

Great planning IS great prompting. The `/feature`, `/bug`, and `/chore`
commands are meta-prompts that scale your one-line descriptions into
comprehensive plans. This is the highest-leverage use of prompting: you write
one line and get a complete specification.

### Templates Solve Problem Classes

Do not solve individual problems. Solve entire categories. Instead of writing
a custom plan for each bug fix, create a bug template that works for any bug
in any codebase. Instead of a one-off feature plan, create a feature template
that handles the full lifecycle from user story to validation.

The templates in `specs/_templates/` demonstrate this. The `feature_template.md`
handles any feature. The `bug_template.md` handles any bug. The
`chore_template.md` handles any maintenance task. Each template is reused
hundreds of times.

### Think Hard Activates Reasoning

The phrase "THINK HARD" is not decorative. When included in a prompt or plan,
it activates extended reasoning in the agent. Use it for:

- Complex root cause analysis where the obvious answer is probably wrong.
- Architectural decisions with multiple valid approaches and non-obvious
  tradeoffs.
- Multi-step problems where the agent needs to reason through dependencies
  before acting.
- Code review where subtle bugs or edge cases might be missed with shallow
  analysis.

You will see "THINK HARD" in the `/feature`, `/bug`, and `/chore` commands.
It is there intentionally. Use it in your own prompts when the problem demands
deep reasoning.

### Validation Creates Closed Loops

Every plan in this template ends with a Validation Commands section. This is
not optional and it is not decorative. It creates a closed-loop system:

1. The agent implements the plan.
2. The agent runs validation commands (tests, lint, build).
3. If validation fails, the agent fixes the issue.
4. The agent runs validation again.
5. The agent only reports done when all validation passes.

Without validation, the loop is open -- the agent claims done but you have no
evidence. With validation, the loop is closed -- the agent proves done.

The mantra: **never claim done without evidence.**

### Meta-Prompts Build Plans

A meta-prompt is a prompt that builds another prompt. When you type
`/feature add user authentication`, the `/feature` command does not implement
user authentication. It generates a plan in `specs/` that describes how to
implement it. That plan is itself a prompt -- a detailed specification that the
`/implement` command can execute.

This two-step workflow (meta-prompt generates plan, HOP executes plan) is the
foundation of reliable agentic engineering. The meta-prompt handles the
creative, design-oriented work. The HOP handles the systematic, step-by-step
execution.

### Higher-Order Prompts Enable Composition

A Higher-Order Prompt (HOP) accepts another prompt as input. The `/implement`
command is the primary HOP in this template: it reads a plan file path from
`$ARGUMENTS` and executes the plan it finds there.

This separation of concerns is powerful:
- Plans can be generated by any meta-prompt (feature, bug, chore) or written
  by hand.
- Plans can be reviewed and edited before execution.
- The same `/implement` command works with any plan format.
- Plans become reusable artifacts that document what was done and why.

### Success is Planned

Those who plan the future tend to create it. The plan-then-implement workflow
is the 80-20 of agentic engineering -- it delivers the majority of the value
with a relatively simple process.

Unplanned agentic sessions tend to wander. The agent starts implementing,
discovers a problem, backtracks, tries a different approach, and eventually
produces something that partially works. Planned sessions move in a straight
line from start to finish because the thinking happened upfront.

---

## 5. Practical Patterns

This section covers specific, actionable patterns you can apply immediately.

### The Plan-Then-Implement Workflow

This is the core workflow for any non-trivial task.

**Step 1: Describe what you need in one line.**
Keep it concise. The meta-prompt will expand it.

```
/feature add rate limiting to the API endpoints
```

**Step 2: The meta-prompt generates a plan.**
The `/feature` command researches your codebase, identifies relevant files,
and generates a comprehensive plan saved to `specs/add-rate-limiting.md`.

**Step 3: Review the generated plan.**
Read the plan. Check that the relevant files are correct, the steps are
logical, and the validation commands will actually prove the feature works.
Edit the plan if needed -- it is a markdown file, not sacred text.

**Step 4: Execute the plan.**

```
/implement specs/add-rate-limiting.md
```

**Step 5: The agent follows every step, runs validation, and reports results.**
The `/implement` command reads the plan, executes each step in order, runs all
validation commands, and reports what it did with `git diff --stat`.

If validation fails, the agent fixes the issue before proceeding. If it
cannot fix the issue, it reports what went wrong so you can intervene.

### Writing Effective ai_docs

Good ai_docs are the difference between an agent that guesses and an agent
that knows. Here is how to write them.

**Focus on what agents need.**
Agents do not need to understand why a library was created or its history.
They need to know: how to import it, how to call its functions, what types
it expects, and what gotchas to watch for.

**Copy quickstart guides from official documentation.**
The quickstart section of any library's docs is usually the closest thing to
what an agent needs. Copy it, trim the narrative, and add your project-specific
details.

**Keep them current.**
When you upgrade a library from v2 to v3, update the ai_doc. Outdated docs
cause outdated code. This is one of the most common sources of subtle bugs in
agentic coding.

**One file per library or API.**
`ai_docs/stripe.md`, `ai_docs/react-query.md`, `ai_docs/internal-api.md`.
Do not combine multiple libraries into one file.

**Include your project-specific configuration.**
The agent does not just need to know how Stripe works in general. It needs to
know how Stripe is configured in YOUR project -- which webhook events you
handle, which API version you use, where the Stripe client is instantiated.

### Structuring Specs for Agents

When writing plans (either manually or by editing generated plans), follow
these structural guidelines.

**Use h3 headers for each step.**
Agents parse markdown structure. Each `### Step N: Description` becomes a
discrete unit of work.

**Include exact file paths.**
Do not write "update the config file." Write "update `src/config.ts`." Agents
interpret instructions literally.

**Include validation commands.**
Every plan ends with commands that prove the work is correct. Reference the
test command from `CLAUDE.md`.

**Order steps logically.**
Foundational changes first (types, interfaces, configuration), then
implementation, then integration, then tests, then validation. This prevents
the agent from building on something that does not exist yet.

**Be explicit about scope.**
State what IS in scope and what is NOT. This prevents the agent from
gold-plating or going down rabbit holes.

See `specs/init_project.md` for a complete example of a well-structured plan.
See `specs/_templates/` for the format templates.

### Permission Configuration

The `.claude/settings.json` file controls what your agent can do. The default
configuration is:

```json
{
  "permissions": {
    "allow": [
      "Read", "Write", "Edit", "WebSearch",
      "Bash(mkdir:*)", "Bash(ls:*)", "Bash(cp:*)", "Bash(mv:*)",
      "Bash(chmod:*)", "Bash(find:*)", "Bash(grep:*)",
      "Bash(git checkout:*)", "Bash(git branch:*)",
      "Bash(git add:*)", "Bash(git commit:*)",
      "Bash(git log:*)", "Bash(git diff:*)",
      "Bash(git status:*)", "Bash(git ls-files:*)"
    ],
    "deny": [
      "Bash(git push --force:*)",
      "Bash(git push -f:*)",
      "Bash(rm -rf:*)"
    ]
  }
}
```

**Add stack-specific commands as you need them.** If your project uses `npm
test`, add `"Bash(npm test:*)"`. If you use `pytest`, add `"Bash(pytest:*)"`.
If you use `cargo build`, add `"Bash(cargo:*)"`. The agent should be able to
run your test suite, linter, and build commands without asking for permission.

**Deny destructive operations.** Force push and recursive delete are denied by
default. Add other dangerous commands for your stack if needed.

**Review permissions periodically.** As your project evolves, new tools become
necessary. Check whether your agent is frequently asking for permission to run
commands and add those commands to the allow list.

### Programmable Claude Patterns

The `programmable/` directory shows how to invoke Claude programmatically from
scripts. The core pattern is the same in every language:

1. Read a prompt from a file.
2. Pass it to `claude -p` (the print/non-interactive mode).
3. Capture and use the output.

**Bash:**
```bash
#!/bin/bash
PROMPT_CONTENT="$(cat programmable/prompt.md)"
OUTPUT="$(claude -p "$PROMPT_CONTENT")"
echo "$OUTPUT"
```

**TypeScript (Bun):**
```typescript
const promptContent = readFileSync("programmable/prompt.md", "utf-8");
const output = await $`claude -p ${promptContent}`.text();
console.log(output);
```

**Python:**
```python
with open("programmable/prompt.md", "r") as f:
    prompt_content = f.read()
result = subprocess.run(["claude", "-p", prompt_content], capture_output=True, text=True)
print(result.stdout)
```

Use cases for programmable Claude:
- **CI/CD pipelines**: run agentic code review on every pull request.
- **Batch processing**: apply the same transformation to many files.
- **Scheduled tasks**: generate daily reports or weekly summaries.
- **Chained workflows**: pipe the output of one agentic call as input to
  another.
- **Custom tooling**: build project-specific developer tools powered by AI.

The prompt file (`programmable/prompt.md`) uses a structured format with
labeled sections (RUN, CREATE, REPORT) that give the agent clear, sequential
instructions.

---

## 6. The 80-20 of Agentic Coding

You do not need to master all 12 leverage points to get dramatic results.
Three tactics deliver 80% of the impact.

### Tactic 1: Stop Coding

This is the hardest habit to break and the most important. Your job is no
longer to write code. Your job is to **direct, review, and validate**.

When you catch yourself typing implementation code, stop. Describe what you
need to your agent instead. Even if it takes three rounds of correction, you
are building the muscle of clear communication that will eventually produce
one-shot results.

The transition is uncomfortable. You will feel less productive at first. You
will want to "just fix it yourself." Resist. The compounding returns of
agentic fluency far exceed the short-term cost of learning.

What you should be doing instead of coding:
- Writing clear prompts and plans.
- Reviewing agent output for correctness and code quality.
- Running validation commands to verify the work.
- Improving context (CLAUDE.md, ai_docs, types) so the next session is better.
- Designing architecture that agents can navigate.

### Tactic 2: Adopt Your Agent's Perspective

This is the core philosophy stated as a tactic. Before every prompt:

1. What context does my agent have? Is anything missing?
2. Is the model appropriate for this task's complexity?
3. Is my prompt clear, specific, and structured?
4. Does the agent have the tools it needs?

If any answer is "no" or "I'm not sure," fix it before prompting. Five minutes
of preparation saves thirty minutes of debugging bad output.

The most common failure mode is assuming the agent knows something it does not.
It has not read the file you are thinking about. It does not know the
convention you discussed yesterday. It does not remember the decision you made
three hours ago in a different session. Make the implicit explicit.

### Tactic 3: Template Your Engineering

Stop solving individual problems. Start solving problem classes.

Every time you find yourself writing a similar prompt for the third time,
extract it into a command template. Every time you structure a plan the same
way, extract the structure into a template in `specs/_templates/`.

This template repository itself is the ultimate expression of this tactic. It
does not solve one project's problems -- it provides the scaffolding for any
project to adopt agentic coding practices.

Templates compound. Each template you create saves time on every future
instance of that problem class. Over months, a good template library becomes
your most valuable engineering asset.

---

## 7. Getting Started with This Template

This section is a quick-start reference for putting the template to work in
your project.

### Initial Setup

1. **Clone or copy the template** into your project.

2. **Customize `CLAUDE.md`** with your project's details:
   - Replace `YOUR_PROJECT_NAME` with your actual project name.
   - Add a description of what the project does.
   - List your tech stack (language, framework, database, package manager).
   - Replace the placeholder commands with real ones for your stack:
     ```
     Test:    npm test
     Lint:    npm run lint
     Start:   npm run dev
     Install: npm install
     ```

3. **Extend `.claude/settings.json`** with stack-specific tool permissions.
   Add your test runner, linter, build tool, and any other CLI commands the
   agent should be able to run without asking.

4. **Add ai_docs** for your key libraries. Create one markdown file per
   library in the `ai_docs/` directory. Start with the libraries the agent
   will interact with most.

### Daily Workflow

**Starting a session:**
```
/prime
```
This orients the agent by reading `README.md`, `CLAUDE.md`, and listing all
project files.

**Planning a feature:**
```
/feature add search functionality to the user dashboard
```
Review the generated plan in `specs/`. Edit if needed.

**Fixing a bug:**
```
/bug login fails when email contains a plus sign
```
Review the generated plan. Verify the root cause analysis is correct.

**Executing a plan:**
```
/implement specs/add-search-functionality.md
```
The agent follows every step and runs validation commands.

**Running a chore:**
```
/chore upgrade React from v18 to v19
```
Review the plan, then implement.

### Directory Reference

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Agent bootstrap file. Read automatically at session start. Contains project info, key paths, commands, and conventions. |
| `.claude/settings.json` | Tool permissions. Controls what the agent can and cannot do. |
| `.claude/commands/` | Slash commands. Each `.md` file becomes a `/command`. |
| `specs/` | Generated plans and specifications. Output of `/feature`, `/bug`, `/chore`. |
| `specs/_templates/` | Plan format templates. Used by meta-prompt commands to structure output. |
| `ai_docs/` | Agent-optimized documentation for libraries and APIs. |
| `programmable/` | Examples of invoking Claude programmatically from bash, TypeScript, and Python. |
| `scripts/` | Utility and automation scripts. |
| `docs/` | Reference documentation (like this guide). |

### Command Reference

| Command | Type | Purpose |
|---------|------|---------|
| `/prime` | Utility | Orient the agent by reading project files. |
| `/install` | Utility | Prime the agent then install project dependencies. |
| `/start` | Utility | Start the development server using the command from CLAUDE.md. |
| `/tools` | Utility | List all built-in tools available to the agent. |
| `/feature` | Meta-prompt | Generate a feature plan in `specs/`. |
| `/bug` | Meta-prompt | Generate a bug fix plan in `specs/`. |
| `/chore` | Meta-prompt | Generate a chore plan in `specs/`. |
| `/implement` | HOP | Execute a plan from a file path. |

### Iterating and Improving

After using the template for a few sessions:

1. **Check your CLAUDE.md.** Is anything missing that the agent keeps asking
   about? Add it.
2. **Check your ai_docs.** Is the agent misusing a library? Add or update its
   ai_doc.
3. **Check your permissions.** Is the agent frequently asking for permission
   to run a command? Add it to the allow list.
4. **Check your plans.** Are generated plans missing important steps? Improve
   the meta-prompt command in `.claude/commands/`.
5. **Track your KPIs.** Are you intervening less? Are iteration cycles
   shrinking? If not, identify the weakest leverage point and invest there.

The template is a starting point, not a finished product. The best version of
it is the one you have customized for your project, your stack, and your
workflow.
