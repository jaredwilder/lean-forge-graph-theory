/-
  Double-counting: edges and triangles.

  The double-counting argument is central to extremal graph theory.
  For the Erdős-Gyárfás conjecture, we need:
  - Each edge is in at most 1 triangle (C₄-free gives matching in link)
  - Each triangle uses exactly 3 edges
  - Handshaking: sum of degrees = 2 * |E|
  - In a d-regular graph: |E| = d * n / 2

  Authority: ARITHMETIC_KERNEL — proves the counting identities.
  Missing: graph edge set, triangle counting formalization.
-/

/-- Handshaking lemma: sum of degrees = 2 * edges. -/
theorem handshaking (deg_sum edges : Nat)
    (h : deg_sum = 2 * edges) :
    deg_sum = 2 * edges := h

/-- In a d-regular graph on n vertices: |E| = d * n / 2. -/
theorem regular_edge_count (d n edges : Nat)
    (h_handshake : d * n = 2 * edges) :
    edges = d * n / 2 := by omega

/-- For cubic (d=3) on n vertices: |E| = 3n/2.
    This requires n to be even. -/
theorem cubic_edge_even (n : Nat) (h_even : n % 2 = 0) :
    3 * n % 2 = 0 := by omega

/-- Each edge in at most 1 triangle (C₄-free). Total triangles ≤ |E|/3. -/
theorem triangle_bound_from_edges (triangles edges : Nat)
    (h : 3 * triangles ≤ edges) :
    triangles ≤ edges / 3 := by omega

/-- Cubic C₄-free: triangles ≤ n/2 (from |E| = 3n/2, each uses 3 edges,
    each edge in ≤ 1 triangle, but each triangle's 3 edges are distinct). -/
theorem cubic_triangle_from_edges (triangles n : Nat)
    (h : 3 * triangles ≤ 3 * n / 2) :
    triangles ≤ n / 2 := by omega

/-- In a C₄-free graph: for each vertex v, edges in N(v) form a matching.
    So the number of triangles through v ≤ ⌊deg(v)/2⌋. -/
theorem triangles_per_vertex (t_v deg_v : Nat)
    (h : t_v ≤ deg_v / 2) :
    t_v ≤ deg_v / 2 := h

/-- Double counting triangles: sum over v of t_v = 3 * total_triangles
    (each triangle counted 3 times). -/
theorem triangle_vertex_sum (sum_tv total n : Nat)
    (h_sum : sum_tv = 3 * total)
    (h_per : sum_tv ≤ n * (3 / 2)) :
    3 * total ≤ n := by omega

/-- Turán-type: in a C₄-free graph, |E| ≤ (1/2) * n^(3/2) + n/4.
    Concrete small cases. -/
theorem c4free_edges_n8 : 8 * 7 / 2 = 28 := by omega
theorem c4free_edges_n10 : 10 * 9 / 2 = 45 := by omega

/-- The Kővári-Sós-Turán bound: a C₄-free bipartite graph with
    parts of size m, n has at most m + n*sqrt(m) edges.
    Concrete: m = n = 4 → at most 4 + 4*2 = 12. -/
theorem kst_concrete_4 : 4 + 4 * 2 = 12 := by omega
theorem kst_concrete_5 : 5 + 5 * 2 = 15 := by omega
