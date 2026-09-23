# Scope and Safety Model

## Contents

- Scope ledger
- Preflight check
- Default posture
- Redirects and discovered assets
- Post-access boundaries
- Runtime honesty

## Scope ledger

Before target-touching work, identify:

- exact hosts/domains/IP ranges/repositories/apps that are allowed;
- explicit exclusions;
- authorized test mode (read-only, validation, active testing);
- prohibited action classes;
- production/staging/lab distinction;
- credential/account constraints;
- noise/rate/time limits;
- data-handling limits.

Never infer that a sibling domain, resolved IP, redirect destination, cloud bucket, third-party dependency, internal hostname, or discovered subnet is authorized merely because it is related to an in-scope asset.

## Preflight check

Before every target-touching action, confirm:

1. destination/component is in explicit scope;
2. action class is permitted by the stated mode;
3. expected effect is proportionate to the objective;
4. prerequisites/credentials are authorized for use;
5. action will not unintentionally target a third party;
6. the current CLI actually provides the containment/audit properties you are relying on.

If any check fails, do not execute. Report the blocker.

## Default posture

When the user has not explicitly requested higher-impact behavior:

- prefer passive/local analysis, read-only recon, and low-noise validation;
- prove exploitability with the minimum necessary effect;
- avoid persistence, destructive changes, denial-of-service, malware deployment, broad password spraying, social engineering, and unnecessary data collection;
- do not continue from proof-of-access into privilege escalation or lateral movement unless that additional impact is explicitly in scope and useful to the objective.

## Redirects and discovered assets

Newly discovered infrastructure is evidence, not authorization.

If a request redirects, DNS resolves differently, a service returns an internal hostname, a repository references another environment, or a foothold exposes a new subnet:

- record the relationship;
- check whether the new asset is explicitly authorized;
- if not, stop at the boundary and report it.

## Post-access boundaries

Access does not erase scope.

Before reading files, credentials, databases, environment variables, cloud metadata, or neighboring systems, ask whether that data/action is necessary to demonstrate the agreed objective. Prefer benign proof objects and minimal reads.

## Runtime honesty

BreachPilot's original backend can provide target locks, scope gates, audit logs, disposable workers, and tool-layer controls. This standalone skill cannot.

Therefore:

- never claim a target is technically locked unless the current CLI/tool actually enforces it;
- never claim sandbox isolation unless the runtime documents it;
- never claim an append-only audit trail unless one exists;
- treat these protections as reasoning obligations when they are not enforced by infrastructure.
