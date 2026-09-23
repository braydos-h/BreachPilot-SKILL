# BreachPilot mindset

This repository packages a portable Agent Skill based on the investigation workflow behind [BreachPilot](https://github.com/braydos-h/BreachPilot). Use it with Claude Code, OpenAI Codex, or another coding-agent CLI that supports Agent Skills or can load Markdown instructions.

The skill guides live, authorized security assessments, source and artifact reviews, and focused finding verification. It gives the agent a clear working loop: set scope, observe, form a hypothesis, choose a useful check, assess the evidence, verify, adapt, and report.

## Package contents

The package includes the main skill, its supporting references, and instruction snippets for Claude Code and Codex.

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

Codex can select the skill from its `name` and `description`, or you can explicitly request `$breachpilot-mindset` where supported.

## Other coding-agent CLIs

If the CLI supports the open Agent Skills layout, install the `breachpilot-mindset/` directory in its skills directory unchanged.

If it loads Markdown instructions instead, keep the folder in the repository and add the appropriate snippet from `adapters/` to the root agent-instructions file. The snippet directs the agent to read `breachpilot-mindset/SKILL.md` for authorized security tasks.

## How the skill maps to BreachPilot

The skill carries over the investigation method in a form that works without BreachPilot's backend:

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

## Limits

This package provides methodology, not technical controls. It contains no server, API, database, MCP dependency, sandbox manager, exploit backend, or persistent state. It cannot enforce a target allowlist, isolate a shell, or verify results automatically. Those safeguards depend on the tools available in the agent's runtime.

## Design notes

The canonical `SKILL.md` uses only the portable `name` and `description` frontmatter fields. Vendor-specific fields are omitted so the same folder works across Agent Skills implementations.

The main file focuses on behavior. Detailed guidance lives in references one level below it, which agents can load when it applies to the task.
