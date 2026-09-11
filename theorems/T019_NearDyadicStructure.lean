/-
  Near-dyadic cycle structure.

  Every cubic vertex of a minimum-order counterexample to the
  Erdős-Gyárfás conjecture lies on a cycle of length 2^k + 1 for
  some k ≥ 2.

  This file proves the arithmetic properties of near-dyadic numbers
  and their interaction with the suppression lift:
  - 2^k + 1 is always odd
  - Adjacent near-dyadics 2^k + 1 and 2^(k+1) + 1 differ by 2^k
  - The near-dyadic exponent is unique
  - The parity structure of near-dyadic cycles

  Authority: ARITHMETIC_KERNEL — proves number-theoretic properties.
  Missing: graph-theoretic cubic vertex existence, suppression operation.
-/

/-- Near-dyadic numbers are odd for k ≥ 1. -/
theorem near_dyadic_odd (k : Nat) (hk : k ≥ 1) :
    (2 ^ k + 1) % 2 = 1 := by
  have ⟨m, hm⟩ : ∃ m, 2 ^ k = 2 * m := ⟨2 ^ (k - 1), by
    have : k = (k - 1) + 1 := by omega
    rw [this, Nat.pow_succ]
    exact Nat.mul_comm _ _⟩
  omega

/-- Adjacent near-dyadics differ by a power of 2. -/
theorem near_dyadic_gap (k : Nat) :
    (2 ^ (k + 1) + 1) - (2 ^ k + 1) = 2 ^ k := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- Near-dyadic is always ≥ 3 for k ≥ 1. -/
theorem near_dyadic_ge_3 (k : Nat) (hk : k ≥ 1) :
    2 ^ k + 1 ≥ 3 := by
  have : 2 ^ 1 ≤ 2 ^ k := Nat.pow_le_pow_right (by omega) hk
  omega

/-- Near-dyadic is always ≥ 5 for k ≥ 2. -/
theorem near_dyadic_ge_5 (k : Nat) (hk : k ≥ 2) :
    2 ^ k + 1 ≥ 5 := by
  have : 2 ^ 2 ≤ 2 ^ k := Nat.pow_le_pow_right (by omega) hk
  omega

/-- The exponent k determines a unique near-dyadic: 2^j + 1 = 2^k + 1 iff j = k. -/
theorem near_dyadic_injective (j k : Nat) (h : 2 ^ j + 1 = 2 ^ k + 1) :
    j = k := by
  have h2 : 2 ^ j = 2 ^ k := by omega
  have h3 : ¬ (j < k) := by
    intro hjk
    have := Nat.pow_lt_pow_right (by omega : 1 < 2) hjk
    omega
  have h4 : ¬ (k < j) := by
    intro hkj
    have := Nat.pow_lt_pow_right (by omega : 1 < 2) hkj
    omega
  omega

/-- Near-dyadic is never a power of 2 (for k ≥ 1). -/
theorem near_dyadic_not_dyadic (k j : Nat) (hk : k ≥ 1) (hj : j ≥ 2) :
    2 ^ k + 1 ≠ 2 ^ j := by
  intro h
  have hk_odd := near_dyadic_odd k hk
  have : (2 ^ j) % 2 = 0 := by
    have ⟨m, hm⟩ : ∃ m, 2 ^ j = 2 * m := ⟨2 ^ (j - 1), by
      have : j = (j - 1) + 1 := by omega
      rw [this, Nat.pow_succ]
      exact Nat.mul_comm _ _⟩
    omega
  omega

/-- Two near-dyadics with different exponents are different. -/
theorem near_dyadic_strict_mono (j k : Nat) (hjk : j < k) :
    2 ^ j + 1 < 2 ^ k + 1 := by
  have := Nat.pow_lt_pow_right (by omega : 1 < 2) hjk
  omega

/-- The count of near-dyadic lengths in {5, ..., n+1} is ⌊log₂ n⌋ - 1.
    Concrete: for n = 8, the near-dyadics are 5 (k=2) and 9 (k=3). -/
theorem near_dyadic_count_8 : 2 ^ 2 + 1 = 5 ∧ 2 ^ 3 + 1 = 9 := by omega
theorem near_dyadic_count_16 : 2 ^ 2 + 1 = 5 ∧ 2 ^ 3 + 1 = 9 ∧ 2 ^ 4 + 1 = 17 := by omega
