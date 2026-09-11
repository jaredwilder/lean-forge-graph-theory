/-
  C₄-free: layer-2 sibling isolation.

  In a C₄-free graph, vertex v has neighbors a₁, a₂ (distinct).
  Each aᵢ has neighbors beyond v: call them bᵢ₁, bᵢ₂ (in cubic, degree 3).

  "Siblings" are vertices sharing a common neighbor.
  a₁ and a₂ are siblings (shared parent v).
  b₁₁ and b₁₂ are siblings (shared parent a₁).

  CROSS-SIBLING constraint: can b₁₁ (child of a₁) be adjacent to b₂₁ (child of a₂)?
  If b₁₁ adj b₂₁: path a₁-b₁₁-b₂₁-a₂. Combined with a₁-v-a₂ (through v):
  C₄ = v-a₁-b₁₁-b₂₁-a₂? Wait, that's 5 vertices: v,a₁,b₁₁,b₂₁,a₂. Length 5.
  Not C₄.

  But wait: the C₄ is a₁-b₁₁-b₂₁-a₂-v-a₁? That's length 5 again.

  The ACTUAL C₄ from cross-layer-2:
  Need 4 distinct vertices forming a cycle.

  If b₁₁ adj a₂: C₄ = v-a₁-b₁₁-a₂-v. 4 vertices: v,a₁,b₁₁,a₂.
  Edges: v-a₁, a₁-b₁₁, b₁₁-a₂, a₂-v. YES!

  This is exactly T124 (sibling's child adj another sibling creates C₄).

  NEW: same-parent cross-child adjacency.
  b₁₁ adj b₁₂ (both children of a₁, distinct from each other and v).
  C₄ = a₁-b₁₁-?-b₁₂-a₁? Need a 4th vertex between b₁₁ and b₁₂.
  If b₁₁ adj b₁₂ directly: triangle a₁-b₁₁-b₁₂. Not C₄.

  So same-parent children being adjacent creates a TRIANGLE, not C₄.
  But: in TRIANGLE-FREE (girth ≥ 4), b₁₁ NOT adj b₁₂ (children of
  same vertex are pairwise non-adjacent).

  In C₄-free only: same-parent adjacency = triangle (allowed unless also TF).

  The C₄ structure: both children of a₁ reaching the SAME vertex z.
  If b₁₁ adj z AND b₁₂ adj z: two paths a₁-b₁₁-z and a₁-b₁₂-z.
  By T122: two length-2 paths from a₁ to z → C₄.
  C₄ = a₁-b₁₁-z-b₁₂-a₁? Check: 4 vertices a₁,b₁₁,z,b₁₂.
  Edges: a₁-b₁₁, b₁₁-z, z-b₁₂, b₁₂-a₁. YES!

  Authority: FULL_FORMALIZATION — complete graph theorem.
-/

universe u

structure SimpleGraph (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

namespace SimpleGraph

variable {V : Type u}

def C4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → b ≠ c → c ≠ d → d ≠ a →
    a ≠ c → b ≠ d →
    G.adj a b → G.adj b c → G.adj c d → G.adj d a → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- Layer-2 sibling common target → C₄.
    Both children of a₁ (namely b₁₁ and b₁₂) reach the same target z.
    Two length-2 paths: a₁-b₁₁-z and a₁-b₁₂-z.
    C₄ = a₁-b₁₁-z-b₁₂-a₁.
    Edges: a₁-b₁₁, b₁₁-z, z-b₁₂, b₁₂-a₁. -/
theorem c4free_l2_sibling_common_target (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a1 b11 z b12 : V)
    (ha1b11 : G.adj a1 b11) (hb11z : G.adj b11 z)
    (hzb12 : G.adj z b12) (hb12a1 : G.adj b12 a1)
    (hne_a1b11 : a1 ≠ b11) (hne_b11z : b11 ≠ z)
    (hne_zb12 : z ≠ b12) (hne_b12a1 : b12 ≠ a1)
    (hne_a1z : a1 ≠ z) (hne_b11b12 : b11 ≠ b12)
    : False := by
  -- C₄: a1-b11-z-b12-a1. hC4 a1 b11 z b12.
  exact hC4 a1 b11 z b12
    hne_a1b11 hne_b11z hne_zb12 hne_b12a1
    hne_a1z hne_b11b12
    ha1b11 hb11z hzb12 hb12a1

/-- Cross-sibling: child of a₁ adj to a₂ (sibling of a₁ through v).
    C₄ = v-a₁-b₁₁-a₂-v.
    Edges: v-a₁, a₁-b₁₁, b₁₁-a₂, a₂-v. -/
theorem c4free_cross_sibling_reach (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a1 b11 a2 : V)
    (hva1 : G.adj v a1) (ha1b11 : G.adj a1 b11)
    (hb11a2 : G.adj b11 a2) (ha2v : G.adj a2 v)
    (hne_va1 : v ≠ a1) (hne_a1b11 : a1 ≠ b11)
    (hne_b11a2 : b11 ≠ a2) (hne_a2v : a2 ≠ v)
    (hne_vb11 : v ≠ b11) (hne_a1a2 : a1 ≠ a2)
    : False := by
  -- C₄: v-a1-b11-a2-v. hC4 v a1 b11 a2.
  exact hC4 v a1 b11 a2
    hne_va1 hne_a1b11 hne_b11a2 hne_a2v
    hne_vb11 hne_a1a2
    hva1 ha1b11 hb11a2 ha2v

end SimpleGraph
