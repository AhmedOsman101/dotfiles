# Template: Proposed Fix

A change you are proposing but **not applying**. This is the reviewer's answer to "so what would you do instead?" without crossing the report-only line.

Read [output-contract.md](output-contract.md) first.

## The hard rule

You never write the fix into the tree. Not the file, not the branch, not a patch that has already been applied. What you produce is a *proposal*: a described change, optionally illustrated with a sketch, that the author or the builder agent decides on.

Three reasons this matters:

- A reviewer that applies its own fix is grading its own homework, and the fix is then the least-reviewed code in the tree.
- You are the last person to arrive and the first to leave. You have the least context about why the code is the way it is.
- A proposal can be rejected cheaply. A committed fix cannot.

## When to propose one

- The finding is `Confirmed` and the fix is not obvious from the problem statement.
- Two reasonable fixes exist and the choice depends on things you cannot see (product intent, migration cost, deployment constraints).
- The author asked.

Do not propose one for every finding. `what` plus `fix` from the finding object is often enough; a proposal template is for the cases where the *shape* of the fix is the interesting part.

## Template

~~~markdown
# Proposed fix for F2 — no retry on 429 in `sendWithRetry`

**Addresses:** F2 · Important · [spec]
**Location:** `src/api/retry.ts:L23`
**Risk:** low — additive, one call site
**Touches:** `src/api/retry.ts` only

## The change

Describe the change in prose first. If the reader cannot follow it without the diff, the diff is
not going to save them.

Replace the bare `fetch` at L23 with a call to the existing `withBackoff` helper at
`src/util/backoff.ts:L12`, which the webhook sender already uses. Three attempts, exponential
backoff, retry on 429 and 5xx only.

## Why this shape

- `withBackoff` already exists and is already tested (`src/util/backoff.test.ts`). Reusing it means
  no new retry logic and no new tests for the retry itself.
- The webhook sender at `src/webhooks/stripe.ts:L40` is the in-repo precedent for outbound calls.
  Matching it keeps one retry policy in the codebase instead of two.
- Not a new dependency. Not a new abstraction.

## Sketch

Illustrative only — not a patch, not verified as written.

```ts
const res = await withBackoff(() => fetch(url, init), { attempts: 3 })
```

## Alternatives considered

- **A retry loop local to `sendWithRetry`.** Rejected: duplicates `withBackoff`, and the two
  policies will drift.
- **Retry at the queue level instead.** Possibly better, but out of scope for this change and it
  would not fix the single-call path. Worth a separate conversation.

## What this does not fix

- F1 is unrelated and untouched.
- The 429 path is still unverified — no stub exists in the suite, so the fix cannot be confirmed by
  test as written. Confirming it needs a fake transport.

## Open questions

- Should 400-class responses retry? Current behaviour does not, and this proposal does not change
  that.
~~~

## Rules

- **Prose before code.** A proposal that is only a diff is a patch you did not run.
- **Mark sketches as sketches.** Anything in a fenced block is illustrative and may not compile. Say so, every time.
- **Name what it touches.** A one-call-site change and a cross-cutting refactor are different asks; the reader decides how to spend their time and needs to know which this is.
- **Say what it does not fix.** A proposal silently read as a complete remedy is a trap.
- **Consider the alternative you rejected.** A proposal that acknowledges the other reasonable option is easier to evaluate, and sometimes you will be told you picked wrong.
- **No "I can apply this if you want".** You cannot; that is the whole point. Offer the description and let the author act.
