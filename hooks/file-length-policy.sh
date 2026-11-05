#!/usr/bin/env bash
# Sourced by check-file-length-stop.sh. Keep both files together.
# All physical lines count, including imports, comments and blank lines.

MAX_LINES=320

# Exact directory names, matched within repository-relative paths.
# These preserve the teacher's broad exemptions.
IGNORE_DIRS='node_modules,dist,build,coverage,tmp,temp,.cache,migrations,plans,prompts,fixture,fixtures,__fixtures__,script,scripts,test,tests,__tests__,__snapshots__,spec,vendor,Pods,.venv,venv,target,.next,.nuxt,.svelte-kit,.turbo,out'

# Basename patterns. Supports * and ? wildcards.
IGNORE_FILES='package-lock.json,pnpm-lock.yaml,yarn.lock,bun.lock,Cargo.lock,composer.lock,Gemfile.lock,Podfile.lock,Package.resolved,manifest.json,*.webmanifest,*.snap,*.min.js,*.min.css,*.bundle.js,*.bundle.css,*.map,*.test.*,*.spec.*,*.generated.*,*.gen.*'

# Additional relative directory sequence.
IGNORE_PATHS='docs/handoffs'

# Optional project-specific JSON file, relative to the repository root.
# Example:
# {"ignored_paths": ["src/legacy/**", "special-file.ts"]}
#
# * matches within a path segment.
# ** matches across segments.
# ? matches one character.
# Patterns without / match basenames.
# No negation or TOML parsing.
PROJECT_IGNORE_FILE='.claude/hooks/file-length-validation.ignore.json'
