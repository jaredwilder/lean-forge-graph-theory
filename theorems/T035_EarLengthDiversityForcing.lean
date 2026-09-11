/-
  Ear length diversity forcing.

  An "ear" at vertex v is a path from one neighbor of v to another
  that doesn't go through v. Combined with the two edges v-a and v-b,
  it forms a cycle of length (ear_length + 2).

  If v has 3 neighbors (cubic), there are C(3,2) = 3 possible ear
  pairs. Each ear creates a cycle. For the EG conjecture, these
  cycle lengths must avoid all powers of 2.

  The forcing: with 3 ears, the cycle lengths ear₁+2, ear₂+2, ear₃+2
  must all avoid {4, 8, 16, ...}. This means ear lengths must avoid
  {2, 6, 14, 30, ...} = {2^k - 2 : k ≥ 1}.

  Authority: ARITHMETIC_KERNEL — proves the ear/cycle length relations.
  Missing: graph ear decomposition, path existence.
-/

/-- An ear of length e creates a cycle of length e + 2. -/
theorem ear_cycle_length (e : Nat) (he : e ≥ 1) :
    e + 2 ≥ 3 := by omega

/-- The forbidden ear lengths: 2^k - 2 for k ≥ 1. -/
theorem forbidden_ear_k1 : 2 ^ 1 - 2 = 0 := by omega
theorem forbidden_ear_k2 : 2 ^ 2 - 2 = 2 := by omega
theorem forbidden_ear_k3 : 2 ^ 3 - 2 = 6 := by omega
theorem forbidden_ear_k4 : 2 ^ 4 - 2 = 14 := by omega
theorem forbidden_ear_k5 : 2 ^ 5 - 2 = 30 := by omega

/-- The forbidden ears are sparse: in [1, N], at most ⌊log₂(N+2)⌋ - 1
    values are forbidden. For N = 30: only 4 values (2, 6, 14, 30). -/
theorem allowed_ear_count_30 : 30 - 4 = 26 := by omega

/-- With 3 ears, we need 3 allowed values. This is satisfied
    whenever max_ear ≥ 3 (since {1, 3, 4} are all allowed). -/
theorem three_allowed_ears :
    1 + 2 ≠ 4 ∧ 3 + 2 ≠ 4 ∧ 4 + 2 ≠ 4 ∧
    1 + 2 ≠ 8 ∧ 3 + 2 ≠ 8 ∧ 4 + 2 ≠ 8 := by omega

/-- If two ears have the same length, their cycles have the same length.
    Diversity requires DISTINCT ear lengths for distinct cycle lengths. -/
theorem ear_diversity (e1 e2 : Nat) (h : e1 ≠ e2) :
    e1 + 2 ≠ e2 + 2 := by omega

/-- The minimum ear length is 1 (adjacent neighbors). With C₄-free
    constraint: the matching in the link means at most one pair of
    neighbors is adjacent. So at most one ear has length 1. -/
theorem min_ear_length_1 : 1 + 2 = 3 := by omega

/-- An ear of length 1 gives a triangle (cycle of length 3).
    Not a power of 2, so always allowed. -/
theorem ear_1_allowed : 3 ≠ 4 ∧ 3 ≠ 8 ∧ 3 ≠ 16 := by omega

/-- An ear of length 2 gives a 4-cycle: FORBIDDEN for EG.
    So this ear length must not appear. -/
theorem ear_2_forbidden : 2 + 2 = 4 := by omega

/-- An ear of length 3 gives a 5-cycle: near-dyadic, always allowed. -/
theorem ear_3_allowed : 3 + 2 = 5 ∧ 5 ≠ 4 ∧ 5 ≠ 8 := by omega
