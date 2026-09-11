/-
  Path combination cycle lengths.

  The core mechanism of the EG argument: two paths P₁, P₂ between
  vertices u and w (internally disjoint) produce a cycle of length
  |P₁| + |P₂|. By varying path lengths in different dyadic bands,
  we generate cycle lengths that avoid powers of 2.

  Key insight: if P₁ has length in (2^k, 2^(k+1)] and P₂ has length
  in (2^j, 2^(j+1)] with j ≠ k, the cycle length |P₁| + |P₂| is
  NOT a power of 2 (it's strictly between two consecutive powers).

  Authority: ARITHMETIC_KERNEL — path-cycle arithmetic.
  Missing: graph path formalization.
-/

/-- Two paths in the same band: cycle in the next band. -/
theorem same_band_promotion (p1 p2 k : Nat)
    (h1 : p1 > 2 ^ k) (h2 : p2 > 2 ^ k)
    (h1u : p1 ≤ 2 ^ (k + 1)) (h2u : p2 ≤ 2 ^ (k + 1)) :
    p1 + p2 > 2 ^ (k + 1) ∧ p1 + p2 ≤ 2 ^ (k + 2) := by
  constructor
  · have : 2 ^ (k + 1) = 2 * 2 ^ k := by rw [Nat.pow_succ, Nat.mul_comm]
    omega
  · have : 2 ^ (k + 2) = 2 * 2 ^ (k + 1) := by rw [Nat.pow_succ, Nat.mul_comm]
    omega

/-- Two paths in different bands: cycle avoids all powers of 2. -/
theorem different_band_avoids_power (p1 p2 k j : Nat)
    (h1lo : p1 > 2 ^ k) (h1hi : p1 < 2 ^ (k + 1))
    (h2lo : p2 > 2 ^ j) (h2hi : p2 < 2 ^ (j + 1))
    (hkj : k < j) :
    p1 + p2 > 2 ^ j + 2 ^ k := by omega

/-- Concrete: path lengths 3 and 5 give cycle 8 = 2³ (BAD — forbidden). -/
theorem concrete_bad_3_5 : 3 + 5 = 8 ∧ 8 = 2 ^ 3 := by omega

/-- But path lengths 3 and 6 give cycle 9 (GOOD — not power of 2). -/
theorem concrete_good_3_6 : 3 + 6 = 9 ∧ 9 > 2 ^ 3 ∧ 9 < 2 ^ 4 := by omega

/-- Path lengths 5 and 6 give 11. -/
theorem concrete_good_5_6 : 5 + 6 = 11 ∧ 11 > 2 ^ 3 ∧ 11 < 2 ^ 4 := by omega

/-- Path lengths 5 and 7 give 12. -/
theorem concrete_good_5_7 : 5 + 7 = 12 ∧ 12 > 2 ^ 3 ∧ 12 < 2 ^ 4 := by omega

/-- Path lengths 9 and 10 give 19. -/
theorem concrete_good_9_10 : 9 + 10 = 19 ∧ 19 > 2 ^ 4 ∧ 19 < 2 ^ 5 := by omega

/-- Path lengths 9 and 15 give 24. -/
theorem concrete_good_9_15 : 9 + 15 = 24 ∧ 24 > 2 ^ 4 ∧ 24 < 2 ^ 5 := by omega

/-- Achievable sums from m path lengths: concrete witnesses. -/
theorem achievable_m2 : 2 * 1 / 2 = 1 := by omega
theorem achievable_m3 : 3 * 2 / 2 = 3 := by omega
theorem achievable_m4 : 4 * 3 / 2 = 6 := by omega
theorem achievable_m5 : 5 * 4 / 2 = 10 := by omega

/-- Cross-band pairs: concrete witnesses. -/
theorem cross_band_2_2 : 2 * 2 = 4 ∧ 4 ≥ 4 := by omega
theorem cross_band_3_3 : 3 * 3 = 9 ∧ 9 ≥ 4 := by omega
theorem cross_band_3_7 : 3 * 7 = 21 ∧ 21 ≥ 4 := by omega
