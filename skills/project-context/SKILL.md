---
name: project-context
description: Gather focused, code-verified project context for the user's task before planning or implementation. Use only when explicitly requested.
disable-model-invocation: true
---

# Project Context

Understand the parts of the project relevant to the user's task.

Start with documentation, follow its references into the code,
and stop when there is enough context to proceed.

This skill gathers context only. It does not authorize implementation,
configuration changes, dependency installation, or documentation edits.

## 1. Read project guidance

Read these files at the project root when they exist:

- `README.md`
- `AGENTS.md`
- `CLAUDE.md`
- `AGENT.md`, if the repository uses that filename

Follow applicable repository instructions, including instructions
in relevant subdirectories.

Read `docs/index.md` when present. If the project uses another
documentation location, follow the links from its README.

Do not assume missing documentation means the project has no guidance.

## 2. Follow the task's scope

Identify the feature, workflow, or component involved in the request.

Read only the documentation that helps explain:

- The relevant behavior and architecture.
- Important interfaces and dependencies.
- Constraints or decisions that affect the task.
- Existing utilities or patterns that can be reused.

Follow references into the relevant code. Read callers, configuration,
or tests when needed to understand the behavior and its contract.

If `docs/utils.md` exists, consult it when looking for reusable code.

Avoid loading unrelated documentation or exploring the entire
repository without a concrete reason.

## 3. Verify against the implementation

Treat documentation as a starting point, not proof of current behavior.

Check important claims against the actual code and relevant tests.

Distinguish:

- Behavior confirmed by the implementation.
- Intended behavior described only in documentation.
- Assumptions or questions that remain unresolved.

Reading tests reveals expected behavior; it does not prove they pass.

When documentation and code disagree, describe the discrepancy.
Do not silently choose one as the intended requirement.

## 4. Expand inspection only when needed

Use file-reading tools and narrow searches to locate relevant files,
symbols, and references.

Prefer `rg` or an equivalent available search tool. Use commands
appropriate to the actual operating system and shell.

Broaden inspection only to resolve a specific gap. Avoid broad dumps
of repository contents or environment state.

Do not start services, run builds or tests, connect to databases,
query live application data, or inspect credentials merely to gather
initial context.

If the task requires runtime investigation, explain the remaining
gap and distinguish that investigation from this initial context pass.
Proceed only within the user's authorized scope.

## 5. Finish with a concise context summary

Summarize:

- The relevant project behavior and structure.
- Key files and why they matter.
- Existing code or patterns worth reusing.
- Constraints, discrepancies, or unanswered questions that affect
  the requested task.

Use project-relative paths where practical.

Keep the summary proportional to the task. Do not reproduce the docs,
write an implementation plan, or propose unrelated improvements.

If the user also requested planning or implementation, continue into
that already-authorized work after gathering context. Otherwise,
stop after the summary.
