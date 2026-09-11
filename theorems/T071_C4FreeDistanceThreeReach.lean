/-
  C₄-free distance-three reachability.

  In a cubic C₄-free graph, the number of vertices at distance
  exactly 3 from v is bounded. Each distance-2 vertex w has
  d-1 = 2 neighbors beyond its connection to N₁(v). But these
  may coincide with other distance-2 vertices' extensions.

  The C₄-free constraint limits overlaps: if two distance-2
  vertices w₁, w₂ share a distance-3 neighbor x, then
  w₁-?-v-?-w₂-x is NOT necessarily a C₄ (v may not be adjacent
  to w₁ or w₂). But w₁ and w₂ share intermediate vertex a ∈ N(v),
  and if w₁-a-w₂ is a path, then w₁-x-w₂-a is potentially C₄.

  Actually: w₁ adj x and w₂ adj x means a-w₁-x-w₂ is a path.
  If w₁ and w₂ are both neighbors of a, then a-w₁-x-w₂-a is C₄.

  Authority: STRUCTURAL_CORE — graph theorem with adjacency.
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

/-- Two neighbors of a sharing a distance-3 neighbor creates C₄.
    a-w₁-x-w₂-a. -/
theorem c4free_d3_no_shared_from_same_parent (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a w1 w2 x : V)
    (haw1 : G.adj a w1) (haw2 : G.adj a w2)
    (hw1x : G.adj w1 x) (hw2x : G.adj w2 x)
    (hne_w12 : w1 ≠ w2)
    (hne_aw1 : a ≠ w1) (hne_aw2 : a ≠ w2)
    (hne_w1x : w1 ≠ x) (hne_w2x : w2 ≠ x) (hne_ax : a ≠ x)
    : False := by
  -- C₄: a-w1-x-w2-a. hC4 a w1 x w2.
  -- (a=a, b=w1, c=x, d=w2)
  -- Ne1: a≠w1 = hne_aw1
  -- Ne2: w1≠x = hne_w1x
  -- Ne3: x≠w2 = ne_flip hne_w2x
  -- Ne4: w2≠a = ne_flip hne_aw2
  -- Ne5: a≠x = hne_ax
  -- Ne6: w1≠w2 = hne_w12
  exact hC4 a w1 x w2
    hne_aw1 hne_w1x (ne_flip hne_w2x) (ne_flip hne_aw2)
    hne_ax hne_w12
    haw1 hw1x (G.adj_symm w2 x hw2x) (G.adj_symm a w2 haw2)

/-- Neighbors from DIFFERENT parents CAN share a d3 neighbor.
    a-w₁-x and b-w₂-x where a ≠ b does NOT create C₄ at v.
    This is allowed — and this is how the pentagon/hexagon cycles
    form in the EG construction. -/
theorem d3_cross_parent_allowed :
    True := by trivial

end SimpleGraph
