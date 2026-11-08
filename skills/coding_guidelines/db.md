# Database Guidelines

Apply these alongside [General Guidelines](general.md).

## Schema Changes

- Use the project's migration mechanism for persistent schema changes.
- Keep migrations reviewable and account for existing data.
- Consider deployment ordering and compatibility with running application
  versions when changing schemas.
- Document recovery or rollback limitations for destructive changes.
- Model current requirements without speculative columns or tables.
- Include required constraints, relationships, and indexes from the start.

## Data Access

- Use the project's existing ORM, query builder, or database access layer.
- Do not introduce a different ORM without a concrete need.
- Use parameterized queries or correctly parameterized ORM operations.
- Enforce relevant invariants in the database as well as application code.
- Use transactions when related writes must succeed or fail together.

## Queries and Performance

- Prefer clear, efficient queries.
- Do not move filtering, aggregation, or joins into application code merely
  to make SQL shorter.
- Avoid N+1 queries and unbounded result sets.
- Use query plans and measurements when investigating performance.
- Keep business orchestration in services while allowing the database to
  perform appropriate data operations.

## Verification

- Test migrations and queries against a suitable non-production database.
- Check relevant constraint violations, empty results, and failure cases.
- Never run destructive operations against production without explicit
  authorization and an appropriate recovery plan.
