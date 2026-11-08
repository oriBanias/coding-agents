---
name: double-cr
description: Review a defined set of code changes with separate feature-completeness and code-quality reviewers, then consolidate evidence-backed findings. Use only when the user explicitly requests double-cr.
disable-model-invocation: true
---

# Double Code Review

Review the requested changes using at least two focused subagents when
delegation is available and permitted.

Keep the review read-only. Do not modify source files, apply fixes, commit,
or publish comments unless the user explicitly requests those actions.

## Establish the Review Scope

- Identify the repository, requested change, and expected behavior.
- Use the user's specified commit, branch comparison, pull request,
  staged changes, or working-tree changes.
- If scope is unspecified, inspect repository status. Use current
  uncommitted changes when that is clearly the intended scope.
- Ask a focused question if the review target remains ambiguous.
- Record the comparison base and target, or describe the working-tree
  snapshot being reviewed.
- Include relevant untracked source files when reviewing uncommitted work.
- Give every reviewer the same scope and snapshot.
- If the code changes during review, identify the affected findings and
  recheck them before presenting conclusions.

Read applicable repository instructions, including AGENTS.md, CLAUDE.md,
and CODING_GUIDELINES.md where present.

Use relevant shared coding guidelines when available. Do not assume that
every project contains the same instruction files or directory structure.

## Delegate Focused Reviews

Start two independent reviewers, preferably in parallel.

Use fresh contexts without full conversation history when supported.
Provide each reviewer with:

- The repository path and exact review scope.
- The task requirements or acceptance criteria already available.
- Relevant constraints and applicable instruction-file paths.
- Their review role and the required findings format.
- An explicit instruction not to edit files or publish results externally.

Do not give reviewers another reviewer's findings before their initial
independent assessment.

### Reviewer 1: Feature Completeness and Correctness

Check whether the changes satisfy the stated requirements.

Focus on:

- Missing or partially implemented behavior.
- Incorrect main workflows and meaningful failure paths.
- Integration points, callers, and compatibility.
- Regressions caused by the change.
- Tests that meaningfully demonstrate the required behavior.

Do not invent requirements. If acceptance criteria are unavailable,
state what completeness could not be assessed.

### Reviewer 2: Code Quality and Maintainability

Check the implementation against applicable project conventions.

Focus on:

- Clear responsibilities and understandable control flow.
- Unnecessary complexity, duplication, or abstraction.
- Fragile workarounds and hidden coupling.
- Error handling, cleanup, and data integrity.
- Relevant security, concurrency, and performance risks.
- Tests that would catch meaningful regressions.

Recommend refactoring when it addresses a concrete problem in the change.
Do not request broad restructuring or stylistic churn without clear value.

### Additional Reviewers

Add reviewers only when the size or risk of the change justifies separate
expertise, such as database migrations, security, UI behavior, or concurrency.

Give each additional reviewer a bounded responsibility.
Avoid redundant reviews and uncontrolled recursive delegation.

If subagents are unavailable or prohibited, disclose that limitation and
perform two explicitly labeled review passes yourself. Do not describe
those passes as independent reviewers.

## Review Standards

- Focus findings on problems introduced or materially affected by the change.
- Read surrounding code and callers as needed to establish impact.
- Keep unrelated pre-existing issues separate from change-specific findings.
- Prioritize realistic failure scenarios over speculative edge cases.
- Do not dismiss security, data-loss, cleanup, or hardware-safety risks
  merely because they occur outside the happy path.
- Prefer simple, robust solutions over patches that hide the underlying issue.
- Follow the project's actual language, framework, and architecture.
- Use commands appropriate to the current operating system and shell.
- Run relevant checks only when safe and useful. Do not run destructive,
  production-connected, or hardware-dependent tests without authorization.
- Never claim a test passed unless it was actually run.

## Finding Format

For each actionable finding, provide:

- Severity: Critical, High, Medium, or Low.
- A short, specific title.
- File path and relevant line number where possible.
- The triggering condition or concrete scenario.
- The resulting impact.
- Supporting evidence from code, requirements, or executed checks.
- A concise suggested correction.

Use severity based on actual impact and likelihood.
Do not report personal preferences as defects.
Keep uncertain concerns separate and explain what would verify them.

## Consolidate and Verify

- Wait for the reviewers that were started and disclose incomplete reviews.
- Verify significant findings against the code.
- Merge duplicate findings and resolve disagreements using evidence.
- Do not treat reviewer agreement alone as proof.
- Remove findings based on incorrect assumptions.
- Separate actionable defects from optional improvements.

## Final Response

Lead with actionable findings, ordered by severity.

Then briefly report:

- The scope reviewed.
- Which review roles were completed.
- Tests or checks actually performed.
- Material uncertainties and coverage limitations.

If there are no actionable findings, say so plainly.
Do not imply that the absence of findings proves the code is defect-free.

Do not begin fixing findings unless the user requests fixes.
