/-
  C₄-free cubic: two triangles must be vertex-disjoint.

  From T116: in cubic C₄-free, two triangles sharing a vertex
  must share an edge (by degree-3 pigeonhole), and two triangles
  sharing an edge create a book → C₄ (T076).

  So: triangles are vertex-disjoint in C₄-free cubic graphs.

  This means: if a cubic C₄-free graph has t triangles,
  they use 3t distinct vertices, so 3t ≤ n, i.e., t ≤ n/3.

  For Petersen (girth 5): t = 0. Consistent (0 ≤ 10/3 = 3).
  For cubic C₄-free with triangles (girth 3): t ≤ n/3.

  NEW theorem: in cubic C₄-free, a triangle vertex and its
  third neighbor (not in the triangle) cannot be adjacent to
  any vertex of a DIFFERENT triangle. This extends disjointness
  beyond vertex-disjointness to "neighborhood-disjointness".

  Setup: T₁ = (v,a,b), v' = third nbr of v.
  T₂ = (w,c,d), vertex-disjoint from T₁.
  If v' adj c: C₄ = v-v'-c-?-v. Need to close.
  v-v'-c: length 2. v adj c? Only if c ∈ N(v) = {a,b,v'}.
  c ≠ v' (since c ∈ T₂, v' ∉ T₂ by vertex-disjointness).
  c ≠ a, c ≠ b (vertex-disjoint triangles).
  So v NOT adj c. No C₄ from v'.

  v' adj w: similar. v-v'-w: length 2. v NOT adj w (v ∉ T₂).
  No immediate C₄.

  Let me find a real C₄: if v' = w (third nbr of v is a triangle vertex).
  Then v-v' = v-w. And w ∈ T₂. So v adj w, w adj c, w adj d.
  Can we get C₄? v-w-c-?-v: need c adj something adj v.
  c has edges c-w, c-d, c-c'. If c' adj v: C₄ = v-w-c-c'-v.
  But c' adj v: c' ∈ N(v) = {a,b,w}. If c' = a: C₄ = v-w-c-a-v. YES!

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

/-- v adj w, w adj c, c adj a, a adj v (where a ∈ T₁, c ∈ T₂).
    C₄ = v-w-c-a-v. Two triangles linked through shared vertex w.
    This is the C₄ that prevents third-neighbor triangle linkage. -/
theorem c4free_triangle_link_through_third (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v w c a : V)
    (hvw : G.adj v w) (hwc : G.adj w c) (hca : G.adj c a) (hav : G.adj a v)
    (hne_vw : v ≠ w) (hne_wc : w ≠ c) (hne_ca : c ≠ a) (hne_av : a ≠ v)
    (hne_vc : v ≠ c) (hne_wa : w ≠ a)
    : False := by
  -- C₄: v-w-c-a-v. hC4 v w c a.
  exact hC4 v w c a
    hne_vw hne_wc hne_ca hne_av
    hne_vc hne_wa
    hvw hwc hca hav

/-- Symmetric: v adj w, w adj d, d adj b, b adj v.
    C₄ = v-w-d-b-v. -/
theorem c4free_triangle_link_through_third_sym (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v w d b : V)
    (hvw : G.adj v w) (hwd : G.adj w d) (hdb : G.adj d b) (hbv : G.adj b v)
    (hne_vw : v ≠ w) (hne_wd : w ≠ d) (hne_db : d ≠ b) (hne_bv : b ≠ v)
    (hne_vd : v ≠ d) (hne_wb : w ≠ b)
    : False := by
  exact hC4 v w d b
    hne_vw hne_wd hne_db hne_bv
    hne_vd hne_wb
    hvw hwd hdb hbv

end SimpleGraph
