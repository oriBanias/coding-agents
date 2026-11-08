---
name: implement
description: Implement an agreed task or plan, using focused subagents when available and useful, then integrate and validate the result. Use only when the user explicitly requests implement.
disable-model-invocation: true
---

# Implement

Complete the agreed task with the simplest maintainable solution.
Use the current conversation, approved plan, or referenced handoff
to establish the goal and authorized scope.

## Understand the task

Before editing:

- Read applicable repository instructions and coding guidelines.
- Inspect the relevant code, existing utilities, and tests.
- Read `docs/index.md` if it exists, then follow the relevant links.
- Confirm the expected behavior and important constraints.
- Inspect existing changes and preserve unrelated user work.

Do not assume a plan still matches the codebase. Adapt routine
implementation details to the current code and explain material
departures from the plan.

Ask a focused question when missing information would materially
change behavior or scope. Otherwise, use reasonable assumptions
and proceed.

## Choose how to execute

Implement small or tightly connected changes directly.

Use subagents when the environment supports them and the work can
be divided into clear, useful responsibilities.

Do not delegate merely because a task touches multiple files.
Consider coordination overhead, shared dependencies, and the risk
of conflicting edits.

If configured implementor roles are available, choose an appropriate
role based on the task's complexity. Do not assume particular agent
names, models, or delegation tools exist.

If delegation is unavailable, complete the work directly and briefly
disclose that limitation when relevant.

## Give each subagent a bounded assignment

Prefer fresh context when the tool supports it. Provide:

- The project location and relevant operating environment.
- The goal, expected behavior, and acceptance criteria.
- Relevant decisions, constraints, specifications, and file paths.
- The files or components the agent owns.
- Dependencies and interfaces it must preserve.
- Appropriate checks to run.
- Instructions to preserve other agents' and the user's changes.

Tell each subagent to read applicable repository instructions and
relevant documentation, starting at `docs/index.md` when present.

Assign non-overlapping edit ownership wherever practical.
Agree on shared interfaces before parallel implementation.

When work depends on another agent's output, sequence it rather
than forcing parallel execution.

Require each agent to report its changes, validation results,
remaining issues, and any assumptions that affect integration.

## Implement within scope

- Reuse existing infrastructure and helpers where appropriate.
- Follow the project's established architecture and conventions.
- Avoid speculative abstractions, unrelated refactors, and unnecessary
  dependencies.
- Handle errors and edge cases that matter to the requested behavior,
  security, data integrity, or resource cleanup.
- Do not add placeholder behavior or silent fallbacks that conceal
  incomplete implementation.
- Respect the actual operating system and shell. Do not assume
  PowerShell, Git Bash, and WSL commands are interchangeable.

Continue through routine implementation problems without asking
the user to make ordinary engineering decisions.

Ask before a consequential expansion of scope or an action that
requires authorization beyond the task.

## Integrate and validate

The coordinating agent remains responsible for the final result.

After delegated work:

- Review the actual changes instead of relying only on agent reports.
- Resolve integration issues and inconsistent assumptions.
- Check that the combined behavior satisfies the task.
- Preserve unrelated work and avoid reverting another contributor's
  changes to make integration easier.

Run checks appropriate to the changes, such as targeted tests,
type checking, linting, builds, or a focused manual verification.

Add or update tests when they meaningfully verify changed behavior.
Avoid tests that merely repeat the implementation.

For visual changes, inspect the result using available browser or
application tools. If visual inspection is unavailable, report the
gap and complete the other relevant checks.

Do not claim native Windows verification from Linux tests or
simulated Windows paths.

Do not run checks that operate physical equipment or affect external
systems unless that action is authorized.

## Finish

Report concisely:

- What changed and how it satisfies the task.
- What was checked and the actual results.
- Any remaining limitations, blockers, or user decisions.

Distinguish completed work from unverified behavior.
If blocked, explain what remains and what is needed to continue.

Do not commit, push, deploy, or publish unless the user authorized it.
