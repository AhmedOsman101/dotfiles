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
# Prefer pdfx — format-aware extraction (lives in ~/scripts)
pdfx "$FILE_PATH"

# Fallback if pdfx is missing, errors, or output is unusable —
# ALWAYS use -layout for slides/tables/multi-column lecture PDFs:
pdftotext -layout "$FILE_PATH" -

# For image-heavy or RTL/Arabic PDFs, extract per page and sanity-check:
pdftotext -layout -f 1 -l 1 "$FILE_PATH" -
```

Toolchain: `pdfx` (Python via `runpy` shim in `~/scripts`), `pdftotext` (poppler), `readtime` + `pandoc`. No versions are pinned — if any of these are missing from PATH, say so and stop.

**Last resort only — `pdfx "$FILE_PATH" --llamaparse [TIER]` (LlamaParse cloud API):** ONLY when the document is image-heavy or has a complex layout AND both `pdfx "$FILE_PATH"` and `pdftotext -layout` produced nothing useful. It spends the user's real credits — **20,000 credits/month** — so tier discipline and user consent are mandatory.

**Garbage-but-nonempty output = ask, don't decide.** If both extractions completed but returned text that is unusable (jumbled reading order, missing/mangled tables and figures across most pages, the majority of the document unreadable), do NOT conclude on your own that `--llamaparse` is warranted, and do NOT invoke it. Use the question tool (the Question tool in opencode; any ask-the-user tool in other harnesses) before doing anything else, with exactly these options:

1. `Use --llamaparse at $TIER (~$N credits, $PAGES pages)` — state your recommended tier and its credit math; mark it "(Recommended)" only when the document is clearly image-heavy or complex-layout
2. `Accept the partial text as-is` — proceed from what was extracted; state plainly what was lost (tables, figures, pages N–M)
3. `Stop — I'll provide a different source or OCR it myself`

Never pick option 1 silently. Pre-authorization is the only exception: if the user already said "use llamaparse" / "use my credits" in the request, skip the question and just proceed with the tier that matches the document (stating tier and cost as you go).

| Tier | Credits/page | Use when |
| --- | --- | --- |
| `fast` | 1 | Simple, text-only documents |
| `cost_effective` (default) | 3 | Text-heavy, no diagrams/images |
| `agentic` | 10 | Straightforward diagrams and images |
| `agentic_plus` | 25 | Complex layouts, diagrams, images |

`pdfx --help` also lists `agentic-full` — no pricing is documented for it here; do not use it without asking first.

Budget rules: pick the cheapest tier the document plausibly needs — do not default to `agentic_plus` "to be safe". Estimate pages × tier before spending: a 30-page document at `agentic_plus` is 750 credits ≈ 26 such documents per month at this budget; at `cost_effective` the same document is 90 credits. Never call `--llamaparse` as a first attempt, never without the question-tool go-ahead (or pre-authorization). If a pass returns garbage, re-extract only the failing pages, not the whole file. (For Arabic/RTL PDFs that poppler garbles beyond repair, `--llamaparse` is preferable to forcing `pdftotext` — same question-first and tier rules apply.)

If `--llamaparse` fails or the user declines it, stop and report: the PDF likely needs OCR, or a layout-preserving source. For image-heavy PDFs, extract per page (`-f N -l N`) and spot-check a known page against the source.

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
- End with the read time footer (see step 5). Nothing after it.
- Incorporate the `/unslop` skill when writing.
- **Vault files:** when the output targets this Obsidian vault, the file must keep its frontmatter (`title`, `prev`, `next`) — never drop or clobber it. If creating a new note, emit the frontmatter stub after this summary and flag that neighboring notes' `prev`/`next` links need updating (see AGENTS.md → Navigation and Progression Rules).

**Worked example (density target):**

Source: "In CMOS circuits, dynamic power is P = αCV²f, where α is the activity factor, C the switched capacitance, V the supply voltage and f the clock frequency. Static (leakage) power is dominated by subthreshold leakage and grows roughly exponentially with temperature. Lowering V cuts dynamic power quadratically but increases propagation delay."

Summary:

```md
## Power Consumption

- **Dynamic power:** $P = \alpha C V^2 f$, where:
  - $\alpha$: activity factor
  - $C$: switched capacitance
  - $V$: supply
  - $f$: clock

The quadratic lever is $V$, but lowering $V$ increases delay ($t_{pd} \propto 1/V$), so $V$ is a power/timing trade, not free savings.

- **Static (leakage) power** — dominated by **subthreshold leakage**, grows ~exponentially with temperature; dominates at low activity / low clock.

_1 min read (source: 2 min)_
```

