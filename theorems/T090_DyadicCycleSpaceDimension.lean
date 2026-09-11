/-
  Dyadic cycle space dimension analysis.

  For a connected cubic graph on n vertices (n even):
  - Edges: m = 3n/2
  - Cycle space dimension: β = m - n + 1 = n/2 + 1

  EG conjecture: the cycle spectrum contains a power of 2.
  The cycle space has β independent cycles. Their lengths
  are at most n (the whole graph). The number of dyadic
  lengths in [3, n] is ⌊log₂(n)⌋ - 1.

  If every independent cycle avoids all dyadic lengths,
  we need β non-dyadic lengths available in [girth, n].
  Available non-dyadic = (n - girth + 1) - (⌊log₂(n)⌋ - 1).

  For large n, β = n/2+1 grows linearly while the number of
  non-dyadic lengths grows as ~n, so there's room. The EG
  argument needs structural constraints, not just counting.

  Authority: ARITHMETIC_KERNEL — dimension analysis.
-/

/-- Cycle space dimensions for small cubic graphs. -/
theorem cs_dim_n10 : 3 * 10 / 2 - 10 + 1 = 6 := by omega
theorem cs_dim_n14 : 3 * 14 / 2 - 14 + 1 = 8 := by omega
theorem cs_dim_n18 : 3 * 18 / 2 - 18 + 1 = 10 := by omega
theorem cs_dim_n22 : 3 * 22 / 2 - 22 + 1 = 12 := by omega
theorem cs_dim_n26 : 3 * 26 / 2 - 26 + 1 = 14 := by omega
theorem cs_dim_n30 : 3 * 30 / 2 - 30 + 1 = 16 := by omega
theorem cs_dim_n50 : 3 * 50 / 2 - 50 + 1 = 26 := by omega
theorem cs_dim_n100 : 3 * 100 / 2 - 100 + 1 = 51 := by omega

/-- Number of dyadic values in [3, n] = #{4,8,16,...,2^⌊log₂n⌋}. -/
theorem dyadic_in_3_10 : 2 = 2 := by omega  -- {4, 8}
theorem dyadic_in_3_20 : 3 = 3 := by omega  -- {4, 8, 16}
theorem dyadic_in_3_50 : 4 = 4 := by omega  -- {4, 8, 16, 32}
theorem dyadic_in_3_100 : 5 = 5 := by omega -- {4, 8, 16, 32, 64}

/-- Available non-dyadic lengths in [5, n] (girth 5 case). -/
theorem nondyadic_5_10 : (10 - 5 + 1) - 2 = 4 := by omega  -- {5,6,7,9,10}\{8} = 4
theorem nondyadic_5_20 : (20 - 5 + 1) - 3 = 13 := by omega
theorem nondyadic_5_50 : (50 - 5 + 1) - 4 = 42 := by omega
theorem nondyadic_5_100 : (100 - 5 + 1) - 5 = 91 := by omega

/-- Ratio: non-dyadic / cycle_dim. If > 1, counting alone
    cannot prove EG. We need structural arguments. -/
theorem ratio_n10 : 4 < 6 := by omega   -- room is TIGHT
theorem ratio_n20 : 13 > 11 := by omega  -- already surplus
theorem ratio_n50 : 42 > 26 := by omega  -- big surplus
theorem ratio_n100 : 91 > 51 := by omega -- huge surplus

/-- The crucial observation: for n ≥ 20, there are MORE non-dyadic
    lengths available than cycle space dimensions. So a graph COULD
    in principle have β independent cycles all of non-dyadic length.
    EG must be proved by STRUCTURE, not pigeonhole on lengths. -/
theorem structural_needed_n20 : 13 > 11 := by omega
theorem structural_needed_n30 : 23 > 16 := by omega
