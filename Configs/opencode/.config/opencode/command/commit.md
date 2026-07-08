---
description: Create well-formatted commits using the Conventional Commits format
---

# Commit Command

You are an AI agent that helps create well-formatted git commits using the Conventional Commits format. Follow these instructions exactly. Always run the commit. Don't ask for confirmation unless there is a big issue or error.

## Instructions for Agent

When the user runs this command, execute the following workflow:

1. **Check command mode**:
   - If the user provides $ARGUMENTS (a simple message), skip to step 3.

2. **Run pre-commit validation**:
   - Execute `pnpm lint` and report any issues.
   - Execute `pnpm typecheck` or `pnpm build` and ensure it succeeds.
   - If either fails, ask the user if they want to proceed anyway or fix issues first.

3. **Analyze git status**:
   - Run `git status --porcelain` to check for changes.
   - If no files are staged, run `git add .` to stage all modified files.
   - If files are already staged, proceed with only those files.

4. **Analyze the changes**:
   - Run `git diff --cached` to see what will be committed.
   - Determine the primary change type and scope from the rules below.

5. **Generate commit message**:
   - Build the message using the format and rules below.
   - Show the proposed message to the user for confirmation.

6. **Execute the commit**:
   - Run `git commit -m "<generated title>" -m "<generated body>"`.
   - Display the commit hash and confirm success.

## Commit Message Format

```
<type>[optional scope]: <description>

[optional body with bullet points]
```

### Rules

1. **First line**: `type(scope): description` (max 50 chars).
   - Use imperative mood for the description (e.g., "add" not "added").
   - Description starts with a lowercase letter.
2. **For small changes**, use only the first line.
3. **For complex changes**, list key points in the body:
   - Each line starts with `- ` and is max 50 chars.
   - Limit to 5 bullet points.
   - Use present tense and active voice.
   - Focus on what and why, not how, unless necessary.
4. **References**: optionally reference issues or PRs (e.g., "Closes #123").

### Type Selection Rules

Choose the most appropriate type based on the change:

- `docs`: any changes to documentation files (`*.md`, `docs/*`, etc.)
- `feat`: new features or significant functional changes
- `fix`: bug fixes and error corrections
- `style`: changes not affecting code behavior (formatting, semicolons, etc.)
- `refactor`: code changes that neither fix a bug nor add a feature
- `perf`: performance improvements
- `test`: adding or updating tests
- `build`: changes affecting the build system or external dependencies
- `ci`: CI/CD changes
- `chore`: build configuration, libraries, and other maintenance tasks
- `revert`: reverting a previous commit

The type drives changelog generation and other automated tooling. Pick it carefully.

## Examples

**Documentation change**:
```
docs: update installation and usage guides

- add new features description
- update configuration section
- add usage examples
```

**Feature change**:
```
feat(auth): add user authentication

- implement OAuth2 provider integration
- create auth service module
- add session management
```

**Fix change**:
```
fix(api): resolve null pointer exception in user service
```

**Refactor change**:
```
refactor(core): simplify error handling logic
```

**Test change**:
```
test: add unit tests for authentication module
```

## Agent Behavior Notes

- **Error handling**: if validation fails, give the user the option to proceed or fix issues first.
- **Auto-staging**: if no files are staged, stage all changes with `git add .`.
- **File priority**: if files are already staged, commit only those specific files.
- **Always run and push the commit**: don't ask for confirmation unless there is a big issue or error.
- **Message quality**: keep the first line at or under 50 chars, imperative mood, lowercase start.
- **Single logical change**: keep each commit focused, especially for complex changes.
- **Reference**: see the [Conventional Commits specification](https://www.conventionalcommits.org/) for more detail.
