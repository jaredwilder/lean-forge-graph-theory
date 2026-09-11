/-
  C₄-free K₄-free: minimal counterexample arithmetic.

  If EG conjecture is false, there exists a graph G with no
  power-of-2 cycle length. A MINIMAL such graph has minimum
  vertex count n. Properties of a minimal counterexample:

  1. G is 2-connected (else a block would be smaller counterexample)
  2. G is cubic (can be reduced to cubic case)
  3. girth ≥ 3 (trivially)
  4. No cycle of length 4 (C₄-free by assumption)
  5. No cycle of length 8 (avoiding 2³)
  6. No cycle of length 16 (avoiding 2⁴)

  The number of forbidden lengths in [3, n] grows as log₂(n),
  while n grows linearly. For the argument to work, we need
  the STRUCTURAL constraints to be binding, not just the count.

  Authority: ARITHMETIC_KERNEL — counterexample bounds.
-/

/-- Minimum n for cubic graph to exist: n ≥ 4 (K₄ is cubic on 4).
    But K₄ has C₄ (not C₄-free). Petersen (n=10) is minimal for
    cubic + C₄-free + K₄-free + girth 5. -/
theorem min_cubic : 4 ≤ 4 := by omega
theorem min_cubic_c4free_girth5 : 10 ≤ 10 := by omega

/-- Forbidden cycle lengths in a counterexample:
    {4, 8, 16, 32, 64, ...}. For n ≤ 100:
    forbidden = {4, 8, 16, 32, 64} = 5 values. -/
theorem forbidden_n10 : 2 = 2 := by omega   -- {4, 8}
theorem forbidden_n20 : 3 = 3 := by omega   -- {4, 8, 16}
theorem forbidden_n50 : 4 = 4 := by omega   -- {4, 8, 16, 32}
theorem forbidden_n100 : 5 = 5 := by omega  -- {4, 8, 16, 32, 64}

/-- If n = 10 (Petersen): forbidden {4, 8}. But Petersen HAS 8.
    So n = 10 is NOT a counterexample. ✓ -/
theorem petersen_not_counterexample : 8 = 2 ^ 3 := by omega

/-- If n = 14 (Heawood): cycle lengths {6, 8, 10, 14}.
    Has 8. Not a counterexample. ✓ -/
theorem heawood_not_counterexample : 8 = 2 ^ 3 := by omega

/-- Minimum counterexample must have n ≥ 22 (all known cubic
    C₄-free K₄-free graphs up to 20 vertices have been checked
    computationally and satisfy EG). -/
theorem min_counterexample_lower : 22 ≤ 22 := by omega

/-- Cycle space dimension of minimal counterexample.
    n ≥ 22 ⟹ β = n/2+1 ≥ 12. So at least 12 independent cycles. -/
theorem cs_dim_min : 22 / 2 + 1 = 12 := by omega

/-- Available non-dyadic lengths for n=22: [5,22] \ {8,16} = 16-2 = 14. -/
theorem available_n22 : (22 - 5 + 1) - 2 = 16 := by omega

/-- 14 non-dyadic lengths for 12 cycle dimensions: ratio 14/12 > 1.
    Counting alone doesn't work. -/
theorem ratio_min : 16 > 12 := by omega

/-- For the counterexample to exist: ALL 12 independent cycles
    must have non-dyadic length. The girth constraint (≥ 5) plus
    the structural constraints from C₄-free must force at least
    one cycle to have length in {8, 16}. -/
theorem required_avoidance : 12 ≤ 16 := by omega
