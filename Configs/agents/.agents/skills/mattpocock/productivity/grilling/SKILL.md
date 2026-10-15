---
name: grilling
description: Grill the user relentlessly about a plan, decision, or idea. Use when the user wants to stress-test their thinking, or uses any 'grill' trigger phrases.
---

Interview the user relentlessly until you reach a shared understanding. Map this as a **design tree**: every decision branches into the decisions that hang off it.

Work the tree in **rounds**. The **frontier** is every decision whose prerequisites are already settled: the questions you can ask _now_ without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Format a round like so:

```
❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>
```

Word each question so "yes" accepts your recommended answer.

## Presentation

These are hard rules. They exist because the round is a conversation, not a form.

- **Grill in chat.** Write the round into your reply as ordinary message text. Never use a structured question/choice tool to ask it, even when one is available and even when the questions have discrete answers. The user reads and answers the round as prose.
- **Recommend everywhere.** Every question carries your recommended answer. The one exception is a question that genuinely cannot be reduced to a preference — one that only the user's own reasoning can answer. Even then, say which way you lean and why.
- **Offer choices as options.** Where a question has discrete answers, list them explicitly as `Option A`, `Option B`, `Option C`. Letters only:
  - Never `Option 1A`, `Option A1`, `Option 2B`, or any hybrid.
  - Never derive the letter from the question's number. Q3's options are still A, B, C — not C, D, E.
  - The option letters belong to the question and restart at A for the next one.
- **Mark the recommendation inline.** Append `(Recommended)` to the option you recommend, inside its label, so a flat "yes" or "agreed" accepts it.

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a _later_ round, not this one.

Finding _facts_ is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent to find it; don't ask the user for anything you could look up yourself. Don't block on it: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the sub-agent to report; ask the rest of the frontier now. The _decisions_ are the user's: put each to them and wait.

The session is done when the frontier is empty: every branch of the design tree visited, nothing left silently assumed. Do not act on it until the user confirms you have reached a shared understanding.
