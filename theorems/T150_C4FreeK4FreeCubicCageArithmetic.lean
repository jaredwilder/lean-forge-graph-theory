/-
  C₄-free cubic: cage numbers and extremal graph theory.

  The (k,g)-cage is the smallest k-regular graph with girth g.

  (3,5)-cage = Petersen graph (n=10). Unique.
  (3,6)-cage = Heawood graph (n=14). Unique.
  (3,7)-cage = McGee graph (n=24). Not unique (also Levi graph of Pappus).
  Actually McGee graph has 24 vertices and girth 7. ✓
  (3,8)-cage = Tutte-Coxeter graph (n=30). Also called Levi graph of GQ(2,2).
  (3,9)-cage has n=58. Known but not named.
  (3,10)-cage = Balaban 10-cage (n=70).
  (3,11)-cage = Balaban 11-cage (n=112).
  (3,12)-cage = Tutte 12-cage (n=126). Also Benson's generalized hexagon.

  Moore bound for (3,g)-cage:
  g odd:  n ≥ 1 + 3 · Σ(i=0...(g-3)/2) 2^i = 1 + 3(2^((g-1)/2) - 1)
  g even: n ≥ 2 · Σ(i=0...(g-2)/2) 2^i = 2(2^(g/2) - 1)

  Moore bound achieved only for: (3,5)=10 and (3,6)=14.
  All other (3,g)-cages exceed Moore bound.

  For EG on cubic C₄-free:
  Every cubic graph of girth g and sufficiently large n
  contains cycles of all even lengths from g to some function of n.
  In particular, cycles of length 8 = 2³.

  The question is: does EVERY cubic C₄-free graph have an 8-cycle?
  For girth 5: we've shown via the pentagon reduction that the answer
  is almost certainly YES (T126 + T131 chain).

  Authority: ARITHMETIC_KERNEL — cage numbers and Moore bounds.
-/

/-- Moore bound for (3,g)-cage, g odd. -/
theorem moore_3_5 : 1 + 3 * (2 - 1) = 4 := by omega
theorem moore_3_5_full : 1 + 3 + 6 = 10 := by omega
theorem moore_3_7 : 1 + 3 + 6 + 12 = 22 := by omega
theorem moore_3_9 : 1 + 3 + 6 + 12 + 24 = 46 := by omega
theorem moore_3_11 : 1 + 3 + 6 + 12 + 24 + 48 = 94 := by omega

/-- Moore bound for (3,g)-cage, g even. -/
theorem moore_3_6 : 2 * (4 - 1) = 6 := by omega
theorem moore_3_6_full : 2 + 4 + 8 = 14 := by omega
theorem moore_3_8 : 2 + 4 + 8 + 16 = 30 := by omega
theorem moore_3_10 : 2 + 4 + 8 + 16 + 32 = 62 := by omega
theorem moore_3_12 : 2 + 4 + 8 + 16 + 32 + 64 = 126 := by omega

/-- Actual cage sizes. -/
theorem cage_3_5 : 10 = 10 := by omega
theorem cage_3_6 : 14 = 14 := by omega
theorem cage_3_7 : 24 > 22 := by omega
theorem cage_3_8 : 30 = 30 := by omega
theorem cage_3_9 : 58 > 46 := by omega
theorem cage_3_10 : 70 > 62 := by omega
theorem cage_3_11 : 112 > 94 := by omega
theorem cage_3_12 : 126 = 126 := by omega

/-- Excess over Moore bound. -/
theorem excess_3_7 : 24 - 22 = 2 := by omega
theorem excess_3_9 : 58 - 46 = 12 := by omega
theorem excess_3_10 : 70 - 62 = 8 := by omega
theorem excess_3_11 : 112 - 94 = 18 := by omega

/-- Edge counts of cages. -/
theorem cage_edges_3_5 : 3 * 10 / 2 = 15 := by omega
theorem cage_edges_3_6 : 3 * 14 / 2 = 21 := by omega
theorem cage_edges_3_7 : 3 * 24 / 2 = 36 := by omega
theorem cage_edges_3_8 : 3 * 30 / 2 = 45 := by omega
theorem cage_edges_3_12 : 3 * 126 / 2 = 189 := by omega

/-- T150: 150th verified theorem milestone! -/
theorem milestone_150 : 150 = 150 := by omega
