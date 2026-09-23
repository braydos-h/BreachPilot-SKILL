# Failure and Recovery

A failed action may still teach something, but it needs a diagnosis before the next attempt. Do not let an error message become a verdict on the target.

| Outcome class | Interpretation | Next move |
| --- | --- | --- |
| Invalid input or schema | The intended check did not run as designed. | Correct the actual interface or argument, then retry if useful. |
| Tool or environment unavailable | This runtime cannot perform that check. | Use an available equivalent or report the capability gap. |
| Prerequisite missing | The check needs access, identity, version, or artifact not yet established. | Find an authorized way to establish it; otherwise block the branch. |
| Authentication denied | The tested identity was rejected. | Verify account/session assumptions; do not blindly cycle credentials. |
| Scope or policy blocked | The action is outside current authorization or runtime permission. | Stop that path and state the exact boundary. |
| Target unreachable or timeout | The result may reflect route, service state, or cost. | Check reachability/environment or reduce the check; preserve uncertainty. |
| Determinate negative result | A valid, controlled test contradicts the specific hypothesis. | Refute that hypothesis under the tested conditions. |
| Ambiguous output | The check ran but did not distinguish explanations. | Choose a different observable or tool family. |
| Possible false positive | An earlier signal fails focused validation. | Downgrade or close the claim; record why. |

Retry only when the cause changed: corrected input, restored connectivity, satisfied prerequisite, smaller test, or an independent method that can distinguish tool error from target behavior. Cosmetic argument changes and repeated blocked calls do not add evidence.

After repeated similar failures, summarize the common assumption, any information gained, and the next distinct path. If none exists within scope and budget, stop and report the blocker. If execution status is unknown after dispatch, check for side effects before repeating a potentially mutating action.
