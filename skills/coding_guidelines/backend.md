# Backend Guidelines

Apply these alongside [General Guidelines](general.md).

## Architecture

- Follow the project's existing backend framework and architecture.
- For HTTP services, separate routing, request handling, business logic,
  and persistence where that separation adds clarity.
- Keep controllers focused on transport concerns.
- Keep business rules independent of HTTP details where practical.
- Organize by cohesive capability or feature.
- Introduce directories and layers when useful, not by default for every
  small service.

## Boundaries and Reliability

- Validate requests and enforce authorization at appropriate boundaries.
- Keep secrets out of source code, responses, and logs.
- Return consistent errors without exposing internal implementation details.
- Use timeouts and cancellation for external operations where supported.
- Retry only when the operation and failure mode make retries safe.
- Consider duplicate requests and idempotency for operations with side effects.
- Release resources reliably and shut down cleanly.

## Observability and Verification

- Log useful operational context without unnecessary sensitive data.
- Test business rules and important integration boundaries.
- Cover relevant authorization, validation, and dependency failure cases.
- Do not add infrastructure or dependencies without a demonstrated need.

For persistence changes, also read [Database Guidelines](db.md).
