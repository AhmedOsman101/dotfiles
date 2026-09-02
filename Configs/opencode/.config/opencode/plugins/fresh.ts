import type { Plugin } from "@opencode-ai/plugin"

/**
 * Wipe / Fresh — clear LLM context while staying in the same session.
 *
 * Built-ins `/new` (alias `/clear`) start a *new* session. This plugin
 * does what PI / Claude Code's `/clear` does: keep the same session ID
 * and directory, but hide all previous history from the next LLM call.
 *
 * Aliases: /fresh, /wipe, /clear-context, /reset, /reset-context
 * (Intentionally *not* `/clear` to avoid colliding with opencode's built-in
 * alias for `/new`.)
 *
 * How it works:
 *  - On `/fresh` etc. we store `clearedAt = Date.now()` for that session.
 *  - On the *next* LLM request, `experimental.chat.messages.transform` fires
 *    with the history that would be sent. We strip every user/assistant
 *    message whose `time.created < clearedAt`, so the model sees a fresh
 *    context. System messages are preserved.
 *  - TUI display still shows old messages (opencode has no API to delete
 *    them); the LLM just won't see them. A toast + reply confirm the clear.
 *
 *  ponytail: timestamp filter vs deleting rows — shortest working clear without
 *  needing a delete-message endpoint (which doesn't exist).
 */

const ALIASES = new Set(["fresh"])
const clearedAt = new Map<string, number>()

export const FreshPlugin: Plugin = async ({ client }) => {
  return {
    "command.execute.before": async (input, output) => {
      const name = input.command.trim().toLowerCase()
      if (!ALIASES.has(name)) return
      if (!input.sessionID) return

      clearedAt.set(input.sessionID, Date.now())

      try {
        await client.tui.showToast({
          body: {
            title: "Context cleared",
            message: "History hidden from LLM on next turn. Same session, fresh context.",
            variant: "success",
            duration: 3000,
          },
        })
      } catch {}

      try {
        await client.app.log({
          body: {
            service: "fresh",
            level: "info",
            message: "Context cleared for session",
            extra: { sessionID: input.sessionID, command: name },
          },
        })
      } catch {}

      output.parts = [
        {
          type: "text",
          text:
            "✓ Context cleared — this session's history will be hidden from the LLM on your next prompt. " +
            "Same session, same directory. (TUI still shows old messages — opencode has no delete-message API. Send your next prompt to start fresh.)",
        } as any,
      ]
    },

    "experimental.chat.messages.transform": async (_input, output) => {
      const msgs: any[] = (output as any).messages ?? []
      if (msgs.length === 0 || clearedAt.size === 0) return

      const filtered = msgs.filter((m) => {
        const role = m.info?.role
        if (role !== "user" && role !== "assistant") return true
        const sid: string | undefined = m.info?.sessionID
        const cutoff = sid ? clearedAt.get(sid) : undefined
        if (cutoff === undefined) return true
        const t = m.info?.time?.created ?? 0
        return t >= cutoff
      })

      if (filtered.length === 0 && msgs.length > 0) {
        const lastUser = [...msgs].reverse().find((m: any) => m.info?.role === "user")
        if (lastUser) {
          ;(output as any).messages = [lastUser]
          return
        }
      }

      if (filtered.length !== msgs.length) {
        ;(output as any).messages = filtered
      }
    },
  }
}

export default FreshPlugin
