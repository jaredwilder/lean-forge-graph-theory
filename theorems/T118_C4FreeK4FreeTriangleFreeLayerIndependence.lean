/-
  C₄-free K₄-free cubic TF: layer independence constraints.

  In a triangle-free cubic C₄-free graph (girth ≥ 5):
  - Layer 1 = N(v) = {a,b,c} is independent (TF: no edges in N(v))
  - Layer 2 from a: {a₁,a₂} = N(a)\{v}. Independent set? Not necessarily.
    If a₁ adj a₂: triangle a-a₁-a₂-a. Contradicts TF!

  So: layer-2 vertices from the same parent are NOT adjacent (by TF).
  Combined with cross-branch independence (T087): ALL 6 layer-2
  vertices form an independent set in the TF case.

  NEW: layer-2 to layer-2 adjacency across branches is also forbidden.
  If a₁ adj b₁: path v-a-a₁-b₁-b-v is a 5-cycle (pentagon!).
  This is NOT forbidden — it creates a pentagon, which is the
  shortest cycle (girth 5). So cross-branch L2-L2 edges are the
  PENTAGON EDGES.

  But: a₁ adj b₁ AND a₁ adj b₂ simultaneously?
  v-a-a₁-b₁-b-v is one pentagon. v-a-a₁-b₂-b-v is another.
  These two pentagons share edge v-a and the path a-a₁.
  Shared path of length 2 (v-a-a₁). Symdiff = 5+5-2·2 = 6.
  But also: C₄ = b-b₁-a₁-b₂-b? If b₁ ≠ b₂ and b adj b₁, b adj b₂,
  a₁ adj b₁, a₁ adj b₂: C₄ = b-b₁-a₁-b₂-b. YES!

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

/-- One L2 vertex cannot reach both children of another branch.
    a₁ adj b₁ AND a₁ adj b₂ → C₄ = b-b₁-a₁-b₂-b. -/
theorem c4free_l2_double_reach_forbidden (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (b b1 b2 a1 : V)
    (hbb1 : G.adj b b1) (hb1a1 : G.adj b1 a1)
    (ha1b2 : G.adj a1 b2) (hb2b : G.adj b2 b)
    (hne_bb1 : b ≠ b1) (hne_b1a1 : b1 ≠ a1)
    (hne_a1b2 : a1 ≠ b2) (hne_b2b : b2 ≠ b)
    (hne_ba1 : b ≠ a1) (hne_b1b2 : b1 ≠ b2)
    : False := by
  -- C₄: b-b1-a1-b2-b. hC4 b b1 a1 b2.
  exact hC4 b b1 a1 b2
    hne_bb1 hne_b1a1 hne_a1b2 hne_b2b
    hne_ba1 hne_b1b2
    hbb1 hb1a1 ha1b2 hb2b

/-- Symmetric: b₁ reaches both children of branch a.
    b₁ adj a₁ AND b₁ adj a₂ → C₄ = a-a₁-b₁-a₂-a. -/
theorem c4free_l2_double_reach_forbidden_sym (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a a1 a2 b1 : V)
    (haa1 : G.adj a a1) (ha1b1 : G.adj a1 b1)
    (hb1a2 : G.adj b1 a2) (ha2a : G.adj a2 a)
    (hne_aa1 : a ≠ a1) (hne_a1b1 : a1 ≠ b1)
    (hne_b1a2 : b1 ≠ a2) (hne_a2a : a2 ≠ a)
    (hne_ab1 : a ≠ b1) (hne_a1a2 : a1 ≠ a2)
    : False := by
  -- C₄: a-a1-b1-a2-a. hC4 a a1 b1 a2.
  exact hC4 a a1 b1 a2
    hne_aa1 hne_a1b1 hne_b1a2 hne_a2a
    hne_ab1 hne_a1a2
    haa1 ha1b1 hb1a2 ha2a

end SimpleGraph
