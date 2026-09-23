# Reporting Contract

Choose a format proportionate to the user's request. A short verification question needs a direct verdict and evidence. A full assessment needs enough detail for another person to reproduce and prioritize the results.

## Interactive updates

During a long run, report the current objective, a material fact or blocker, and the next decision. Keep the rationale concise. Do not present a tool's own success label as a verified security result.

## Final answer, any size

Lead with the outcome and scope actually assessed. For each material claim, make clear:

- what component and condition were tested;
- what happened and which raw evidence or source location supports it;
- whether it was confirmed, partial, refuted, inconclusive, or untested;
- what impact was demonstrated versus inferred;
- how independent verification was done, or why it was unavailable;
- what remains uncertain and the best remediation or next check.

“No verified finding in the tested paths” is a valid result. Do not convert it to “the system is secure.” A blocked path should name the missing asset permission, account, capability, access, or environment.

## Full assessment outline

Use only sections that serve the work:

1. Scope, objective, action limits, and method.
2. Executive result: goal status, highest-confidence findings, key limitations.
3. Observed attack surface or reviewed code paths.
4. Findings: affected component, security boundary, reproduction, evidence, validation, impact, remediation, retest.
5. Relevant attack path or prerequisite chain.
6. Refuted, inconclusive, and blocked branches that affect confidence.
7. Recommended next actions.

Prioritize by demonstrated effect, reachability, exposure, and exploit prerequisites; do not inherit severity from a scanner label alone. Redact secrets and unrelated personal data. Cite artifact paths, request IDs, code locations, or concise output excerpts rather than flooding the report with raw logs.
