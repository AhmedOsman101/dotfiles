# Decisions

- id: decisions-001
  date: 2026-11-14
  tags: [cerulean,pr-33,cli,exit-codes]
  project: cerulean
  fact: cerulean PR #33 (stdin no-FS-walk + unreadable dirs): maintainer efredriksson wants walk errors collected, printed to stderr, and non-zero exit — never silently skipped; stdin mode must not touch the filesystem at all (Ahmeds narrow scope). Chosen semantics mirror process_files: process readable files, print all discovery errors to stderr, exit 1. Tests use shared helpers.locked_tree() + busted finally.

- id: decisions-002
  date: 2026-11-14
  tags: [commit-sage, logo, branding, design]
  project: commit-sage
  fact: commit-sage logo direction chosen by user: attempt-5 from Nano Banana generations — hooded sage face, closed eyes, amber spark third eye, beard rendered as a git graph; dark lockup with lowercase 'commit-sage' wordmark. Files live in /tmp/opencode/attempt-*.jpg (transient).

- id: decisions-003
  date: 2026-11-16
  tags: [vitepress,astro,migration,obsidian,notes-site]
  project: obsidian
  fact: Repo is an Obsidian vault published via VitePress 2.0.0-alpha (srcDir=src, 419 md files, ~53s build); 2026-11-16: user ACCEPTED the stay-on-VitePress + Vue-in-Markdown route (rejected Astro/Hugo/SPA for now); report at /tmp/opencode/markdown-vs-framework-migration-report.md (post-publication corrections appended); @vercel/speed-insights removed; user staged srcExclude fix themselves.

- id: decisions-004
  date: 2026-11-16
  tags: [vitepress,callouts,gfm-alerts]
  project: obsidian
  fact: VitePress renders Obsidian `> [!note]`-style callouts natively as GFM alerts (dist output: <div class="warning custom-block github-alert">); no plugin needed — an earlier claim in the migration report that they render as raw blockquotes was wrong and retracted 2026-11-16.

- id: decisions-005
  date: 2026-11-16
  tags: [summarize-material,skill,viz,phase1]
  project: obsidian
  fact: Phase 1 visualizer work done 2026-11-16: @viz alias + SSR-safe Stepper/PipelineViz in .vitepress/theme/components/viz/; pilots in YearThree/FirstTerm (ComputerArchitecture L5, DataCommunication S4); AGENTS.md pattern docs; summarize-material SKILL.md updated with opt-in whitelisted <Stepper>/<PipelineViz> clause (script setup after frontmatter, @viz alias only, prose self-sufficient); cytoscape + @vercel/speed-insights removed; builid green ~55s; uncommitted.

- id: decisions-006
  date: 2026-11-16
  tags: [pipelineviz,summarize-material,phase1]
  project: obsidian
  fact: 2026-11-16 (later): user found PipelineViz 'just a fancy table'; redesigned into interactive k+n-1 vs k+2n-1 simulator (n slider 1-12, slow-stage picker, discrete-event sim, bubbles rendered); Lecture-5 updated to <PipelineViz :initial-n=10>. summarize-material SKILL.md weaknesses 1,3,5,6,7 fixed (mandatory 4-check verification pass incl. exam probe, toolchain/-layout/RTL notes, vault frontmatter rule, worked example); weaknesses 2 (readtime fragility) and 4 (unslop dep) deliberately left. Build green 61s.
