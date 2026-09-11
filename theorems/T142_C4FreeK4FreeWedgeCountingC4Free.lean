/-
  C₄-free: wedge counting and C₄-free constraint.

  A "wedge" (or cherry or path-2) is an ordered triple (a,b,c)
  where b adj a and b adj c, with a ≠ c.

  In cubic graph: each vertex b has 3 neighbors. Number of wedges
  centered at b: C(3,2) = 3. Total wedges: 3n.

  C₄-free constraint on wedges:
  Two wedges (a,b,c) and (a,d,c) with the SAME endpoints a,c
  but different centers b ≠ d → C₄ = a-b-c-d-a.

  So in C₄-free: each pair {a,c} has at most ONE common neighbor.
  This is exactly T122.

  Total pairs of vertices: C(n,2) = n(n-1)/2.
  Each pair has at most 1 common neighbor.
  Each wedge (a,b,c) gives one common-neighbor pair {a,c}.
  So: total wedges ≤ n(n-1)/2.
  We have: 3n ≤ n(n-1)/2 → 6 ≤ n-1 → n ≥ 7.

  For cubic girth 5: n ≥ 10 (Moore bound). So wedge bound is slack.

  But for C₄-free specifically (not necessarily cubic):
  If max degree Δ: wedges ≤ Σ C(deg(v),2) ≤ n·C(Δ,2).
  C₄-free → wedges ≤ C(n,2).
  Kővári–Sós–Turán from wedge counting.

  Authority: ARITHMETIC_KERNEL — wedge counting arithmetic.
-/

/-- Wedges per vertex in cubic. -/
theorem wedges_cubic : 3 * 2 / 2 = 3 := by omega
theorem wedges_cubic_alt : 3 * (3 - 1) / 2 = 3 := by omega

/-- Total wedges in cubic on n vertices. -/
theorem total_wedges_n10 : 3 * 10 = 30 := by omega
theorem total_wedges_n20 : 3 * 20 = 60 := by omega
theorem total_wedges_n50 : 3 * 50 = 150 := by omega

/-- C₄-free upper bound: n(n-1)/2. -/
theorem c4free_wedge_bound_n10 : 10 * 9 / 2 = 45 := by omega
theorem c4free_wedge_bound_n20 : 20 * 19 / 2 = 190 := by omega
theorem c4free_wedge_bound_n50 : 50 * 49 / 2 = 1225 := by omega

/-- Wedge bound implies n ≥ 7 for cubic C₄-free. -/
theorem cubic_c4free_n7 : 3 * 7 ≤ 7 * 6 / 2 := by omega
theorem cubic_c4free_n6_fail : 3 * 6 > 6 * 5 / 2 := by omega

/-- Wedge slack for cubic girth 5 (n ≥ 10). -/
theorem wedge_slack_n10 : 30 ≤ 45 := by omega
theorem wedge_slack_ratio_n10 : 45 - 30 = 15 := by omega

/-- Wedge counting for degree-4 regular. -/
theorem wedges_deg4 : 4 * 3 / 2 = 6 := by omega
theorem total_wedges_deg4_n10 : 6 * 10 = 60 := by omega
theorem c4free_deg4_n_min : 6 * 13 ≤ 13 * 12 / 2 := by omega

/-- Pairs in Petersen. -/
theorem petersen_pairs : 10 * 9 / 2 = 45 := by omega
theorem petersen_edges : 15 * 2 = 30 := by omega
theorem petersen_non_edges : 45 - 15 = 30 := by omega
