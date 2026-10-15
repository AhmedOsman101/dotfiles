# Output Contract

The rules for every finding this skill produces. The templates in this directory consume this contract; this file *is* the contract. When a template and this file disagree, this file wins.

## Why the contract is this heavy

A review is read by an agent or a human who was not present at the review. They cannot see what you saw, and they will treat what you write as established fact unless you tell them otherwise. Two failure modes follow directly:

- **A finding without context gets read as fact.** The reader has no way to tell whether you traced the call graph or glanced at a hunk. They will act on it either way.
- **A finding without evidence gets read as opinion.** "There may be a race here" costs the reader a ten-minute investigation to discover you were guessing.

Both are fixed by the same discipline: attach the context that justifies the claim, and label the confidence honestly.

## The finding object

Every finding is an object with these fields. No other fields.

| Field | Required | Contents |
| --- | --- | --- |
| `id` | always | `F1`, `F2`, … stable for the life of the review. Never renumber mid-review. |
| `where` | always | `path:L<line>` or `path:L<a>-<b>`, plus the enclosing symbol in backticks. |
| `severity` | always | `Critical` \| `Important` \| `Minor` \| `Question` |
| `confidence` | always | `Confirmed` \| `Unverified` |
| `axis` | always | `correctness` \| `spec` \| `smell` |
| `what` | always | The defect, one sentence, specific enough to act on. |
| `context` | always | Why this is a finding *here*. See below. |
| `impact` | `Critical`, `Important` | What goes wrong, for whom, under what conditions. |
| `evidence` | `Confirmed` | The command you ran and the output you observed. |
| `fix` | always | A concrete change. A proposed direction, never an applied edit. |
| `unverified_reason` | `Unverified` | Why you could not confirm it, and what would confirm it. |

## Context: what "always attach context" means

`context` is the field that makes a finding trustworthy. It is not a restatement of `what`, and it is not optional. It answers: **what did I check that makes this claim safe to make?**

Write the context that would let a reader reproduce your reasoning:

- **For a correctness finding** — the call path you traced. Who calls this, with what. What you verified upstream. Whether the input really can be null, not just that it is typed as optional.
- **For a spec finding** — the spec line, quoted, and where it came from. A spec finding with no quoted requirement is an opinion about intent.
- **For a smell finding** — the sibling implementation that does it the other way, or the other hunk with the same shape. A smell with no second example is a preference.
- **For a historical claim** — the commit you are pointing at. "This is a regression" requires a SHA.

Bad context: `context: this function can be called with null.`
Good context: `context: three callers reach this — SessionStore.load (L88), AuthGuard.check (L120), and the new one here. The other two guard the result; a41f2c9 added those guards after the same crash. This caller was added later and did not inherit the guard.`

The good one is usable by a reader who has never opened the file. The bad one is a claim about a claim.

## Evidence: what counts

Evidence must be something you actually ran and observed. Paste the command and the output. Trim the output to the relevant lines, but never paraphrase it into an assertion.

```
evidence: `bun test src/api/retry.test.ts` → 1 failing:
  retry.test.ts:44  expected 3 attempts, received 1
```

```
evidence: `sed -n '38,46p' src/auth/session.ts` → confirms no guard between `.find()` and `.email`
```

Static reading is legitimate evidence for a static claim — "this line is not there" is checkable. It is not evidence that the code *misbehaves* at runtime. If you have not executed the failure path, you are `Unverified`, however sure you feel.

## Severity

How much it matters if you are right.

| Label | Means | Test |
| --- | --- | --- |
| `Critical` | Wrong behaviour, data loss, security hole, crash, broken contract. | Does this ship an incident? |
| `Important` | Real defect or design flaw that should be fixed before merge. | Will this bite in production or in the next change? |
| `Minor` | Polish, naming, micro-optimisation. | Can the author ignore it without regret? |
| `Question` | You need information from the author. | Is the honest answer "I don't know, do you?" |

`Question` is not a soft `Minor`. It exists so you never have to dress up an uncertainty as an assertion, and it blocks a fix only when the answer blocks it.

## Confidence

How sure you are. Orthogonal to severity.

| Label | Means |
| --- | --- |
| `Confirmed` | You executed something, or checked a static claim directly, and observed it. Evidence is attached. |
| `Unverified` | You reasoned your way here and could not confirm it. A reason is attached. |

`Unverified` is not an accusation and not an apology. It is a labelled gap. Most static reasoning is `Unverified`, and pretending otherwise is the fastest way to lose a reader's trust on the findings that are real.

Never present an unverified claim without the label. If you catch yourself writing "this will fail", either run it or downgrade the sentence.

## Axis

Every finding is tagged `[correctness]`, `[spec]`, or `[smell]`. A change can pass one axis and fail another, and a single ranked list lets a passing axis mask a failing one. Tag, then report per axis.

- `[correctness]` — it does not do what the code says it does.
- `[spec]` — it does what the code says, but not what the work asked for.
- `[smell]` — it works, and the shape of it will cost you later.

## Writing rules

- **Exact locations.** Real paths, real line numbers. Ranges as `L88-140`.
- **Exact symbols** in backticks: `` `parseInt(input)` ``, `` `UserSession.expiresAt` ``.
- **A concrete fix.** "Consider refactoring" is not a fix. "Extract the retry loop into `src/util/retry.ts` and call it from both sites" is.
- **No hedging.** `perhaps`, `maybe`, `I think`, `might possibly` — pick `Unverified` and state the reason instead.
- **No throat-clearing.** "I noticed that", "It seems like", "You might want to consider", "Just a small thing but".
- **No praise padding.** Not because praise is bad, but because it is not this artifact's job. One clean line if the change is clean.
- **Security findings break the format.** A CVE-class bug or an architectural disagreement gets a full paragraph with a reference, then you resume the contract. A one-line security finding is a security finding nobody acts on.

## Anti-patterns

| Don't write | Why | Write instead |
| --- | --- | --- |
| `L42: bug. Add null check.` | No context, no evidence, unreadable by a stranger. | The full object. |
| `This function is too long.` | Not a defect and not actionable. | `Minor`: name the specific extraction, or drop it. |
| `Might have a race condition.` | An unlabelled guess presented as fact. | `Unverified` + the interleaving you suspect + what would confirm it. |
| `Should consider improving error handling.` | Vague by construction. | Name the function, the failure, the handling. |
| `Critical` on a naming nit | Destroys the report's ability to be triaged. | `Minor`. |
| A finding with no `where` | The reader cannot verify it. | Get the line number or drop the finding. |

## GitHub mapping

Labels are chosen to map onto GitHub issue labels without translation: `critical`, `important`, `minor`, `question`, `unverified`, `confirmed`, `correctness`, `spec`, `smell`. One severity label plus one confidence label plus one axis label carries a finding into an issue with no rework.
