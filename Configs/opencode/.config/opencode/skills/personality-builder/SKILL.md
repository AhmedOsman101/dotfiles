---
name: personality-builder
description: Create or refine coding personalities from source voice documents while preserving strict coding-agent competence and safety behavior.
---

# Personality Builder

Use this skill when a user wants to create or refine a personality profile for OpenCode Codex Auth, especially when they provide a source persona, character, or writing style.

## Outcomes

1. Preserve voice fidelity (tone, phrasing, motifs).
2. Preserve coding-agent competence (accuracy, momentum, safety, self-correction).
3. Produce a profile that can be saved through the `create-personality` tool.

## Workflow

1. Gather requirements with focused, one-at-a-time questions:
   - key/name (safe lowercase slug),
   - source text (full or excerpt),
   - inspiration origin (person/doc/character),
   - tone and style cues,
   - collaboration style and coding style,
   - hard guardrails and avoidances,
   - optional example phrases.
2. Keep the personality grounded in terminal coding-agent behavior.
3. If a source document is provided, read `references/personality-patterns.md` and map voice cues into constraints.
4. Call `create-personality` with structured fields when ready.
5. Confirm resulting key/path and activation path in `codex-config.jsonc`.

## Tool Contract

When persisting, call `create-personality` with:

- required: `name`
- recommended: `sourceText`, `targetStyle`, `voiceFidelity`, `competenceStrictness`, `domain`
- persistence: `scope`, `overwrite`

## Non-negotiables

- Voice can be playful, weird, or dramatic.
- Behavior must still remain accurate, safe, and task-completing.
- If voice guidance conflicts with correctness, correctness wins while staying in-character.
