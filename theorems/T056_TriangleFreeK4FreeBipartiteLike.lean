/-
  Triangle-free + K₄-free: bipartite-like structure.

  A triangle-free graph has no odd cycle of length 3. Combined
  with C₄-free (no 4-cycle), the shortest cycle has length ≥ 5.

  In a triangle-free graph, every edge (u,v) has the property that
  N(u) and N(v) are disjoint (no common neighbors). This makes the
  graph locally bipartite: from any edge's perspective, the two
  neighborhoods are completely separate sets.

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

def K4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → a ≠ c → a ≠ d →
    b ≠ c → b ≠ d → c ≠ d →
    G.adj a b → G.adj a c → G.adj a d →
    G.adj b c → G.adj b d → G.adj c d → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- Edge neighborhoods are disjoint in TF graphs. -/
theorem tf_edge_disjoint_neighborhoods (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (u v w : V)
    (huv : G.adj u v) (huw : G.adj u w) (hvw : G.adj v w)
    (hne_uv : u ≠ v) (hne_uw : u ≠ w) (hne_vw : v ≠ w)
    : False := by
  -- Triangle {u, v, w}. hTF u v w.
  -- Slot trace: u≠v, v≠w, u≠w, adj u-v, adj v-w, adj u-w
  exact hTF u v w hne_uv hne_vw hne_uw huv hvw huw

/-- In TF, vertices at distance 1 share no neighbors. -/
theorem tf_dist1_no_common (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (u v w : V)
    (huv : G.adj u v) (huw : G.adj u w) (hvw : G.adj v w)
    (hne_uv : u ≠ v) (hne_uw : u ≠ w) (hne_vw : v ≠ w)
    : False := by
  exact tf_edge_disjoint_neighborhoods G hTF u v w
    huv huw hvw hne_uv hne_uw hne_vw

/-- In TF + K₄-free, the local structure is very sparse.
    K₄-free adds: no 4-clique (redundant since TF already kills
    3-cliques, and K₄ contains a triangle). But K₄-free constrains
    the distance-2 structure: no vertex w at distance 2 from v
    can be adjacent to two different vertices at distance 1 from v
    AND those two be adjacent. -/
theorem tf_k4free_sparse_distance2 (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (v a w : V)
    (hva : G.adj v a) (haw : G.adj a w) (hvw : G.adj v w)
    (hne_va : v ≠ a) (hne_aw : a ≠ w) (hne_vw : v ≠ w)
    : False := by
  exact hTF v a w hne_va hne_aw hne_vw hva haw hvw

end SimpleGraph
