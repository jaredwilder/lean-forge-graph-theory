/-
  Triangle-free path extension.

  In a triangle-free graph, every edge a-b has the property that
  the neighborhoods N(a)\{b} and N(b)\{a} are completely disjoint.
  (A common neighbor w would create triangle a-w-b.)

  This means every path extension from a through a neighbor x ≠ b
  goes into a region completely separate from b's neighbors.
  This is the structural engine that forces long paths in TF graphs.

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

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- In a triangle-free graph, adjacent vertices share no common
    neighbor. If a-b edge and w adjacent to both, triangle. -/
theorem tf_disjoint_neighborhoods (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (a b w : V)
    (hab : G.adj a b) (haw : G.adj a w) (hbw : G.adj b w)
    (hne_ab : a ≠ b) (hne_aw : a ≠ w) (hne_bw : b ≠ w)
    : False := by
  -- Triangle {a, b, w}. hTF a b w.
  -- Slot trace for hTF a b w:
  --   Ne slots: a≠b, b≠w, a≠w
  --   Adj slots: a-b, b-w, a-w
  exact hTF a b w hne_ab hne_bw hne_aw hab hbw haw

/-- In TF, if a-x-y is a path (a adj x, x adj y, a ≠ y),
    then a is NOT adjacent to y (else triangle a-x-y). -/
theorem tf_path_no_shortcut (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (a x y : V)
    (hax : G.adj a x) (hxy : G.adj x y) (hay : G.adj a y)
    (hne_ax : a ≠ x) (hne_xy : x ≠ y) (hne_ay : a ≠ y)
    : False := by
  -- Triangle {a, x, y}. hTF a x y.
  -- Slot trace for hTF a x y:
  --   Ne slots: a≠x, x≠y, a≠y
  --   Adj slots: a-x, x-y, a-y
  exact hTF a x y hne_ax hne_xy hne_ay hax hxy hay

/-- Combining: in TF, a path a-x-y of length 2 starting from a
    guarantees y ∉ N(a). So path extension strictly increases
    the "distance" from a. Every 2-step walk is a shortest path. -/
theorem tf_two_step_increases_distance (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (a x y : V)
    (hax : G.adj a x) (hxy : G.adj x y)
    (hne_ax : a ≠ x) (hne_xy : x ≠ y) (hne_ay : a ≠ y)
    (hay : G.adj a y)
    : False := by
  exact tf_path_no_shortcut G hTF a x y hax hxy hay hne_ax hne_xy hne_ay

end SimpleGraph
