# Chore Planning

Create a new plan in specs/*.md to resolve the `Chore` using the exact specified markdown `Plan Format`. Follow the `Instructions` to create the plan and use the `Relevant Files` to focus on the right files.

## Instructions

- You're writing a plan to resolve a chore. It should be simple but thorough and precise so we don't miss anything or waste time with any second round of changes.
- Create the plan in the `specs/*.md` file. Name it appropriately based on the `Chore`.
- Use the plan format below to create the plan.
- Research the codebase and put together a plan to accomplish the chore.
- IMPORTANT: Replace every <placeholder> in the `Plan Format` with the requested value. Add as much detail as needed to accomplish the chore.
- Use your reasoning model: THINK HARD about the plan and the steps to accomplish the chore.
- Respect requested files in the `Relevant Files` section.
- Start your research by reading the `README.md` and `CLAUDE.md` files.

## Relevant Files

Focus on the following files:
- `README.md` - Contains the project overview and instructions.
- `CLAUDE.md` - Contains project conventions, key paths, and commands.
- Project source directories and files relevant to the chore.
- `scripts/` - Contains utility and development scripts.

## Plan Format

```md
# Chore: <chore name>

## Chore Description
<describe the chore in detail>

## Relevant Files
Use these files to resolve the chore:

<find and list the files that are relevant to the chore and describe why they are relevant in bullet points. If there are new files that need to be created, list them in an h3 'New Files' section.>

## Step by Step Tasks
IMPORTANT: Execute every step in order, top to bottom.

<list step by step tasks as h3 headers plus bullet points. use as many h3 headers as needed to accomplish the chore. Order matters, start with the foundational shared changes then move on to the specific changes. Your last step should be running the Validation Commands.>

## Validation Commands
Execute every command to validate the chore is complete with zero regressions.

<list commands you'll use to validate with 100% confidence the chore is complete with zero regressions. every command must execute without errors. Reference the test command from CLAUDE.md.>

## Notes
<optionally list any additional notes or context that are relevant to the chore>
```

## Chore
$ARGUMENTS
