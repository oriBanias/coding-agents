# React Guidelines

Apply these alongside [General Guidelines](general.md) and
[Frontend Guidelines](frontend.md).

## Components

- Reuse existing components when their behavior and semantics fit.
- Keep components focused and their data flow understandable.
- Use the project's component library when available.
- If the project uses Mantine, prefer its components and styling APIs where
  they simplify the implementation.
- Use semantic HTML and custom CSS when they are the clearer or more
  appropriate choice.
- Extract shared components when there is meaningful reuse, not merely
  similar-looking markup.

## State and Data Flow

- Use props for explicit component inputs.
- Keep state local unless multiple consumers need to share it.
- Lift state to the nearest appropriate common owner when needed.
- Use context or the project's state-management library for genuinely
  shared concerns.
- Do not introduce MobX or another store solely to avoid passing props.
- Avoid duplicating values that can be derived from existing state or props.

## Rendering and Effects

- Keep rendering free of side effects.
- Use effects for synchronization with external systems, not as the default
  way to calculate derived values.
- Clean up subscriptions, timers, and other external resources.
- Follow the Rules of Hooks and the project's lint configuration.
- Use stable keys that represent item identity.
- Add memoization when supported by a concrete performance need.

## Verification

- Test user-visible behavior and important state transitions.
- Check keyboard operation, accessible names, and focus behavior.
- Verify loading, empty, error, and success states where applicable.
