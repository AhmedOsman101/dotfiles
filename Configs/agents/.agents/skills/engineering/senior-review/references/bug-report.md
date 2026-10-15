# Template: Bug Report

One defect, written so it can be filed as a GitHub issue without rework. Use this when a single finding needs to outlive the review — it is going on a tracker, into a backlog, or to someone who was not in the room.

Read [output-contract.md](output-contract.md) first. The bug report is a finding object expanded to issue shape.

## When to use

- The finding is `Critical` or `Important` and survives the review.
- The fix is out of scope for the change under review.
- The reader will not have the review in front of them.

Do not write one per finding. A review report with a bug report inside it for every line is a report nobody reads. Use this for the ones that travel.

## Template

~~~markdown
# <Verb-first title: "Session lookup throws on unknown email">

**Severity:** Critical
**Confidence:** Confirmed
**Axis:** correctness
**Labels:** `bug`, `critical`, `confirmed`, `correctness`
**Found in:** <commit sha / branch / version>
**Location:** `src/auth/session.ts:L42` in `getUserByEmail`

## What happens

`getUserByEmail` returns `undefined` when no user matches, and the caller at L42 dereferences
`.email` on the result without a guard. A login attempt for an unknown email throws a TypeError
instead of failing authentication cleanly.

State the behaviour, not the code shape. "Throws a TypeError" beats "missing null check" — the
first is observable, the second is a judgement about style.

## Context

Three callers reach the return value: `SessionStore.load` (L88), `AuthGuard.check` (L120), and the
new caller here. The first two guard the result; `a41f2c9` added those guards after the same crash
in `AuthGuard`. This caller was added later and did not inherit the guard.

This section exists so the reader can judge the finding without re-deriving it. Name what you
traced, what you compared against, and what you ruled out.

## Impact

Any login attempt with an email that has no user record throws. Reachable from the public login
route, so it is remotely triggerable. No data loss; the request 500s.

Be concrete about reachability and blast radius. "Remotely triggerable" and "requires a
misconfigured env var" are different bugs with the same code.

## Evidence

```bash
$ bun test src/auth/session.test.ts
  ✗ getUserByEmail > returns undefined for unknown email
    expected undefined, received TypeError: Cannot read properties of undefined (reading 'email')
```

```bash
$ sed -n '38,46p' src/auth/session.ts
  40:  const user = await this.getUserByEmail(email)
  41:
  42:  return { id: user.id, email: user.email }
```

Command and observed output. Not a paraphrase.

## Suggestions for a fix

- Guard the result before `.email`, returning the same failure the other two callers return.
- Or change `getUserByEmail` to throw on a miss, so the contract is unmissable at every call site.
  This touches the two existing callers, so it is the larger of the two changes.

Propose, never apply. If the fix touches something you did not review, say so.

## Not confirmed / open questions

- The `AuthGuard` guards are covered by tests; this caller is not. Whether that is a test gap or
  an accepted risk is a question for the author.

Anything you could not establish, so the reader knows where the edges of the report are.
~~~

## Rules

- **The title is a behaviour**, not a code location. `Session lookup throws on unknown email`, not `session.ts L42 null check`.
- **Labels come from the contract**: severity, confidence, axis, all lowercase, all already GitHub-shaped.
- **Evidence is a fenced block** with the command and the output. Never an assertion that you ran something.
- **Context is required**, and it is the section that distinguishes this from a guess.
- **The fix is a suggestion**, phrased as a direction. You are not the author.
- **Carry the review's finding id** into the issue body if the review is filed alongside it, so the two can be reconciled later.
