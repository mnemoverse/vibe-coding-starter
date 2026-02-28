# Algorithmic Fidelity Protocol

> Every function that computes a formula, applies a threshold, filters data, or makes a numerical decision must pass this protocol.

## Scope

This protocol covers:
1. **Mathematical formulas** — scoring, learning rates, decay functions, normalization
2. **Filtering logic** — thresholds, stopwords, min/max guards, type checks
3. **Scoring/ranking** — relevance boosts, weight calculations, sorting criteria
4. **Structural decisions** — cluster sizes, batch limits, capacity caps

## Before implementing any algorithmic function

### Core Checklist

1. **What does it compute?** One-sentence description of the formula/algorithm.
2. **Scientific basis?** Paper reference, equation number, or design rationale. If there's no paper — document WHY this formula was chosen over alternatives.
3. **Exact or approximation?** If approximation — document what is approximated and the error bound. If heuristic — say so explicitly.
4. **All parameters in config?** Every tunable number MUST come from a config object. No magic numbers in function bodies. Exception: mathematical constants (pi, 1.0, 2.0 as normalization).
5. **Toy example test?** If an analytic answer exists for a small case, write a unit test that verifies it.
6. **Edge cases documented?** What happens with zero input, empty list, single element, negative values?

### STOP Rule

If during implementation the formula turns out harder than expected — **STOP and report**. Do NOT build a simpler proxy and label it "sufficient for now".

An honest stub with `raise NotImplementedError("Needs X, see Issue #XX")` is better than working code with wrong mathematics or silent degradation.

## Filtering / gating logic

1. **What does it filter?** Document what passes and what gets blocked.
2. **Is the filter complete?** Are all edge cases covered? Is it overly aggressive?
3. **Single source of truth?** Filter lists belong in one place, not scattered across files.
4. **Configurable?** Threshold-based filters must use config params. Hardcoded lists should be in dedicated modules.
5. **Silent failures?** Does the filter silently drop valid data? Add logging for filtered items at DEBUG level.

## Scoring / ranking

1. **Formula in docstring.** Write the scoring formula explicitly.
2. **Score range.** Document the theoretical min/max of the output.
3. **Monotonicity.** Does higher input always mean higher output? If not — document.
4. **Composability.** If scores are multiplied together (boost chains), document the interaction and maximum theoretical compound effect.

## Anti-patterns

- **Magic numbers:** `x / 50` without explanation → extract to config with a name
- **Silent proxies:** "close enough" formula that doesn't match the spec → raise NotImplementedError
- **Undocumented caps:** `[:50]` slice without comment → document why 50
- **Compound boosts:** Three `*= (1 + bonus)` in sequence without documenting the maximum combined effect
- **Precision theater:** Using float64 for a value that's already an approximation → match precision to reality
