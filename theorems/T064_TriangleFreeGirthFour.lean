/-
  Triangle-free girth properties.

  A triangle-free graph has girth ≥ 4 (no 3-cycles). Combined with
  C₄-free (no 4-cycles), girth ≥ 5.

  The girth constrains the minimum order of the graph via the
  Moore bound. For a d-regular graph with girth g:
  - g = 5: n ≥ d² + 1
  - g = 6: n ≥ 2d² + 2 (bipartite Moore bound)
  - g = 7: n ≥ d³ + d² + d + 1

  For cubic (d=3):
  - g = 5: n ≥ 10 (Petersen)
  - g = 6: n ≥ 14 (Heawood, actually 14)
  - g = 7: n ≥ 24 (McGee, actually 24)

  Authority: ARITHMETIC_KERNEL — girth bounds.
  Missing: graph girth formalization.
-/

/-- Moore bound for cubic, girth 5. -/
theorem moore_cubic_g5 : 3 * 3 + 1 = 10 := by omega

/-- Moore bound for cubic, girth 6 (bipartite). -/
theorem moore_cubic_g6 : 2 * (3 * 3) - 2 = 16 := by omega

/-- Actually the bipartite Moore bound gives 2(d²-d+1) for girth 6.
    For d=3: 2(9-3+1) = 14. The Heawood graph achieves this. -/
theorem heawood_bound : 2 * (9 - 3 + 1) = 14 := by omega

/-- Moore bound for cubic, girth 7: 1 + 3 + 6 + 12 = 22.
    Actually d³+d²+d+1 = 27+9+3+1 = 40... that's not right.
    The Moore bound for girth 2k+1 is 1+d+d(d-1)+...+d(d-1)^(k-1).
    For g=5 (k=2): 1 + 3 + 3·2 = 10. ✓
    For g=7 (k=3): 1 + 3 + 6 + 6·2 = 22.
    McGee graph: n=24, girth 7, cubic. Not Moore-tight. -/
theorem girth7_ball : 1 + 3 + 6 + 12 = 22 := by omega

/-- Cycle space dimension for cubic n-vertex graph: 3n/2 - n + 1 = n/2+1. -/
theorem cycle_space_10 : 3 * 10 / 2 - 10 + 1 = 6 := by omega
theorem cycle_space_14 : 3 * 14 / 2 - 14 + 1 = 8 := by omega
theorem cycle_space_20 : 3 * 20 / 2 - 20 + 1 = 11 := by omega
theorem cycle_space_24 : 3 * 24 / 2 - 24 + 1 = 13 := by omega

/-- For the EG argument: with girth g and n vertices, cycle lengths
    range over [g, n]. Available non-dyadic lengths = (n-g+1) - forbidden.
    Forbidden dyadics in [g,n] ≤ log₂(n). -/
theorem available_g5_n10 : (10 - 5 + 1) - 1 = 5 := by omega
theorem available_g5_n20 : (20 - 5 + 1) - 2 = 14 := by omega
theorem available_g5_n40 : (40 - 5 + 1) - 3 = 33 := by omega
theorem available_g5_n100 : (100 - 5 + 1) - 5 = 91 := by omega

/-- Sufficiency check: cycle space dimension ≥ available lengths needed.
    For n=20, girth 5: dim = 11, available non-dyadic = 14.
    We need dim ≥ some fraction of available. This is where the EG
    combinatorial argument needs to work harder. -/
theorem dim_vs_available_20 : 11 < 14 := by omega
theorem dim_vs_available_40 : 21 < 33 := by omega
