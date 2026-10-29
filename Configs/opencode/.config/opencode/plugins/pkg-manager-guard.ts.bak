import { existsSync } from "node:fs"
import { join } from "node:path"
import type { Plugin } from "@opencode-ai/plugin"

type PkgManager = { manager: string; runner: string }

const NPM_RE = /\bnpm\s+/g
const NPX_RE = /\bnpx\s+/g

const MANAGERS: Record<string, PkgManager> = {
  pnpm: { manager: "pnpm", runner: "pnpm dlx" },
  bun: { manager: "bun", runner: "bunx" },
  deno: { manager: "deno", runner: "deno x" },
}

function needsRewrite(cmd: string): boolean {
  return cmd.includes(" npm ") || cmd.startsWith("npm ") ||
    cmd.includes(" npx ") || cmd.startsWith("npx ")
}

function rewrite(cmd: string, pm: PkgManager): string {
  const hadNpx = cmd.includes(" npx ") || cmd.startsWith("npx ")
  const hadNpm = cmd.includes(" npm ") || cmd.startsWith("npm ")
  const corrected = cmd.replace(NPX_RE, `${pm.runner} `).replace(NPM_RE, `${pm.manager} `)

  const parts: string[] = []
  if (hadNpx) parts.push(`npx -> ${pm.runner}`)
  if (hadNpm) parts.push(`npm -> ${pm.manager}`)

  // Strip chars that would break out of the double-quoted echo (quotes, backticks,
  // $-expansion, backslashes) — the original command is shown for context only.
  const safeOriginal = cmd.replace(/["\\`$]/g, "'")
  const notice =
    `[pkg-manager-guard] AGENT NOTICE: Your command was AUTO-REWRITTEN by an opencode plugin before running. ` +
    `The 'echo' line below was injected by the plugin, not written by you. ` +
    `Original: '${safeOriginal}' (${parts.join(", ")}). ` +
    `Use '${pm.manager}' directly next time (and '${pm.runner}' instead of npx).`

  return `echo "${notice}" >&2 && ${corrected}`
}

// ponytail: fs-based lockfile detection instead of shelling out — opencode's
// plugin ctx `$` lacked .quiet() and crashed the whole plugin on load.
function detectPkgManager(dir: string): PkgManager {
  if (existsSync(join(dir, "pnpm-lock.yaml"))) return MANAGERS.pnpm
  if (existsSync(join(dir, "bun.lock"))) return MANAGERS.bun
  if (existsSync(join(dir, "deno.lock"))) return MANAGERS.deno
  return MANAGERS.pnpm
}

// biome-ignore lint/suspicious/useAwait: That's how it works
export const PkgManagerGuard: Plugin = async ({ directory }) => {
  const pm = detectPkgManager(directory)

  return {
    // biome-ignore lint/suspicious/useAwait: That's how it works
    "tool.execute.before": async (input, output) => {
      if (input.tool !== "bash") return

      const command = output.args.command
      if (typeof command !== "string" || !needsRewrite(command)) return

      const rewritten = rewrite(command, pm)
      output.args.command = rewritten
    },
  }
}
