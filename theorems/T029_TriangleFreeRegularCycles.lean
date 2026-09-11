/-
  Triangle-free regular graph cycle structure.

  In a triangle-free graph, the link of every vertex is an independent
  set. Combined with C₄-free: every pair of neighbors of v has no
  common neighbor other than v.

  For a d-regular triangle-free C₄-free graph: every vertex has exactly
  d neighbors, all pairwise non-adjacent, and no two share a neighbor
  outside v. This severely constrains the graph structure.

  Authority: STRUCTURAL_CORE — complete graph theorems (no missing semantics).
  Missing: nothing — proofs conclude False from contradictions.
-/

universe u

structure SimpleGraph (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

namespace SimpleGraph

variable {V : Type u}

def TriangleFree (G : SimpleGraph V) : Prop :=
  ∀ (a b c : V), a ≠ b → b ≠ c → a ≠ c →
    G.adj a b → G.adj b c → G.adj a c → False

def C4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → b ≠ c → c ≠ d → d ≠ a →
    a ≠ c → b ≠ d →
    G.adj a b → G.adj b c → G.adj c d → G.adj d a → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- In a triangle-free graph, any two neighbors of v are non-adjacent. -/
theorem triangle_free_independent_link (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (v a b : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (hne_ab : a ≠ b) (hne_va : v ≠ a) (hne_vb : v ≠ b)
    : ¬ G.adj a b := by
  intro hab
  exact hTF v a b hne_va hne_ab hne_vb
    hva hab hvb

/-- In a triangle-free C₄-free graph, two neighbors a, b of v share
    no common neighbor other than v. -/
theorem tf_c4f_no_common_neighbor (G : SimpleGraph V)
    (hTF : G.TriangleFree) (hC4 : G.C4Free)
    (v a b w : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (haw : G.adj a w) (hbw : G.adj b w)
    (hne_ab : a ≠ b) (hne_va : v ≠ a) (hne_vb : v ≠ b)
    (hne_vw : v ≠ w) (hne_aw : a ≠ w) (hne_bw : b ≠ w)
    : False := by
  exact hC4 v a w b
    hne_va hne_aw (ne_flip hne_bw) (ne_flip hne_vb)
    hne_vw hne_ab
    hva haw (G.adj_symm b w hbw)
    (G.adj_symm v b hvb)

end SimpleGraph
