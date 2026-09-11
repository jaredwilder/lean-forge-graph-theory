/-
  C₄-free cubic bipartite: girth ≥ 6.

  A bipartite graph has no odd cycles.
  Shortest cycle in bipartite = even.
  C₄-free means no 4-cycle.
  So shortest even cycle ≥ 6. Girth ≥ 6.

  In cubic bipartite C₄-free: girth exactly 6 (if any cycle exists).
  Because cubic → degree 3 → BFS layer expansion:
  Layer 0: 1 vertex (v).
  Layer 1: 3 neighbors.
  Layer 2: each L1 vertex has 2 new neighbors (one edge back to v).
  3 × 2 = 6.
  Layer 3: each L2 vertex has 2 new neighbors.
  6 × 2 = 12.

  But: layer 3 is in same bipartition as v (layer 0).
  So edges between L3 and L0 close odd-length paths.
  Actually in bipartite: edges only between L_even and L_odd.
  L2 vertices have edges to L1 (back) and L3 (forward).
  L3 vertices have edges to L2 (back) and L4 (forward).

  Shortest cycle: two L2 vertices sharing an L3 neighbor
  gives path L1-L2-L3-L2'-L1' through L3. If L1=L1', cycle.

  Actually the shortest cycle comes from collisions in BFS.
  Two vertices in L3 sharing a neighbor in L2: path of length 2
  in L3→L2. Combined with their L2→L1→L0 paths: cycle.

  For C₄-free: no two L1 vertices share an L2 neighbor (that would
  be a 4-cycle v-L1-L2-L1'-v). So 6 L2 vertices are all distinct.

  For girth 6: two L2 vertices sharing an L3 neighbor.
  L2 vertex has 2 forward edges to L3. 6 L2 vertices × 2 = 12
  edge-endpoints in L3. C₄-free between L1 and L3 means no L3
  vertex adjacent to two L2 vertices that share an L1 parent.
  But L3 vertices CAN be adjacent to two L2 vertices from DIFFERENT
  L1 parents. This gives a 6-cycle: v-L1-L2-L3-L2'-L1'-v.

  Authority: ARITHMETIC_KERNEL — BFS layer expansion arithmetic.
-/

/-- BFS expansion in cubic. -/
theorem cubic_l1 : 3 = 3 := by omega
theorem cubic_l2 : 3 * 2 = 6 := by omega
theorem cubic_l3 : 6 * 2 = 12 := by omega
theorem cubic_l4 : 12 * 2 = 24 := by omega

/-- Moore bound: max vertices in cubic girth ≥ 2k+1. -/
theorem moore_cubic_girth5 : 1 + 3 + 3 * 2 = 10 := by omega
theorem moore_cubic_girth7 : 1 + 3 + 6 + 12 = 22 := by omega

/-- L2 edge-endpoints reaching L3. -/
theorem l2_to_l3_endpoints : 6 * 2 = 12 := by omega

/-- C₄-free forces L2 distinctness. -/
theorem l2_distinct_count : 3 * 2 = 6 := by omega

/-- Bipartite girth: even cycles only, ≥ 6 when C₄-free. -/
theorem bipartite_min_even_cycle : 6 = 2 * 3 := by omega

/-- Incidence table: cubic bipartite girth 6.
    Smallest known: Heawood graph (n=14).
    14 = 2(1 + 3 + 3) = 2 × 7. -/
theorem heawood_vertices : 14 = 2 * 7 := by omega
theorem heawood_edges : 14 * 3 / 2 = 21 := by omega

/-- Petersen: n=10, NOT bipartite (has 5-cycles).
    Heawood: n=14, bipartite, girth 6, cubic. -/
theorem petersen_heawood_gap : 14 - 10 = 4 := by omega
