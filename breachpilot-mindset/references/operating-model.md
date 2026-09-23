# Operating Model

## Contents

- Mission model
- Phase gates
- Decision-cycle scoring
- Prerequisite-aware planning
- Branch control
- Reflection and re-planning
- Termination

## Mission model

Represent the task mentally as:

`Mission = Goal + Scope + Mode + Constraints + Evidence + Open Hypotheses + Plan`

Only `Evidence` may promote an assertion from plausible to confirmed. The model's confidence, a scanner label, or a successful process exit is not enough by itself.

## Phase gates

### 1. Recon

Objective: learn enough about the target to avoid technique-first guessing.

Exit when the relevant attack surface is minimally characterized: reachability, protocols/routes/components, and at least one useful fingerprint or behavioral observation. For broad network work, two complementary recon observations are preferred.

### 2. Enumeration

Objective: deepen each relevant surface until a vulnerability hypothesis can be specific.

For each important service/application boundary, seek the minimum details that change technique selection: implementation, version, authentication model, exposed functionality, input surfaces, trust relationships, headers/protocol features, error behavior, or source path.

### 3. Vulnerability research

Objective: convert observations into ranked, evidence-compatible hypotheses.

Rank candidates by:

1. fit to observed product/behavior/code;
2. reachability of the vulnerable path;
3. user/control prerequisites already satisfied;
4. ability to validate safely and reproducibly;
5. impact if confirmed;
6. cost/noise of the check.

Do not let severity scores outrank poor applicability.

### 4. Validation

Objective: discriminate one hypothesis per cycle.

For each action, know before execution:

- what exact outcome confirms the hypothesis;
- what exact outcome refutes it;
- what result would remain inconclusive;
- what evidence should be retained.

Prefer the least invasive discriminating test.

### 5. Post-access

Objective: prove only the additional impact needed by the mission.

Entering this phase is not automatic. Re-check authorization, exclusions, data-handling limits, and user objective. Do not escalate, move laterally, collect credentials, or inspect unrelated data simply because access is available.

### 6. Reporting

Objective: create a reproducible evidence chain, not a victory narrative.

Promote only verified claims. Include refuted or blocked branches when they explain confidence or remaining uncertainty.

## Decision-cycle scoring

When several next actions are possible, prefer the one with the highest expected information value:

`priority ≈ decision impact × probability of discrimination ÷ cost/noise/risk`

Use this qualitatively. The best action is usually the cheapest one that can change the plan.

Avoid:

- broad scans after the relevant service is already known;
- exploit research before a product/version/behavior is identified;
- credential guessing before evidence indicates authentication is the blocking prerequisite;
- repeated equivalent tools that answer the same question;
- post-access activity that does not serve the mission objective.

## Prerequisite-aware planning

Treat actions as a dependency graph even without a backend DAG.

For each candidate action, ask:

- What does it require?
- Which requirements are already established?
- Which missing requirement has the lowest-cost producer?
- What evidence will the action produce?
- Which later decisions depend on that evidence?

If an action fails because a prerequisite is missing, schedule a producer of that prerequisite rather than retrying the consumer.

## Branch control

Do not drift endlessly between services. Keep one active branch until one of these occurs:

- hypothesis confirmed;
- hypothesis refuted;
- prerequisite unavailable;
- branch blocked by scope/tooling;
- a new observation makes another branch materially higher-value.

When switching branches, state why.

## Reflection and re-planning

Use reflection as a control mechanism, not a monologue. After repeated failure or major new evidence, produce only:

1. facts that changed;
2. assumptions invalidated;
3. branch status;
4. highest-value next action;
5. expected confirm/refute signal.

Do not repeat prior reasoning unchanged.

## Termination

A good autonomous assessment knows when to stop.

Terminate when:

- the user objective is confirmed with enough evidence;
- no in-scope path remains with reasonable expected value;
- required authorization/prerequisites are absent;
- capability limitations make further testing non-informative;
- time/action budget is exhausted.

A blocked path is an outcome. Report the prerequisite rather than pretending a result.
