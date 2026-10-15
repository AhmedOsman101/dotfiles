# Context Toolbox

How to read the *connected* code — the callers, callees, siblings, types, and tests around a change. A diff-only reviewer cannot see the bug that lives between the hunks. This file is how you get past the diff.

## The three sources, and when each is right

| Question | Tool |
| --- | --- |
| Who calls this? What does this call? What breaks if I change it? | `codegraph callers` / `callees` / `impact` |
| What is this symbol, really — signature, source, trail? | `codegraph node` |
| Which tests cover these changed files? | `codegraph affected` |
| What does this area of the codebase do? | `codegraph explore` |
| Where is `X` defined, and where is it used? In *this* project, live. | `lsp` tool — `goToDefinition`, `findReferences` |
| Is this override actually reached? What implements this interface? | `lsp` tool — `goToImplementation`, `incomingCalls` |
| What is the real type here? | `lsp` tool — `hover`, `documentSymbol` |
| Anything not covered above, or no index and no LSP. | `grep` / `glob` (ripgrep) |

Rule of thumb: **codegraph for structure and blast radius, LSP for precision on a live symbol, grep for the rest.** They overlap. Use the cheapest one that answers the question.

## codegraph: MCP versus CLI

The MCP server and the CLI expose the same engine, and both read a `.codegraph/` index. They differ in **reach**:

- **MCP (`codegraph_explore`) only works for the project OpenCode was opened in.** It resolves the index at or above the session's own directory and has no way to be pointed elsewhere. If a user starts OpenCode in `~/projectA` and asks you to review `~/projectB`, the MCP tool will happily answer — about `~/projectA`. That is worse than no answer, because it looks like an answer.
- **The CLI runs anywhere.** Every command takes `-p, --path <path>`:

```bash
cd ~/projectB && codegraph files
codegraph explore "retry backoff sendWithRetry" -p ~/projectB
codegraph callers getUserByEmail -p ~/projectB
```

**Always confirm which project you are pointed at.** Before trusting any codegraph answer, know whether the code under review is the session's project or a different one. If it is different, use the CLI with an explicit `-p` and ignore the MCP tool entirely.

### Commands worth knowing

```bash
codegraph status -p <path>            # is there an index, and is it stale?
codegraph callers <symbol> -p <path>  # who reaches this
codegraph callees <symbol> -p <path>  # what this reaches
codegraph impact  <symbol> -p <path>  # blast radius of changing it
codegraph affected <files...> -p <path> -q   # tests that cover these files, paths only
codegraph node <symbol> -p <path>     # source + caller/callee trail
codegraph files -p <path> --format tree      # project shape
codegraph query <search> -p <path> -k function
```

- `callers` / `callees` accept `-f, --file` to disambiguate a symbol defined in several places. Use it: an ambiguous symbol silently returns the union.
- `affected -q` prints bare paths. That is what you feed into a test command for the consent gate.
- `impact` has `-d, --depth` (default 2). Raise it for a symbol on a hot path.

### Rules

- **Check `status` before trusting an index.** A stale index gives confident wrong answers about callers. If it is stale, say so in the report and fall back to grep for the affected area — or ask whether to `sync`.
- **Never run `codegraph init` or `codegraph index`.** Indexing is the user's decision, and an index is a costly, surprising side effect. If there is no `.codegraph/`, say so and use grep.
- **An empty result is a finding about your query, not about the code.** No callers may mean no index, an ambiguous symbol, or a dynamic call site. Confirm with `grep` before you write "nothing calls this".

## LSP

Two distinct things, and they are easy to conflate:

1. **Passive diagnostics.** With `lsp: true`, OpenCode starts the right language server when it opens a file, and surfaces diagnostics back to you. These arrive on their own — you do not call anything. Treat them as free evidence, and cite them the way you would cite a linter.
2. **The `lsp` tool.** An *experimental* tool, available only when `OPENCODE_EXPERIMENTAL_LSP_TOOL=true` or `OPENCODE_EXPERIMENTAL=true`. It is **not enabled by default**, and it is not enabled on this machine unless that variable is set.

### If the `lsp` tool is available

Operations: `goToDefinition`, `findReferences`, `hover`, `documentSymbol`, `workspaceSymbol`, `goToImplementation`, `prepareCallHierarchy`, `incomingCalls`, `outgoingCalls`.

Where it beats codegraph:

- **`findReferences` sees what the index misses** — re-exports, dynamic imports, and same-name symbols in other packages.
- **`goToImplementation` resolves interfaces and abstract methods** that a call graph records only as an edge to the abstract declaration.
- **`incomingCalls` / `outgoingCalls` is live call hierarchy** on the *current* code, so it is correct before the next index sync.
- **`hover` gives the inferred type**, which is how you confirm a guard is genuinely unnecessary rather than merely absent.

It is scoped to the **session's project**, same as MCP — it reads the language server's workspace. For a different project, prefer codegraph CLI or grep.

### If it is not available

Check before assuming. If `lsp` is not among your tools, do not plan around it:

- Diagnostics still arrive passively — use them.
- For references and implementations, fall back to `grep` across the tree, and to `codegraph callers`.
- Prefer whatever CLI the project documents (`tsc --noEmit`, `biome check`, `ruff check`, `cargo clippy`, `deno check`). OpenCode's own guidance is that these are often a better feedback loop than a language server, because they are deterministic and versioned with the project.
- Say so in the report if it cost you a claim you would otherwise have confirmed.

## The fallback that always works

`grep` and `glob` run on ripgrep and need no index and no server. They respect `.gitignore`, so vendored and built code stays out of the way — add a `.ignore` file with `!node_modules/` only if you genuinely need into a build tree.

Some things only grep will find: string literals in config, env var names, a route path assembled from constants, a symbol referenced by a string key. When codegraph and LSP both come back empty, grep is the tiebreaker.

## A worked pass

For a change to `getUserByEmail` in a repo indexed at `~/app`:

```bash
codegraph status -p ~/app                      # index present and fresh?
codegraph node getUserByEmail -p ~/app         # source + trail
codegraph callers getUserByEmail -p ~/app -f src/auth/session.ts   # who reaches it
codegraph affected src/auth/session.ts -p ~/app -q   # what tests cover it
```

Then, to check the *caller's* assumption rather than the callee's:

```bash
grep -rn "getUserByEmail" ~/app/src --include=*.ts
```

And for the type claim the change depends on — `lsp hover` if the tool is available, otherwise read the declaration and say the type was read, not resolved.

Every one of those commands is read-only. None of them is a build, a test run, or an index rebuild.
