# Template: Review Report

The whole-review artifact. Produced in two densities for two audiences.

Read [output-contract.md](output-contract.md) first. This file only describes how findings are assembled into a report.

## Which density

| Mode | Density | Lands in |
| --- | --- | --- |
| Subagent (another agent called you to gate its work) | **Compact** | The reply, inline |
| Primary (the user selected you to audit something) | **Full** | `docs/code-review/YYYY-MM-DD-<slug>.md` |

The compact report is token-expensive for the caller and should stay scannable. The full report is a document someone reads a week later, and carries everything.

Both are read-only on the repo. Neither applies a fix.

---

## Compact report (subagent)

Header, findings, declined list, roll-up. Nothing else — no preamble, no closing offer to help.

```
SCOPE · branch `feat/retry` vs merge-base with `main` · 12 commits, 340 lines · review of 2026-10-16
CONSENT · approved: `bun test`, `bunx biome check` | not approved: `bun run build`
SPEC · docs/plans/2026-10-14-retry-backoff.md (found) | STANDARDS · AGENTS.md, biome.json

F1 · Critical [Confirmed] · [correctness] · src/auth/session.ts:L42 `getUserByEmail`
ctx  three callers reach the return value — SessionStore.load L88, AuthGuard.check L120, and the new call here. The first two guard it; a41f2c9 added those guards after the same crash. This caller did not inherit one.
what `user` is dereferenced at `.email` with no guard; `.find()` returns `undefined` on a miss.
fix  guard the result, or make `getUserByEmail` throw on a miss so the contract is unmissable.
ev   `bun test src/auth/session.test.ts` → 1 failing: "miss returns undefined then throws on .email"

F2 · Important [Unverified] · [spec] · src/api/retry.ts:L23 `sendWithRetry`
ctx  `withBackoff` exists at src/util/backoff.ts:L12 and is used by the webhook sender at src/webhooks/stripe.ts:L40, but not here. Spec §4 asks for "resilient retries on all outbound calls".
what no retry on 429; the call gives up on the first throttle.
fix  wrap in `withBackoff(3)`, matching the webhook sender.
ev   — (see below)

F3 · Minor [Confirmed] · [smell] · src/db/query.ts:L88 `listActive`
ctx  no second example; the shape is local to this function.
what `const rows = build(); return rows` — the binding adds nothing.
fix  return the call inline.
ev   `bunx biome check src/db/query.ts` → `lint/style/useConst` at L88

DECLINED TO JUDGE
- src/api/retry.ts:L5 — retry count constant; not part of this change's contract.
- src/config/* — config surface, no spec coverage, separate concern.

UNVERIFIED, AND WHY
- F2 — no 429 stub exists in the test suite, and `bun run build` was not approved, so the
  network path could not be exercised. Confirmable with a fake transport returning 429.

ROLL-UP
- correctness · 1 Critical
- spec        · 1 Important
- smell       · 1 Minor
- axis coverage: correctness (full), spec (full), smell (diff only)
- 2 of 3 confirmed by execution
```

Omit a section rather than filling it with "none". An absent "Declined to judge" list is not the same as an empty one — if you set nothing aside, say so explicitly in the roll-up.

---

## Full report (primary)

~~~markdown
# Code Review: <scope name>

**Date:** YYYY-MM-DD
**Reviewer:** SeniorReviewer
**Scope:** <fixed point or tree, and what was covered>
**Commits:** <count and range, if a git range>
**Spec:** <path, or "none available">
**Standards:** <paths consulted>

## Consent

| Command | Status |
| --- | --- |
| `bun test` | approved, run |
| `bunx biome check` | approved, run |
| `bun run build` | approved, not needed |
| `bun run e2e` | not approved, skipped |

## Summary

<Three sentences maximum. What the change does, how many findings by severity, and the single
most important thing. No praise, no hedging.>

## Findings

### Critical

#### F1 · [correctness] · Confirmed

**Where:** `src/auth/session.ts:L42` in `getUserByEmail`

**What:** `user` is dereferenced at `.email` with no guard; `.find()` returns `undefined` on a miss.

**Context:** Three callers reach the return value — `SessionStore.load` (L88), `AuthGuard.check`
(L120), and the new call here. The first two guard it; `a41f2c9` added those guards after the same
crash. This caller was added later and did not inherit one.

**Impact:** Any login attempt with an email that has no user record throws instead of returning
a clean "invalid credentials". Reachable from the public login route.

**Evidence:**
```bash
$ bun test src/auth/session.test.ts
  ✗ getUserByEmail > returns undefined for unknown email
    expected undefined, received TypeError: Cannot read properties of undefined (reading 'email')
```

**Fix:** Guard the result before `.email`, or make `getUserByEmail` throw on a miss so the contract
cannot be forgotten by the next caller.

### Important

<same structure; `Impact` required, `Evidence` required only when Confirmed>

### Minor

<compact one-line form is acceptable here — see the compact report for the shape>

### Question

<F-n · [axis] · the question, what you already checked, and what answer would unblock you>

## Declined to judge

- `<where>` — <what you set aside, and why>. The author rules on this line.

## Unverified

| Id | Claim | Why unconfirmed | What would confirm it |
| --- | --- | --- | --- |
| F2 | No retry on 429 | No 429 stub; build not approved | Fake transport returning 429 |

## Roll-up

| Axis | Critical | Important | Minor | Question |
| --- | --- | --- | --- | --- |
| correctness | 1 | 0 | 0 | 0 |
| spec | 0 | 1 | 0 | 0 |
| smell | 0 | 0 | 1 | 0 |

**Coverage:** <what you actually read, and anything you did not. If the diff was too large for one
pass, say so here.>
~~~

## Rules for the report

- **No strengths section.** One line in `Summary` if the change is clean, then stop.
- **No single winner across axes.** The roll-up table is the closest you get to a verdict, and it never collapses the axes into one rank.
- **Do not reorder findings by importance.** Group by severity within their axis tags, and keep ids stable between the inline and file forms so a reader can cross-reference.
- **Quote the spec.** Every `[spec]` finding carries the requirement it fails, verbatim.
- **The declined list is mandatory in both densities**, even when empty. It is the record of what you chose not to see.
- **Never round up a finding to fill a severity band.** An empty `Critical` section is a good outcome, not a gap.
