# Skills Inventory

All skills across `~/.agents/skills/` (65 total) and `~/.config/opencode/skills/` (3 system skills).

---

## Foundation

| Skill                 | Description                                                                                                            |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **using-superpowers** | Establishes how to find and use skills, requiring skill invocation before ANY response including clarifying questions. |

---

## Planning & Design

| Skill                     | Description                                                                                                                                                                                     |
| ------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **brainstorming**         | MUST use before any creative work — creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before implementation.   |
| **codebase-design**       | Shared vocabulary for designing deep modules (depth, seam, interface, leverage). Use when designing/improving module interfaces, finding deepening opportunities, or making code more testable. |
| **design-doc-mermaid**    | Create Mermaid diagrams (activity, deployment, sequence, architecture) from text descriptions or source code.                                                                                   |
| **frontend-design**       | Guidance for distinctive, intentional visual design when building new UI or reshaping an existing one. Aesthetic direction, typography, avoiding templated defaults.                            |
| **web-design-guidelines** | Review UI code for Web Interface Guidelines compliance. Check accessibility, audit design, review UX.                                                                                           |
| **writing-plans**         | Create multi-step implementation plans from specs or requirements before touching code.                                                                                                         |
| **request-refactor-plan** | Create a detailed refactor plan with tiny commits via user interview, then file as GitHub issue.                                                                                                |
| **to-spec**               | Turn conversation into a spec/PRD and publish to issue tracker — no interview, just synthesis of what was discussed.                                                                            |
| **to-tickets**            | Break a plan/spec/conversation into tracer-bullet vertical-slice tickets with blocking edges, published to tracker.                                                                             |
| **wayfinder**             | Plan huge work spanning multiple agent sessions as a shared map of investigation tickets, resolve one per session until path is clear.                                                          |

---

## Interview & Grilling

| Skill               | Description                                                                                              |
| ------------------- | -------------------------------------------------------------------------------------------------------- |
| **grilling**        | Relentless one-question-at-a-time interview to stress-test a plan or design, with recommended answers.   |
| **grill-with-docs** | Grilling session that also creates ADRs and glossary entries as decisions are made.                      |
| **loop-me**         | Grill to produce workflow specs for recurring life patterns — triggers, checkpoints, briefs, push-right. |

---

## Development & Implementation

| Skill                             | Description                                                                                                                                      |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **implement**                     | Execute work from spec/tickets. Uses TDD where possible, runs typechecking and tests regularly, then code-review.                                |
| **prototype**                     | Build throwaway prototype to answer a design question. Two branches: logic (terminal state machine) or UI (radically different visual variants). |
| **improve-codebase-architecture** | Scan codebase for deepening opportunities, present as visual HTML report, then grill through chosen candidate.                                   |
| **dispatching-parallel-agents**   | Use when facing 2+ independent tasks that can be worked on without shared state or sequential dependencies.                                      |
| **subagent-driven-development**   | Execute implementation plans with independent tasks using subagents in the current session.                                                      |
| **executing-plans**               | Execute a written implementation plan in a separate session with review checkpoints.                                                             |
| **using-git-worktrees**           | Start feature work with isolated workspace via native tools or git worktree fallback.                                                            |

---

## Test-Driven Development

| Skill   | Description                                                                                                                                                                                          |
| ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **TDD** | Red-green-refactor discipline: good tests at public seams, vertical slices, anti-patterns (implementation-coupled, tautological, horizontal slicing). Includes mocking guidelines and test examples. |

---

## Code Review & QA

