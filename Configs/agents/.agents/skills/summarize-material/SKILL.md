---
name: summarize-material
description: >
  Summarize study material from a PDF file or pasted/attached content into
  exam-optimized review notes. Use whenever the user says "summarize this PDF",
  "summarize my lecture", "summarize this section", "make study notes", "condense",
  or provides a PDF path alongside a request for a summary, notes, or study guide.
---

# Summarize Study Material

Produces exam-optimized Markdown notes from a PDF or pasted material.
The summary must always be shorter than the source. Never pad, never introduce.

## Inputs

Accept any of:

- A PDF file path via `$ARGUMENTS` or an attached file
- Pasted or attached text content
- Extra instructions or emphasis via `$ARGUMENTS`

If no source material is present, ask the user to provide it. Do not guess or fabricate content.

## Workflow

### 1. Extract content

**PDF path provided:**

```bash
# Use pdfx to get useful metadata and a best effort to format and organize the PDF content
pdfx "$FILE_PATH"

# Then use pdftotext to get the raw text, may give you more info
pdftotext "$FILE_PATH" -
```

If `pdfx` and `pdftotext` both fail (non-zero exit or empty output), stop and tell the user: the PDF may be scanned/image-based and needs OCR, or the path is wrong.

**Other input:** use the attached file or pasted content directly.

### 2. Measure original read time

```bash
# Accepts PDF files or any text file format
readtime "$FILE_PATH"
# or, for raw text input:
echo "$TEXT" | readtime
```

Save this value for the footer.

### 3. Write the summary

**Length principle:** match the density of the source. Dense technical material compresses less; sparse or narrative material compresses more. Never add words to reach a target.
Never cut testable content to stay under one. If the source is short, the summary is short.

**Core objective:** maximize information density per sentence. Every line must be testable or explain a relationship.

---

**Output structure:**

- Start immediately with the first `##` heading. No title, no preamble, no introduction.
- `##` for main topics, `###` for subtopics. No "Introduction" or "Overview" headings.
- End with the read time footer (see step 4). Nothing after it.
- Incorporate the `stop-slop` skill when writing.

**Active recall structure:**

- **Concept chunks:** group related ideas under a single `##` or `###` header
- **Elaborative rehearsal:** follow each definition with one sentence explaining _why_ or _how_ it works, not just _what_ it is
- **Relationships:** use comparison tables for contrasting concepts; Mermaid diagrams for multi-step processes; nested bullets for hierarchies
- **Edge cases:** use GitHub-flavored alerts (`> [!WARNING]`, `> [!NOTE]`) for critical exceptions and nuanced conditions, remember to add a new line after the `> [!ALERT_LEVEL]` line

**Content hierarchy (strict priority order):**

1. **Definitions with boundaries** — what is included and excluded (exam traps live here)
2. **Conditional logic** — if/then rules, edge cases, exceptions
3. **Procedural steps** — numbered, with a note on why the order matters
4. **Contrast pairs** — easily confused concepts; use explicit "vs." statements and tables
5. **Formulas and code** — fenced blocks with language specified, 2-space indentation, inline comments explaining the purpose of each block

**Formatting rules:**

- **Bold** all testable terminology (definitions, formulas, proper nouns) on first appearance
- _Italic_ for cautionary notes or common errors
- Tables for 2+ related concepts
- Fenced code blocks with language tag for all code and commands

**Compression rules:**

- Eliminate: illustrative examples that add no edge-case information, historical development, author attribution, repeated restatements of the same point
- Preserve: all technical terms, numerical thresholds, syntax details, any example that reveals a boundary condition or corrects a common mistake

**Self-contained rule:** define all terms on first use. The summary must be fully understandable without the source material.

Honor any narrowing or emphasis in `$ARGUMENTS` as long as it does not conflict with the source material.

### 4. Measure summary read time and append footer

```bash
readtime "$SUMMARY_FILE"
```

Footer format for summarized lectures: `_X min read (source: Y min)_` where X is summary read time and Y is original source read time.

If the summary read time is greater than the original, the summary is too long.

Revise by removing in this order:
1. Any sentence that restates a point made elsewhere
2. Any illustrative example that does not reveal an edge case
3. Any prose that can be converted to a tighter bullet or table row

Re-measure after each pass. Do not cut testable content to pass the check.

## Edge Cases

- **Multi-topic PDF** (merged slides or chapters): one `##` section per topic.
- **Math-heavy content:** preserve LaTeX or plain-text formulas verbatim; do not simplify.
- **Very short source** (under 1 minute read time): produce a bullet-only summary with no structural overhead; still append the read time footer.
- **Non-English source:** summarize in the same language as the source unless `$ARGUMENTS` specifies otherwise.
