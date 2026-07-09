import type { Plugin } from "@opencode-ai/plugin"

type PkgManager = { manager: string; runner: string }

const NPM_RE = /\bnpm\s+/g
const NPX_RE = /\bnpx\s+/g

const MANAGERS: Record<string, PkgManager> = {
  pnpm: { manager: "pnpm", runner: "pnpm dlx" },
  bun: { manager: "bun", runner: "bunx" },
  deno: { manager: "deno", runner: "deno x" },
}

async function detectPkgManager($: any, dir: string): Promise<PkgManager> {
  const check = async (file: string) => {
    const out = await $`test -f ${dir}/${file} && echo "exists"`.quiet()
    return (await out.text()).trim() === "exists"
  }

  if (await check("pnpm-lock.yaml")) return MANAGERS.pnpm
  if (await check("bun.lock")) return MANAGERS.bun
  if (await check("deno.lock")) return MANAGERS.deno
  return MANAGERS.pnpm
}

function needsRewrite(cmd: string): boolean {
  return NPX_RE.test(cmd) || NPM_RE.test(cmd)
}

function rewrite(cmd: string, pm: PkgManager): string {
  return cmd.replace(NPX_RE, `${pm.runner} `).replace(NPM_RE, `${pm.manager} `)
}

export const PkgManagerGuard: Plugin = async ({ $, directory }) => {
  const pm = await detectPkgManager($, directory)

  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool !== "bash") return

      const command = output.args.command
      if (typeof command !== "string" || !needsRewrite(command)) return

      output.args.command = rewrite(command, pm)
    },
  }
}
