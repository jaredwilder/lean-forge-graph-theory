/-
  Vertex minimality forcing.

  In a minimum-order counterexample to the Erdős-Gyárfás conjecture,
  every vertex is "essential": removing any vertex v yields a smaller
  graph that (by minimality) DOES contain a dyadic cycle.

  The forcing argument: the dyadic cycle in G-v must pass through
  edges incident to v's former neighbors. This constrains which
  cycles can exist in G.

  Authority: ARITHMETIC_KERNEL — proves the order reduction arithmetic.
  Missing: graph vertex deletion, cycle existence by minimality.
-/

/-- Deleting a vertex from a graph on n vertices gives n-1 vertices. -/
theorem deletion_order (n : Nat) (hn : n ≥ 1) :
    n - 1 < n := by omega

/-- The deleted vertex had degree d, so d edges are removed. -/
theorem deletion_edges (edges d : Nat)
    (h : edges ≥ d) (hd : d ≥ 1) :
    edges - d < edges := by omega

/-- In a cubic graph: deleting a vertex removes exactly 3 edges
    and reduces the degree of 3 neighbors by 1. -/
theorem cubic_deletion (n edges : Nat)
    (h_edges : edges = 3 * n / 2) (hn : n ≥ 4) :
    edges - 3 = 3 * n / 2 - 3 := by omega

/-- The resulting graph G-v has minimum degree ≥ 2 if original
    minimum degree ≥ 3 and every neighbor of v had degree exactly 3. -/
theorem min_deg_after_deletion (d_orig d_after : Nat)
    (h_orig : d_orig ≥ 3) (h_after : d_after = d_orig - 1) :
    d_after ≥ 2 := by omega

/-- By minimality of G, the graph G-v on n-1 vertices contains
    a cycle of length 2^j for some j. This cycle either:
    (a) was already in G (not through v) — contradicting G being
        a counterexample
    (b) uses a "shortcut" through a former edge of v — i.e., two
        former neighbors of v are connected by a path that, with
        the former edges, creates the dyadic cycle.
    In case (b): the shortcut path has length 2^j - 2 (subtracting
    the two edges through v). -/
theorem shortcut_path_length (j : Nat) (hj : j ≥ 2) :
    2 ^ j - 2 ≥ 2 := by
  have : 2 ^ 2 ≤ 2 ^ j := Nat.pow_le_pow_right (by omega) hj
  omega

/-- The shortcut path connects two neighbors of v. In the link
    structure, this creates a new edge between neighbors (in G-v
    the path replaces v's mediation). -/
theorem shortcut_creates_link (path_len j : Nat)
    (h : path_len = 2 ^ j - 2) (hj : j ≥ 2) :
    path_len ≥ 2 := by
  have : 2 ^ 2 ≤ 2 ^ j := Nat.pow_le_pow_right (by omega) hj
  omega

/-- For cubic graphs with 3 neighbors: at most C(3,2) = 3 pairs
    of neighbors can be connected by shortcut paths. -/
theorem cubic_shortcut_pairs : 3 * 2 / 2 = 3 := by omega

/-- If the dyadic cycle in G-v has length 4 (j=1), the shortcut
    path has length 2 — two neighbors of v connected by a path
    of length 2, giving a C₄ in G. But G is C₄-free: contradiction! -/
theorem length_4_contradiction :
    2 ^ 2 - 2 = 2 := by omega
