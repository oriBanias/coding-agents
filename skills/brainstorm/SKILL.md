---
name: brainstorm
description: Explore an idea through focused product and architecture questions, clarify assumptions and tradeoffs, and assess readiness for planning. Use only when the user explicitly requests this skill or a brainstorming session.
disable-model-invocation: true
---

# Brainstorm

Help the user clarify an idea before committing to a solution.

Stay exploratory. Do not create an implementation plan, task breakdown,
code, or project changes unless the user explicitly requests that transition.
Read-only inspection and narrowly scoped research are allowed when relevant.

## Establish Context

- Start with what the user has already shared.
- Do not repeat questions that have already been answered.
- If unclear and consequential, establish whether this is a personal
  experiment, a prototype, or a production project.
- For an existing project, inspect relevant documentation or code when
  available before asking questions those sources can answer.

## Ask Focused Questions

Ask one to three meaningful questions at a time.

Prioritize the uncertainties that would most affect the direction:

- Who is the user, what problem do they face, and what outcome matters?
- What would success look like?
- What is in scope, and what is deliberately out of scope?
- What constraints, assumptions, and important edge cases exist?
- Which workflows, roles, integrations, and data are involved?
- What reliability, security, privacy, scale, latency, or operational
  requirements matter for this particular idea?

Treat these as prompts, not a checklist to exhaust.

Use plain language. Explain why a question matters when the reason is
not obvious. Offer a few concrete choices when they make answering easier,
without forcing the user into an unsuitable option.

Ask the user about their goals, preferences, budget, and acceptable tradeoffs.
Research externally verifiable facts rather than asking the user to guess them.

## Explore and Challenge

- Reflect back the current understanding when it helps resolve ambiguity.
- Distinguish confirmed requirements, assumptions, and open questions.
- Challenge contradictions, unnecessary complexity, and unsupported assumptions.
- Explain concerns respectfully and suggest a simpler framing when useful.
- Discuss alternatives and tradeoffs to clarify decisions, but do not turn
  tentative options into a prescribed architecture or implementation plan.
- Do not introduce speculative requirements merely to prolong the discussion.

## Research When Needed

- Research only questions that materially affect the current discussion.
- Prefer primary sources for technical claims and cite relevant findings.
- Use tools available in the current environment.
- Use narrowly scoped research subagents only when supported, permitted,
  and beneficial. Do not require a particular model or reasoning setting.
- If research tools are unavailable, state the uncertainty and continue
  with clearly labeled assumptions where reasonable.
- Return to the discussion after resolving the factual question.

## Recognize Readiness

Stop asking questions when the key uncertainties for the next decision
are sufficiently understood. Do not require every implementation detail
to be settled before planning.

Provide a concise summary of:

- The problem, intended users, and desired outcome.
- Agreed scope and constraints.
- Important tradeoffs and decisions.
- Remaining assumptions or questions that can be resolved later.

State whether the idea is ready for planning and explain any material blocker.

Do not begin planning or implementation automatically.
If the user explicitly requests the next stage, acknowledge the transition
and follow that request without asking for redundant confirmation.
