/-
  C₄-free cubic girth 5: automorphism group arithmetic.

  Petersen graph: |Aut(P)| = 120 = 5!.
  Vertex-transitive: any vertex maps to any other.
  Edge-transitive: any edge maps to any other.
  Arc-transitive (= symmetric): any oriented edge maps to any other.

  120 = 10 × 12: each vertex has stabilizer of order 12,
  and there are 10 vertices. 12 = |S₃ × Z₂|.
  Actually: Aut(Petersen) ≅ S₅.

  For general cubic girth-5 graph G on n vertices:
  |Aut(G)| divides n! (acts on vertices).
  Vertex-transitive → |Aut(G)| = n × |stab(v)|.
  Cubic vertex-transitive → |stab(v)| divides 3! × 2^k for some k
  (automorphisms fixing v permute neighbors, then propagate).

  Foster census: cubic symmetric graphs.
  Petersen (n=10): symmetric, |Aut| = 120.
  Heawood (n=14): symmetric, |Aut| = 336 = 14 × 24.
  Pappus (n=18): symmetric, |Aut| = 216 = 18 × 12.
  Desargues (n=20): symmetric, |Aut| = 240 = 20 × 12.

  Authority: ARITHMETIC_KERNEL — automorphism group orders.
-/

/-- Petersen automorphism group. -/
theorem petersen_aut : 120 = 5 * 4 * 3 * 2 * 1 := by omega
theorem petersen_aut_vertex : 120 / 10 = 12 := by omega
theorem petersen_aut_edge : 120 / 15 = 8 := by omega
theorem petersen_aut_arc : 120 / 30 = 4 := by omega

/-- Heawood automorphism group. -/
theorem heawood_aut : 336 = 14 * 24 := by omega
theorem heawood_aut_vertex : 336 / 14 = 24 := by omega
theorem heawood_edges : 14 * 3 / 2 = 21 := by omega
theorem heawood_aut_edge : 336 / 21 = 16 := by omega

/-- Pappus automorphism group. -/
theorem pappus_aut : 216 = 18 * 12 := by omega
theorem pappus_edges : 18 * 3 / 2 = 27 := by omega

/-- Desargues automorphism group. -/
theorem desargues_aut : 240 = 20 * 12 := by omega
theorem desargues_edges : 20 * 3 / 2 = 30 := by omega

/-- S₅ = 120. -/
theorem s5_order : 5 * 4 * 3 * 2 * 1 = 120 := by omega

/-- Stabilizer bounds in cubic graphs. -/
theorem cubic_stab_s3 : 3 * 2 * 1 = 6 := by omega
theorem cubic_stab_max : 6 * 2 = 12 := by omega
theorem cubic_stab_max2 : 6 * 4 = 24 := by omega
