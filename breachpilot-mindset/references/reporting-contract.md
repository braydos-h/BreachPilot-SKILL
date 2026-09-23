# Reporting Contract

## Contents

- Interactive update format
- Final assessment structure
- Finding template
- Confidence language
- Negative and blocked results

## Interactive update format

During execution, keep updates compact:

**Phase**: `<phase>`  
**Fact changed**: `<new evidence>`  
**Hypothesis**: `<open/confirmed/refuted>`  
**Next action**: `<one action>`  
**Why**: `<decision value>`

Do not dump internal chain-of-thought. Report concise decision rationale and evidence.

## Final assessment structure

Use this structure when a full report is appropriate:

```markdown
# Assessment Summary

## Scope and objective
- Authorized scope:
- Mode/constraints:
- Objective:

## Executive result
- Goal status: achieved / partially achieved / not achieved / blocked
- Highest-confidence findings:
- Material limitations:

## Attack surface observed
- Component/service — evidence — relevance

## Findings
### [Severity/priority] Finding title
- Status: confirmed / partial / refuted / inconclusive
- Affected component:
- Hypothesis:
- Evidence:
- Independent verification:
- Security impact:
- Reproduction summary:
- Residual uncertainty:
- Remediation:

## Attack path / dependency chain
1. Observation → evidence
2. Hypothesis → test
3. Verified effect → evidence

## Refuted and blocked paths
- Path — reason — evidence/blocker

## Recommended next actions
1. ...
```

## Finding template

A valid finding should answer:

- What exactly is wrong?
- Where is it reachable?
- What input/control does an attacker possess?
- What security boundary fails?
- What evidence proves the effect?
- Was it independently verified?
- What assumptions remain?
- How can it be fixed and retested?

## Confidence language

Use evidence-linked language:

- **Confirmed**: reproducible evidence establishes the claimed effect.
- **Partial**: a prerequisite or limited effect is proven, but not the full claim.
- **Refuted**: focused testing contradicts the claim under tested conditions.
- **Inconclusive**: evidence is insufficient or ambiguous.
- **Blocked**: authorization, capability, reachability, or prerequisite prevented a valid test.

Avoid labels such as "definitely vulnerable" unless the evidence warrants them.

## Negative and blocked results

Negative results matter when they prune the attack graph. Record them briefly if they explain why a path was abandoned.

For blockers, state the exact prerequisite required to continue, such as:

- authorization for an additional asset;
- a test account/role;
- a reachable environment;
- a browser/network capability;
- a dependency/version/build artifact;
- permission to perform a higher-impact validation step.
