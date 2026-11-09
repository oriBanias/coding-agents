---
name: senior-plan-review
description: Review an implementation plan against current requirements and code, then simplify unnecessary complexity while preserving correctness and required behavior. Use only when explicitly requested.
disable-model-invocation: true
---

# Senior Plan Review

Review the current plan and revise it to use the simplest approach
that satisfies the user's requirements.

This is a plan review. Do not implement application changes, install
dependencies, or run migrations.

## 1. Establish the review scope

Identify the plan from the user's request or current conversation.

If several plans could apply and the intended one is unclear,
ask which to review.

Read:

- The plan and any linked phase files.
- The user's requirements and relevant decisions.
- Applicable repository instructions.
- Relevant documentation and existing code.
- Tests or configuration that establish important constraints.

Verify important assumptions against the implementation.
Do not rely solely on the plan's description of the codebase.

If required context is unavailable, identify the limitation and
avoid speculative changes based on unverified assumptions.

## 2. Obtain an independent review when available

Use a subagent with fresh context when supported.

Provide:

- The plan and its location.
- The user's requirements and acceptance criteria.
- Relevant constraints and decisions.
- Pointers to the documentation and code needed for review.

Choose an available reviewer suited to architectural reasoning.
Do not require a particular model name or reasoning setting.

Ask the reviewer to return findings without editing files.

Each finding should identify:

- The affected plan section.
- What adds unnecessary complexity.
- Why it is unnecessary for the current requirements.
- A concrete simpler alternative.
- Any behavior or constraint the alternative could affect.

If subagents are unavailable, perform the review directly and
disclose that an independent review was not performed.

## 3. Look for unjustified complexity

Focus on:

- Unnecessary abstractions, layers, or indirection.
- Refactors broader than the task requires.
- Features included only for hypothetical future needs.
- Premature optimization without evidence of a current need.
- Dependencies or configuration without a concrete benefit.
- Duplicate mechanisms or unnecessary fallback paths.
- Implementation steps that do not support an actual requirement.
- Existing utilities or patterns the plan could reuse.

Do not equate fewer files, fewer lines, or fewer tests with a
simpler solution automatically.

Consider how easy the result will be to understand, implement,
verify, and maintain.

## 4. Preserve necessary behavior

Keep complexity that has a concrete justification, including:

- Required functionality and supported compatibility.
- Security and authorization requirements.
- Data integrity, transactions, and resource cleanup.
- Relevant failure handling and recovery.
- Established architectural constraints.
- Performance requirements supported by evidence.
- Hardware or operational safety where applicable.

When retaining a disputed design choice, explain its purpose
briefly in the plan.

Do not remove a requirement simply because implementing it
is inconvenient.

If simplification depends on an unresolved product decision,
flag that decision instead of silently choosing different behavior.

## 5. Evaluate findings and revise the plan

The coordinating agent is responsible for the final revision.

Verify reviewer findings against the requirements and code.
Accept only changes that improve the plan without losing necessary
behavior or expanding the task.

When a plan file exists, update it in place. Preserve unrelated
content and existing user edits.

For multi-file plans, update affected phase files and the index
so they remain consistent.

After simplifying, check:

- Dependencies and phase order.
- Interfaces and shared assumptions.
- Acceptance criteria.
- Manual verification steps and planned automated checks.
- References to removed or renamed work.

Do not leave downstream steps depending on something removed
from the plan.

If no plan file exists, provide the revised plan in the conversation.
Do not create a new file unless requested.

Use file operations appropriate to the current operating system
and shell.

## 6. Report the result

Briefly explain:

- Material simplifications and why they help.
- Important complexity retained and its justification.
- Any unresolved decisions or review limitations.

Link to the updated plan when applicable.

If no changes are justified, say so. Do not manufacture edits
to demonstrate that a review occurred.

Do not implement, commit, push, or publish as part of this review.
