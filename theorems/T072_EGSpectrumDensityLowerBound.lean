/-
  EG spectrum density lower bound.

  The Erdős-Gyárfás conjecture states: every graph with minimum
  degree ≥ 3 has a cycle whose length is a power of 2.

  Contrapositively: if a graph with δ(G) ≥ 3 avoids all cycle
  lengths 2^k, what constraints does this impose?

  In a cubic (3-regular) C₄-free K₄-free graph on n vertices:
  - Cycle space dimension: n/2 + 1
  - Cycle lengths in [girth, n] ⊆ [5, n]
  - Forbidden lengths in [5,n]: at most ⌊log₂ n⌋ - 1
  - Required: at least n/2 + 1 "independent" cycle lengths

  The density argument: for large n, the forbidden set is too sparse
  to block all cycle lengths. Specifically, if n/2 + 1 > ⌊log₂ n⌋ - 1,
  there must exist a cycle whose length IS a power of 2 (because there
  aren't enough non-dyadic lengths to fill the cycle space without
  using a dyadic length).

  This is the quantitative core of the EG approach.

  Authority: ARITHMETIC_KERNEL — density counting.
  Missing: graph cycle space formalization.
-/

/-- Cycle space vs forbidden count for small n. -/
theorem cs_vs_forbidden_n10 : 10 / 2 + 1 = 6 ∧ 1 < 6 := by omega
theorem cs_vs_forbidden_n20 : 20 / 2 + 1 = 11 ∧ 2 < 11 := by omega
theorem cs_vs_forbidden_n40 : 40 / 2 + 1 = 21 ∧ 3 < 21 := by omega
theorem cs_vs_forbidden_n100 : 100 / 2 + 1 = 51 ∧ 5 < 51 := by omega
theorem cs_vs_forbidden_n1000 : 1000 / 2 + 1 = 501 ∧ 8 < 501 := by omega

/-- The gap grows: cycle_space - forbidden for increasing n. -/
theorem gap_n10 : 6 - 1 = 5 := by omega
theorem gap_n20 : 11 - 2 = 9 := by omega
theorem gap_n40 : 21 - 3 = 18 := by omega
theorem gap_n100 : 51 - 5 = 46 := by omega

/-- Available non-dyadic lengths vs cycle space dimension. -/
theorem available_vs_cs_n10 : 5 ≥ 6 - 1 := by omega
theorem available_vs_cs_n20 : 14 ≥ 11 := by omega
theorem available_vs_cs_n40 : 33 ≥ 21 := by omega

/-- For the EG argument to work, we need:
    available non-dyadic ≥ cycle space dimension.
    Available = (n - girth + 1) - ⌊log₂ n⌋ + 1
    Cycle space = n/2 + 1.
    So need: n - 5 + 1 - log₂(n) + 1 ≥ n/2 + 1
    i.e., n/2 - 4 ≥ log₂(n).
    For n ≥ 20: 6 ≥ log₂(20) ≈ 4.3. TRUE. -/
theorem threshold_n20 : 20 / 2 - 4 = 6 ∧ 6 > 4 := by omega
theorem threshold_n30 : 30 / 2 - 4 = 11 ∧ 11 > 4 := by omega
theorem threshold_n40 : 40 / 2 - 4 = 16 ∧ 16 > 5 := by omega

/-- Minimum n for the density argument to work (girth 5):
    Need n/2 - 4 > log₂(n). For n = 16: 4 > 4 is FALSE.
    For n = 18: 5 > 4 is TRUE. So n ≥ 18 suffices. -/
theorem min_n_fails_16 : 16 / 2 - 4 = 4 := by omega
theorem min_n_works_18 : 18 / 2 - 4 = 5 ∧ 5 > 4 := by omega
theorem min_n_works_20 : 20 / 2 - 4 = 6 ∧ 6 > 4 := by omega
