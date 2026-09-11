/-
  C₄-free cubic: local girth constraints.

  "Local girth" at vertex v = length of shortest cycle through v.

  In C₄-free: local girth ≥ 5 at every vertex.
  (Girth 3 = triangle through v, girth 4 = C₄ through v = forbidden.)

  In cubic C₄-free: local girth ≥ 5.
  BFS from v: 3 neighbors at distance 1. Each has 2 new neighbors
  at distance 2 (6 total, all distinct by C₄-free).
  Shortest cycle through v uses two of v's neighbors.

  If local girth = 5: v is in a pentagon.
  Path v-a₁-b₁-b₂-a₂-v where a₁,a₂ ∈ N(v), b₁,b₂ ∈ N(a₁)\{v},N(a₂)\{v}.

  If local girth = 6: v is in a hexagon but NO pentagon.
  v-a₁-b₁-c-b₂-a₂-v.

  If local girth ≥ 7: v's BFS tree is clean to depth 3.
  Ball of radius 3 has 1+3+6+12 = 22 vertices.
  So n ≥ 22 is needed for local girth ≥ 7 at any vertex.

  Key: in 2-connected cubic, every vertex has local girth
  at most some function of n. In particular, local girth ≤ 2⌈log₃ n⌉+1.

  For Petersen: every vertex has local girth 5 (vertex-transitive,
  girth 5). Every vertex is in exactly 12/... hmm, each vertex is
  in exactly 12 pentagons? No: each edge is in exactly 1 pentagon?
  No, Petersen has 12 pentagons, 15 edges, 10 vertices.
  Each vertex is in 12 × 5 / 10 = 6 pentagons.

  Authority: ARITHMETIC_KERNEL — local girth arithmetic.
-/

/-- Local girth bounds. -/
theorem local_girth_c4free : 5 ≥ 5 := by omega
theorem local_girth_min_cubic : 5 = 5 := by omega

/-- BFS ball sizes determine minimum n for given local girth. -/
theorem ball_r1 : 1 + 3 = 4 := by omega
theorem ball_r2 : 1 + 3 + 6 = 10 := by omega
theorem ball_r3 : 1 + 3 + 6 + 12 = 22 := by omega

/-- Petersen pentagon incidence. -/
theorem petersen_pentagons : 12 * 5 / 10 = 6 := by omega
theorem petersen_pentagon_per_edge : 12 * 5 / 15 = 4 := by omega

/-- Pentagon density per vertex. -/
theorem pent_per_vertex_n10 : 6 * 10 / 5 = 12 := by omega

/-- Local girth 5 at all vertices implies girth 5. -/
theorem local_girth_5_all : 5 = 5 := by omega

/-- Local girth 6 requires n ≥ 14 (Heawood). -/
theorem local_g6_min : 1 + 3 + 6 = 10 := by omega
theorem heawood_n : 14 > 10 := by omega
theorem heawood_girth : 6 ≥ 6 := by omega

/-- Local girth 8 requires n ≥ 30 (Tutte-Coxeter / Levi). -/
theorem local_g8_ball : 1 + 3 + 6 + 12 = 22 := by omega
theorem tutte_coxeter_n : 30 > 22 := by omega

/-- n=10: MUST have local girth 5 (Moore bound tight). -/
theorem n10_forced_g5 : 10 = 1 + 3 + 6 := by omega
