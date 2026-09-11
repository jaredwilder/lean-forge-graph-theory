/-
  C₄-free K₄-free: minimum cycle length spectrum.

  In a cubic C₄-free K₄-free graph with girth 5 (TF case) or
  girth 3 (with triangles), the cycle lengths that MUST exist:

  Girth 5 (TF + C₄-free):
  - Length 5 exists (girth)
  - Length 6 exists if n ≥ 14 (two paths of length 3)
  - Length 7 exists if n ≥ 18 (path 3 + path 4)

  Girth 3 (with triangles, C₄-free + K₄-free):
  - Length 3 exists (triangle)
  - Length 5 exists (pentagon, T070)
  - Length 6, 7 from path combinations

  The key: ALL these lengths are non-dyadic (3,5,6,7 ≠ 2^k).
  The first dyadic length is 8 = 2³.

  Authority: ARITHMETIC_KERNEL — spectrum arithmetic.
  Missing: cycle existence in graphs.
-/

/-- All short cycle lengths are non-dyadic. -/
theorem length_3_nondyadic : 3 ≠ 2 ∧ 3 ≠ 4 := by omega
theorem length_5_nondyadic : 5 ≠ 4 ∧ 5 ≠ 8 := by omega
theorem length_6_nondyadic : 6 ≠ 4 ∧ 6 ≠ 8 := by omega
theorem length_7_nondyadic : 7 ≠ 4 ∧ 7 ≠ 8 := by omega
theorem length_9_nondyadic : 9 ≠ 8 ∧ 9 ≠ 16 := by omega
theorem length_10_nondyadic : 10 ≠ 8 ∧ 10 ≠ 16 := by omega

/-- First few dyadic lengths and their gaps. -/
theorem dyadic_8 : 2 ^ 3 = 8 := by omega
theorem dyadic_16 : 2 ^ 4 = 16 := by omega
theorem dyadic_32 : 2 ^ 5 = 32 := by omega

/-- Non-dyadic lengths in [3, 8): {3, 4, 5, 6, 7} minus {4} = {3,5,6,7}. -/
theorem nondyadic_below_8 : 8 - 3 - 1 = 4 := by omega

/-- Non-dyadic lengths in [3, 16): {3,...,15} minus {4,8} = 11 values. -/
theorem nondyadic_below_16 : 16 - 3 - 2 = 11 := by omega

/-- Non-dyadic lengths in [3, 32): {3,...,31} minus {4,8,16} = 26. -/
theorem nondyadic_below_32 : 32 - 3 - 3 = 26 := by omega

/-- For the EG argument: the conjecture states that at least ONE
    dyadic length must occur. So among the cycle lengths of the graph,
    not ALL can be non-dyadic. The density argument says: with n/2+1
    independent cycles and only ~log₂(n) forbidden lengths, the
    pigeonhole forces a collision with a dyadic value. -/
theorem pigeonhole_n20 : 20 / 2 + 1 = 11 ∧ 11 > 2 := by omega
theorem pigeonhole_n40 : 40 / 2 + 1 = 21 ∧ 21 > 3 := by omega

/-- Concrete: if ALL cycle lengths in [5,20] avoid {8,16},
    that's 14 non-dyadic values. But cycle space has dimension 11.
    So 14 values can "fill" 11 dimensions — no contradiction yet.
    The EG argument needs the COMBINATION mechanism to show that
    avoiding 8 and 16 is impossible, not just counting. -/
theorem counting_not_enough_n20 : 14 > 11 := by omega

/-- For n ≥ 34: cycle space dim = 18, forbidden = {8,16,32} = 3.
    Available non-dyadic in [5,34]: 28. Ratio 28/3 > 9. -/
theorem ratio_n34 : 34 - 5 + 1 - 3 = 27 ∧ 34 / 2 + 1 = 18 := by omega