| Skill                              | Description                                                                                                                                                             |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **code-review**                    | Two-axis review of diff from a fixed point — Standards (conformance to repo conventions + smell baseline) and Spec (faithfulness to requirements). Parallel sub-agents. |
| **requesting-code-review**         | Use when completing tasks or before merging to verify work meets requirements.                                                                                          |
| **receiving-code-review**          | Use when receiving code review feedback — requires technical rigor, not performative agreement.                                                                         |
| **caveman-review**                 | Ultra-compressed one-line code review comments: location, problem, fix.                                                                                                 |
| **douchebag-review**               | One-line-per-finding code review in vulgar gym-bro-chad voice. Precise, actionable.                                                                                     |
| **qa**                             | Interactive QA session: user reports bugs conversationally, agent explores codebase for context, files GitHub issues.                                                   |
| **verification-before-completion** | Run verification commands and confirm output before claiming work is complete/fixed/passing.                                                                            |
| **finishing-a-development-branch** | Guide completion when implementation is done — structured options for merge, PR, or cleanup.                                                                            |

---

## Debugging & Diagnosis

| Skill                    | Description                                                                                                                                                    |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **diagnosing-bugs**      | 6-phase bug diagnosis: build tight feedback loop → reproduce/minimise → hypothesise (3-5 ranked) → instrument → fix + regression test → cleanup + post-mortem. |
| **systematic-debugging** | Use when encountering any bug, test failure, or unexpected behavior before proposing fixes.                                                                    |
| **arch-linux-triage**    | Triage and resolve Arch Linux issues with pacman, systemd, and rolling-release best practices.                                                                 |

---

## Research & Learning

| Skill                  | Description                                                                                                  |
| ---------------------- | ------------------------------------------------------------------------------------------------------------ |
| **research**           | Investigate a question against high-trust primary sources via background agent, capture as Markdown file.    |
| **find-skills**        | Discover and install agent skills when user asks "how do I do X" or "is there a skill that can...".          |
| **summarize-material** | Summarize study material from PDF or pasted content into exam-optimized review notes.                        |
| **teach**              | Multi-session teaching workspace with lessons (HTML), reference docs, learning records, mission doc, assets. |

---

## Writing & Content

| Skill                 | Description                                                                                                                   |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| **stop-slop**         | Remove AI writing patterns from prose. Use when drafting, editing, or reviewing text to eliminate predictable AI tells.       |
| **dom-to-pptx-skill** | Create professional PowerPoint presentations with premium aesthetics (bento-grids, glassmorphism) via HTML-to-PPTX rendering. |
| **handoff**           | Compact conversation into handoff document for another agent. Saves to temp directory with suggested skills section.          |

---

## Skills Meta

| Skill                        | Description                                                                                                                        |
| ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| **writing-great-skills**     | Reference for writing/editing skills well — predictability, invocation types, information hierarchy, leading words, failure modes. |
| **setup-matt-pocock-skills** | One-time repo scaffold: configure issue tracker, triage label vocabulary, domain doc layout for engineering skills.                |

---

## System Administration

| Skill                         | Description                                                                                                             |
| ----------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **bash**                      | Bash/Linux terminal patterns — critical commands, piping, error handling, scripting. Includes shell strategy reference. |
| **linux-administration**      | System administration for Linux servers — manage packages, services, and system configuration.                          |
| **resolving-merge-conflicts** | Resolve in-progress git merge/rebase conflicts: understand sources, resolve hunks, run checks, finish.                  |

---

## GitHub & DevOps

| Skill                   | Description                                                                                                                     |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **github-actions-docs** | Write, explain, customize, migrate, secure, or troubleshoot GitHub Actions workflows, syntax, triggers, matrices, runners, etc. |

---

## Persona & Voice Modifiers

| Skill              | Description                                                                                                                                                  |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **caveman**        | Ultra-compressed communication mode (~75% token reduction). Levels: lite, full, ultra, wenyan variants.                                                      |
| **caveman-help**   | Quick-reference card for all caveman modes, skills, and commands. One-shot display.                                                                          |
| **cavecrew**       | Decision guide for delegating to caveman-style subagents — investigator (locate code), builder (1-2 file edit), reviewer (diff review). ~60% smaller output. |
| **douchebag**      | Vulgar, sleazy gym-bro-chad persona. Constant profanity, aggressive swagger. Levels: normal/full/ultra.                                                      |
| **douchebag-help** | One-shot quick reference card for douchebag plugin — activation, intensity, slash commands, deactivation.                                                    |

---

## Framework: Vue Ecosystem

