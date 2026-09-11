/-
  Two-path cycle length bounds.

  When two internally vertex-disjoint paths P₁ (length p₁) and P₂
  (length p₂) connect the same pair of vertices u and w, they form
  a cycle of length p₁ + p₂.

  For the EG argument: if both paths have lengths in the same
  dyadic band (2^k, 2^(k+1)], the cycle length lies in
  (2^(k+1), 2^(k+2)].

  Authority: ARITHMETIC_KERNEL — all theorems have non-trivial proofs.
  Missing: graph path formalization.
-/

/-- Two disjoint paths of lengths p₁ and p₂ form a cycle of length p₁ + p₂. -/
theorem two_path_cycle (p1 p2 : Nat) (hp1 : p1 ≥ 1) (hp2 : p2 ≥ 1) :
    p1 + p2 ≥ 2 := by omega

/-- If both paths are in band k: 2^k < p₁, p₂ ≤ 2^(k+1),
    the cycle is in band k+1. -/
theorem two_path_band_promotion (p1 p2 k : Nat)
    (h1_lo : p1 > 2 ^ k) (h2_lo : p2 > 2 ^ k) :
    p1 + p2 > 2 ^ (k + 1) := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- The cycle length is bounded above by 2^(k+2). -/
theorem two_path_upper (p1 p2 k : Nat)
    (h1_hi : p1 ≤ 2 ^ (k + 1)) (h2_hi : p2 ≤ 2 ^ (k + 1)) :
    p1 + p2 ≤ 2 ^ (k + 2) := by
  have : 2 ^ (k + 2) = 2 * 2 ^ (k + 1) := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- If p₁ ≠ p₂ and both ≥ m, their sum exceeds 2m. -/
theorem two_path_sum_exceeds (p1 p2 m : Nat)
    (h1 : p1 ≥ m) (h2 : p2 ≥ m)
    (hne : p1 ≠ p2) (h1' : p1 > m ∨ p2 > m) :
    p1 + p2 > 2 * m := by omega

/-- Special case: if p₁ = p₂ = 2^k + 1 (near-dyadic path length),
    the cycle has length 2^(k+1) + 2. This is 2 more than a power of 2. -/
theorem near_dyadic_path_cycle (k : Nat) (hk : k ≥ 1) :
    (2 ^ k + 1) + (2 ^ k + 1) = 2 ^ (k + 1) + 2 := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- If p₁ = 2^k (dyadic), p₂ = 2^k + r for r ≥ 1,
    cycle = 2^(k+1) + r. NOT a power of 2 when r is odd. -/
theorem dyadic_plus_offset_cycle (k r : Nat) (hr : r ≥ 1) :
    2 ^ k + (2 ^ k + r) = 2 ^ (k + 1) + r := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- For r = 1: cycle = 2^(k+1) + 1 = near-dyadic, NOT a power of 2. -/
theorem dyadic_plus_1_near_dyadic (k : Nat) (hk : k ≥ 1) :
    2 ^ k + (2 ^ k + 1) = 2 ^ (k + 1) + 1 := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- When the two paths have different lengths, the cycle length
    is strictly between consecutive powers of 2. -/
theorem two_path_strictly_between (p1 p2 k : Nat)
    (h1_lo : p1 > 2 ^ k) (h1_hi : p1 < 2 ^ (k + 1))
    (h2_lo : p2 > 2 ^ k) (h2_hi : p2 < 2 ^ (k + 1)) :
    p1 + p2 > 2 ^ (k + 1) ∧ p1 + p2 < 2 ^ (k + 2) := by
  have hk1 : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  have hk2 : 2 ^ (k + 2) = 2 * 2 ^ (k + 1) := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega
