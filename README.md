# Agentic Coding Template

A stack-agnostic template encoding agentic coding best practices from
Tactical Agentic Coding (TAC). Use it to bootstrap new projects, add
agentic workflows to existing ones, or point Claude at it as a reference
to apply the patterns to any project.

The core idea: **plan first, then implement**. Slash commands generate
structured plans in `specs/`, you review and approve them, then a single
command executes the plan step by step with automatic validation.

---

## How to Use This Template

### Option A: Use as a Reference (Recommended)

Point Claude at this repo from any project you're working on. In your
project's Claude Code session, say:

```
Read <path-or-url-to-this-repo> and apply the agentic coding patterns
to this project. Set up CLAUDE.md, .claude/commands/, specs/, and
ai_docs/ customized for my stack.
```

Claude will read this template's structure, commands, and patterns, then
recreate them adapted to your project's tech stack and conventions. This
is the fastest way to get the agentic workflow into an existing project.

You can also be more targeted:

```
Read <path-or-url>/docs/agentic-coding-guide.md and apply the
plan-then-implement workflow to my project.
```

```
Read <path-or-url>/.claude/commands/ and create equivalent commands
for my Python/FastAPI project.
```

### Option B: Clone for New Projects

```bash
git clone <repo-url> my-project
cd my-project
rm -rf .git && git init
```

Then customize:
1. Fill in `CLAUDE.md` (project name, tech stack, test/lint/start commands)
2. Add stack-specific permissions to `.claude/settings.json`
3. Add library docs to `ai_docs/`
4. Start using `/feature`, `/bug`, `/chore`, `/implement`

### Option C: Copy Into an Existing Project

Cherry-pick the pieces you need:

```bash
cp -r agentic-template/.claude/ my-project/.claude/
cp -r agentic-template/specs/ my-project/specs/
cp agentic-template/CLAUDE.md my-project/CLAUDE.md
mkdir -p my-project/ai_docs
```

Then customize `CLAUDE.md` and `.claude/settings.json` for your stack.

---

## Project Structure

```
.
├── CLAUDE.md                        # Agent bootstrap file (project info, commands, conventions)
├── README.md                        # This file
├── .claude/
│   ├── settings.json                # Tool permissions (allow/deny lists)
│   └── commands/                    # Slash commands (each .md file becomes a /command)
│       ├── feature.md               # Meta-prompt: generate a feature plan
│       ├── bug.md                   # Meta-prompt: generate a bug fix plan
│       ├── chore.md                 # Meta-prompt: generate a chore plan
│       ├── implement.md             # Higher-order prompt: execute a plan file
│       ├── prime.md                 # Orient the agent (read README, CLAUDE.md, list files)
│       ├── install.md               # Prime then install project dependencies
│       ├── start.md                 # Start the development server
│       └── tools.md                 # List all built-in tools available to the agent
├── specs/                           # Generated plans and specifications
│   ├── _templates/                  # Plan format templates used by meta-prompts
│   │   ├── feature_template.md      # Template for feature plans
│   │   ├── bug_template.md          # Template for bug fix plans
│   │   └── chore_template.md        # Template for chore plans
│   └── init_project.md             # Example: a fully written feature spec
├── ai_docs/                         # Agent-optimized library/API documentation
│   └── README.md                    # Guide for writing effective ai_docs
├── docs/
│   └── agentic-coding-guide.md      # Full TAC reference guide (12 leverage points, 4 layers)
├── programmable/                    # Examples of invoking Claude programmatically
│   ├── prompt.md                    # Sample prompt for programmatic use
│   ├── programmable.sh              # Bash implementation
│   ├── programmable.ts              # TypeScript (Bun) implementation
│   └── programmable.py              # Python implementation
└── scripts/
    └── start.sh                     # Development server start script (customize per stack)
```

---

## Workflow Overview

The template follows a **plan-then-implement** cycle.

### 1. Plan

Use a meta-prompt command to generate a structured plan:

```
/feature "add user authentication"
```

The agent researches your codebase and writes a detailed plan to
`specs/add-user-auth.md`, including phases, step-by-step tasks, testing
strategy, and validation commands.

