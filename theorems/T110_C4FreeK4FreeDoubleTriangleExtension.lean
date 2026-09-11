/-
  C₄-free K₄-free cubic: double-triangle extension constraints.

  Two vertex-disjoint triangles T₁=(v,a,b) and T₂=(w,c,d) in a
  cubic C₄-free K₄-free graph.

  Third neighbors: v→v', a→a', b→b', w→w', c→c', d→d'.

  Cross-triangle edges: can v' be adjacent to w'?
  If v' adj w': this doesn't immediately create C₄ unless
  there's a short path connecting them back.

  What IS forbidden: v' adj c (deep vertex of other triangle).
  If v' adj c AND v' adj v AND c adj w AND w adj v... too long.

  Simpler: v adj c. In cubic graph, v has degree 3: {a,b,v'}.
  So v adj c means c ∈ {a,b,v'}. If c=v' then triangle T₂ uses
  v' which is the third neighbor of v. Then v-v'-... path exists.

  Actually the right constraint: if v' = w (shared vertex between
  triangles through third neighbors), then v-a-b-v is T₁ and
  v'-c-d-v' is T₂ with v' = w. Edge v-v' exists. Then
  v-v'-c and v-a... this gets structural, not C₄.

  Let's do a clean constraint: in cubic C₄-free, if v has triangle
  (v,a,b) and v' is v's third neighbor, and v' also has a triangle
  (v',c,d), then a NOT adj c (cross-triangle non-adjacency).
  If a adj c: path v-a-c-v' and edge v-v'. So v-a-c-v'-v is C₅.
  But a adj c: C₄ = v-a-c-v'-v only if length 4. v,a,c,v' = 4
  vertices, edges v-a, a-c, c-v', v'-v. Yes! C₄.

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

/-- Adjacent triangles via third neighbor: cross-triangle non-adjacency.
    Triangle (v,a,b), v' = third nbr of v, triangle (v',c,d).
    a NOT adj c. If a adj c: C₄ = v-a-c-v'-v. -/
theorem c4free_cross_triangle_not_adj (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c v' : V)
    (hva : G.adj v a) (hac : G.adj a c) (hcv' : G.adj c v') (hv'v : G.adj v' v)
    (hne_va : v ≠ a) (hne_ac : a ≠ c) (hne_cv' : c ≠ v') (hne_v'v : v' ≠ v)
    (hne_vc : v ≠ c) (hne_av' : a ≠ v')
    : False := by
  -- C₄: v-a-c-v'-v. hC4 v a c v'.
  -- Ne1: v≠a = hne_va
  -- Ne2: a≠c = hne_ac
  -- Ne3: c≠v' = hne_cv'
  -- Ne4: v'≠v = hne_v'v
  -- Ne5: v≠c = hne_vc
  -- Ne6: a≠v' = hne_av'
  -- Adj1: v-a = hva ✓
  -- Adj2: a-c = hac ✓
  -- Adj3: c-v' = hcv' ✓
  -- Adj4: v'-v = hv'v ✓
  exact hC4 v a c v'
    hne_va hne_ac hne_cv' hne_v'v
    hne_vc hne_av'
    hva hac hcv' hv'v

/-- Symmetric: b NOT adj d (other triangle vertices).
    If b adj d: C₄ = v-b-d-v'-v. -/
theorem c4free_cross_triangle_not_adj_bd (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v b d v' : V)
    (hvb : G.adj v b) (hbd : G.adj b d) (hdv' : G.adj d v') (hv'v : G.adj v' v)
    (hne_vb : v ≠ b) (hne_bd : b ≠ d) (hne_dv' : d ≠ v') (hne_v'v : v' ≠ v)
    (hne_vd : v ≠ d) (hne_bv' : b ≠ v')
    : False := by
  -- C₄: v-b-d-v'-v. hC4 v b d v'.
  exact hC4 v b d v'
    hne_vb hne_bd hne_dv' hne_v'v
    hne_vd hne_bv'
    hvb hbd hdv' hv'v

end SimpleGraph
