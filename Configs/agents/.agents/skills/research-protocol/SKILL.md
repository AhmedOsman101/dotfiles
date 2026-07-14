---
name: research-protocol
description: "Gather facts from the web using evidence-first approach with mandatory citations. Use when researching topics, answering factual questions, or any task requiring web-sourced evidence."
keywords:
  ["research", "web", "browse", "evidence", "fact", "search", "investigate"]
related: [cite-before-answer, task-decomposition]
token_cost: 180
---

## Recommended research sources

- **web-search**
- **web-fetch** — Fetch a URL or local file and convert to Markdown text. Use on URLs found via web-search.
- **GitHub and GitHub CLI** — Search GitHub repositories, code, issues, and PRs.
- **NPM** — Search the npm registry for JavaScript/TypeScript packages.
- **PyPI** — Search PyPI for Python packages.

## Research Protocol (evidence-first)

1. Decompose the question into one or two unknowns. Write them down in your first reply.
2. For each unknown, search with the appropriate tool above, then fetch relevant pages with web-fetch, then call evidence-add (one fact per entry).
3. Do NOT state a fact that isn't backed by an evidence-add id.
4. Before answering, call evidence-list. Your answer must reference at least one id.
5. If evidence-list is empty, you are not ready to answer — go back to step 2.

## Rules

- NEVER state a fact that isn't backed by an evidence-add id
- ALWAYS call evidence-list before answering
- Your answer must reference at least one evidence id
- If evidence-list is empty, go back to gathering evidence
- After 3+ search refinements with no usable evidence, say "insufficient evidence" instead of guessing

## Stop conditions

- You have an evidence id for every claim in your answer → ANSWER
- You have tried 3+ search refinements with no usable evidence → say "insufficient evidence"

## Workflow

1. **Decompose**: Break the question into 1-2 unknowns
2. **Search**: Use searching tools, or other domain tool
3. **Fetch**: Use web-fetch on promising URLs to get full page content
4. **Save evidence**: Save evidence for each fact found (one fact per entry)
5. **Verify**: List evidence before answering; answer must reference at least one ID
6. **Stop condition**: Answer when all claims have evidence; say "insufficient evidence" after 3+ failed searches
