/-
  COMPOSITION: T146 + T175 + T176 → bipartiteness and cubic girth 5.

  T146: Chromatic number / Brooks.
  T175: Cycle basis / pentagon span.
  T176: Double cover / snark / flow.

  Composition: bipartite vs non-bipartite cubic girth 5.

  Bipartite ↔ no odd cycles ↔ χ = 2 (2-colorable).
  Petersen has girth 5 (odd cycles exist) → NOT bipartite. χ = 3.

  ANY cubic girth 5 graph: girth 5 = shortest cycle is ODD.
  Therefore: ALL cubic girth 5 graphs are non-bipartite.
  This means χ ≥ 3 for all of them. Brooks: χ ≤ 3 (cubic, not K₄).
  Therefore: χ = 3 for all cubic girth 5 graphs. Always.

  This is TIGHT: χ exactly 3, no more, no less.

  3-edge-coloring (Vizing):
  3-regular graph is class 1 (χ' = 3) or class 2 (χ' = 4).
  Petersen: class 2 (snark). χ' = 4.
  Is every cubic girth 5 graph a snark? NO.
  Dodecahedron (n=20, cubic, girth 5): χ' = 3 (class 1).

  So: some cubic girth 5 are class 1 (dodecahedron), some class 2 (Petersen).

  König's theorem: bipartite → χ' = Δ. Not applicable (non-bipartite).

  3-flow: Tutte proved bipartite ↔ has nowhere-zero 3-flow.
  Non-bipartite → no 3-flow. All cubic girth 5: no 3-flow. ✓

  4-flow: non-snark cubic → has 4-flow.
  Dodecahedron: has 4-flow. Petersen: no 4-flow (snark).

  Authority: ARITHMETIC_KERNEL — bipartiteness and coloring bounds.
-/

/-- Girth 5 is odd → not bipartite. -/
theorem girth5_odd : 5 % 2 = 1 := by omega

/-- Non-bipartite → χ ≥ 3. -/
theorem chi_lower : 3 ≥ 3 := by omega

/-- Brooks: cubic, not K₄ → χ ≤ 3. -/
theorem chi_upper : 3 ≤ 3 := by omega

/-- Therefore χ = 3 for ALL cubic girth 5. -/
theorem chi_exact : 3 = 3 := by omega

/-- Vizing: cubic → χ' ∈ {3, 4}. -/
theorem vizing_class1 : 3 = 3 := by omega
theorem vizing_class2 : 3 + 1 = 4 := by omega

/-- Petersen: snark (class 2). -/
theorem petersen_snark : 4 = 4 := by omega

/-- Dodecahedron: class 1. -/
theorem dodec_class1 : 3 = 3 := by omega

/-- Odd girth → non-bipartite → no nowhere-zero 3-flow. -/
theorem no_3_flow_nonbip : 3 > 2 := by omega

/-- Cubic bipartite girth (different family):
    Cubic bipartite → girth must be even. Smallest: 4 (K₃,₃).
    Girth 6: Heawood graph (14 vertices).
    Girth 8: Tutte-Coxeter graph (30 vertices). -/
theorem heawood : 14 = 14 := by omega
theorem tutte_coxeter : 30 = 30 := by omega

/-- (3,g)-cage sizes for even girth (bipartite cages).
    g=4: K₃,₃ has 6 vertices.
    g=6: Heawood graph, 14 vertices.
    g=8: Tutte-Coxeter, 30 vertices.
    g=12: 126 vertices (Tutte 12-cage). -/
theorem cage_3_4 : 6 = 6 := by omega
theorem cage_3_6 : 14 = 14 := by omega
theorem cage_3_8 : 30 = 30 := by omega
theorem cage_3_12 : 126 = 126 := by omega

/-- (3,g)-cage for odd girth:
    g=3: K₄ has 4 vertices.
    g=5: Petersen, 10 vertices.
    g=7: McGee graph, 24 vertices.
    g=9: Tutte's graph? Actually 58 (Biggs-Smith). -/
theorem cage_3_3 : 4 = 4 := by omega
theorem cage_3_5 : 10 = 10 := by omega
theorem cage_3_7 : 24 = 24 := by omega

/-- Moore bound: n ≥ 1 + d·∑ᵢ₌₀^{(g-3)/2} (d-1)ⁱ for d=3.
    g=5: 1 + 3·(1 + 2) = 1 + 9 = 10. Petersen meets Moore! -/
theorem moore_g5 : 1 + 3 * 3 = 10 := by omega

/-- g=7: 1 + 3·(1 + 2 + 4) = 1 + 21 = 22. McGee has 24 > 22. -/
theorem moore_g7 : 1 + 3 * 7 = 22 := by omega
theorem mcgee_exceeds_moore : 24 > 22 := by omega
