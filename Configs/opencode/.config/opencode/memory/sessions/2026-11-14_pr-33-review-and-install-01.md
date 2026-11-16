# ceru PR #33 review rework + install cleanup

**Date**: 2026-11-14
**Checkpoint**: 01
**Context**: auto
**Project**: /home/othman/work/forks/cerulean

## What was done
- Replied to maintainer (efredriksson) on cerulean PR #33: still interested, busy with college.
- Reworked PR #33 per CHANGES_REQUESTED review: stdin mode never walks FS (unchanged), walk errors now collected by file_discovery.expand_paths ({files},{errors}), printed to stderr by cli (before formatting), ceru exits 1 if any walk error occurred; readable files still processed (mirrors process_files aggregation). Removed dead fmt_logger in file_discovery.
- Specs: shared helpers.locked_tree() fixture (readable ok/a.tl + chmod-000 locked/b.tl, tree.readable root guard), busted `finally` for cleanup; resolve_options now returns (opts, err, walk_errors); new cli_spec coverage (exit 1, stderr names locked dir, readable file reformatted). 739 successes, make lint clean. Commit bd1c993 pushed; PR body rewritten; 3 review threads replied to (left unresolved for maintainer).
- Created /tmp/opencode/unformatted-teal/ sample Teal files (messy, unsorted_requires, weird_wrapping, already_formatted, parse_error).
- Install mess fixed: `sudo make install` (LUADIR 5.4, mismatch with system Lua 5.5) vs `sudo make rock` produced duplicates; user deleted /usr/local/bin/ceru and /usr/local/share/lua/5.4 manually (CC safety net blocks recursive sudo rm outside cwd); kept luarocks dev-1 at /usr/bin/ceru. Reinstall after rebuilds: make compile && sudo make rock.

## Key decisions
- Walk errors: process readable files, print all discovery errors to stderr, exit 1 — mirrors process_files; NOT a hard abort.
- Keep luarocks install over make install.

## Outcome
PR #33 awaiting re-review; single working ceru install.
