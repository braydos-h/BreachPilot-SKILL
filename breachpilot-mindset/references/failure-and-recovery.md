# Failure and Recovery

## Contents

- Failure taxonomy
- Recovery matrix
- Retry discipline
- Anti-loop rules

## Failure taxonomy

Classify before recovering:

- `invalid-input` — wrong type, syntax, target form, option, schema, or malformed request.
- `tool-unavailable` — command/tool/capability does not exist in the current runtime.
- `prerequisite-missing` — required credential, foothold, artifact, version detail, feature, or access level is absent.
- `auth-failed` — credentials/session/authorization were rejected.
- `scope-blocked` — target/action is outside explicit authorization or current mode.
- `target-unreachable` — routing, DNS, firewall, service state, proxy, or environment prevents contact.
- `timeout` — action may be valid but did not complete in the useful window.
- `false-positive` — prior signal does not survive focused validation.
- `refuted-hypothesis` — evidence contradicts the working hypothesis.
- `unexpected-output` — action completed but returned a shape/state not accounted for.
- `environment-limited` — current agent CLI lacks the necessary execution/network/browser/system capability.

## Recovery matrix

| Failure | Default recovery |
| --- | --- |
| invalid-input | Correct once using the real tool/schema/interface, then retry once. |
| tool-unavailable | Find a simpler equivalent capability already present; otherwise report the limitation. |
| prerequisite-missing | Identify the minimum producer of the missing prerequisite and pursue that first. |
| auth-failed | Stop reusing the same credential/session; verify auth assumptions or obtain an authorized alternative. |
| scope-blocked | Do not retry. Report the exact required scope/authorization change. |
| target-unreachable | Verify routing/name resolution/environment, then switch technique if a distinct path exists. |
| timeout | Reduce scope, lower work factor, or choose a lower-cost discriminating test before retrying. |
| false-positive | Close the branch or reformulate the hypothesis from new evidence. |
| refuted-hypothesis | Close that hypothesis; do not rename the same test and repeat it. |
| unexpected-output | Inspect the smallest relevant output, update the model, and choose a new discriminating action. |
| environment-limited | State the missing capability and what would be required to continue. |

## Retry discipline

Retry only when one of these is true:

- malformed arguments were corrected;
- a clearly transient transport/service issue changed;
- test scope was reduced meaningfully;
- a missing prerequisite was actually satisfied;
- the retry uses an independent implementation that can distinguish tool failure from target behavior.

Do not retry simply because the previous result was undesirable.

## Anti-loop rules

After two materially similar failures with no new evidence:

1. stop the branch;
2. classify the failure;
3. restate current facts;
4. identify the missing prerequisite or invalid assumption;
5. choose a different family of action or report the blocker.

If every alternative depends on the same missing prerequisite, stop and report it.
