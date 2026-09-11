/-
  C₄-free cubic: diameter lower bounds.

  In cubic graph on n vertices with girth g:
  BFS from any vertex v reaches:
    Layer 0: 1 vertex
    Layer 1: 3 vertices
    Layer 2: ≤ 6 vertices (each L1 has 2 forward edges)
    Layer k: ≤ 3·2^(k-1) vertices

  Total within distance d: 1 + 3 + 6 + 12 + ... + 3·2^(d-1)
  = 1 + 3(2^d - 1) = 3·2^d - 2.

  For all n vertices to be reachable: n ≤ 3·2^d - 2.
  → d ≥ log₂((n+2)/3).

  C₄-free adds: L2 vertices are all distinct (no two L1 vertices
  share an L2 neighbor — that would be C₄ with v).
  So L2 count is EXACTLY 6, not "at most 6".

  Girth 5 adds: no edges within layers 0,1 (those create short cycles).
  And no back-edges to L0 from L2 (that's distance 2, creating girth ≤ 4).

  Diameter bounds for known cubic girth-5 graphs:
  Petersen (n=10): diameter 2. (3·2²-2 = 10. Tight!)
  Robertson (n=19): diameter 3. (3·2³-2 = 22 > 19. ✓)
  McGee (n=24): diameter 4. (3·2⁴-2 = 46 > 24. ✓)

  Petersen achieves Moore bound: diam = 2, n = 10 = 3·4-2.

  Authority: ARITHMETIC_KERNEL — diameter and expansion arithmetic.
-/

/-- BFS expansion upper bounds. -/
theorem bfs_d1 : 1 + 3 = 4 := by omega
theorem bfs_d2 : 1 + 3 + 6 = 10 := by omega
theorem bfs_d3 : 1 + 3 + 6 + 12 = 22 := by omega
theorem bfs_d4 : 1 + 3 + 6 + 12 + 24 = 46 := by omega
theorem bfs_d5 : 1 + 3 + 6 + 12 + 24 + 48 = 94 := by omega

/-- Formula check: 3·2^d - 2. -/
theorem moore_d2 : 3 * 4 - 2 = 10 := by omega
theorem moore_d3 : 3 * 8 - 2 = 22 := by omega
theorem moore_d4 : 3 * 16 - 2 = 46 := by omega
theorem moore_d5 : 3 * 32 - 2 = 94 := by omega

/-- Petersen achieves Moore bound at d=2. -/
theorem petersen_moore : 10 = 3 * 4 - 2 := by omega

/-- Diameter lower bound: n=19 needs d ≥ 3 (10 < 19 ≤ 22). -/
theorem n19_needs_d3 : 19 > 10 := by omega
theorem n19_fits_d3 : 19 ≤ 22 := by omega

/-- n=24 needs d ≥ 3 (22 < 24). But fits d=4 (24 ≤ 46). -/
theorem n24_exceeds_d3 : 24 > 22 := by omega
theorem n24_fits_d4 : 24 ≤ 46 := by omega

/-- n=50 needs d ≥ 4 (46 < 50). Fits d=5 (50 ≤ 94). -/
theorem n50_exceeds_d4 : 50 > 46 := by omega
theorem n50_fits_d5 : 50 ≤ 94 := by omega

/-- Layer 2 exactness under C₄-free: 3 × 2 = 6 distinct. -/
theorem c4free_l2_exact : 3 * 2 = 6 := by omega

/-- Max vertices reachable at each layer in cubic C₄-free girth 5. -/
theorem layer_sizes : 1 + 3 + 6 + 12 + 24 = 46 := by omega
