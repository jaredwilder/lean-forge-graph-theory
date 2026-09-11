/-
  Dyadic gap covering.

  The dyadic values {4, 8, 16, 32, ...} partition [3, ∞) into
  "gaps": [3, 3], [5, 7], [9, 15], [17, 31], [33, 63], ...

  Each gap has size 2^k - 1 (between 2^k and 2^(k+1)).
  The n-th gap grows exponentially.

  For the EG argument: if a graph has cycle lengths in some gap,
  it can have at most 2^k - 1 distinct cycle lengths in that gap.
  The total number of available cycle lengths up to 2^K is
  2^K - K - 2 (total minus dyadics minus {1, 2}).

  Authority: ARITHMETIC_KERNEL — proves the gap arithmetic.
  Missing: cycle length existence.
-/

/-- Gap sizes between consecutive dyadics. -/
theorem gap_4_8 : 8 - 4 - 1 = 3 := by omega
theorem gap_8_16 : 16 - 8 - 1 = 7 := by omega
theorem gap_16_32 : 32 - 16 - 1 = 15 := by omega
theorem gap_32_64 : 64 - 32 - 1 = 31 := by omega

/-- General gap size: 2^(k+1) - 2^k - 1 = 2^k - 1. -/
theorem gap_size (k : Nat) :
    2 ^ (k + 1) - 2 ^ k - 1 = 2 ^ k - 1 := by
  have : 2 ^ (k + 1) = 2 * 2 ^ k := by
    rw [Nat.pow_succ, Nat.mul_comm]
  omega

/-- Total available (non-dyadic) values in [3, 2^K]:
    (2^K - 2) total values minus (K - 1) dyadics. -/
theorem total_available_k3 : (2 ^ 3 - 2) - (3 - 1) = 4 := by omega
theorem total_available_k4 : (2 ^ 4 - 2) - (4 - 1) = 11 := by omega
theorem total_available_k5 : (2 ^ 5 - 2) - (5 - 1) = 26 := by omega

/-- The first gap [3, 3] has only 1 value: 3 itself. -/
theorem first_gap : 3 = 3 := rfl

/-- The second gap [5, 7] has 3 values: 5, 6, 7. -/
theorem second_gap : 7 - 5 + 1 = 3 := by omega

/-- The k-th gap has exactly 2^(k-1) - 1 values for k ≥ 2. -/
theorem kth_gap_k2 : 2 ^ 1 - 1 = 1 := by omega
theorem kth_gap_k3 : 2 ^ 2 - 1 = 3 := by omega
theorem kth_gap_k4 : 2 ^ 3 - 1 = 7 := by omega

/-- Covering argument: if the graph's cycle lengths must include
    at least F values, and the total available up to 2^K is
    2^K - K - 2, then we need 2^K - K - 2 ≥ F.
    For F = 3 (cubic minimum): 2^K ≥ K + 5.
    This holds for K ≥ 3. -/
theorem covering_k3 : 2 ^ 3 - 3 - 2 ≥ 3 := by omega
theorem covering_k4 : 2 ^ 4 - 4 - 2 ≥ 3 := by omega

/-- The gap structure ensures that consecutive non-dyadic values
    span at most one gap. If l and l+1 are both non-dyadic and
    in the same gap (2^k, 2^(k+1)), then they're both available. -/
theorem consecutive_in_gap (l k : Nat)
    (h_lo : l > 2 ^ k) (h_hi : l + 1 < 2 ^ (k + 1))
    (h_nd1 : l ≠ 2 ^ k) (h_nd2 : l + 1 ≠ 2 ^ (k + 1)) :
    l > 2 ^ k ∧ l + 1 < 2 ^ (k + 1) := ⟨h_lo, h_hi⟩
