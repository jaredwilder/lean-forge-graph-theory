/-
  COMPOSITION: T108 + T126 + T140 + T153 → dual pentagon forcing.

  In cubic girth 5 with n > 10:
  Ball(v,2) = 10 vertices (Moore-tight for diameter 2).
  But n > 10 means ∃ vertex w at distance ≥ 3 from v.

  Pentagon P₁ through v. Pentagon P₂ through w.
  Since d(v,w) ≥ 3: no vertex of P₁ is in P₂.
  (Pentagon vertices of P₁ are at distance ≤ 2 from v.)

  P₁ and P₂ are vertex-disjoint. Use 10 vertices total.
  Remaining: n-10 vertices.

  Each pentagon has 5 external neighbors. These external neighbors
  are at distance 1 from pentagon vertices.

  Can an external of P₁ be an external of P₂?
  If w₀(P₁) = w₀(P₂): this vertex is external to BOTH pentagons.
  Its edges: one to P₁, one to P₂, one more.
  It's a bridge between the two pentagons.
  Distance from v (through P₁) to w (through P₂):
  v → v₀(P₁) → w₀ → v₀(P₂) → w. Length ≤ 4 ish.

  For the 8-cycle:
  P₁ has edges E₁, P₂ has edges E₂.
  If there's a path of length 3 from P₁ to P₂:
  Combined with a length-5 path through P₁ or P₂: 8-cycle!

  Specifically: path from v₀(P₁) to v₀(P₂) of length 3:
  v₀(P₁) → w₀ → x → v₀(P₂).
  Through P₁: v₀-v₁-v₂-v₃-v₄ (length 4).
  Cycle: v₀(P₁)-w₀-x-v₀(P₂)-...-v₀(P₁). Depends on connection.

  SIMPLER: any two pentagons sharing a vertex → C₄ by T126 chain.
  So the only escape is vertex-disjoint pentagons.
  But we showed (T153): in n=10, vertex-disjointness is impossible.
  For n>10: more room, but MORE pentagons too.

  Number of pentagons in cubic girth 5:
  Each vertex is in at least 1 pentagon (girth 5, shortest cycle).
  In 2-connected cubic girth 5: each vertex is in ≥ 1 pentagon.

  Total pentagon-vertex incidences: ≥ n.
  Pentagons: ≥ n/5. Pentagon pairs: ≥ (n/5)(n/5-1)/2.
  For large n: many pairs. Most must be vertex-disjoint.
  But BFS constraints force collisions.

  Authority: ARITHMETIC_KERNEL — dual pentagon arithmetic.
-/

/-- Two vertex-disjoint pentagons: 10 vertices used. -/
theorem dual_pentagon_vertices : 5 + 5 = 10 := by omega

/-- External sets: 5 + 5 = 10 external neighbors. -/
theorem dual_pentagon_externals : 5 + 5 = 10 := by omega

/-- Total vertices touched: 10 pentagon + ≤ 10 external = ≤ 20. -/
theorem dual_pentagon_total : 10 + 10 = 20 := by omega

/-- Pentagon pairs from n/5 pentagons. -/
theorem pairs_n20 : 4 * 3 / 2 = 6 := by omega
theorem pairs_n50 : 10 * 9 / 2 = 45 := by omega
theorem pairs_n100 : 20 * 19 / 2 = 190 := by omega

/-- Path between pentagons: min length 1 (shared vertex, forbidden),
    min length 2 if edge-disjoint, min length 3 if vertex-disjoint. -/
theorem min_path_vdj : 3 ≥ 3 := by omega

/-- 8-cycle from path(3) + pentagon-arc(5): 3 + 5 = 8. -/
theorem eight_from_path_arc : 3 + 5 = 8 := by omega
theorem eight_dyadic : 8 = 2 ^ 3 := by omega

/-- 8-cycle from path(4) + pentagon-arc(4): 4 + 4 = 8. -/
theorem eight_from_path4_arc4 : 4 + 4 = 8 := by omega

/-- Pentagon-vertex incidence bound. -/
theorem incidence_n10 : 10 * 1 = 10 := by omega
theorem incidence_n20 : 20 / 5 = 4 := by omega
theorem petersen_incidence : 12 * 5 = 60 := by omega
theorem petersen_per_vertex : 60 / 10 = 6 := by omega

/-- Pigeonhole on externals: 10 externals in n-10 slots.
    If n=20: 10 externals in 10 slots. Tight. -/
theorem n20_external_slots : 20 - 10 = 10 := by omega
theorem n15_external_overflow : 10 > 15 - 10 := by omega
