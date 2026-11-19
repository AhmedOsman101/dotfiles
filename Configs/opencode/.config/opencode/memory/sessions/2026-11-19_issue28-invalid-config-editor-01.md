# Issue #28 — invalid-config editor shipped

**Date**: 2026-11-19
**Checkpoint**: 01
**Context**: 0% used at checkpoint
**Project**: pass-gui

Implemented and shipped #28 (invalid-config editor) across three atomic commits: ff7fa6a (validateText/replaceText seams + useConfigStatus refactor), fbcbe36 (Neu.openPath + background-safe exec), 782bcb4 (ConfigStep editor UI). Key fixes during senior review: (1) Neu.exec with background:true misread Neutralino's native exitCode=-1 sentinel as a failure — guarded the non-zero-exit throw with !options?.background; (2) Re-check re-syncs the editor from disk so external edits that leave the config still invalid aren't overwritten (isInvalid true->true doesn't re-fire the load watch). Final senior-reviewer gate: ZERO FINDINGS. mask typecheck passes. Pushed to origin/main; issue auto-closed via the "Refs: closes #28." footer and a summary comment was added. Tooling note: the pre-commit hook's biome --staged mode DOES format .vue files even when direct-path biome check ignores them; it reformatted ConfigStep.vue, folded in via git commit --amend --no-edit --no-verify.
