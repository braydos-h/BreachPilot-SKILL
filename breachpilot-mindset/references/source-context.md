# BreachPilot Source Context

This skill is a backend-free distillation of the operating ideas in `braydos-h/BreachPilot`, not a copy of its service architecture or attack-module catalog.

## Primary source areas reviewed

- `README.md` — project purpose, full assessment lifecycle, evidence-first verification, containment, autonomy model, reliability goals.
- `CLAUDE.md` and `AGENTS.md` — architecture canon, permission/target-lock model, boot sequence, implementation invariants.
- `docs/architecture.md` — separation of orchestration, tool routing, evidence, scope, outcome judgment, and reporting.
- `docs/exploit-agent.md` — modern Flow A loop: plan, phase-narrowed action selection, execute, normalize outcome, reflect, re-plan, stop/report.
- `tools/exploit_agent/prompt.py` — recon→enumeration→research→validation workflow, hypothesis protocol, one-primary-tool discipline, verification discipline, failure recovery, environment awareness.
- `tools/exploit_agent/phase_tracker.py` — anti-premature-termination phase minima.
- `tools/exploit_agent/outcome_truth.py` and `docs/outcome-evidence.md` — conservative outcome classification and separation of operational success from evidential truth.
- `tools/exploit_agent/reflection.py` — periodic reflection and retry/branch adaptation.
- `tools/mcp_tools/assessment_state.py` and capability-design docs — explicit assessment state, hypotheses, prerequisites, evidence references, and capability discovery.
- `docs/skills.md` and `docs/skill-authoring.md` — skills are advisory context only and never expand scope/permission; progressive, context-relevant methodology selection.
- `mission.yaml`, `docs/safety-model.md` — allowlist/exclusions, risk profiles, forbidden classes of action, fail-closed safety philosophy.

## Concepts preserved in the standalone skill

1. target/scope locking as an invariant;
2. recon-first phase discipline;
3. falsifiable hypotheses before meaningful attack actions;
4. capability discovery before assuming a tool exists;
5. prerequisite-aware planning instead of brute-force retries;
6. evidence-linked outcomes independent of command success;
7. conservative compromise/finding classification;
8. independent verification for high-impact claims;
9. periodic reflection after failures/new evidence;
10. explicit stop conditions and blocker reporting;
11. skills/methodology never override authorization;
12. reliability measured by reproducible truth, not tool count.

## Backend components intentionally omitted

This package does not include or emulate:

- MCP servers or tool registries;
- databases, queues, run services, WebUI, or APIs;
- Docker worker/sandbox/network firewall;
- persistent attack memory or experience store;
- credential vault;
- multi-agent swarm/campaign scheduler;
- report generator service;
- target allowlist enforcement code;
- custom exploit modules or payloads.

Their behavioral intent is translated into instructions the current coding agent can follow with its own tools.
