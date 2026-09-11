# RSI Slot Reference — Permanent Improvement Log

## Error Taxonomy (ranked by frequency)

### 1. Ne Direction (60% of all compile failures)
**Root cause:** C4Free/K4Free/TriangleFree slots have a fixed argument order.
**Fix:** TRACE EVERY SLOT before writing the proof.

#### C4Free Slot Map
```
def C4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b →   -- slot 1
    b ≠ c →   -- slot 2
    c ≠ d →   -- slot 3
    d ≠ a →   -- slot 4
    a ≠ c →   -- slot 5
    b ≠ d →   -- slot 6
    G.adj a b → G.adj b c → G.adj c d → G.adj d a → False
```

For `hC4 x y z w`: substitute a→x, b→y, c→z, d→w, then read off:
- slot 1: x ≠ y
- slot 2: y ≠ z
- slot 3: z ≠ w
- slot 4: w ≠ x
- slot 5: x ≠ z
- slot 6: y ≠ w

#### K4Free Slot Map
```
def K4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → a ≠ c → a ≠ d →   -- slots 1-3
    b ≠ c → b ≠ d → c ≠ d →   -- slots 4-6
    G.adj a b → G.adj a c → G.adj a d →   -- adj 1-3
    G.adj b c → G.adj b d → G.adj c d → False   -- adj 4-6
```

#### TriangleFree Slot Map
```
def TriangleFree (G : SimpleGraph V) : Prop :=
  ∀ (a b c : V), a ≠ b → b ≠ c → a ≠ c →
    G.adj a b → G.adj b c → G.adj a c → False
```

#### ne_flip
`ne_flip (h : a ≠ b) : b ≠ a` — use when you HAVE `x ≠ y` but NEED `y ≠ x`.
Do NOT use when the slot already matches.

### 2. Mathlib-Only Identifiers (20% of failures)
**Banned:** `ring`, `by_contra` (needs Classical), `interval_cases`, `Nat.pow_right_injective`, `norm_num` (sometimes), `simp [...]` with Mathlib lemmas
**Replacements:**
- `ring` → `rw [Nat.pow_succ, Nat.mul_comm]` or `omega` with stepping stones
- `by_contra h` → restructure to take `h` as hypothesis and conclude `False`
- `Nat.pow_right_injective` → use strict monotonicity: if j < k then 2^j < 2^k

### 3. omega + Exponentials (15% of failures)
omega treats `2^k` as an opaque variable. It CANNOT prove `2^k > k`.
**Fix:** Provide stepping stones:
```lean
have h1 : 2^k ≥ N := Nat.pow_le_pow_right (by omega) hk  -- bound from below
have h2 : 2^(k+1) = 2 * 2^k := by rw [Nat.pow_succ, Nat.mul_comm]  -- unfold one layer
have h3 : 2^k ≥ 1 := Nat.one_le_pow k 2 (by omega)  -- for Nat subtraction
```
When the general case needs induction, use concrete witnesses instead.

### 4. Nat Subtraction Underflow (5% of failures)
`a - b` in Nat is 0 when b > a. omega needs explicit bounds.
**Fix:** Always add `(h : b ≤ a)` or `(h : a ≥ b)` hypothesis.

## QC3 Mandatory Gate: No Assumption Returns
A theorem whose proof body is ``:= h`` (returning a hypothesis) has ZERO semantic credit.
Every theorem must have a non-trivial proof: `by omega`, `by exact ...`, or structural.
The forge's `detect_assumption_returns()` catches these automatically.

## RSI Log
- Round 1 (T001-T011): Learned Ne direction taxonomy
- Round 2 (T012-T016): Learned omega+exponential stepping stones
- Round 3 (T017-T031): Learned Mathlib-only bans, assumption-return problem identified
- Round 4 (QC3): Installed assumption-return detector, slot-trace reference
- Round 5 (T032-T036+): Applying all RSI. Target: zero assumption-returns per file.
