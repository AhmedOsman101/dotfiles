# Issue #26 — ask-first missing-config onboarding step

**Date**: 2026-11-19
**Checkpoint**: 01
**Context**: 0% used at checkpoint
**Project**: /home/othman/work/desktop/pass-gui

Implemented and shipped the missing-config branch of the Config onboarding step. Config.ensure() is directory-only/fail-closed; Config.load() serves un-cached in-memory defaults; new Config.getDefaultConfigText(), createDefault() and importText() give a byte-identical Default config, fail-closed creation, verbatim import writes, and parse+validate before any mkdir/write. Added use-config-status.ts (real ConfigStatus, contentValid null) and ConfigStep.vue (Use default, TOML file picker, pasted TOML, error list beside example, neutral message for existing schema-invalid config); onboarding.vue consumes the composable and orchestrates post-write reload/refresh/Re-check. Two rounds of adversarial review found no blockers; two minors fixed (validate-before-mkdir, pre-write exists() re-check for TOCTOU). Senior-review verdict CLEAN with one non-blocking Question about valid-store+missing-config startup not entering onboarding. Verified mask typecheck exit 0 and mask format no fixes (one pre-existing unrelated info). Two atomic commits 7a208ab and aafd0ec pushed to origin/main; the 'Refs: closes #26.' footer auto-closed #26 on push, and a verification/comment was posted. No test runner exists; no coverage claimed.
