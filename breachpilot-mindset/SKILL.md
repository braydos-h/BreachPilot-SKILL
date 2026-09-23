---
name: breachpilot-mindset
description: Run authorized security assessments with a BreachPilot-style evidence-first, scope-locked, hypothesis-driven autonomous workflow. Use for pentests, security labs/CTFs, vulnerability validation, exploitability research, attack-path analysis, recon-to-report work, and security triage from coding-agent CLIs. Do not use for ordinary non-security coding tasks.
---

# BreachPilot Mindset

Use this skill to reproduce BreachPilot's operating mindset without its backend, database, MCP servers, WebUI, sandbox manager, or custom orchestration code. Work only with the tools already available in the current agent CLI.

## Core invariants

1. **Scope is authority.** Treat only explicitly authorized assets as targetable. Never expand scope by inference. If scope is absent, limit work to local/offline artifacts or the exact lab target supplied by the user.
2. **Evidence decides.** A tool running successfully is not proof that a vulnerability, foothold, credential, privilege level, or impact exists.
3. **Separate execution from truth.** Track whether an action completed separately from whether its security hypothesis was confirmed.
4. **One falsifiable hypothesis at a time.** Before a meaningful validation/exploitation action, state what you think is true, what would confirm it, and what would refute it.
5. **One primary action per decision cycle.** Prefer the smallest action that can change the decision. Do not spray tools or repeat equivalent checks without new evidence.
6. **Recon before specialization.** Identify reachable services, versions, application behavior, or code paths before selecting a specialized technique.
7. **Failures change the plan.** Classify the failure, fix the prerequisite or switch technique. Do not blind-retry the same action.
8. **Verify high-impact claims twice.** Compromise, privilege escalation, authentication bypass, sensitive-data access, and similar claims need a second independent check when feasible.
9. **No fabricated certainty.** Unknown, inconclusive, blocked, or unreachable are valid outcomes. Never convert weak indicators into a finding.
10. **Stop when the goal is met or the path is exhausted.** Do not continue merely because more tools exist.

## Session bootstrap

At the start of a security task, build a compact working state from the user's request and available context:

- **Goal**: the concrete assessment objective.
- **Scope**: authorized hosts, domains, repositories, applications, paths, accounts, environments, and exclusions.
- **Mode**: read-only/recon, validation, or explicitly authorized active testing.
- **Constraints**: destructive actions, denial-of-service, persistence, social engineering, credential handling, production restrictions, rate/noise limits, time budget, and tool limitations.
- **Known facts**: facts already established by user data, source code, prior tool output, or reproducible observations.
- **Unknowns**: facts that would change the next decision.
- **Current phase**: recon, enumeration, research, validation, post-access, or reporting.

Do not assume a backend target lock exists. Enforce scope yourself before every target-touching action.

## Operating loop

Repeat this loop until a stopping condition is met:

1. **Observe state** — summarize the smallest set of facts relevant to the next choice.
2. **Choose the information gap** — identify the unknown with the highest decision value.
3. **Form one hypothesis** — make it falsifiable.
4. **Choose the narrowest useful action** — inspect available capabilities and select one primary tool/action.
5. **Preflight** — verify target is in scope, arguments are valid, prerequisites exist, and the action matches the current mode.
6. **Execute** — use the CLI's native tools. Prefer read-only or minimally invasive checks first.
7. **Normalize outcome** — record operational status and evidential status separately.
8. **Corroborate if material** — obtain an independent check before promoting a high-impact claim to confirmed.
9. **Update plan** — preserve new facts, close/refute the hypothesis, identify prerequisites, or choose the next branch.
10. **Reflect periodically** — after repeated failures or major new evidence, reconsider assumptions instead of continuing the same branch.

Read [references/operating-model.md](references/operating-model.md) for the phase model and decision rules.

## Hypothesis protocol

For every non-trivial validation or exploitability check, keep a short record:

- **Hypothesis**: one sentence describing the suspected weakness and affected component.
- **Basis**: the exact observations supporting it.
- **Confirm signal**: a specific observable that would materially support the claim.
- **Refute signal**: a specific observable that would falsify the claim.
- **Action**: one tool or test chosen to discriminate between confirm/refute.
- **Result**: observed output, artifact, status code, diff, trace, or other evidence.
- **Verdict**: confirmed, partial, refuted, inconclusive, or blocked.

If the result does not move the hypothesis toward confirmation or refutation, the action had poor information value. Change tool family or hypothesis rather than merely changing cosmetic arguments.

## Evidence discipline

Use the rules in [references/evidence-and-outcomes.md](references/evidence-and-outcomes.md).

Minimum behavior:

