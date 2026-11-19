# Issue #27 — config content validation shipped

**Date**: 2026-11-19
**Checkpoint**: 01
**Context**: 0% used at checkpoint
**Project**: /home/othman/work/desktop/pass-gui

Implemented and shipped #27 (config content validation). NEW client/src/services/config-validator.ts: ConfigValidator.validate(config) composes validateAppConfig/formatZodError with per-store GNUPGHOME probes (Path.resolveUserPath + Fs.isDirectory, fail closed on Err). Active-store problem -> errors + contentValid:false (blocks); inactive-store -> warnings only, contentValid:true. Schema invalid -> schemaValid:false, contentValid:null, Zod errors split into the same list. use-config-status.ts now returns {status, errors, warnings, refresh}, one validation pass, clears stale diagnostics, surfaces path/read/parse failures. ConfigStep.vue gains read-only invalid branch with Re-check and one shared error/warning/example grid; warnings visible even when config valid. onboarding.vue passes errors/warnings and binds @recheck to onConfigWritten. types/onboarding.ts ConfigStatus comment updated to post-#27 semantics. Verification: mask format clean (only pre-existing info in untouched stream-box/index.ts), mask typecheck green. Senior-reviewer dispatched: round 1 found one stale doc comment (F1), fixed; round 2 ZERO FINDINGS. Two atomic commits: 2071e6b (service), 4a3f939 (wiring, footer Refs: closes #27.). Pushed origin/main; GitHub auto-closed #27 via closes keyword; summary comment posted. No editor/readiness/step-machine changes (#28 untouched).