| Skill                         | Description                                                                                                                     |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **vue**                       | Vue 3 Composition API, script setup macros, reactivity system, built-in components (Transition, Teleport, Suspense, KeepAlive). |
| **vue-best-practices**        | MUST use for Vue.js tasks. Composition API with `<script setup>` and TypeScript. Covers SSR, Volar, vue-tsc.                    |
| **vue-debug-guides**          | Vue 3 debugging and error handling — runtime errors, warnings, async failures, SSR/hydration issues.                            |
| **vue-pinia-best-practices**  | Pinia stores, state management patterns, store setup, reactivity with stores.                                                   |
| **vue-router-best-practices** | Vue Router 4 patterns, navigation guards, route params, route-component lifecycle.                                              |
| **vueuse-functions**          | Apply VueUse composables where appropriate for concise, maintainable Vue.js/Nuxt features.                                      |
| **pinia**                     | Pinia official Vue state management — define stores, state/getters/actions, store patterns.                                     |

---

## Build Tools

| Skill         | Description                                                                                               |
| ------------- | --------------------------------------------------------------------------------------------------------- |
| **vite**      | Vite build tool configuration, plugin API, SSR, Vite 8 Rolldown migration.                                |
| **vitepress** | VitePress static site generator powered by Vite and Vue — documentation sites, themes, Markdown with Vue. |
| **vitest**    | Vitest unit testing framework powered by Vite with Jest-compatible API — mocking, coverage, fixtures.     |
| **pnpm**      | Node.js package manager with strict dependency resolution — workspaces, catalogs, patches, overrides.     |
| **shadcn**    | Manages shadcn components — adding, searching, fixing, debugging, styling, composing UI.                  |

---

## Tools & Integrations

| Skill                   | Description                                                                                                   |
| ----------------------- | ------------------------------------------------------------------------------------------------------------- |
| **context7**            | Retrieve up-to-date documentation for libraries, frameworks, components via Context7 API.                     |
| **lib-result**          | Result-driven error handling in TypeScript — try/catch to typed Results, chaining, recovery without throwing. |
| **obsidian-vault**      | Search, create, and manage notes in Obsidian vault with wikilinks and index notes.                            |
| **task-management**     | Task management CLI for tracking feature subtasks with status, dependencies, and validation.                  |
| **personality-builder** | Create or refine coding personalities from source voice documents while preserving safety.                    |

---

## Overlapping Skills

Skills that cover similar ground — consider which to keep or merge:

### Debugging (2 skills)

- **diagnosing-bugs** / **systematic-debugging** — both provide structured bug diagnosis workflows. `diagnosing-bugs` is the most detailed (6 phases). `systematic-debugging` is a lighter trigger.

### Code Review (5 skills)

- **code-review** — two-axis (Standards + Spec), the most thorough.
- **requesting-code-review** / **receiving-code-review** — process skills for the review workflow.
- **caveman-review** / **douchebag-review** — compressed persona-driven review formats.

### Grilling (3 skills)

- **grilling** / **grill-with-docs** / **loop-me** — all involve relentless user interviewing. `grill-with-docs` adds ADR/glossary creation. `loop-me` targets workflow specs specifically.

### Planning (5 skills)

- **writing-plans** — straightforward plan creation from specs.
- **wayfinder** — heavy-weight multi-session investigation mapping.
- **to-spec** / **to-tickets** — issue-tracker-oriented output formats.
- **request-refactor-plan** — refactor-specific planning with Martin Fowler's tiny commits.

### Skills Creation (1 skill)

- **writing-great-skills** — reference for writing/editing skills well.

### Persona/Voice (6 skills)

- **caveman** / **caveman-help** / **caveman-review** / **douchebag** / **douchebag-help** / **douchebag-review** / **cavecrew** — voice modifiers and their helpers. `cavecrew` is a subagent delegation framework with compressed output.

### Architecture (2 skills)

- **codebase-design** — vocabulary and principles (vocabulary skill).
- **improve-codebase-architecture** — scanning + HTML report + grilling (execution skill).
