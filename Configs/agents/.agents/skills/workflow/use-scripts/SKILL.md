---
name: use-scripts
description: Use before writing a multi-step or chained bash command, or one likely to need iteration. Write a script file (Bun, Deno, Python, Bash, or PHP) instead, so a failing run gets patched in place instead of the whole command rewritten.
---

# Use scripts

A one-shot bash command that fails mid-pipeline gets rewritten whole: the working half retyped, the syntax reproduced, only the broken part different from what was already tried. A script file fails the same way but recovers with a single edit to the broken line, then a rerun. Same task, one failure mode costs one line and the other costs a full retype.

## When to write a script instead

Write to a file when the command:

- chains more than three steps with `&&`, `|`, or `;`
- embeds a loop, conditional, or heredoc
- is likely to need a second attempt: parsing output, transforming data, anything with an edge case to discover

Run a single simple command (`ls`, `cat`, one `grep`) directly through bash. Scripting a one-liner is a no-op: there's nothing to patch that retyping wouldn't fix as fast.

## Choosing the runtime

Pick the runtime the task calls for, not a fixed default.
Fetching data, hitting an API, or shaping JSON and objects: TypeScript (Bun or Deno).
Text processing, data wrangling, or anything with a solid library in the Python ecosystem calls for Python.
File operations, process management, and gluing other commands together call for Bash.
When the project already runs on one of these, match it unless the task itself points elsewhere.

## Workflow

1. Write the script to a scratch file: Use `/tmp/scripts` for disposable scripts. Note: `EDITOR=true mkscript --temp` this will generate a bash script at the `/tmp` directory.
2. Run it.
3. On failure, edit only the broken part with a targeted string replace. Never rewrite the whole file for one bad line.
4. Rerun. Repeat steps 2 through 4 until it passes.
5. Discard the scratch file unless the user is building a reusable tool. A reusable script belongs in the project, not tmp.