Every line is testable, the formula is verbatim, the why is attached to the what, and contrast survives as a boundary — that is the density to match.

**Active recall structure:**

- **Concept chunks:** group related ideas under a single `##` or `###` header
- **Elaborative rehearsal:** follow each definition with one sentence explaining _why_ or _how_ it works, not just _what_ it is
- **Relationships:** use comparison tables for contrasting concepts; Mermaid diagrams for multi-step processes; nested bullets for hierarchies
- **Edge cases:** use GitHub-flavored alerts (`> [!WARNING]`, `> [!NOTE]`) for critical exceptions and nuanced conditions, remember to add a new line after the `> [!ALERT_LEVEL]` line

**Interactive visualizers (freely, as many as the subject needs):** when a subject benefits from interactive visuals — processes, state machines, simulations, comparisons, graphs — add as many as genuinely add value. There is no per-note cap and no preferred primitive. If an existing `@viz/` component does the job, use it. If none exists, write a new SSR-safe component in `.vitepress/theme/components/viz/` (the `@viz/` namespace).

Rules (all mandatory):

- The markdown carries **only the wiring**: a `<script setup>` import block immediately after the frontmatter, then the component tags. No component implementation, styles, or helper functions inside the note.
- Import with the `@viz` alias — never relative paths.
- Components must be SSR-safe: no `window` / `document` / `localStorage` at module scope; compute in `computed`, touch the DOM only inside handlers or lifecycle hooks.
- Props: typed (`defineProps`), data inline as JSON-ish literals (no functions, no arbitrary HTML). Prefer a few well-documented props over a giant config object.
- New components: small, single-purpose, documented at the top with a usage example, themed with `var(--vp-*)` CSS variables so light/dark just works. Reuse existing components (`Stepper`, `PipelineViz`, or future ones) — a parameterized shared component beats near-duplicates every time.
- The prose must remain fully self-sufficient — visualizers are enhancements. Obsidian renders the tag as raw text, so a reader on the plain file must lose nothing.
- If a concept simply has no interactive structure to expose, don't invent one for decoration; Mermaid or a table is the right tool. Interactivity must earn its bytes.

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

### 4. Verify against the source (mandatory — do not skip)

Before appending the footer, run these four checks on the draft. Failing any of them means fix the summary first, then re-check:

1. **Formulas & thresholds verbatim.** Scan the source for formulas, numeric thresholds, and proper nouns (e.g. `P = αCV²f`, `k + n − 1`, `DC3 = 13h`, `±15 V`). Each one must appear verbatim in the summary (use KaTeX math instead of copying unicode symbols from the source). If missing, add it — drop a weaker line if space is needed.
2. **Coverage.** List the source's `##` / `###` headings (and any LO/objective numbers). Each is either covered in the summary or explicitly noted as omitted with a one-line reason. Learning objectives the source states are treated as mandatory coverage (but don't include them in the actual summary, they are just verification for you).
3. **Boundaries on every "vs."** Every comparison in the summary states the distinguishing condition, not just the similarity.
4. **Exam probe.** Write the 5 toughest questions the exam could ask from the source. The summary must answer each in ≤ 2 sentences. If not, add the missing line — never delete good content to pass this check.

Keep it fast: this is a checklist, not a rewrite. If the source is under 1 minute read time, checks 1 and 4 suffice.

### 5. Measure summary read time and append footer

```bash
readtime "$SUMMARY_FILE"
```

Footer format for summarized lectures: `_X min read (source: Y min)_` where X is summary read time and Y is original source read time.
You can append the footer using the following command: `printf '\n_%d min read (source: %d min)_\n' "$(readtime <summary> | rg -o '^\d*')" "$(readtime <source> | rg -o '^\d*')" >> <summary>`

If the summary read time is greater than the original, the summary is too long — with one exception: `readtime` counts Vue wiring (`<script setup>`, component tags, props) as words and cannot exclude it, so notes with visualizers carry ghost weight. **Tolerance:** when the summary contains component blocks, it may exceed the source read time by up to **10%** without revision. For precision, measure the prose with the Vue wiring stripped first — drop the `<script setup>…</script>` block and the tag-only lines (e.g. `rg -v -e '^<script' -e '^</script' -e '^<[A-Za-z]' -e '^import '`), then run `readtime` on the result. Without wiring, zero tolerance applies. Beyond the tolerance, revise.

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
