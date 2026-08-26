/**
 * External Editor Extension
 *
 * Open your $EDITOR (or $VISUAL) to compose the prompt:
 *   - Run /editor, or
 *   - Press ctrl+x then e (Emacs-style chord)
 *
 * The current TUI editor content is used as the initial file content.
 * When the external editor exits successfully, its contents become the
 * new prompt text in the TUI. Exiting with a non-zero code cancels.
 */

import { spawn } from "node:child_process";
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { tmpdir } from "node:os";
import { join } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { matchesKey } from "@earendil-works/pi-tui";

const CHORD_TIMEOUT_MS = 1000;

/** Resolve which editor command to use. */
function resolveEditorCommand(): string | undefined {
	return (
		process.env.VISUAL?.trim() ||
		process.env.EDITOR?.trim() ||
		// Sensible fallbacks per platform
		(process.platform === "win32" ? "notepad" : process.platform === "darwin" ? "vim" : "vi")
	);
}

/**
 * Suspend the TUI, run the external editor on the given content,
 * restore the TUI and return the edited content (or null on failure/cancel).
 */
async function runExternalEditor(ctx: ExtensionContext, command: string): Promise<string | null> {
	return ctx.ui.custom<string | null>((tui, _theme, _kb, done) => {
		void (async () => {
			let result: string | null = null;
			tui.stop(); // release the terminal so the editor can take over
			try {
				// Random suffix (mktemp-style) lets multiple pi instances edit
				// prompts concurrently without clobbering each other.
				const suffix = Array.from({ length: 5 }, () =>
					"abcdefghijklmnopqrstuvwxyz0123456789"[Math.floor(Math.random() * 36)],
				).join("");
				const directory = mkdtempSync(join(tmpdir(), "pi-prompt-editor-"));
				const filePath = join(directory, `prompt-${suffix}.md`);
				try {
					writeFileSync(filePath, ctx.ui.getEditorText(), "utf-8");
					process.stdout.write(`Launching external editor: ${command}\nPi will resume when the editor exits.\n`);

					const [editor, ...editorArgs] = command.split(" ");
					const exitCode = await new Promise<number | null>((resolve) => {
						const child = spawn(editor, [...editorArgs, filePath], {
							stdio: "inherit",
							shell: process.platform === "win32",
						});
						child.on("error", () => resolve(null));
						child.on("close", (code) => resolve(code));
					});

					if (exitCode === 0) {
						result = readFileSync(filePath, "utf-8").replace(/\n$/, "");
					} else {
						ctx.ui.notify("External editor exited without saving; prompt unchanged", "warning");
					}
				} finally {
					try {
						rmSync(directory, { recursive: true, force: true });
					} catch {
						// best effort cleanup
					}
				}
			} catch (err) {
				ctx.ui.notify(`External editor failed: ${err instanceof Error ? err.message : String(err)}`, "error");
			} finally {
				tui.start();
				if (result !== null && result !== ctx.ui.getEditorText()) {
					ctx.ui.setEditorText(result);
				}
				done(result);
			}
		})();

		// Invisible placeholder component while the terminal is handed to the editor.
		return {
			render: () => [],
			invalidate() {},
		};
	}).then(() => null);
}

export default function (pi: ExtensionAPI) {
	// Guard so we never open two editors at once.
	let busy = false;

	async function openEditor(ctx: ExtensionContext) {
		if (!ctx.hasUI || ctx.mode !== "tui") {
			ctx.ui.notify("External editor requires interactive mode", "warning");
			return;
		}
		if (busy) return;
		busy = true;
		try {
			const command = resolveEditorCommand();
			if (!command) {
				ctx.ui.notify("No editor found. Set $VISUAL or $EDITOR.", "error");
				return;
			}
			const result = await runExternalEditor(ctx, command);
			if (result === null) return;
			if (result !== ctx.ui.getEditorText()) {
				ctx.ui.setEditorText(result);
			}
		} finally {
			busy = false;
		}
	}

	pi.on("session_start", (_event, ctx) => {
		if (!ctx.hasUI || ctx.mode !== "tui") return;

		// ctrl+x e chord detection on raw terminal input.
		let pendingChord = false;
		let chordTimer: ReturnType<typeof setTimeout> | undefined;

		ctx.ui.onTerminalInput((data: string) => {
			if (pendingChord) {
				pendingChord = false;
				clearTimeout(chordTimer);

				if (matchesKey(data, "e")) {
					// Chord complete — fire and forget, keys are consumed either way.
					void openEditor(ctx);
					return { consume: true };
				}

				// Not part of the chord: hand ctrl+x back to the normal pipeline
				// (prepended before this data) so built-in bindings still work.
				return { consume: false, data: "\x18" + data };
			}

			if (matchesKey(data, "ctrl+x")) {
				pendingChord = true;
				chordTimer = setTimeout(() => {
					// Timed out: the lone ctrl+x is swallowed. Acceptable for a chord.
					pendingChord = false;
				}, CHORD_TIMEOUT_MS);
				return { consume: true };
			}

			return undefined;
		});
	});

	pi.registerCommand("editor", {
		description: "Edit the current prompt in your external editor ($EDITOR/$VISUAL)",
		handler: async (_args, ctx) => {
			await openEditor(ctx);
		},
	});
}