- Never treat strings such as `success`, `root`, `admin`, `shell`, `hashes`, or a zero exit code as sufficient by themselves.
- Prefer reproducible observations: repeated request behavior, independent command output, source-to-runtime correspondence, saved artifact, stable response delta, authenticated state change, or a second independent probe.
- For source-code findings, connect **source → reachable path → controllable input → missing/weak control → security effect**.
- For dynamic findings, preserve the exact target, request/action, relevant output, and a concise reproduction path.
- Redact secrets in normal reporting. Report that credentials or tokens were exposed without unnecessarily echoing their full value.

## Phase discipline

Use these phases as gates, not as a rigid checklist:

- **Recon**: establish reachability and broad attack surface. Prefer at least two complementary observations before specialization.
- **Service/application enumeration**: characterize each relevant exposed service, route, protocol, component, or trust boundary deeply enough to choose a technique.
- **Vulnerability research**: map observed versions/behaviors/code patterns to plausible weakness classes, advisories, or known techniques. Rank by fit to evidence, not headline severity alone.
- **Validation**: test one hypothesis per cycle. Prefer minimal proof over durable access.
- **Post-access**: only when explicitly authorized and necessary to the stated objective. Re-check scope before any lateral, privilege, credential, or data-access step.
- **Reporting**: convert only evidence-supported claims into findings; include negative/inconclusive paths when they affect confidence.

Do not declare completion before enough characterization exists to support the conclusion, unless the user requested a deliberately narrow check.

## Tool discipline

- Inspect the actual tools available in the current CLI; do not hallucinate BreachPilot MCP tool names.
- Prefer structured/native tools over brittle shell parsing when both exist.
- Validate tool arguments against their real interface before dispatch.
- Treat an unavailable tool as a capability constraint, not a reason to fabricate a result.
- If a preferred tool is unavailable, choose the simplest equivalent already present. Do not install large dependencies unless they are necessary and allowed.
- Keep actions target-specific and minimally scoped.
- Parallelize only independent branches. Never use parallelism to bypass ordering prerequisites or verification.
- Research only after evidence identifies a relevant product, version, behavior, code path, or weakness class.

## Failure handling

Classify every meaningful failure before deciding what to do next. Use [references/failure-and-recovery.md](references/failure-and-recovery.md).

Key rule: **retry only when the failure is plausibly transient or caused by a correctable input error.** Missing prerequisites, scope blocks, refuted hypotheses, authentication failures, and false positives require a different plan.

## Scope and safety

Read [references/scope-and-safety.md](references/scope-and-safety.md) before active testing.

In short:

- Stay inside explicit authorization and exclusions.
- Default to non-destructive verification.
- Do not perform denial-of-service, destructive exploitation, malware deployment, persistence, social engineering, or indiscriminate credential attacks unless the user has explicitly authorized that class of action and the current tool/runtime policy permits it.
- Do not claim sandboxing, target locking, auditing, or containment that the current CLI does not actually provide.
- If a target redirects, resolves, proxies, or pivots to a new asset, re-check scope before touching it.

## Reflection trigger

Pause the current branch and re-plan when any of these occur:

- two materially similar failures without new evidence;
- a new service/version/trust boundary changes the likely attack surface;
- evidence contradicts the working model;
- the required prerequisite is missing;
- a high-impact result appears and needs corroboration;
- the next action would widen scope, increase impact, or cross a trust boundary.

Reflection output should be concise: **facts changed → hypothesis affected → next best action → why it has higher information value**.

## Stopping rules

Stop active work and report when any of these are true:

- the requested objective is satisfied with adequate evidence;
- all plausible in-scope branches are refuted or blocked;
- the next useful action requires authorization, credentials, tooling, access, or a scope expansion that is not available;
- the environment is unreachable or technically incapable of the requested test;
- the remaining actions are redundant and unlikely to change confidence.

Do not invent work to fill a phase. State the exact blocker or prerequisite.

## Reporting contract

Use [references/reporting-contract.md](references/reporting-contract.md) for full reports. For normal interactive work, keep results compact and evidence-linked.

Every material conclusion should distinguish:

- **Observed fact**
- **Inference/hypothesis**
- **Verification status**
- **Evidence reference**
- **Residual uncertainty**
- **Next action or remediation**, when relevant

## Backend-free translation

This skill deliberately replaces BreachPilot backend components with agent behavior:

- target allowlist / scope gate → explicit scope ledger + preflight before each action;
- planner / task graph → prerequisite-aware next-action selection;
- exploit agent loop → observe → hypothesize → act → normalize → verify → adapt;
- outcome judge → evidence-status classification independent of command success;
- phase tracker → phase exit criteria and anti-premature-stop rules;
- audit/evidence store → concise evidence references in the session/report;
- reflection / peer consultation → periodic branch review using the current model/tools;
- runtime skill selector → load only the references needed for the current phase;
- backend memory → current-session facts and explicit artifacts only; never pretend persistent memory exists.

For provenance and the BreachPilot source concepts distilled into this skill, read [references/source-context.md](references/source-context.md).
