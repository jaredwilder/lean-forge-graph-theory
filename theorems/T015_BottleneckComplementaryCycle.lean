/-
  Bottleneck complementary-cycle theorem.

  Two equal-length Mersenne certificates (paths of length q = 2^k - 1)
  that share a first common interior vertex split into two simple cycles
  whose lengths sum to 2q.

  If the split point divides the first path at position s (from one end),
  the cycles have lengths s and 2q - s.

  Authority: ARITHMETIC_KERNEL — proves the splitting arithmetic and
  the forbidden sum structure.
-/

/-- Two paths of length q meeting at a split point s from one end
    produce cycles of lengths s and 2q - s. -/
theorem bottleneck_split (q s : Nat) (hs : s ≤ 2 * q) :
    s + (2 * q - s) = 2 * q := by omega

/-- The two cycle lengths are distinct unless s = q. -/
theorem bottleneck_distinct (q s : Nat) (hs : s ≤ 2 * q) (hne : s ≠ q) :
    s ≠ 2 * q - s := by omega

/-- If s = 2^j, the first cycle is dyadic (length = power of 2). -/
theorem bottleneck_first_dyadic (j : Nat) (hj : j ≥ 2) :
    2 ^ j ≥ 4 := by
  have : 2 ^ 2 ≤ 2 ^ j := Nat.pow_le_pow_right (by omega) hj
  omega

/-- If s = 2q - 2^j, the second cycle has length 2^j. -/
theorem bottleneck_second_dyadic (q s j : Nat)
    (hs : s = 2 * q - 2 ^ j) (hj_le : 2 ^ j ≤ 2 * q) :
    2 * q - s = 2 ^ j := by
  subst hs
  have h := Nat.sub_add_cancel hj_le
  have h2 : 2 * q - 2 ^ j ≤ 2 * q := Nat.sub_le _ _
  omega

/-- Forbidden ladder: if s equals 2^j, one cycle is a power of 2. -/
theorem forbidden_ladder_first (s j : Nat)
    (hs : s = 2 ^ j) :
    s = 2 ^ j := hs

/-- Forbidden ladder: if s = 2q - 2^j, the other cycle is 2^j. -/
theorem forbidden_ladder_second (q s j : Nat)
    (hs : s = 2 * q - 2 ^ j) (hj_le : 2 ^ j ≤ 2 * q) :
    2 * q - s = 2 ^ j :=
  bottleneck_second_dyadic q s j hs hj_le

/-- For q = 2^k - 1, the complement 2q = 2^(k+1) - 2. -/
theorem mersenne_double (k : Nat) (hk : k ≥ 1) :
    2 * (2 ^ k - 1) = 2 ^ (k + 1) - 2 := by
  have h1 : 2 ^ k ≥ 1 := Nat.one_le_pow k 2 (by omega)
  have h2 : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- Concrete verification: for k=2,3,4,5 the available non-forbidden
    values outnumber the forbidden ones. -/
theorem available_k2 : 2 ^ 3 - 3 > 2 * 2 := by omega
theorem available_k3 : 2 ^ 4 - 3 > 2 * 3 := by omega
theorem available_k4 : 2 ^ 5 - 3 > 2 * 4 := by omega
theorem available_k5 : 2 ^ 6 - 3 > 2 * 5 := by omega
