# Evidence and Outcomes

The core truth rule is `tool completed ≠ hypothesis confirmed ≠ impact demonstrated`. Judge each separately.

## Three-part action record

| Part | Useful values | Question |
| --- | --- | --- |
| Execution | completed, failed, blocked, unknown | Did the action run and return a usable result? |
| Hypothesis | confirmed, partial, refuted, inconclusive, untested | Did the evidence resolve the specific claim? |
| Impact | demonstrated effect and privilege, or none established | What security consequence was actually observed? |

A transport loss after dispatch is `unknown`: the action may have run. A scope denial is `blocked + untested`. A scanner completing is commonly `completed + inconclusive`. A controlled, valid test returning the predicted safe behavior may be `completed + refuted` for that precise hypothesis. A syntax error or missing authentication is normally not refutation. Keep the verdict narrower than the test.

## Hypothesis record

For material checks, capture:

- claim and affected component;
- observed basis, with evidence reference;
- predicted confirm and refute signals;
- actual test condition and output;
- operational status and evidential verdict;
- next distinct check, if still inconclusive.

Avoid making the record ceremonial. A one-line note is enough for a small check.

## Strong and weak evidence

Weak alone: process exit 0, a scanner severity, an HTTP 200, an error string, a copied exploit claim, a shell-looking prompt, a model assertion, or text containing `admin`, `root`, or `success`. These may justify a hypothesis.

Stronger evidence: controlled input causing a specific unauthorized state change; a stable response difference with a benign control; an independent identity/authorization check after claimed access; a source-to-runtime path with attacker control and a missing boundary; or a reproducible saved artifact. Interpret output in context, including negation and stale responses.

For a source finding, trace `entry → attacker control → reachable path → validation/authorization boundary → effect`. State the configuration and deployment conditions under which it applies. Source evidence can establish a defect even when a runtime environment is unavailable; describe the impact as conditional if it has not been exercised.

For a dynamic finding, retain target, test inputs or request shape, relevant output/response, expected versus observed behavior, and any ordering needed to reproduce. Use a benign proof object and the minimum data needed. Do not put full secrets in routine notes or reports.

## Independent verification

For a material access, privilege, data exposure, or exploitability claim, seek a check with a different failure mode: scanner result plus manual reproduction, response plus independent state read, source trace plus focused runtime check, or access marker plus an identity probe on the target. Repeating the same parser or request twice can show stability but is not independent corroboration. If another check is unavailable, say what was observed and lower the claim or confidence accordingly.

A false positive has a specific disproving observation. An inconclusive run lacks enough information. A blocked run did not test the hypothesis. Keep these separate when reporting.
