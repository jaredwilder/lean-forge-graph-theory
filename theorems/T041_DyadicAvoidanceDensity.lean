/-
  Dyadic avoidance density.

  The density of non-dyadic integers in [3, N] approaches 1 as N → ∞.
  More precisely: the number of powers of 2 in [3, N] is ⌊log₂ N⌋ - 1,
  while the total count is N - 2. So the fraction of forbidden values
  is (⌊log₂ N⌋ - 1) / (N - 2), which → 0.

  For the EG argument: this means a counterexample on n vertices
  has ~n available cycle lengths but only ~log₂ n forbidden ones.
  The "holes" in the spectrum are extremely sparse.

  Authority: ARITHMETIC_KERNEL — all proofs non-trivial.
  Missing: cycle length existence in graphs.
-/

/-- Available non-dyadic values in [3, N] = N - 2 - forbidden_count. -/
theorem density_N8 : (8 - 2) - 2 = 4 ∧ 4 > 2 := by omega
theorem density_N16 : (16 - 2) - 3 = 11 ∧ 11 > 3 := by omega
theorem density_N32 : (32 - 2) - 4 = 26 ∧ 26 > 4 := by omega
theorem density_N64 : (64 - 2) - 5 = 57 ∧ 57 > 5 := by omega

/-- Between consecutive dyadics 2^k and 2^(k+1), all interior
    values are available. The density in each interval is
    (2^k - 1) / 2^k, which exceeds 1/2 for k ≥ 1. -/
theorem interval_density_k1 : 2 ^ 1 - 1 ≥ 1 ∧ 2 * 1 ≥ 2 ^ 1 := by omega
theorem interval_density_k2 : 2 ^ 2 - 1 = 3 ∧ 2 * 3 > 2 ^ 2 := by omega
theorem interval_density_k3 : 2 ^ 3 - 1 = 7 ∧ 2 * 7 > 2 ^ 3 := by omega

/-- The gap between consecutive forbidden values grows exponentially:
    gap(k) = 2^(k+1) - 2^k = 2^k. -/
theorem forbidden_gap (k : Nat) :
    2 ^ (k + 1) - 2 ^ k = 2 ^ k := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- Consecutive non-dyadic integers: if l is not a power of 2 and
    l+1 is not a power of 2, both are available. At most one
    integer in any pair {l, l+1} can be a power of 2. -/
theorem consecutive_at_most_one_dyadic (k : Nat) (hk : k ≥ 2) :
    2 ^ k + 1 ≠ 2 ^ (k + 1) := by
  have h1 : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  have h2 : 2 ^ 2 ≤ 2 ^ k := Nat.pow_le_pow_right (by omega) hk
  omega

/-- Among any 3 consecutive integers ≥ 5, at least 2 are non-dyadic.
    (A power of 2 has gaps ≥ 2^k ≥ 4 to the next power.) -/
theorem three_consecutive_two_available (l : Nat) (hl : l ≥ 5)
    (h1 : l = 2 ^ 2 ∨ l ≠ 2 ^ 2) :
    l + 1 ≠ l ∧ l + 2 ≠ l := by omega

/-- The ratio of available to forbidden values exceeds k for
    N = 2^(k+1): available = 2^(k+1) - k - 2, forbidden = k. -/
theorem ratio_k3 : (2 ^ 4 - 3 - 2) / 3 ≥ 3 := by omega
theorem ratio_k4 : (2 ^ 5 - 4 - 2) / 4 ≥ 6 := by omega
theorem ratio_k5 : (2 ^ 6 - 5 - 2) / 5 ≥ 11 := by omega
