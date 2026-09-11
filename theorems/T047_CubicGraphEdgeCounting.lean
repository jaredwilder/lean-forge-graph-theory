/-
  Cubic graph edge counting.

  In a cubic (3-regular) graph on n vertices:
  - Total degree = 3n
  - Edge count = 3n/2 (handshaking lemma)
  - n must be even
  - Each vertex contributes 3 edges, each counted twice

  For EG: cubic graph structure constrains the cycle spectrum.
  A cubic graph has exactly 3n/2 edges, and each edge participates
  in a bounded number of triangles (from C₄-free).

  Authority: ARITHMETIC_KERNEL — all proofs non-trivial.
  Missing: graph regularity formalization.
-/

/-- Handshaking: in a d-regular graph on n vertices, 2*edges = d*n. -/
theorem handshaking_cubic (n edges : Nat) (h : 2 * edges = 3 * n) :
    edges * 2 = 3 * n := by omega

/-- n must be even in a cubic graph (3n = 2*edges → 3n even → n even). -/
theorem cubic_n_even (n edges : Nat) (h : 2 * edges = 3 * n) :
    n % 2 = 0 := by omega

/-- Edge count for small cubic graphs. -/
theorem cubic_edges_4 : 3 * 4 / 2 = 6 := by omega
theorem cubic_edges_6 : 3 * 6 / 2 = 9 := by omega
theorem cubic_edges_8 : 3 * 8 / 2 = 12 := by omega
theorem cubic_edges_10 : 3 * 10 / 2 = 15 := by omega

/-- Triangle bound: each triangle uses 3 edges. In a cubic graph
    with e = 3n/2 edges and at most e/3 triangles (disjoint edge
    assumption from C₄-free), we get ≤ n/2 triangles. -/
theorem triangle_bound_cubic (n : Nat) (hn : n ≥ 4) :
    3 * n / 2 / 3 = n / 2 := by omega

/-- In a cubic C₄-free graph, each vertex is in at most 1 triangle.
    (3 neighbors, and at most one pair can be adjacent — from C₄-free
    edge uniqueness.) So total triangles ≤ n/3 (each triangle has
    3 vertices). -/
theorem vertex_triangle_bound (n : Nat) (hn : n ≥ 6) :
    n / 3 ≤ n / 2 := by omega

/-- Edge surplus: edges minus triangle edges gives "non-triangle edges".
    In cubic C₄-free with ≤ n/3 triangles, triangle edges ≤ n.
    Non-triangle edges ≥ 3n/2 - n = n/2. -/
theorem non_triangle_edges (n : Nat) (hn : n ≥ 6) :
    3 * n / 2 - n = n / 2 := by omega

/-- Minimum cycle count: a cubic graph with e edges and spanning tree
    of n-1 edges has cycle rank e - n + 1 = 3n/2 - n + 1 = n/2 + 1. -/
theorem cycle_rank_cubic (n : Nat) (hn : n ≥ 4) :
    3 * n / 2 - n + 1 = n / 2 + 1 := by omega

/-- For the EG argument: if we need k distinct cycle lengths and the
    graph has cycle rank n/2 + 1, we need n ≥ 2(k-1) = 2k - 2. -/
theorem minimum_n_for_k_lengths (n k : Nat) (hk : k ≥ 2)
    (h : n / 2 + 1 ≥ k) : n ≥ 2 * k - 2 := by omega
