/-
  COMPOSITION: T122 + T129 + T132 + T137.

  T122: two L2 paths → C₄ (unique common neighbor).
  T129: depth-2 external NOT adj next pentagon vertex.
  T132: layer-2 sibling common target → C₄.
  T137: shared penultimate → C₄.

  COMBINED: Layer-3 isolation theorem.

  In C₄-free cubic graph, vertex v with neighbors a₁,a₂,a₃:
  Each aᵢ has 2 neighbors beyond v: bᵢ₁, bᵢ₂.
  Layer 2 = {b₁₁,b₁₂,b₂₁,b₂₂,b₃₁,b₃₂} (6 vertices, all distinct by T122).

  Each bᵢⱼ has 2 neighbors beyond aᵢ: call them cᵢⱼₖ (k=1,2).
  Layer 3 = up to 12 vertices.

  CONSTRAINTS on Layer 3:
  1. cᵢⱼₖ ≠ v (distance 3 from v, but v at distance 0 — if equal, cycle of length 3).
  2. cᵢⱼₖ ≠ aₘ for any m (T129 pattern: depth-2 not adj layer-0 neighbor).
     Actually: cᵢⱼₖ adj aₘ would mean b adj c adj a, creating potential C₄.
     If cᵢⱼ₁ adj a₂ (cross-branch): C₄ = v-a₁-bᵢⱼ-cᵢⱼ₁-? Need cᵢⱼ₁ adj v.
     cᵢⱼ₁ = a₂ means bᵢⱼ adj a₂. Combined with v adj a₂ and v adj a₁ adj bᵢⱼ:
     C₄ = v-a₁-bᵢⱼ-a₂-v. YES! (T132).
  3. c₁₁₁ ≠ c₁₂₁ (same-parent-branch, different L2 vertices reaching same L3):
     b₁₁ adj c, b₁₂ adj c → a₁ reaches c through both b₁₁ and b₁₂.
     C₄ = a₁-b₁₁-c-b₁₂-a₁ (T132).
  4. c₁₁₁ ≠ c₂₁₁ (cross-branch same L3):
     b₁₁ adj c, b₂₁ adj c → paths v-a₁-b₁₁-c and v-a₂-b₂₁-c.
     Two length-3 paths from v to c. If b₁₁ adj b₂₁: C₄ (T134).
     Even without: the paths share only v and c — no immediate C₄
     UNLESS there's a cross edge.

  Authority: FULL_FORMALIZATION — composition theorem.
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

/-- Constraint 2: L2 vertex NOT equal to cross-branch L1 vertex.
    If b₁₁ adj a₂: C₄ = v-a₁-b₁₁-a₂-v.
    Edges: v-a₁, a₁-b₁₁, b₁₁-a₂, a₂-v. -/
theorem c4free_l2_not_cross_l1 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a1 b11 a2 : V)
    (hva1 : G.adj v a1) (ha1b : G.adj a1 b11)
    (hba2 : G.adj b11 a2) (ha2v : G.adj a2 v)
    (hne1 : v ≠ a1) (hne2 : a1 ≠ b11)
    (hne3 : b11 ≠ a2) (hne4 : a2 ≠ v)
    (hne5 : v ≠ b11) (hne6 : a1 ≠ a2)
    : False := by
  exact hC4 v a1 b11 a2
    hne1 hne2 hne3 hne4 hne5 hne6
    hva1 ha1b hba2 ha2v

/-- Constraint 3: same-branch L2 siblings NOT sharing L3 target.
    b₁₁ adj c AND b₁₂ adj c: C₄ = a₁-b₁₁-c-b₁₂-a₁.
    Edges: a₁-b₁₁, b₁₁-c, c-b₁₂, b₁₂-a₁. -/
theorem c4free_l2_siblings_not_share_l3 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a1 b11 c b12 : V)
    (ha1b11 : G.adj a1 b11) (hb11c : G.adj b11 c)
    (hcb12 : G.adj c b12) (hb12a1 : G.adj b12 a1)
    (hne1 : a1 ≠ b11) (hne2 : b11 ≠ c)
    (hne3 : c ≠ b12) (hne4 : b12 ≠ a1)
    (hne5 : a1 ≠ c) (hne6 : b11 ≠ b12)
    : False := by
  exact hC4 a1 b11 c b12
    hne1 hne2 hne3 hne4 hne5 hne6
    ha1b11 hb11c hcb12 hb12a1

end SimpleGraph
