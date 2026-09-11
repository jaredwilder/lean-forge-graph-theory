/-
  Triangle-free + C₄-free: unique common neighbor.

  In a graph that is both triangle-free and C₄-free, any two
  non-adjacent vertices share at most one common neighbor.

  Proof: if u and v (non-adjacent) have two common neighbors w₁ and w₂,
  then u-w₁-v-w₂ is a C₄.

  And any two adjacent vertices share ZERO common neighbors
  (a common neighbor would create a triangle).

  Authority: FULL_FORMALIZATION — complete graph theorem.
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

/-- Adjacent vertices in a triangle-free graph share no common neighbor. -/
theorem tf_adjacent_no_common (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (u v w : V)
    (huv : G.adj u v) (huw : G.adj u w) (hvw : G.adj v w)
    (hne_uv : u ≠ v) (hne_uw : u ≠ w) (hne_vw : v ≠ w)
    : False := by
  -- Triangle {u, v, w}. hTF u v w.
  -- slots: u≠v, v≠w, u≠w
  -- adj: uv, vw, uw
  exact hTF u v w hne_uv hne_vw hne_uw huv hvw huw

/-- Non-adjacent vertices in a C₄-free graph share at most one
    common neighbor. Two common neighbors create a C₄. -/
theorem c4f_nonadj_unique_common (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u v w1 w2 : V)
    (huw1 : G.adj u w1) (hvw1 : G.adj v w1)
    (huw2 : G.adj u w2) (hvw2 : G.adj v w2)
    (hne_uv : u ≠ v) (hne_w12 : w1 ≠ w2)
    (hne_uw1 : u ≠ w1) (hne_uw2 : u ≠ w2)
    (hne_vw1 : v ≠ w1) (hne_vw2 : v ≠ w2)
    : False := by
  -- C₄: u-w1-v-w2-u. hC4 u w1 v w2.
  -- slots: u≠w1, w1≠v, v≠w2, w2≠u, u≠v, w1≠w2
  exact hC4 u w1 v w2
    hne_uw1 (ne_flip hne_vw1) hne_vw2 (ne_flip hne_uw2)
    hne_uv hne_w12
    huw1 (G.adj_symm v w1 hvw1) hvw2 (G.adj_symm u w2 huw2)

/-- In triangle-free + C₄-free: any two distinct vertices share
    at most one common neighbor. This is the strongest possible
    codegree bound: codeg(u,v) ≤ 1 for ALL pairs, not just
    non-adjacent ones. -/
theorem tf_c4f_codegree_at_most_one (G : SimpleGraph V)
    (hTF : G.TriangleFree) (hC4 : G.C4Free)
    (u v w1 w2 : V)
    (huw1 : G.adj u w1) (hvw1 : G.adj v w1)
    (huw2 : G.adj u w2) (hvw2 : G.adj v w2)
    (hne_uv : u ≠ v) (hne_w12 : w1 ≠ w2)
    (hne_uw1 : u ≠ w1) (hne_uw2 : u ≠ w2)
    (hne_vw1 : v ≠ w1) (hne_vw2 : v ≠ w2)
    : False := by
  exact c4f_nonadj_unique_common G hC4 u v w1 w2
    huw1 hvw1 huw2 hvw2 hne_uv hne_w12
    hne_uw1 hne_uw2 hne_vw1 hne_vw2

end SimpleGraph
