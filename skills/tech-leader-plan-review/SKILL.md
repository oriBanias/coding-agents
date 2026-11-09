---
name: tech-leader-plan-review
description: Review an implementation plan for concrete correctness problems, unsupported assumptions, missing steps, and data-flow failures, then revise it within the agreed scope. Use only when explicitly requested.
disable-model-invocation: true
---

# Tech Leader Plan Review

Review the current plan against the user's requirements and the
existing implementation. Correct problems that would prevent it
from delivering the required behavior.

Review and update the plan only. Do not implement application changes,
install dependencies, or run migrations.

## 1. Establish the context

Identify the plan from the user's request or current conversation.
If several plans could apply, clarify which one to review.

Read:

- The plan and any linked phase files.
- The user's requirements and acceptance criteria.
- Relevant decisions and constraints.
- Applicable repository instructions.
- Documentation, code, tests, and configuration needed to assess
  the proposed behavior.

Verify important assumptions against the implementation.
Distinguish existing capabilities from proposed additions.

If relevant evidence is unavailable, state what cannot be verified.
Do not invent project behavior or interfaces.

## 2. Obtain an independent review when available

Use a subagent with fresh context when supported.

Provide the plan, requirements, constraints, and relevant source
references. Choose an available reviewer suited to reasoning about
correctness and architecture.

Do not require a particular model name or reasoning setting.

Ask the reviewer to return findings without editing files.

Each finding should include:

- The affected plan section.
- The incorrect assumption, missing step, or failure scenario.
- Supporting evidence from requirements or the current code.
- The expected impact.
- The smallest correction that addresses the problem.

If independent review is unavailable, perform the review directly
and disclose that limitation.

## 3. Check correctness

Focus on concrete problems in the proposed approach:

- Logic that does not satisfy the required behavior.
- Assumed functions, interfaces, or capabilities that do not exist.
- Missing integration, configuration, or migration steps.
- Incompatible contracts between producers and consumers.
- Dependencies used before they are available.
- Acceptance criteria that do not demonstrate the intended outcome.

For multi-phase plans, check that each phase can work with the
capabilities available at that point.

Do not mistake an intentionally deferred capability for a missing
step unless an earlier phase depends on it.

## 4. Trace relevant data flows

Follow important data through the proposed implementation:

- Where it originates and how it is validated.
- How it is transformed and passed between components.
- Where it is stored and which component owns updates.
- How it reaches users or downstream consumers.
- What happens if an operation fails or completes only partially.

Where relevant, check:

- Authorization and trust boundaries.
- Duplicate requests, retries, and concurrent updates.
- Data loss, duplication, or inconsistent state.
- Resource cleanup and cancellation.
- Compatibility with existing stored data and consumers.
- Units, timestamps, or ordering assumptions.
- Hardware interactions and safe failure behavior.

Apply these checks only where the task makes them relevant.
Do not turn them into a requirement to add every possible safeguard.

## 5. Check supported edge cases

Consider realistic cases arising from expected inputs and supported
behavior, such as empty results, invalid input, repeated actions,
or unavailable dependencies.

Explain the trigger and consequence of each issue.

Avoid speculative scenarios, unrelated improvements, or requirements
that the user has not established.

If behavior depends on an unresolved product decision, flag the
decision rather than silently choosing an answer.

## 6. Evaluate findings and update the plan

Verify reviewer findings against the code and requirements.
Treat them as hypotheses, not automatic instructions.

Incorporate justified corrections using the simplest viable approach.

Preserve the agreed scope. If a required correction would materially
expand it, explain the issue and ask for the relevant decision before
rewriting the plan around that expansion.

When a plan file exists, update it in place while preserving unrelated
content and user edits.

For multi-file plans, update affected phase files and the index.

After editing, check that:

- Dependencies and phase ordering remain coherent.
- Interfaces and data-flow descriptions agree.
- Acceptance criteria cover the corrected behavior.
- Planned verification can expose the identified failure.
- No steps still rely on an assumption that was removed.

If no plan file exists, provide the revised plan in the conversation.
Do not create a new file unless requested.

Use file operations appropriate to the actual operating system
and shell.

## 7. Report the result

Briefly explain:

- Material correctness problems addressed.
- Why the changes are needed.
- Any unresolved decisions or verification limitations.
- Whether an independent review was completed.

Link to the updated plan when applicable.

If no justified changes are needed, say so. Do not manufacture
findings or expand the plan to demonstrate review effort.

Do not implement, commit, push, or publish as part of this review.
