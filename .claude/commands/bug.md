# Bug Planning

Create a new plan in specs/*.md to resolve the `Bug` using the exact specified markdown `Plan Format`. Follow the `Instructions` to create the plan and use the `Relevant Files` to focus on the right files.

## Instructions

- You're writing a plan to resolve a bug. It should be thorough and precise so we fix the root cause and prevent regressions.
- Create the plan in the `specs/*.md` file. Name it appropriately based on the `Bug`.
- Use the plan format below to create the plan.
- Research the codebase to understand the bug, reproduce it, and put together a plan to fix it.
- IMPORTANT: Replace every <placeholder> in the `Plan Format` with the requested value. Add as much detail as needed to fix the bug.
- Use your reasoning model: THINK HARD about the bug, its root cause, and the steps to fix it properly.
- IMPORTANT: Be surgical with your bug fix. Solve the bug at hand and don't fall off track.
- IMPORTANT: We want the minimal number of changes that will fix and address the bug.
- If you need a new library, note it in the `Notes` section of the `Plan Format`.
- Respect requested files in the `Relevant Files` section.
- Start your research by reading the `README.md` and `CLAUDE.md` files.

## Relevant Files

Focus on the following files:
- `README.md` - Contains the project overview and instructions.
- `CLAUDE.md` - Contains project conventions, key paths, and commands.
- Project source directories and files relevant to the bug.
- `scripts/` - Contains utility and development scripts.

## Plan Format

```md
# Bug: <bug name>

## Bug Description
<describe the bug in detail, including symptoms and expected vs actual behavior>

## Problem Statement
<clearly define the specific problem that needs to be solved>

## Solution Statement
<describe the proposed solution approach to fix the bug>

## Steps to Reproduce
<list exact steps to reproduce the bug>

## Root Cause Analysis
<analyze and explain the root cause of the bug>

## Relevant Files
Use these files to fix the bug:

<find and list the files that are relevant to the bug and describe why they are relevant in bullet points. If there are new files that need to be created, list them in an h3 'New Files' section.>

## Step by Step Tasks
IMPORTANT: Execute every step in order, top to bottom.

<list step by step tasks as h3 headers plus bullet points. use as many h3 headers as needed to fix the bug. Order matters, start with the foundational shared changes required to fix the bug then move on to the specific changes. Include tests that will validate the bug is fixed with zero regressions. Your last step should be running the Validation Commands.>

## Validation Commands
Execute every command to validate the bug is fixed with zero regressions.

<list commands you'll use to validate with 100% confidence the bug is fixed with zero regressions. every command must execute without errors. Include commands to reproduce the bug before and after the fix. Reference the test command from CLAUDE.md.>

## Notes
<optionally list any additional notes or context that are relevant to the bug>
```

## Bug
$ARGUMENTS
