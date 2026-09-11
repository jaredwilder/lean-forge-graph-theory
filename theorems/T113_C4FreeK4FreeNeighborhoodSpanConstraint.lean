/-
  C₄-free K₄-free cubic: neighborhood span constraint.

  For vertex v with N(v) = {a,b,c}, the neighborhoods
  N(a)\{v}, N(b)\{v}, N(c)\{v} are pairwise disjoint (by C₄-free,
  proven in T087/T106).

  The 2-neighborhood N₂(v) = N(a) ∪ N(b) ∪ N(c) \ {v} has exactly
  6 vertices in the TF case (no edges within N(v)).

  NEW: the 3-neighborhood. Each vertex in N₂(v) has degree 3.
  One edge goes to its parent in N(v). Two edges go outward.
  These outward edges cannot go to:
  - v (distance 1 from a layer-2 vertex, but v is distance 2)
    Actually if a₁ adj v, that's C₄ = v-a-a₁-v... no, that's
    a loop through v. a₁ adj v means a₁ ∈ N(v) = {a,b,c}.
    If a₁ = b: then a adj b (via a adj a₁ = b). In TF, a NOT adj b.
  - Another vertex in N(v) (layer-1): forbidden by T106.
  - Another vertex in same branch of N₂(v): forbidden by T075.
  - A vertex in different branch of N₂(v): if a₁ adj b₁ (different
    parents a,b), C₄ = a-a₁-b₁-b-... wait, need a adj b for C₄.
    In TF, a NOT adj b. So a₁ adj b₁ does NOT immediately give C₄.
    But: path v-a-a₁-b₁-... is length 3 from v. This is a layer-3
    shortcut, NOT a C₄.

  The critical C₄: a₁ adj b₁ where a adj v adj b.
  If a₁ adj b₁: is there a C₄? v-a-a₁-b₁-b-v is C₅ (5 vertices).
  No C₄ from this alone.

  But: a₂ adj b₁ where a₂ is SECOND neighbor of a (same parent).
  If a₁ adj b₁ AND a₂ adj b₂: can we find C₄?
  a₁-b₁ and a₂-b₂ are cross-branch edges. a₁ adj a₂? Only if
  same parent. But a₁,a₂ ∈ N(a)\{v}, and they might not be adjacent.

  Let me formalize what IS a C₄ in cross-branch:
  a₁ adj b₁ with a₁ ∈ N(a), b₁ ∈ N(b), and a adj b (triangle case).
  Then C₄ = a-a₁-b₁-b-a. ✓ (T105 already proves this!)

  NEW (non-triangle case): a₁ adj b₁ with a NOT adj b.
  NOT a C₄. But if additionally a₂ adj b₁ (two from branch-a
  reaching same vertex in branch-b):
  C₄ = a-a₁-b₁-a₂-a? But a₁,a₂ ∈ N(a), so a adj a₁, a adj a₂.
  Edges: a-a₁, a₁-b₁, b₁-a₂, a₂-a. 4 distinct: a,a₁,b₁,a₂. C₄!

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

/-- Two children of same parent reaching same target → C₄.
    a₁,a₂ ∈ N(a). If both adj b₁: C₄ = a-a₁-b₁-a₂-a. -/
theorem c4free_two_children_same_target (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a a1 a2 b1 : V)
    (haa1 : G.adj a a1) (ha1b1 : G.adj a1 b1)
    (hb1a2 : G.adj b1 a2) (ha2a : G.adj a2 a)
    (hne_aa1 : a ≠ a1) (hne_a1b1 : a1 ≠ b1)
    (hne_b1a2 : b1 ≠ a2) (hne_a2a : a2 ≠ a)
    (hne_ab1 : a ≠ b1) (hne_a1a2 : a1 ≠ a2)
    : False := by
  -- C₄: a-a1-b1-a2-a. hC4 a a1 b1 a2.
  -- Ne1: a≠a1 = hne_aa1
  -- Ne2: a1≠b1 = hne_a1b1
  -- Ne3: b1≠a2 = hne_b1a2
  -- Ne4: a2≠a = hne_a2a
  -- Ne5: a≠b1 = hne_ab1
  -- Ne6: a1≠a2 = hne_a1a2
  -- Adj1: a-a1 = haa1 ✓
  -- Adj2: a1-b1 = ha1b1 ✓
  -- Adj3: b1-a2 = hb1a2 ✓
  -- Adj4: a2-a = ha2a ✓
  exact hC4 a a1 b1 a2
    hne_aa1 hne_a1b1 hne_b1a2 hne_a2a
    hne_ab1 hne_a1a2
    haa1 ha1b1 hb1a2 ha2a

/-- Symmetric: two children of b reaching same target.
    b₁,b₂ ∈ N(b). If both adj a₁: C₄ = b-b₁-a₁-b₂-b. -/
theorem c4free_two_children_same_target_b (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (b b1 b2 a1 : V)
    (hbb1 : G.adj b b1) (hb1a1 : G.adj b1 a1)
    (ha1b2 : G.adj a1 b2) (hb2b : G.adj b2 b)
    (hne_bb1 : b ≠ b1) (hne_b1a1 : b1 ≠ a1)
    (hne_a1b2 : a1 ≠ b2) (hne_b2b : b2 ≠ b)
    (hne_ba1 : b ≠ a1) (hne_b1b2 : b1 ≠ b2)
    : False := by
  exact hC4 b b1 a1 b2
    hne_bb1 hne_b1a1 hne_a1b2 hne_b2b
    hne_ba1 hne_b1b2
    hbb1 hb1a1 ha1b2 hb2b

end SimpleGraph
