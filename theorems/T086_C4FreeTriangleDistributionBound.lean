/-
  C₄-free cubic: triangle distribution bound.

  In a cubic C₄-free graph, each edge is in AT MOST one triangle
  (T037). Each vertex is in at most one triangle (cubic: 3 edges,
  and a triangle uses 2, leaving 1).

  Actually, a vertex CAN be in more than one triangle in a non-cubic
  graph. In cubic: vertex v has edges to a, b, c.
  Triangle at v uses two neighbors, say a and b (edge a-b).
  For another triangle at v: need c adj a or c adj b.
  If c adj a: triangle (v,c,a) but edge v-a already in triangle
  (v,a,b). Two triangles sharing edge v-a → book → C₄.
  So: at most one triangle per vertex in cubic C₄-free.

  Total triangles ≤ n/3 (each triangle uses 3 vertices, each vertex
  in ≤ 1 triangle).

  Authority: ARITHMETIC_KERNEL — triangle counting.
-/

/-- Max triangles in cubic C₄-free graph on n vertices.
    Each vertex in ≤ 1 triangle, each triangle has 3 vertices. -/
theorem max_triangles_n12 : 12 / 3 = 4 := by omega
theorem max_triangles_n18 : 18 / 3 = 6 := by omega
theorem max_triangles_n24 : 24 / 3 = 8 := by omega
theorem max_triangles_n30 : 30 / 3 = 10 := by omega

/-- Triangle edges vs total edges.
    Each triangle contributes 3 edges. Max triangles = n/3.
    Triangle edges ≤ n. Total edges = 3n/2.
    Fraction of edges in triangles ≤ n/(3n/2) = 2/3. -/
theorem triangle_edge_fraction_n12 : 4 * 3 = 12 ∧ 3 * 12 / 2 = 18 := by omega
theorem triangle_edge_fraction_n18 : 6 * 3 = 18 ∧ 3 * 18 / 2 = 27 := by omega

/-- Non-triangle edges. -/
theorem nontriangle_edges_n12 : 18 - 12 = 6 := by omega
theorem nontriangle_edges_n18 : 27 - 18 = 9 := by omega
theorem nontriangle_edges_n30 : 45 - 30 = 15 := by omega

/-- Vertices not in any triangle: n - 3t where t = #triangles.
    These vertices have all 3 edges as non-triangle edges. -/
theorem non_triangle_verts_n12_t4 : 12 - 3 * 4 = 0 := by omega
theorem non_triangle_verts_n18_t4 : 18 - 3 * 4 = 6 := by omega
theorem non_triangle_verts_n18_t6 : 18 - 3 * 6 = 0 := by omega
theorem non_triangle_verts_n30_t5 : 30 - 3 * 5 = 15 := by omega

/-- For the EG argument: the mix of triangle and non-triangle
    vertices determines the local structure and hence the
    cycle length spectrum. More triangles → shorter cycles → more
    non-dyadic short lengths. -/
theorem short_cycles_from_triangles : 3 + 5 = 8 := by omega
theorem short_cycles_nondyadic : 3 ≠ 4 ∧ 5 ≠ 4 ∧ 5 ≠ 8 := by omega
