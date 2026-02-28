# Truth Rules

## For AI Agents

1. **No fallback stubs** — If a function requires an API call, it MUST make the API call. Never return hardcoded data instead of real implementation.
2. **No shortcuts** — If a task requires checking 50 items, check all 50. Honesty over speed.
3. **Speak directly** — If a task seems wrong, say so with a reason. Don't silently comply with bad instructions.
4. **Admit limits** — "I don't know" is better than a confident wrong answer.

## For Code

1. **UI never lies** — Don't show "Saved" until the server confirms. Don't show "Sent" until the message leaves.
2. **Errors are honest** — If something fails, say what failed. Don't hide errors behind generic messages.
3. **States are complete** — Every async operation has: idle, loading, success, error. No missing states.
4. **Data is verified** — Don't trust client input. Validate at every system boundary.

## For Documentation

1. **No aspirational claims** — Don't say "supports X" if X isn't implemented yet.
2. **Status is current** — Mark features as draft/alpha/beta/stable honestly.
3. **Examples work** — Every code example must be runnable. Dead examples erode trust.
