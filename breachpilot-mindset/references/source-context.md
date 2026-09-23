# BreachPilot Source Context

This portable skill distills BreachPilot's operating model, not its implementation. The source repository supplied in `context/` includes a modern exploit agent (Flow A), a frozen database-backed research loop (Flow B), and supporting engineering docs. Some source documents describe different generations of the system; the common behavioral contract is the useful part to transfer.

## Ideas retained

| Source concept | Portable agent behavior |
| --- | --- |
| Operator goal and mission scope | Keep a goal, success condition, scope ledger, and action limits. |
| Planner, task graph, capability prerequisites | Pick the next discriminating action and satisfy missing prerequisites first. |
| Recon, enumeration, research, validation | Ask phase questions in an order suited to the task; avoid technique-first guesses. |
| Observer, OutcomeJudge, outcome normalization | Separate execution, hypothesis verdict, and demonstrated impact. |
| Evidence store and finding verifier | Keep reproducible evidence references and corroborate material claims. |
| Failure taxonomy and reflection | Diagnose failures, change a real assumption, and stop duplicate loops. |
| Report generator and reliability metrics | Value truthful, reproducible findings and sound stopping judgment over action or tool counts. |

The key references are `context/README.md`, `context/CLAUDE.md`, `context/AGENTS.md`, `context/docs/architecture.md`, `runtime-flows.md`, `exploit-agent.md`, `outcome-evidence.md`, `safety-model.md`, `skills.md`, `capability-upgrade-design.md`, `reliability-metrics.md`, and `context/tools/exploit_agent/prompt.py`, `phase_tracker.py`, and `outcome_truth.py`.

## What does not transfer

No part of this skill implements BreachPilot's MCP servers, target allowlist, network firewall, Docker worker, policy engine, audit hash chain, database, credential vault, multi-agent scheduler, or verification oracle. The agent must use the current runtime's real tools and permissions. A prose scope check is useful discipline, but it is not a technical lock. The source's fixed phase counts, output markers, tool names, and lab-specific defaults are implementation details, not universal requirements for this skill.
