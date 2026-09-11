/-
  C₄-free wedge uniqueness.

  A "wedge" at vertex v is a pair of edges v-a, v-b where a ≠ b.
  In a C₄-free graph, any two vertices u, w are connected by at most
  one wedge (path of length 2). If u-v₁-w and u-v₂-w are both paths
  with v₁ ≠ v₂, then u-v₁-w-v₂ is a C₄.

  This uniqueness is what makes C₄-free graphs "locally tree-like"
  at distance 2: the distance-2 neighborhood has no redundancy.

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

/-- In a C₄-free graph, two vertices are connected by at most one
    length-2 path (wedge). Two distinct wedges create a C₄. -/
theorem c4free_unique_wedge (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u w v1 v2 : V)
    (huv1 : G.adj u v1) (hv1w : G.adj v1 w)
    (huv2 : G.adj u v2) (hv2w : G.adj v2 w)
    (hne_v12 : v1 ≠ v2)
    (hne_uv1 : u ≠ v1) (hne_uv2 : u ≠ v2)
    (hne_v1w : v1 ≠ w) (hne_v2w : v2 ≠ w)
    (hne_uw : u ≠ w)
    : False := by
  -- C₄: u-v1-w-v2-u. hC4 u v1 w v2.
  -- Slot trace for hC4 u v1 w v2:
  --   Ne slots: u≠v1, v1≠w, w≠v2, v2≠u, u≠w, v1≠v2
  --   Adj slots: u-v1, v1-w, w-v2, v2-u
  exact hC4 u v1 w v2
    hne_uv1 hne_v1w (ne_flip hne_v2w) (ne_flip hne_uv2)
    hne_uw hne_v12
    huv1 hv1w (G.adj_symm v2 w hv2w) (G.adj_symm u v2 huv2)

/-- Symmetric form: two vertices at distance 2 have a unique
    intermediate vertex. -/
theorem c4free_unique_intermediate (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u w v1 v2 : V)
    (huv1 : G.adj u v1) (hv1w : G.adj v1 w)
    (huv2 : G.adj u v2) (hv2w : G.adj v2 w)
    (hne_v12 : v1 ≠ v2)
    (hne_uv1 : u ≠ v1) (hne_uv2 : u ≠ v2)
    (hne_v1w : v1 ≠ w) (hne_v2w : v2 ≠ w)
    (hne_uw : u ≠ w)
    : False := by
  exact c4free_unique_wedge G hC4 u w v1 v2
    huv1 hv1w huv2 hv2w hne_v12
    hne_uv1 hne_uv2 hne_v1w hne_v2w hne_uw

/-- In C₄-free, if v has neighbors a and b, and a has neighbor w ≠ v,
    then w is not also a neighbor of b (otherwise v-a-w-b is C₄). -/
theorem c4free_neighbor_link_disjoint (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b w : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (haw : G.adj a w) (hbw : G.adj b w)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_aw : a ≠ w) (hne_bw : b ≠ w) (hne_vw : v ≠ w)
    : False := by
  -- C₄: v-a-w-b-v. hC4 v a w b.
  -- Slot trace for hC4 v a w b:
  --   Ne slots: v≠a, a≠w, w≠b, b≠v, v≠w, a≠b
  --   Adj slots: v-a, a-w, w-b, b-v
  exact hC4 v a w b
    hne_va hne_aw (ne_flip hne_bw) (ne_flip hne_vb)
    hne_vw hne_ab
    hva haw (G.adj_symm b w hbw) (G.adj_symm v b hvb)

end SimpleGraph
