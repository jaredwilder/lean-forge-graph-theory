/-
  K₄-free common neighbor structure.

  In a K₄-free graph, no three pairwise-adjacent vertices can all
  be adjacent to a fourth. This means:

  For any triangle {a, b, c}, the set of vertices adjacent to all
  three is EMPTY. The "common neighborhood" N(a) ∩ N(b) ∩ N(c) = ∅
  (beyond {a, b, c} themselves).

  For any edge {a, b}, the common neighborhood N(a) ∩ N(b) induces
  an independent set (no two common neighbors are adjacent).

  Authority: STRUCTURAL_CORE — complete graph theorems.
-/

universe u

structure SimpleGraph (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

namespace SimpleGraph

variable {V : Type u}

def K4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → a ≠ c → a ≠ d →
    b ≠ c → b ≠ d → c ≠ d →
    G.adj a b → G.adj a c → G.adj a d →
    G.adj b c → G.adj b d → G.adj c d → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- In a K₄-free graph, if {a, b, c} is a triangle, no vertex d
    (distinct from a, b, c) can be adjacent to all three. -/
theorem k4free_triangle_common_empty (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (a b c d : V)
    (hab : G.adj a b) (hac : G.adj a c) (hbc : G.adj b c)
    (had : G.adj a d) (hbd : G.adj b d) (hcd : G.adj c d)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_ad : a ≠ d)
    (hne_bc : b ≠ c) (hne_bd : b ≠ d) (hne_cd : c ≠ d)
    : False :=
  hK4 a b c d
    hne_ab hne_ac hne_ad
    hne_bc hne_bd hne_cd
    hab hac had
    hbc hbd hcd

/-- In a K₄-free graph, two common neighbors of an edge {a, b}
    cannot be adjacent: if w₁, w₂ ∈ N(a) ∩ N(b) and w₁-w₂,
    then {a, b, w₁, w₂} is K₄. -/
theorem k4free_common_neighbors_independent (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (a b w1 w2 : V)
    (hab : G.adj a b)
    (haw1 : G.adj a w1) (hbw1 : G.adj b w1)
    (haw2 : G.adj a w2) (hbw2 : G.adj b w2)
    (hw12 : G.adj w1 w2)
    (hne_ab : a ≠ b) (hne_aw1 : a ≠ w1) (hne_aw2 : a ≠ w2)
    (hne_bw1 : b ≠ w1) (hne_bw2 : b ≠ w2) (hne_w12 : w1 ≠ w2)
    : False :=
  hK4 a b w1 w2
    hne_ab hne_aw1 hne_aw2
    hne_bw1 hne_bw2 hne_w12
    hab haw1 haw2
    hbw1 hbw2 hw12

end SimpleGraph
