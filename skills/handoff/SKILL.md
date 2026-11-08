---
name: handoff
description: Write a concise handoff document so another agent can continue the current task with the relevant context, decisions, progress, and next steps. Use only when the user explicitly requests a handoff.
disable-model-invocation: true
---

# Handoff

Create a lean, self-contained document that lets another agent
continue the current task without reconstructing the conversation.

Write the document only. Do not continue implementation or start
another agent unless the user explicitly asks.

## Establish the current state

Use the conversation and inspect relevant project files to confirm:

- The user's goal and the remaining scope.
- Decisions already made and constraints that affect the work.
- What is implemented, partially implemented, or still planned.
- Relevant uncommitted changes, when working in a Git repository.
- Validation already performed and its actual results.
- Known blockers or approaches that were tried and did not work.

Distinguish verified facts from assumptions and proposals.
Do not describe planned changes as completed work.

If the project or relevant files are unavailable, say what could
not be verified instead of inventing details.

## Write the handoff

Save a new Markdown file under `handoffs/todos/`, relative to the
current project's root.

Use a descriptive, Windows-safe filename, such as:
`handoff-calibration-csv-export.md`

Do not overwrite an existing handoff. Add a numeric suffix if needed.
Create the directory if it does not exist.

Keep the document focused on what the next agent needs:

### Goal and scope

Explain the desired outcome and the work that remains.
Include important user constraints and acceptance criteria.

### Current state

Summarize completed and partially completed work.
Identify relevant uncommitted changes that must be preserved.

### Decisions and known blockers

Record decisions that guide the next steps and why they matter.
Include failed approaches only when they would prevent repeated work.

### Relevant files

List the small set of project-relative paths needed to continue.
Explain briefly why each file matters.

Point to existing documentation for deeper context rather than
duplicating it. Include applicable repository instruction files.

### Next steps

Give a short, ordered list of concrete actions.
Identify the immediate next action and any unresolved decisions.

Preserve the user's authorized scope. If implementation has not
been authorized, say so.

### Validation

Record checks already run, their results, and checks still needed.
Mention required tools, services, or hardware when relevant.

For commands, identify the working directory and shell when they
matter, especially for PowerShell, Git Bash, or WSL on Windows.

## Keep it lean and safe

- Use plain language and omit empty or irrelevant sections.
- Preserve essential context, not the full conversation.
- Do not include credentials, tokens, private payloads, or unrelated
  personal information.
- Prefer project-relative paths over machine-specific absolute paths.
- Do not claim the handoff itself has been tested by another agent.
- Do not commit, push, or modify application code as part of this skill.

Finish by linking to the handoff file and briefly stating what it covers.
