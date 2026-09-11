# Lean Forge — RSI Rules (Permanent)

Accumulated from 19 rounds of compiler-in-the-loop production.
Every rule below was learned from a real compilation failure or a caught pre-compilation error.
**Read this before writing ANY .lean file.**

---

## Slot Tracing (R1-R3)

1. **Ne slot trace BEFORE proof.** For `hC4 a b c d`, write out all 6 Ne slots and 4 Adj slots as comments. Map each to a hypothesis name. Only then write the `exact` line.

2. **C4Free Ne slot pattern:** `hC4 a b c d` requires:
   - Ne: a≠b, b≠c, c≠d, d≠a, a≠c, b≠d (6 total)
   - Adj: a-b, b-c, c-d, d-a (4 total)

3. **K4Free Ne slot pattern:** `hK4 a b c d` requires:
   - Ne: a≠b, a≠c, a≠d, b≠c, b≠d, c≠d (6 total)
   - Adj: a-b, a-c, a-d, b-c, b-d, c-d (6 total)

4. **TriangleFree Ne slot pattern:** `hTF a b c` requires:
   - Ne: a≠b, b≠c, a≠c (3 total)
   - Adj: a-b, b-c, a-c (3 total)

## Adjacency Direction (R5, R14, R17)

5. **ne_flip is `fun heq => h heq.symm`.** Derives `b ≠ a` from `a ≠ b`. Always define it per-file.

6. **adj_symm direction:** `G.adj_symm a b hab` takes `G.adj a b` and produces `G.adj b a`. If the hypothesis ALREADY has the correct direction, do NOT apply adj_symm — this was the R14 T077 bug.

7. **adj_symm argument order:** `G.adj_symm v a hva` — first two args are the vertices in the ORIGINAL direction, third is the proof.

## Compilation Environment (R9, R16)

8. **Use PowerShell, not Bash** for `lean.exe` on Windows. Git Bash cannot resolve Windows backslash paths. Invoke as `& "C:\Users\jared\.elan\bin\lean.exe" <path>`.

9. **Standalone files only.** No Mathlib imports. Every file redefines SimpleGraph, C4Free, ne_flip independently.

## Banned Identifiers (R2-R4)

10. **Never use:** `ring`, `by_contra`, `interval_cases`, `Nat.pow_right_injective`, `simp [Mathlib.lemma]`, `Finset`, `dvd_mul_right`. These require Mathlib.

## Arithmetic (R16, verified R17-R19)

11. **omega handles:** linear arithmetic, concrete Nat division, concrete Nat.pow.

12. **omega CANNOT handle:** `2^k` where k is a variable, `m * n` where both are variables. Use concrete witnesses instead (e.g., `2^3 = 8` not `2^k`).

13. **Nat division is left-associative and truncates.** `3 * 10 / (2 * 5) = 3`, not 1. Double-check every division in ARITHMETIC_KERNEL files before compilation.

## Quality Control (R6-R8)

14. **No assumption-returns.** If a theorem's proof body just returns a hypothesis unchanged, it has zero semantic credit. The forge's QC3 gate detects this.

15. **No duplicate theorem content.** R15 audit found T091/T094/T087 all proving codegree-1 variants. Check existing files before creating new ones.

16. **namespace/end pairing.** Every `namespace SimpleGraph` must have a matching `end SimpleGraph`. Every `structure` must close before namespace begins.

## Pre-Compilation Checklist (R17+)

Before writing the `exact` line:

- [ ] All 6 Ne hypotheses traced and named
- [ ] All 4 Adj hypotheses traced with correct direction
- [ ] adj_symm applied ONLY where direction needs flipping
- [ ] ne_flip applied ONLY where direction needs flipping
- [ ] No Mathlib identifiers
- [ ] Arithmetic double-checked (if ARITHMETIC_KERNEL)
- [ ] No sorry
- [ ] namespace/end paired

## RSI History

| Round | Error | Fix | Permanent Rule |
|-------|-------|-----|----------------|
| R5 | Ne slot mismatch | Explicit slot trace | Rule 1 |
| R9 | Bash can't find lean.exe | Use PowerShell | Rule 8 |
| R11 | adj_symm on correct-direction hyp | Check before applying | Rule 6 |
| R14 | T077 adj_symm wrong direction | Use hyp directly when correct | Rule 6 |
| R16 | T108 Nat division arithmetic | Double-check division | Rule 13 |
| R19-pre | T122 wrong Ne hypothesis names | Trace ALL 6 Ne before writing signature | Rule 1 |
