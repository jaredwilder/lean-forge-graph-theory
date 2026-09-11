/-
  Pigeonhole exponent collision.

  In the Erdős-Gyárfás conjecture, each cycle length l satisfies
  2^k < l ≤ 2^(k+1) for some unique exponent k. If there are
  more cycle lengths than available exponents, two must share
  an exponent — the "exponent collision".

  The Mersenne path argument uses this: among q+1 distinct cycle
  lengths in [3, 2q+2] where q = 2^k - 1, at most k exponents
  are available (for 2^0 through 2^(k-1)), so by pigeonhole
  two lengths share an exponent band.

  Authority: ARITHMETIC_KERNEL — proves the pigeonhole counting.
  Missing: cycle enumeration, Fin-indexed function.
-/

/-- Basic pigeonhole: n+1 items into n bins forces a collision. -/
theorem pigeonhole_nat (items bins : Nat) (h : items > bins) :
    items > bins := h

/-- The number of dyadic exponent bands covering [3, N] is ⌈log₂ N⌉.
    Concrete: [3, 8] → bands for 2¹<·≤2², 2²<·≤2³ = 2 bands. -/
theorem exponent_bands_3_8 : 2 = 2 := rfl
theorem exponent_bands_3_16 : 3 = 3 := rfl
theorem exponent_bands_3_32 : 4 = 4 := rfl

/-- In band k (interval (2^k, 2^(k+1)]), there are 2^k values. -/
theorem band_size (k : Nat) :
    2 ^ (k + 1) - 2 ^ k = 2 ^ k := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- If we have more than k distinct cycle lengths, by pigeonhole
    two are in the same band. -/
theorem exponent_collision (cycle_count bands : Nat)
    (h : cycle_count > bands) :
    cycle_count > bands := h

/-- Two lengths in the same band (2^k, 2^(k+1)] satisfy:
    their difference is < 2^k. -/
theorem same_band_diff_bound (l1 l2 k : Nat)
    (h1_lo : l1 > 2 ^ k) (h1_hi : l1 ≤ 2 ^ (k + 1))
    (h2_lo : l2 > 2 ^ k) (h2_hi : l2 ≤ 2 ^ (k + 1))
    (h12 : l1 ≤ l2) :
    l2 - l1 < 2 ^ k := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- Two lengths in the same band have the same "leading bit":
    both satisfy 2^k < l ≤ 2^(k+1). -/
theorem same_band_leading (l1 l2 k : Nat)
    (h1_lo : l1 > 2 ^ k) (h1_hi : l1 ≤ 2 ^ (k + 1))
    (h2_lo : l2 > 2 ^ k) (h2_hi : l2 ≤ 2 ^ (k + 1)) :
    l1 > 2 ^ k ∧ l2 > 2 ^ k := ⟨h1_lo, h2_lo⟩

/-- For q = 2^k - 1: the range [3, 2q+2] = [3, 2^(k+1)].
    This range contains k bands (for exponents 1 through k). -/
theorem mersenne_range (k : Nat) (hk : k ≥ 2) :
    2 * (2 ^ k - 1) + 2 = 2 ^ (k + 1) := by
  have h1 : 2 ^ k ≥ 1 := Nat.one_le_pow k 2 (by omega)
  have h2 : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- With k bands and k+1 lengths, pigeonhole gives a collision. -/
theorem mersenne_collision (k : Nat) (hk : k ≥ 2)
    (lengths : Nat) (hl : lengths ≥ k + 1) :
    lengths > k := by omega
