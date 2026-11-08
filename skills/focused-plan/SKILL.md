---
name: focused-plan
description: Create a concise, codebase-grounded implementation plan for a bounded task, identifying meaningful changes, reuse opportunities, and validation. Use only when the user explicitly requests focused-plan.
disable-model-invocation: true
---

# Focused Plan

Create a practical plan for the requested task.
Plan only. Do not implement changes, install dependencies, run migrations,
or modify project files.

Read-only inspection and narrowly scoped research are allowed.
Write a plan file only when the user requests one.

## Understand the Task

- Establish the desired outcome, scope, constraints, and acceptance criteria.
- Use the context already provided instead of repeating answered questions.
- Ask a focused question when missing information materially changes the
  implementation approach.
- Otherwise, proceed with clearly stated assumptions.
- Keep the plan proportional to the task. Do not expand a bounded change
  into a broader redesign.

## Inspect the Existing Code

- Read applicable repository instructions and relevant coding guidelines.
- Inspect the affected code, callers, interfaces, and existing tests.
- Search for reusable infrastructure, components, utilities, and patterns.
- Read docs/utils.md if it exists, then verify relevant entries against
  the actual implementation.
- Identify existing behavior and compatibility requirements to preserve.
- If the repository is unavailable, state that the plan is provisional.
  Do not invent existing files, functions, or architectural details.

## Choose the Smallest Coherent Solution

- Reuse existing code when it fits the requirement.
- Prefer focused changes over new abstractions, layers, or dependencies.
- Introduce helpers when they clarify responsibilities or enable meaningful
  reuse, not solely to make functions shorter.
- Avoid speculative fallbacks and support for unrequested scenarios.
- Include validation, error handling, cleanup, and recovery where required
  for correctness, data integrity, or safe operation.
- Handle expected failures at appropriate boundaries.
- Do not restrict error handling to entry and exit points when resources,
  transactions, concurrency, or hardware require additional care.
- Mention alternatives only when a meaningful tradeoff needs a decision.
  Recommend one approach and explain why.

## Describe Meaningful Changes

Cover only the categories relevant to the task:

- Existing files, modules, functions, or components to change.
- New functions or components and their responsibilities.
- Code to remove and the behavior that replaces it, if any.
- New or changed types, contracts, and public interfaces.
- Integrations or dependencies to add, change, or remove.
- Database queries, schema changes, migrations, and data cleanup.
- Existing helpers to reuse or extend.
- Configuration or documentation changes needed for the result.

Distinguish verified existing names from proposed names.
Avoid line-by-line edit instructions and trivial changes.

For interface or schema changes, identify affected consumers.
Include deployment ordering, compatibility, or rollback considerations
only when they materially affect the task.

## Structure the Plan

Use this compact structure, omitting sections that add no useful information:

### Goal and Scope

State the intended behavior and important exclusions.

### Existing Code to Reuse

Identify verified components, helpers, or infrastructure and their roles.

### Implementation Steps

List meaningful steps in dependency order.
For each step, explain what changes, where it belongs, and why.
Use concrete file or symbol references when verified.

### Validation

Describe how to verify the acceptance criteria.
Include relevant automated checks, regression cases, and manual or visual
checks where appropriate.

Distinguish proposed checks from checks already performed.
Use commands appropriate to the project's actual toolchain and shell.
Identify hardware or external-service requirements when applicable.

### Risks and Open Decisions

Include only material risks, unresolved choices, and assumptions.
Make blockers explicit rather than hiding them inside implementation steps.

## Communication and Completion

- Use plain language and concrete verbs.
- Use technical terms only when they improve precision.
- Keep the plan concise enough to review before implementation.
- Avoid full implementations or large code blocks.
- Finish after presenting the plan.
- Do not treat requesting a plan as permission to implement it.
- If the user subsequently requests implementation, follow that request
  without asking for redundant confirmation.
