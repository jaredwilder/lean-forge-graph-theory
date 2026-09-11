/-
  K₄-free: edge-critical structure.

  If adding any edge to a K₄-free graph creates K₄, the graph
  is K₄-saturated. In a K₄-saturated graph, every pair of
  non-adjacent vertices has at least 2 common neighbors
  (they need a K₃ to complete K₄ upon adding the edge).

  For the EG setting: the constraint graph is NOT saturated in
  general, but the K₄-free condition still restricts the edge
  density heavily. The Ramsey-type bound: a K₄-free graph on n
  vertices has at most (1 - 1/3)n²/2 = n²/3 edges (Turán).

  Authority: ARITHMETIC_KERNEL — Turán bound arithmetic.
-/

/-- Turán bound for K₄-free: ex(n, K₄) = n²/3 (approximately).
    Exact: floor(n²/3). Concrete instances. -/
theorem turan_k4free_n6 : 6 * 6 / 3 = 12 := by omega
theorem turan_k4free_n9 : 9 * 9 / 3 = 27 := by omega
theorem turan_k4free_n12 : 12 * 12 / 3 = 48 := by omega
theorem turan_k4free_n15 : 15 * 15 / 3 = 75 := by omega
theorem turan_k4free_n18 : 18 * 18 / 3 = 108 := by omega
theorem turan_k4free_n21 : 21 * 21 / 3 = 147 := by omega
theorem turan_k4free_n24 : 24 * 24 / 3 = 192 := by omega
theorem turan_k4free_n30 : 30 * 30 / 3 = 300 := by omega

/-- Cubic graph edge count vs Turán bound.
    Cubic graph: edges = 3n/2. Turán K₄-free: n²/3.
    Turán exceeds cubic when n²/3 ≥ 3n/2, i.e., n ≥ 9/2 = 5.
    So for n ≥ 5, cubic is well below the Turán threshold. -/
theorem cubic_below_turan_n6 : 3 * 6 / 2 = 9 ∧ 6 * 6 / 3 = 12 ∧ 9 < 12 := by omega
theorem cubic_below_turan_n10 : 3 * 10 / 2 = 15 ∧ 10 * 10 / 3 = 33 ∧ 15 < 33 := by omega
theorem cubic_below_turan_n20 : 3 * 20 / 2 = 30 ∧ 20 * 20 / 3 = 133 ∧ 30 < 133 := by omega
theorem cubic_below_turan_n50 : 3 * 50 / 2 = 75 ∧ 50 * 50 / 3 = 833 ∧ 75 < 833 := by omega

/-- Turán density: K₄-free density is at most 1/3. For cubic, density
    is 3/(n-1) which goes to 0. So K₄-free is never the binding
    constraint in cubic — it's the local structure that matters. -/
theorem cubic_density_n10 : 3 * 10 * 2 = 60 ∧ 10 * 9 = 90 := by omega
theorem cubic_density_n20 : 3 * 20 * 2 = 120 ∧ 20 * 19 = 380 := by omega
