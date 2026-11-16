# Environment

- id: environment-001
  date: 2026-11-14
  tags: [cerulean,install,luarocks,lua]
  project: cerulean
  fact: System Lua is 5.5 (/usr/bin/lua, lua5.5). ceru is installed via `sudo make rock` (luarocks dev-1) at /usr/bin/ceru + /usr/share/lua/5.5/cerulean; modules compiled from local dist/. Do NOT use plain `make install` — its default LUADIR=/usr/local/share/lua/5.4 mismatches system Lua 5.5, producing a duplicate/stale wrapper. To reinstall after source changes: make compile && sudo make rock. Uninstall with `sudo luarocks remove cerulean`.

- id: environment-002
  date: 2026-11-14
  tags: [rustow,name-collision,aur,gitlab,distribution]
  project: rustow
  fact: The name 'rustow' is taken by Erenoit/rustow on GitLab (gitlab.com/Erenoit/rustow), published on AUR as rustow-git (submitted 2022-10-21, GPL-3.0+, ~68 commits, v1.0 June 2024, last commit 2024-07-18). Independent same-name GNU Stow replacement in Rust; not a fork of this project. AUR lookup confirmed 2026-11-14. Constraint: this project cannot publish to AUR under 'rustow-git'. Project ships publish=false (no crates.io); GitHub repo is AhmedOsman101/Rustow (namespaced, no collision). Renaming the binary/crate would touch config dir, env vars, docs, hooks — heavy for zero functional gain.

- id: environment-003
  date: 2026-11-16
  tags: [pdfx, llamaparse, pdf extraction, summarize-material]
  fact: summarize-material skill (updated 2026-11): pdfx --llamaparse tier table — fast=1 credit/page (text-only), cost_effective=3 (text-heavy, NO images), agentic=10 (straightforward diagrams/images), agentic_plus=25 (complex layouts/diagrams). Image-heavy slide decks MUST use agentic or higher, never cost_effective; agentic-full undocumented — ask first. 20,000 credits/month budget; always estimate pages×tier before spending; per-page re-extract on failure, never re-dump whole file. Still: question-tool go-ahead or pre-authorization first ('use llamaparse' in the request); garbage-but-nonempty = ask. User corrected tier choice on 2026-11-16: cost_effective was wrong for Section-1.pdf (billed 3/page but images need agentic 10/page).