### 2. Review

Read the generated plan in `specs/`. Edit anything that needs adjustment --
it is a markdown file. Verify the relevant files, implementation steps, and
acceptance criteria are correct.

### 3. Implement

Hand the plan to the higher-order prompt:

```
/implement specs/add-user-auth.md
```

The agent reads the plan and executes every step in order.

### 4. Validate

The agent runs all validation commands listed in the plan (tests, lint,
build). If any command fails, it fixes the issue and re-runs until all
checks pass. Work is not reported as done until validation succeeds.

---

## Commands Reference

| Command | Type | Usage | Purpose |
|---------|------|-------|---------|
| `/feature` | Meta-prompt | `/feature "add rate limiting"` | Generate a feature plan in `specs/` |
| `/bug` | Meta-prompt | `/bug "login fails with special chars"` | Generate a bug fix plan in `specs/` |
| `/chore` | Meta-prompt | `/chore "upgrade React to v19"` | Generate a chore plan in `specs/` |
| `/implement` | HOP | `/implement specs/add-rate-limiting.md` | Execute a plan file step by step |
| `/prime` | Utility | `/prime` | Orient the agent by reading project files |
| `/install` | Utility | `/install` | Prime the agent then install dependencies |
| `/start` | Utility | `/start` | Start the development server |
| `/tools` | Utility | `/tools` | List all built-in tools available to the agent |

**Meta-prompt**: A prompt that generates a plan (a prompt that builds a prompt).
**HOP (Higher-Order Prompt)**: A prompt that takes another prompt (a plan file) as input and executes it.

---

## Customization Guide

### CLAUDE.md

This is the agent bootstrap file, read automatically at the start of every session.

What to change:
- **Project name**: replace `YOUR_PROJECT_NAME`.
- **Description**: add a one-line summary of the project.
- **Tech stack**: list language, framework, database, and package manager.
- **Commands**: replace the `echo` placeholders with real commands for your stack.

### .claude/settings.json

Controls what the agent can and cannot do. The defaults cover file
operations and git commands. Add your stack-specific tools:

```json
// Node.js
"Bash(npm test:*)", "Bash(npm run lint:*)", "Bash(npm run build:*)"

// Python
"Bash(uv run:*)", "Bash(pytest:*)", "Bash(ruff:*)"

// Rust
"Bash(cargo build:*)", "Bash(cargo test:*)", "Bash(cargo clippy:*)"
```

Destructive operations (`git push --force`, `rm -rf`) are denied by
default. Add other dangerous commands to the deny list as needed.

### ai_docs/

Add one markdown file per library or API your project depends on. Each
file should contain:
- Import patterns and function signatures.
- Short, working code examples.
- Project-specific configuration and gotchas.
- Version numbers.

Keep files under 500 lines. See `ai_docs/README.md` for a detailed guide
and example.

### scripts/start.sh

Edit this file to start your development services. The script supports
multiple background processes with signal-based cleanup. Follow the
`CUSTOMIZE` comments in the file.

---

## Key Concepts

The full reference is in `docs/agentic-coding-guide.md`. Key topics:

- **The 12 Leverage Points** -- The factors that determine agentic coding
  success: context, model, prompt, tools, documentation, types,
  architecture, tests, planning, AI developer workflows, KPIs, and
  one-shot success.

- **The 4-Layer Architecture** -- How to organize agentic capabilities:
  Skills (raw tools), Sub-Agents (specialized roles), Commands/Prompts
  (orchestration via meta-prompts and HOPs), and Reusability (task runners).

- **Meta-Prompts and HOPs** -- Meta-prompts generate plans from one-line
  descriptions. Higher-Order Prompts execute those plans. This separation
  creates a review checkpoint between planning and execution.

- **The 80-20** -- Three tactics that deliver most of the value: stop
  coding (direct and review instead), adopt your agent's perspective, and
  template your engineering.

---

## Credits

Based on [Tactical Agentic Coding](https://www.agenticengineer.com) by
IndieDevDan / Agentic Engineer.
