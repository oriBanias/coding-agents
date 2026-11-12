# Coding Agents (written by Codex)

A personal toolkit of reusable agents, skills, hooks, prompts, and configurations for AI-assisted software development.

## About

This repository brings together resources I develop and refine through everyday engineering work and experimentation.

The goal is to make coding agents more useful, consistent, and reliable across projects, with clear instructions, focused workflows, and practical automation.

These resources reflect my workflow. Use them as a starting point, review their assumptions, and adapt them to your own projects.

## Resources

The collection will grow to include:

| Resource | Purpose |
|---|---|
| **Agents** | Specialized roles for tasks such as planning, implementation, debugging, and code review. |
| **Skills** | Reusable instructions and supporting resources for specific workflows. |
| **Hooks** | Scripts triggered by supported agent events to automate checks and routine actions. |
| **Prompts** | Templates for recurring engineering tasks. |
| **Guidelines** | Shared expectations for code quality, testing, and agent behavior. |
| **Configurations** | Tool-specific examples for connecting and using these resources. |

Resources will be added incrementally as they are tested and refined.

## Engineering Principles

- **Understand before changing.** Inspect existing code, conventions, and constraints before proposing a solution.
- **Verify assumptions.** Check documentation and implementation details rather than relying on guesses.
- **Keep changes focused.** Prefer clear, maintainable solutions with minimal unnecessary complexity.
- **Validate the outcome.** Run relevant checks and report what was verified and what remains uncertain.
- **Protect sensitive data.** Keep credentials, private code, and machine-specific state out of this repository.
- **Keep automation explicit.** Document what an agent or hook can execute and when it runs.

## Getting Started

1. Clone this repository to your machine.
2. Choose a resource that addresses a specific task in your workflow.
3. Read its instructions, dependencies, and any scripts it includes.
4. Follow the setup instructions for your coding tool.
5. Test it in a small project before adopting it more broadly.

Cloning this repository does not install or activate its resources.

## Tool Compatibility

Compatibility is documented per resource. Instructions, configuration formats, hook events, and installation locations can differ between coding tools.

Do not assume that a resource designed for one tool works unchanged in another.

## Managing Shared Resources

This repository is intended to be the source of truth for reusable resources.

Where supported, individual files or directories can be linked into a coding tool’s expected locations to avoid maintaining duplicate copies.

When setting up links:

- Back up existing files before replacing them.
- Link only the resources you intend to share.
- Preserve directories and files managed by the coding tool.
- Keep local settings and private application data outside this repository.
- Verify that each link resolves correctly.

Edits made through a symbolic link change the original resource in this repository. Review those changes before committing them.

## Project Status

This is an evolving personal toolkit. Resources may change as I learn, test new approaches, and refine my workflow.

### Choosing when a skill runs

Skills such as `wt-cleanup` and `implement` are selected explicitly.
In Codex, use `$skill-name`. In Claude Code, use `/skill-name`.

When adding an explicit-only skill, set `policy.allow_implicit_invocation`
to `false` in its `agents/openai.yaml` and `disable-model-invocation`
to `true` in its `SKILL.md` frontmatter.

Skills intended for automatic use, such as `research`, can keep their
default invocation settings.

## License

Original content in this repository is licensed under the [MIT License](LICENSE).

Any included third-party material remains subject to its original license and attribution requirements.

See the [hook guide](hooks.md) for available hooks, required companion files, and Windows setup.
