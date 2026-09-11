/-
  C₄-free cubic girth 5: pentagon coverage arithmetic.

  KEY RESULT from T126: in cubic, two pentagons sharing a vertex
  must share an edge (pigeonhole on degree 3). Shared edge → 8-cycle.

  So EG for cubic girth 5 reduces to:
  "Is every vertex in at most one pentagon?"
  i.e., "Are pentagons vertex-disjoint?"

  Pentagon vertex coverage analysis:
  - Each pentagon covers 5 vertices.
  - In cubic girth 5 on n vertices: p₅ ≥ n/5 pentagons (lower bound).
  - If vertex-disjoint: covers exactly 5·p₅ ≤ n vertices.
  - If p₅ = n/5: covers ALL vertices. Tight.
  - If p₅ > n/5: covers > n, impossible if vertex-disjoint.

  Petersen: n=10, p₅=12. 12 > 10/5 = 2. Way more than needed.
  12·5 = 60 vertex-uses for 10 vertices = 6 per vertex.
  Cannot be vertex-disjoint. → shared vertex → shared edge → 8-cycle ✓.

  n=22: p₅ ≥ 22/5 = 4. 4·5 = 20 < 22. Two uncovered vertices.
  CAN be vertex-disjoint in principle. This is where the argument
  needs strengthening.

  Authority: ARITHMETIC_KERNEL — coverage bounds.
-/

/-- Pentagon coverage in Petersen. -/
theorem petersen_p5_times_5 : 12 * 5 = 60 := by omega
theorem petersen_per_vertex : 60 / 10 = 6 := by omega
theorem petersen_cannot_be_vdj : 12 * 5 > 10 := by omega

/-- Pentagon coverage for general n. -/
theorem n10_vdj_max : 10 / 5 = 2 := by omega
theorem n22_vdj_max : 22 / 5 = 4 := by omega
theorem n22_coverage : 4 * 5 = 20 := by omega
theorem n22_gap : 22 - 20 = 2 := by omega

/-- n=46 coverage. -/
theorem n46_vdj_max : 46 / 5 = 9 := by omega
theorem n46_coverage : 9 * 5 = 45 := by omega
theorem n46_gap : 46 - 45 = 1 := by omega

/-- n=50 coverage. -/
theorem n50_vdj_max : 50 / 5 = 10 := by omega
theorem n50_coverage : 10 * 5 = 50 := by omega
theorem n50_gap : 50 - 50 = 0 := by omega

/-- n=94: ball(5) from layer expansion. -/
theorem n94_vdj_max : 94 / 5 = 18 := by omega
theorem n94_coverage : 18 * 5 = 90 := by omega
theorem n94_gap : 94 - 90 = 4 := by omega

/-- For vertex-disjoint pentagons: edges between pentagon
    vertices and uncovered vertices.
    Each uncovered vertex has 3 edges. Each goes to pentagon vertices
    (or other uncovered vertices). But uncovered vertices can form
    their own structure.
    For n=22, gap=2: 2 uncovered vertices, 3 edges each = 6 edge-endpoints.
    These 6 must go to pentagon vertices (can't go to each other twice
    in cubic). Actually they CAN be adjacent: 2 vertices, 1 edge between
    them, each has 2 more edges to pentagon vertices. Total: 4 cross edges. -/
theorem n22_uncovered_cross : 2 * 3 - 1 * 2 = 4 := by omega
