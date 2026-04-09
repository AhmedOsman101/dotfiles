---
description: Summarize study material into exam-optimized review notes
---

Use the attached files, pasted material, and any extra user instructions in `$ARGUMENTS`.

If no source material is present, ask the user to attach or paste the material instead of guessing.

Create an exam-optimized summary that prioritizes **understanding through structure** and **active recall**.

Length Constraint: Target 750-800 words for a 5-minute review at 150 WPM. Hard ceiling: 1000 words only if cutting would lose testable information.

**Core Objective:** Maximize information density per sentence. Every line must be testable or explain a relationship.

**Structural Requirements for Active Recall:**

- **Concept Chunks:** Group related ideas into 100-150 word sections with clear `##` headers
- **Elaborative Rehearsal:** Follow each definition with 1 sentence explaining _why_ or _how_ it works (not just "what")
- **Visualize relationships:** Comparison tables for contrasting concepts; Mermaid diagrams for multi-step processes; nested bullets for hierarchies
- **Edge Case Highlighting:** Use GitHub-flavored alerts to surface critical exceptions and nuanced conditions.
- Bold all **testable terminology** (definitions, formulas, proper nouns) on first appearance

**Content Hierarchy (strict priority order):**

1. **Definitions with boundaries** - what's included/excluded (exam traps live here)
2. **Conditional logic** - "If/then" rules, edge cases, exceptions
3. **Procedural steps** - numbered, with _why this order matters_
4. **Contrast pairs** - easily confused concepts; use explicit "vs." statements and tables
5. **Formulas/code** - with code/commands (preserve syntax exactly)

**Compression Rules:**

- Eliminate: examples that merely illustrate (keep only if they reveal edge cases, or clear the concept), historical development, author attribution
- Preserve: all technical terms, numerical thresholds, syntax details

**Self-Contained Rule:** Each summary must be fully understandable without prior context. Define all terms on first use; no cross-references to external material.

**Output Format:** Markdown with strict formatting:

- Headings: `##` for main topics (no "Introductions"), `###` for subtopics
- **Bold** = potential exam question target
- _Italic_ = cautionary notes or common errors
- Tables for 2+ related concepts
- Code: fenced blocks with language specified and comments explaining the _purpose_ of each block. Use 2-space indentation.

Honor any narrowing or emphasis in `$ARGUMENTS` as long as it does not conflict with the source material.

Begin immediately with the first heading. No introduction or conclusion.
