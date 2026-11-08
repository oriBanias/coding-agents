# Frontend Guidelines

Apply these alongside [General Guidelines](general.md).

## Existing Conventions

- Follow the project's framework, component library, and styling approach.
- Reuse existing components and design tokens before introducing new ones.
- Do not add a UI framework or styling system for an isolated change.

## Styling

- Use shared design tokens for recurring colors, spacing, typography,
  borders, and other visual values.
- Avoid aliases that merely rename an existing token without adding meaning.
  Semantic tokens are appropriate when they express a distinct role.
- Keep CSS focused and remove redundant or conflicting declarations.
- Include the properties needed for readable and usable interfaces,
  including appropriate line height, focus styles, and responsive behavior.
- Keep component-specific styles close to the component.
  Keep genuinely shared styles in the project's shared styling layer.

## Accessibility and Behavior

- Use semantic elements and accessible names.
- Support keyboard navigation and visible focus.
- Check contrast, text wrapping, and content overflow.
- Handle loading, empty, error, disabled, and success states where relevant.
- Avoid fixed dimensions that break with smaller screens or longer content.

## Verification

- Inspect the changed interface at relevant viewport sizes.
- Test affected interactions, not only the initial appearance.
- Report any UI behavior or visual states that could not be verified.

For React projects, also read [React Guidelines](react.md).
