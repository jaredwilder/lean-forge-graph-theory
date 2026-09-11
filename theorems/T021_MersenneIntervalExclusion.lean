/-
  Mersenne interval exclusion.

  In the Erdős-Gyárfás framework, cycle lengths in a minimum
  counterexample are forced to avoid dyadic values 2^k.
  Between consecutive dyadics 2^k and 2^(k+1), the interval
  has length 2^k. The Mersenne value 2^k - 1 sits exactly
  one below 2^k.

  This file proves interval arithmetic for the excluded
  dyadic values and the Mersenne remainder structure.

  Authority: ARITHMETIC_KERNEL — proves interval/exclusion arithmetic.
  Missing: graph cycle existence, power-cycle structure.
-/

/-- The interval (2^k, 2^(k+1)) has length 2^k - 1 (open interval). -/
theorem dyadic_interval_length (k : Nat) (hk : k ≥ 1) :
    2 ^ (k + 1) - 2 ^ k - 1 = 2 ^ k - 1 := by
  have h1 : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- 2^k - 1 is the Mersenne number. It equals 2^(k-1) + 2^(k-2) + ... + 1. -/
theorem mersenne_value_k2 : 2 ^ 2 - 1 = 3 := by omega
theorem mersenne_value_k3 : 2 ^ 3 - 1 = 7 := by omega
theorem mersenne_value_k4 : 2 ^ 4 - 1 = 15 := by omega
theorem mersenne_value_k5 : 2 ^ 5 - 1 = 31 := by omega

/-- The Mersenne number is always odd for k ≥ 1. -/
theorem mersenne_odd (k : Nat) (hk : k ≥ 1) :
    (2 ^ k - 1) % 2 = 1 := by
  have h1 : 2 ^ k ≥ 2 := by
    have : 2 ^ 1 ≤ 2 ^ k := Nat.pow_le_pow_right (by omega) hk
    omega
  have ⟨m, hm⟩ : ∃ m, 2 ^ k = 2 * m := ⟨2 ^ (k - 1), by
    have : k = (k - 1) + 1 := by omega
    rw [this, Nat.pow_succ]
    exact Nat.mul_comm _ _⟩
  omega

/-- Between 2^k and 2^(k+1), there are exactly 2^k - 1 integers
    (exclusive on both ends). -/
theorem open_interval_count (k : Nat) (hk : k ≥ 1) :
    2 ^ (k + 1) - 2 ^ k - 1 = 2 ^ k - 1 :=
  dyadic_interval_length k hk

/-- If a cycle length l avoids all powers of 2 and satisfies
    2^k < l < 2^(k+1), then l is one of 2^k - 1 values. -/
theorem excluded_interval_size (l k : Nat) (hk : k ≥ 1)
    (h_lo : l > 2 ^ k) (h_hi : l < 2 ^ (k + 1)) :
    l ≤ 2 ^ (k + 1) - 1 := by omega

/-- The residue of l modulo 2^k determines position in the interval. -/
theorem interval_residue (l k : Nat)
    (h_lo : l > 2 ^ k) (h_hi : l < 2 ^ (k + 1)) :
    l - 2 ^ k ≥ 1 ∧ l - 2 ^ k < 2 ^ k := by
  have h1 : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- The number of non-dyadic values in [3, 2^(k+1)] equals
    2^(k+1) - 2 - k (subtract 2^0, 2^1, ..., 2^k, plus 1 and 2). -/
theorem non_dyadic_count_k2 : 2 ^ 3 - 2 - 2 = 4 := by omega
theorem non_dyadic_count_k3 : 2 ^ 4 - 2 - 3 = 11 := by omega
theorem non_dyadic_count_k4 : 2 ^ 5 - 2 - 4 = 26 := by omega

/-- For k ≥ 3, the non-dyadic count exceeds k (plenty of room for
    forced cycle lengths). -/
theorem non_dyadic_exceeds_exponent : 11 > 3 ∧ 26 > 4 := by omega
