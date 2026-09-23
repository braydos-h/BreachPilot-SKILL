# Evidence and Outcome Model

## Contents

- Two-axis outcome model
- Evidence levels
- Strong vs weak signals
- Independent verification
- Source-code evidence chain
- Dynamic evidence chain
- Secret handling

## Two-axis outcome model

Always separate these axes.

### Operational status

What happened to the action itself?

- `completed` — tool/action ran to completion;
- `blocked` — policy, scope, permission, or environment prevented execution;
- `failed` — execution attempted but errored;
- `unknown` — status cannot be established reliably.

### Evidential status

What did the result prove about the security hypothesis?

- `confirmed` — reproducible evidence materially establishes the claim;
- `partial` — some preconditions or limited impact are established, but the full claim is not;
- `refuted` — evidence contradicts the hypothesis;
- `inconclusive` — the test ran but did not discriminate sufficiently;
- `not-tested` — no valid test occurred.

Examples:

- `completed + inconclusive`: scanner ran, result did not prove exploitability.
- `failed + refuted`: a deterministic rejection proves the suspected bypass does not work under tested conditions.
- `blocked + not-tested`: target was out of scope or required authorization was missing.

## Evidence levels

Use the strongest available level:

1. **Direct reproducible evidence** — independent command/request proves the effect.
2. **Corroborated behavioral evidence** — multiple independent observations align.
3. **Single behavioral indicator** — useful but usually insufficient for high-impact claims.
4. **Static/source evidence** — can be strong when reachability and controllability are also demonstrated.
5. **Tool label or model inference** — hypothesis only until verified.

## Strong vs weak signals

Weak by themselves:

- exit code 0;
- words like `success`, `root`, `admin`, `shell`, `hash`, `vulnerable`;
- a scanner severity label;
- a stack trace without control over the vulnerable condition;
- an HTTP 200 without a meaningful response/state difference;
- a theoretical vulnerable dependency with no reachable use.

Stronger signals include:

- a controlled input producing a specific security-relevant state change;
- an independently verified identity/privilege result;
- repeatable unauthorized data access to a deliberately chosen benign record;
- a deterministic response difference tied to controlled input;
- source evidence plus reachable call path plus attacker-controlled data flow plus missing control;
- a saved artifact that can be independently inspected and reproduced.

## Independent verification

For high-impact claims, use a second check that fails differently from the first.

Bad corroboration: same tool, same request, same parser, repeated twice.

Better corroboration examples:

- application response + independent state query;
- exploit output + separate identity/authorization check;
- source data-flow analysis + focused runtime test;
- scanner finding + manual request/response reproduction;
- one API route + a second route that reads the changed state.

If a second check is impossible, downgrade confidence and say why.

## Source-code evidence chain

For a codebase finding, document:

1. **Entry** — how untrusted input enters.
2. **Reachability** — the real call/control-flow path.
3. **Transformation** — validation, encoding, sanitization, parsing, or absence thereof.
4. **Sink/control** — the sensitive operation or missing authorization boundary.
5. **Security effect** — what an attacker could control or bypass.
6. **Runtime applicability** — configuration, feature flags, deployment assumptions, or version constraints.
7. **Verification** — unit/integration/reproduction evidence when feasible.

A dangerous-looking sink without a reachable attacker-controlled path is not a confirmed vulnerability.

## Dynamic evidence chain

Retain enough information to reproduce without dumping unnecessary secrets:

- target or component;
- exact test condition;
- relevant request/action shape;
- relevant response/output excerpt or artifact path;
- timestamp/order if sequencing matters;
- expected vs observed behavior;
- second-check result for material findings.

## Secret handling

- Do not echo full passwords, tokens, cookies, private keys, or credential material into normal reports.
- Use redacted identifiers or hashes/fingerprints when evidence needs identity.
- Preserve sensitive evidence only where the user explicitly requested it and the runtime is appropriate for secret material.
