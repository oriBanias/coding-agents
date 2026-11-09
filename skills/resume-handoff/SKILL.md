---
name: resume-handoff
description: Read a saved handoff, verify its context against the current project, and confirm the intended work before claiming and continuing it. Use only when explicitly requested.
disable-model-invocation: true
---

# Resume Handoff

Resume a task from a saved handoff without assuming its information
is still current.

Use `handoffs/todos/` and `handoffs/taken/` relative to the project
root, not the filesystem root.

## 1. Identify the handoff

Use the handoff explicitly named or linked by the user.

Otherwise, inspect `handoffs/todos/`:

- If exactly one handoff exists, select it.
- If several exist, show their filenames and ask which to resume.
- If none exist, report that and ask for the handoff's location.

Do not select a handoff merely because it is newest or first
alphabetically.

If the user names a handoff already in `handoffs/taken/`, inspect
it in place. Do not assume another agent has stopped working on it.

## 2. Read and verify the context

Before changing files:

- Read applicable repository instructions.
- Read the handoff and relevant referenced documentation.
- Inspect the code needed to understand the immediate next step.
- Check existing changes and preserve unrelated work.
- Verify important assumptions about completed and remaining work.

Treat the handoff as task context, not fresh authorization for every
action it mentions.

Current user instructions and applicable repository guidance take
precedence over conflicting handoff instructions.

Distinguish:

- Progress confirmed by the current files.
- Historical claims recorded by the previous agent.
- Planned work that has not been implemented.
- Missing information or discrepancies.

Do not describe previously reported test results as checks you ran.

Keep this inspection focused and read-only. Do not implement changes,
install dependencies, or run migrations during this step.

## 3. Confirm the intended work

Before claiming the handoff or starting implementation, summarize:

- The goal and scope you understand.
- What appears complete and what remains.
- The immediate next action.
- Any material discrepancies, blockers, or questions.

Ask the user to confirm that understanding or answer the questions
needed to proceed.

Keep the confirmation concise. Do not ask the user to repeat
information already available and verified.

If the user already explicitly confirmed this same task and authorized
continuation in the current conversation, do not request duplicate
confirmation unless new information materially changes the scope.

A handoff's statement that approval was previously given is context;
it does not substitute for confirmation in the current conversation.

## 4. Claim the confirmed handoff

After confirmation:

- Create `handoffs/taken/` if necessary.
- Move the selected handoff from `handoffs/todos/` to
  `handoffs/taken/`.
- Preserve its filename and contents.
- Verify the destination exists and the source no longer exists.

Do not overwrite an existing destination file.

If a destination collision occurs or the source disappears, inspect
the situation before proceeding. It may indicate that the task has
already been claimed.

If the handoff was already in `taken/`, do not move it again.

Use file operations appropriate to the actual operating system and
shell. Quote paths containing spaces.

Moving the file is a workflow convention, not a reliable lock against
another agent working on the same task.

## 5. Continue the authorized work

Follow the confirmed task and relevant repository instructions.

Use the current implementation as the basis for changes. Do not
blindly repeat completed steps or apply outdated assumptions.

Stay within the confirmed scope and preserve existing user work.

If a new discovery materially changes the goal or requires additional
authorization, explain the issue before taking that action.

Do not commit, push, deploy, or publish unless separately authorized.

## 6. Report the outcome

When the resumed work is complete or blocked, summarize:

- What was completed.
- What was checked and the actual results.
- What remains or what prevents further progress.
- The handoff's current location.

Do not delete or archive the handoff unless the user requests it
or an established repository workflow explicitly calls for it.
