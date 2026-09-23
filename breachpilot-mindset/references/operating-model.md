# Operating Model

BreachPilot's useful abstraction is a mission state, a choice of next action, and an evidence-based update. The portable version can live in the agent's working context; no database, task queue, or framework is required.

## Working state

Keep only decision-relevant information:

| Field | What to retain |
| --- | --- |
| Mission | Goal, success condition, authorized scope, exclusions, action limits |
| Facts | Observations with source and time/context where relevant |
| Hypotheses | Statement, basis, confirm/refute signals, status |
| Branches | Candidate paths, prerequisites, cost/risk, why one is active |
| Evidence | Reproducible request, output, code location, or artifact reference |
| Blockers | The exact missing authority, access, tool, or environmental condition |

Update this state after meaningful observations. Do not turn model belief, a tool label, or repeated assertion into a fact. If context becomes crowded, compact it around facts, unresolved claims, and next decisions; keep raw artifacts available when possible.

## Phase questions

Use phases to avoid premature specialization, not to fill quotas.

1. **Recon / orientation:** What is reachable or present, and what is actually relevant to the objective?
2. **Enumeration / path tracing:** Which interface, code path, identity, or trust boundary makes a suspected weakness plausible?
3. **Research:** Does external information fit the observed version, configuration, and prerequisites? Confirm dates and applicability when they matter.
4. **Validation:** Which minimal test would distinguish a vulnerable state from a benign explanation?
5. **Post-access / impact:** Is more access necessary to prove the user's objective, and is that action authorized?
6. **Reporting:** Which claims survived validation, which were disproven or blocked, and what remains unknown?

A static source review may start at path tracing. A supplied finding may start at validation. A narrow task may finish without network interaction. Revisit earlier phases when a new result changes the model.

## Choose the next action

For competing actions, favor the one most likely to change the decision for the least cost, noise, and risk. Ask:

- Is the asset and action in scope?
- What prerequisite does the action require, and is that prerequisite established?
- What observation would change the branch or verdict?
- Can a simpler read-only check answer the same question?
- Is this action distinct from a check already performed?

Use a dependency sketch when needed: `goal ← proof ← test ← prerequisites`. If a test fails because a prerequisite is missing, investigate an authorized producer of that prerequisite. If several branches are independent, limited parallel read-only analysis may help; keep dependent validations ordered.

## Branch and reflection rules

Stay with a promising branch while each action yields new information. Switch when evidence refutes it, prerequisites cannot be met, scope blocks it, or another branch has clearly higher decision value. After repeated equivalent failures, identify the shared assumption and choose a materially different check or close the branch. Repeating the same probe through a different wrapper is usually not independent evidence.

Reflection should be a concise state update: what changed, which hypothesis it affects, and the best next test. Peer or research advice is a lead; compare it with evidence and authorization before acting.

## Stopping judgment

Stop when the requested claim or effect has adequate, reproducible proof; when reasonable in-scope branches have been tested or are blocked; when the budget is reached; or when the next useful action needs a missing permission or capability. A negative result is useful when it rules out the tested path, but it is not proof that the whole target is secure. Report the tested boundary and remaining uncertainty.
