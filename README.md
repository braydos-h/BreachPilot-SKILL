# BreachPilot Mindset — Portable Agent Skill

A backend-free `SKILL.md` package that transfers the **BreachPilot operating model** into Claude Code, OpenAI Codex, and other coding-agent CLIs that support Agent Skills or can load Markdown instructions.

It contains no server, API, database, MCP dependency, sandbox manager, exploit backend, or persistent state. The skill teaches the agent to use BreachPilot's decision loop: **scope → observe → hypothesize → choose a useful check → classify evidence → verify → adapt → report**. It applies to live authorized assessments, source and artifact reviews, and focused finding verification.

The skill is methodology, not a technical control. It cannot enforce a target allowlist, isolate a shell, or verify a result automatically. The agent uses the tools and safeguards actually present in its runtime.

## Package

```text
breachpilot-mindset-skill/
├── breachpilot-mindset/
│   ├── SKILL.md
│   └── references/
│       ├── operating-model.md
│       ├── evidence-and-outcomes.md
│       ├── failure-and-recovery.md
│       ├── scope-and-safety.md
│       ├── reporting-contract.md
│       └── source-context.md
├── adapters/
│   ├── AGENTS.md.snippet
│   └── CLAUDE.md.snippet
└── README.md
```

## Install in Claude Code

Project-local:

```bash
mkdir -p .claude/skills
cp -R breachpilot-mindset .claude/skills/breachpilot-mindset
```

Personal/global:

```bash
mkdir -p ~/.claude/skills
cp -R breachpilot-mindset ~/.claude/skills/breachpilot-mindset
```

Invoke explicitly with `/breachpilot-mindset`, or let Claude activate it when the request matches its description.

## Install in Codex CLI

Project-local:

```bash
mkdir -p .agents/skills
cp -R breachpilot-mindset .agents/skills/breachpilot-mindset
```

Personal/global:

```bash
mkdir -p ~/.agents/skills
cp -R breachpilot-mindset ~/.agents/skills/breachpilot-mindset
```

Codex can select the skill automatically from its `name`/`description`, or you can explicitly request `$breachpilot-mindset` where supported.

## Generic coding-agent CLI

If the CLI supports the open Agent Skills layout, install the `breachpilot-mindset/` directory in its skills directory unchanged.

If it does not support skills natively, keep the folder in the repository and add the appropriate snippet from `adapters/` to your root agent-instructions file. The snippet tells the agent to read `breachpilot-mindset/SKILL.md` for authorized security tasks.

## What changed from BreachPilot

| BreachPilot backend concept | Standalone skill equivalent |
| --- | --- |
| target allowlist / scope gate | explicit scope ledger + preflight every target-touching action |
| exploit-agent loop | observe → hypothesize → act → normalize → verify → adapt |
| phase tracker | phase questions and evidence-based stopping judgment |
| assessment-state service | compact session facts/hypotheses maintained by the agent |
| outcome judge | separate execution, hypothesis verdict, and demonstrated impact |
| audit/evidence store | evidence references in the current session/report |
| failure taxonomy | local failure classification + recovery matrix |
| reflection/peer agents | concise re-plan when evidence or failures change the path |
| runtime skill selector | progressive references loaded only when relevant |
| backend memory | compact working state; task-local artifacts only when useful |
| MCP tool catalog | discover/use only tools actually available in the CLI |

## Design notes

The canonical `SKILL.md` intentionally uses only the portable `name` and `description` frontmatter fields. Vendor-specific fields are omitted so the same folder remains valid across Agent Skills implementations.

The main file stays focused on behavior; detailed rules live one reference level below it. That matches the progressive-disclosure pattern used by current Claude and Codex skill systems.
