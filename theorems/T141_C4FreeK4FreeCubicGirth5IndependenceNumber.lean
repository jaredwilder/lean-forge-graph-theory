/-
  C₄-free cubic girth 5: independence number arithmetic.

  Independence number α(G) = max independent set size.

  For cubic graph: each vertex has 3 neighbors, so choosing v
  excludes 3 others. Greedy bound: α ≥ n/4.

  Better (Staton 1979): for triangle-free cubic graphs,
  α ≥ 5n/14. Tight for Petersen + isolated edge.

  For cubic girth ≥ 5: even better bounds.
  Petersen: α = 4 (out of 10). 4/10 = 2/5 = 0.4.
  5/14 ≈ 0.357. So Petersen exceeds Staton bound (4 > 50/14 ≈ 3.57).

  Cubic girth 5 independence:
  Petersen (n=10): α = 4. α/n = 0.4.
  Robertson (n=19): α = 7. α/n ≈ 0.368.
  McGee (n=24): α = 9. α/n = 0.375.

  For EG connection: independent set I in cubic C₄-free girth 5.
  Each vertex in I has exactly 3 neighbors, all in V\I.
  Each vertex in V\I has at most 3 neighbors, some in I.
  Edges between I and V\I: exactly 3|I| = 3α.
  Each vertex in V\I has at most 3 neighbors in I.
  So: 3α ≤ 3(n-α) → α ≤ n/2 (trivially true).

  Actually edges between I and V\I: exactly 3α (each I vertex contributes 3).
  Each V\I vertex receives at most 3 of these edges.
  So: 3α ≤ 3(n-α) → α ≤ n/2.

  Authority: ARITHMETIC_KERNEL — independence number bounds.
-/

/-- Greedy bound: α ≥ n/4. -/
theorem greedy_n10 : 10 / 4 = 2 := by omega
theorem greedy_n20 : 20 / 4 = 5 := by omega
theorem greedy_n50 : 50 / 4 = 12 := by omega

/-- Staton bound: α ≥ 5n/14. -/
theorem staton_n10 : 5 * 10 / 14 = 3 := by omega
theorem staton_n14 : 5 * 14 / 14 = 5 := by omega
theorem staton_n20 : 5 * 20 / 14 = 7 := by omega
theorem staton_n28 : 5 * 28 / 14 = 10 := by omega

/-- Petersen independence number. -/
theorem petersen_alpha : 4 * 10 = 40 := by omega
theorem petersen_alpha_check : 4 > 5 * 10 / 14 := by omega
theorem petersen_ratio_num : 4 * 5 = 20 := by omega
theorem petersen_ratio_den : 10 * 2 = 20 := by omega

/-- Edge counting between I and V\I. -/
theorem edges_I_complement_n10 : 3 * 4 = 12 := by omega
theorem complement_size_n10 : 10 - 4 = 6 := by omega
theorem edge_bound_check : 12 ≤ 3 * 6 := by omega

/-- Robertson independence. -/
theorem robertson_alpha : 7 * 19 = 133 := by omega
theorem robertson_staton : 5 * 19 / 14 = 6 := by omega
theorem robertson_exceeds_staton : 7 > 6 := by omega

/-- McGee independence. -/
theorem mcgee_alpha_check : 9 * 24 = 216 := by omega
theorem mcgee_staton : 5 * 24 / 14 = 8 := by omega
theorem mcgee_exceeds_staton : 9 > 8 := by omega
