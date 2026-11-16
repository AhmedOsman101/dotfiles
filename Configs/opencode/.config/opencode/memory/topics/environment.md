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
