/-
  Cubic neighborhood degree-sum constraints.

  In a cubic (3-regular) C₄-free graph, the neighborhood N(v) of any
  vertex v induces a graph with maximum degree ≤ 1 (a matching).

  Since |N(v)| = 3 in a cubic graph, the induced subgraph on N(v) has
  at most 3 vertices and max degree 1, so it is either:
    (a) independent (0 edges) — "naked" vertex
    (b) one edge + one isolated vertex — "ear" configuration
  There is no room for 2 edges (would need 4 vertices).

  This file proves the degree-sum arithmetic.

  Authority: ARITHMETIC_KERNEL — proves degree-sum bounds.
  Missing: graph regularity, induced subgraph formalization.
-/

/-- In a 3-vertex graph with max degree ≤ 1, edge count ≤ 1. -/
theorem cubic_link_edge_bound (edges : Nat) (vertices : Nat)
    (hv : vertices = 3) (h_max_deg : edges ≤ vertices / 2) :
    edges ≤ 1 := by omega

/-- Degree sum = 2 * edges in any graph. With 3 vertices and max degree 1,
    degree sum ≤ 3. -/
theorem cubic_link_degree_sum (deg_sum edges : Nat)
    (h_handshake : deg_sum = 2 * edges) (h_edges : edges ≤ 1) :
    deg_sum ≤ 2 := by omega

/-- In a d-regular graph, the link of a vertex has d vertices. -/
theorem regular_link_size (d n_link : Nat)
    (h_reg : n_link = d) :
    n_link = d := h_reg

/-- If the link has at most ⌊d/2⌋ edges, the number of triangles
    through v equals the number of edges in the link. -/
theorem triangles_through_vertex (triangles edges_in_link d : Nat)
    (h_count : triangles = edges_in_link)
    (h_bound : edges_in_link ≤ d / 2) :
    triangles ≤ d / 2 := by omega

/-- For cubic (d=3): at most 1 triangle through any vertex. -/
theorem cubic_triangle_bound (triangles : Nat) (h : triangles ≤ 3 / 2) :
    triangles ≤ 1 := by omega

/-- For quartic (d=4): at most 2 triangles through any vertex
    (if C₄-free). -/
theorem quartic_triangle_bound (triangles : Nat) (h : triangles ≤ 4 / 2) :
    triangles ≤ 2 := by omega

/-- The total number of triangles in a cubic C₄-free graph on n vertices
    is at most n/3 (each triangle is counted 3 times, once per vertex,
    and each vertex contributes at most 1 triangle). -/
theorem cubic_total_triangle_bound (n total_triangles : Nat)
    (h_each : 3 * total_triangles ≤ n) :
    total_triangles ≤ n / 3 := by omega

/-- Each triangle uses 3 of the 3n/2 edges. With at most n/3 triangles,
    the triangle edges use at most n edges out of 3n/2. -/
theorem triangle_edge_fraction (n triangle_edges total_edges : Nat)
    (h_total : total_edges = 3 * n / 2)
    (h_tri : triangle_edges ≤ 3 * (n / 3))
    (hn : n ≥ 6) :
    triangle_edges ≤ total_edges := by omega
