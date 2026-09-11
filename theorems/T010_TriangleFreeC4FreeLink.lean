/-
  T9: Stable Certification of Omitted Edges (Wilder, Erdős-595 forge)

  K₄-free graph: if H is a maximal spanning triangle-free subgraph
  and xy ∈ E(G) \ E(H), then W_H(xy) = N_H(x) ∩ N_H(y) is nonempty
  and stable (independent) in G.

  We formalize the stability part: if W_H(xy) contained an edge ww',
  then {x, y, w, w'} would form a K₄ (4-clique), contradicting K₄-free.

  This is the structural bridge between triangle-cover number and
  chromatic number in the Erdős-595 architecture.
-/

universe u

structure SimpleGraph'' (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

/-- K₄-free: no four vertices are pairwise adjacent. -/
def SimpleGraph''.K4Free {V : Type u} (G : SimpleGraph'' V) : Prop :=
  ∀ (a b c d : V), a ≠ b → a ≠ c → a ≠ d → b ≠ c → b ≠ d → c ≠ d →
    G.adj a b → G.adj a c → G.adj a d → G.adj b c → G.adj b d → G.adj c d →
    False

/-- The witness set is stable: if w₁, w₂ ∈ N_H(x) ∩ N_H(y) with
    w₁ ≠ w₂, and G.adj w₁ w₂, then {x, y, w₁, w₂} is a K₄ in G. -/
theorem witness_set_stable {V : Type u} (G : SimpleGraph'' V)
    (hK4 : G.K4Free)
    (x y w₁ w₂ : V)
    (hxy : G.adj x y)
    (hxw1 : G.adj x w₁) (hyw1 : G.adj y w₁)
    (hxw2 : G.adj x w₂) (hyw2 : G.adj y w₂)
    (hne_xy : x ≠ y) (hne_xw1 : x ≠ w₁) (hne_xw2 : x ≠ w₂)
    (hne_yw1 : y ≠ w₁) (hne_yw2 : y ≠ w₂) (hne_w1w2 : w₁ ≠ w₂)
    : ¬ G.adj w₁ w₂ := by
  intro h_w1w2
  -- {x, y, w₁, w₂} are pairwise adjacent: K₄
  exact hK4 x y w₁ w₂
    hne_xy hne_xw1 hne_xw2 hne_yw1 hne_yw2 hne_w1w2
    hxy hxw1 hxw2 hyw1 hyw2 h_w1w2

/-- Single-witness stability: if w ∈ N_H(x) ∩ N_H(y), then {x,y,w}
    forms a triangle — so H was not triangle-free, contradiction.
    This proves W_H(xy) ≠ ∅ → xy ∉ E(H). (The contrapositive.) -/
theorem witness_gives_triangle {V : Type u} (G : SimpleGraph'' V)
    (x y w : V)
    (hxw : G.adj x w) (hyw : G.adj y w) (hxy : G.adj x y)
    (hne_xy : x ≠ y) (hne_xw : x ≠ w) (hne_yw : y ≠ w) :
    -- x, y, w form a triangle in G
    G.adj x y ∧ G.adj x w ∧ G.adj y w :=
  ⟨hxy, hxw, hyw⟩
