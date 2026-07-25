---
name: mask
description: "Runs CLI tasks defined in a maskfile.md — commands, positional args, named flags, subcommands, and multi-runtime scripts. Use when defining project dev tasks, replacing Makefiles, or generating a CLI from markdown."
keywords: ["mask", "maskfile", "task", "cli", "markdown", "runner"]
---

# mask

CLI task runner driven by a `maskfile.md` — headings are commands, code blocks are scripts, blockquotes become `--help` text.

## maskfile Structure

```

## build

> Builds the project

```sh
cargo build --release
```
```

H2 = command, blockquote = description, code block = script. No code block = ignored docs.

## Positional Arguments

Required in `(parens)`, optional in `[brackets]`. Injected as env vars.

```

## greet (name) [title]

> Say hello

```bash
echo "Hello, $name!"
```
```

## Named Flags

Define an `**OPTIONS**` list before the code block.

```

## serve

> Serve a directory

**OPTIONS**
* port
    * flags: -p --port
    * type: string
    * desc: Which port to use

```sh
PORT=${port:-8080}
python -m SimpleHTTPServer $PORT
```
```

Types: `boolean` (default), `string`, `number`. Add `required` to make it mandatory, `choices: A, B` to constrain values.

The `verbose` flag (`-v`/`--verbose`) is auto-injected into every command.

## Subcommands

H3+ headings nest under parents. Prefixing with the ancestor name is optional.

```

## services

> Manage services

### services start (name)

> Start a service

```bash
echo "Starting $name"
```

### stop (name)

> Stop a service

```bash
echo "Stopping $name"
```
```

## Script Runtimes

The code block's language tag selects the runtime: `sh`/`bash`/`zsh`/`fish` (shell), `js` (Node), `py` (Python), `rb` (Ruby), `php`, `swift`, `powershell`, `batch`.

For cross-platform commands, include both a shell and a PowerShell block — mask picks the right one.

## Environment Variables

- `$MASK` — calls `mask --maskfile <path>`, keeping scripts location-agnostic
- `$MASKFILE_DIR` — absolute path to the maskfile's parent directory

## Running

```bash
mask build
mask greet Alice
mask services start api
mask --maskfile ~/global.md backup
mask build -h        # Auto-generated help
```

Mask inherits exit codes, so chaining with `&&` works.

## Best Practices

- Commit `maskfile.md` — it documents the dev workflow as it runs it
- Use `$MASK` inside scripts so chaining works from any directory
- Alias global maskfiles: `alias wask="mask --maskfile ~/maskfile.md"`
- One code block per command — one concern per heading

See [full reference](references/README.md) for advanced features (Windows support, exit codes, help output).
