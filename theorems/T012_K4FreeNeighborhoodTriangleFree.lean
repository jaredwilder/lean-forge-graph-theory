/-
  K₄-free implies every vertex link is triangle-free.

  If G is K₄-free, then for any vertex v, the induced subgraph G[N(v)]
  contains no triangle. Proof: a triangle {a,b,c} ⊆ N(v) together with v
  forms a K₄.

  This is the key structural lemma behind Erdős-595 T7 (forward links
  are triangle-free) and the triangle-book construction.

  Authority: FULL_FORMALIZATION — complete graph theorem, no missing semantics.
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

/-- In a K₄-free graph, no three neighbors of a vertex form a triangle. -/
theorem k4free_link_triangle_free (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b) (hbc : G.adj b c) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_bc : b ≠ c) (hne_ac : a ≠ c)
    : False :=
  hK4 v a b c
    hne_va hne_vb hne_vc
    hne_ab hne_ac hne_bc
    hva hvb hvc
    hab hac hbc

/-- Contrapositive: if N(v) contains a triangle, G has K₄. -/
theorem triangle_in_link_gives_k4 (G : SimpleGraph V)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b) (hbc : G.adj b c) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_bc : b ≠ c) (hne_ac : a ≠ c)
    : ¬ G.K4Free := by
  intro hK4
  exact k4free_link_triangle_free G hK4 v a b c
    hva hvb hvc hab hbc hac
    hne_va hne_vb hne_vc hne_ab hne_bc hne_ac

/-- In K₄-free, if u and w are both adjacent to v and to each other,
    then no other common neighbor of v is adjacent to both u and w.
    (The common neighborhood of an edge in N(v) is a stable set.) -/
theorem k4free_edge_in_link_stable (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (v u w x : V)
    (hvu : G.adj v u) (hvw : G.adj v w) (hvx : G.adj v x)
    (huw : G.adj u w)
    (hne_vu : v ≠ u) (hne_vw : v ≠ w) (hne_vx : v ≠ x)
    (hne_uw : u ≠ w) (hne_ux : u ≠ x) (hne_wx : w ≠ x)
    : ¬ (G.adj u x ∧ G.adj w x) := by
  intro ⟨hux, hwx⟩
  exact k4free_link_triangle_free G hK4 v u w x
    hvu hvw hvx huw hwx hux
    hne_vu hne_vw hne_vx hne_uw hne_wx hne_ux

end SimpleGraph
