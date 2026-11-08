---
name: multi-phase-plan
description: Create a codebase-grounded implementation plan split into meaningful, verifiable phases. Present the outline for approval before writing linked plan files. Use only when explicitly requested.
disable-model-invocation: true
---

# Multi-Phase Plan

Turn the agreed goal into a small number of coherent implementation
phases grounded in the actual project.

Plan only. Do not implement application changes, install dependencies,
run migrations, or start implementation agents.

## 1. Establish the goal and current state

Use the conversation and any referenced specifications or handoffs.

Before planning:

- Read applicable repository instructions and relevant documentation.
- Inspect the code, interfaces, configuration, and tests affected.
- Identify existing utilities and infrastructure that can be reused.
- Read `docs/utils.md` if present and verify relevant entries in code.
- Identify important constraints, dependencies, and uncertainties.

Distinguish verified facts from assumptions and proposed changes.
Do not invent existing files, functions, or capabilities.

Ask focused questions only when the answers materially affect scope,
phase order, or architecture.

If repository access is unavailable, label the plan provisional and
identify what must be verified before implementation.

## 2. Define meaningful phases

Use the fewest phases that make the work practical to implement
and evaluate.

Each phase should:

- Deliver a meaningful capability or verifiable technical outcome.
- Leave the project in a coherent, working state.
- Depend only on capabilities already available or delivered earlier.
- Have a clear scope and concrete acceptance criteria.
- Include practical verification steps.
- Explicitly identify relevant deferred work.

Prefer thin end-to-end slices over separate frontend, backend,
and integration phases when practical.

Group closely related operations into a coherent capability.
A button or helper function is usually a task within a phase.

When several features share a genuine abstraction, introduce it
alongside one representative end-to-end use case. Add the remaining
cases later when that separation is useful.

Do not add speculative abstractions or phases merely to make
the plan look comprehensive.

Validate risky assumptions and external integrations early.

A technical foundation or investigation may be a phase when it
produces an observable result and a clear decision or usable capability.

If the work fits naturally into one focused plan, say so instead
of forcing multiple phases.

## 3. Present the outline for approval

Before creating files, present:

- The goal and overall scope.
- The proposed phases and the outcome of each.
- Important dependencies and ordering decisions.
- Material assumptions or unresolved questions.
- The proposed plan directory.

Use `docs/plans/<feature-name>/` unless repository instructions or
the user specify another location.

Choose a short, descriptive, Windows-safe directory name.

Ask the user to approve or revise this outline before writing
the plan files.

If the user already explicitly approved the same outline and
requested the files, proceed without asking again.

Approval to write the plan does not authorize implementation.

## 4. Write the approved plan

Create:

- `index.md`
- Numbered phase files such as `01-foundation.md` and
  `02-first-workflow.md`

Use descriptive filenames and relative Markdown links.

Inspect an existing plan directory before writing. Preserve unrelated
plans and user edits. Do not silently replace a different plan.

### Index

Keep `index.md` concise. Include:

- Goal and expected final outcome.
- Overall scope and important exclusions.
- Relevant current architecture and shared decisions.
- An ordered phase list with links and outcomes.
- Dependencies, material risks, and unresolved assumptions.

Record shared context once here instead of repeating it in every phase.

### Phase files

Each phase should include:

#### Outcome

What becomes possible or verifiable when the phase is complete.

#### Prerequisites and scope

What must already exist and what this phase includes.

#### Implementation changes

Describe meaningful changes to relevant files, components, interfaces,
data, configuration, or integrations.

Identify existing code to reuse and distinguish proposed files or
functions from existing ones.

Include removals or replacements when relevant.

Keep the detail specific enough to guide implementation without
writing the implementation itself.

#### Acceptance criteria

List observable conditions that demonstrate the phase is complete.
Avoid vague criteria such as "works correctly."

#### Verification

Provide concrete manual steps and expected results.

State prerequisites, working directory, shell, services, or hardware
when relevant. Use commands appropriate to the actual environment.

Do not invent runnable commands for tooling that does not exist yet.
Clearly label checks that depend on the phase's implementation.

Identify up to three high-value automated test scenarios by default.
Use fewer when sufficient, or more when distinct critical behaviors
justify them.

Separate planned checks from checks already executed.

#### Deferred work

Briefly state relevant capabilities intentionally left for later phases
or outside the overall scope.

Do not repeat an exhaustive list of everything the project will not do.

## 5. Keep the solution proportionate

- Prefer existing infrastructure and straightforward implementations.
- Avoid unnecessary fallbacks, abstractions, and defensive layers.
- Include error handling where needed for correctness and recovery.
- Account for security, authorization, data integrity, resource cleanup,
  and hardware safety when relevant.
- Include migration compatibility or rollback considerations when
  the proposed changes require them.
- Focus on realistic failure modes rather than every imaginable edge case.

Use plain language. Introduce technical terms only when they make
the plan more precise.

## 6. Review the complete plan

When subagents are available, request an independent review using
fresh context where supported.

Provide the reviewer with:

- The approved goal and constraints.
- The plan files and relevant repository instructions.
- The source files needed to verify important claims.
- The review criteria below.

Do not require a particular model, agent name, or reasoning setting.

The review should check:

- Consistency between the index and phase files.
- Correct ordering and absence of circular dependencies.
- Coherent, verifiable outcomes for every phase.
- Alignment with the existing codebase.
- Clear acceptance criteria and practical verification steps.
- Missing work, duplication, or unnecessary complexity.
- Compliance with the approved scope.

If independent review is unavailable, perform these checks yourself
and accurately report that limitation.

Resolve findings within the approved scope. If review reveals a
material change to the scope or phase structure, explain it and
obtain approval before finalizing that change.

## 7. Finish

Link to the index and summarize the phases briefly.

State any unresolved assumptions and whether an independent review
was completed.

Stop after planning. Do not begin implementation, commit, push,
or publish unless separately authorized.
