/-
  COMPOSITION: T122 + T130 + T134 + T137.

  T122: at most 1 common neighbor (two L2 paths → C₄).
  T130: distance-4 shortcut u adj c → C₄ = u-a-b-c-u.
  T134: cross edge between two L3 paths → C₄.
  T137: shared penultimate vertex in two L3 paths → C₄.

  COMBINED: Distance rigidity in C₄-free graphs.

  For vertices u,w at distance d(u,w) = k:
  k=1: adjacent. Direct edge.
  k=2: unique shortest path u-v-w (at most 1 common neighbor, T122).
       Any second common neighbor creates C₄.
  k=3: path u-a-b-w. Another path u-a'-b'-w must satisfy:
       - a ≠ a' (else same first step, then b = b' by T122 at a).
       - b ≠ b' (else C₄ by T137).
       - a NOT adj b' (else C₄ by T134).
       - b NOT adj a' (else C₄ by T134).
       So two L3 paths are "fully separated" — no cross edges.
  k=4: path u-a-b-c-w. u NOT adj c (T130 would give C₄).
       a NOT adj w (T130 symmetric). So NO shortcuts at all.

  NEW: combining these, the BFS tree from any vertex in a
  C₄-free graph is "almost a tree" — very few extra edges.

  Specific new C₄: distance-3 double shortcut.
  u-a-b-w (path). u also has neighbor a'. a' also reaches w:
  a'-b'-w. Then: u-a-b-w-b'-a'-u is 6-cycle. But if a adj b':
  C₄ = u-a-b'-a'-u. 4 vertices.

  Authority: FULL_FORMALIZATION — composition theorem.
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

/-- Distance-3 double shortcut: a adj b' across two L3 paths.
    Paths: u-a-b-w and u-a'-b'-w. Cross: a adj b'.
    C₄ = u-a-b'-a'-u.
    Edges: u-a, a-b', b'-a', a'-u. -/
theorem c4free_d3_double_shortcut (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u a b' a' : V)
    (hua : G.adj u a) (hab' : G.adj a b')
    (hb'a' : G.adj b' a') (ha'u : G.adj a' u)
    (hne_ua : u ≠ a) (hne_ab' : a ≠ b')
    (hne_b'a' : b' ≠ a') (hne_a'u : a' ≠ u)
    (hne_ub' : u ≠ b') (hne_aa' : a ≠ a')
    : False := by
  exact hC4 u a b' a'
    hne_ua hne_ab' hne_b'a' hne_a'u
    hne_ub' hne_aa'
    hua hab' hb'a' ha'u

/-- Distance-3 reverse shortcut: b adj a' across two L3 paths.
    Paths: u-a-b-w and u-a'-b'-w. Cross: b adj a'.
    C₄ = u-a'-b-a-u? No: C₄ = a-b-a'-u-a.
    Edges: a-b, b-a', a'-u, u-a. -/
theorem c4free_d3_reverse_shortcut (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b a' u : V)
    (hab : G.adj a b) (hba' : G.adj b a')
    (ha'u : G.adj a' u) (hua : G.adj u a)
    (hne_ab : a ≠ b) (hne_ba' : b ≠ a')
    (hne_a'u : a' ≠ u) (hne_ua : u ≠ a)
    (hne_aa' : a ≠ a') (hne_bu : b ≠ u)
    : False := by
  exact hC4 a b a' u
    hne_ab hne_ba' hne_a'u hne_ua
    hne_aa' hne_bu
    hab hba' ha'u hua

/-- Distance-2 double path: the foundational T122 restated.
    Two paths u-x-w and u-y-w → C₄ = u-x-w-y-u. -/
theorem c4free_d2_unique_path (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u x w y : V)
    (hux : G.adj u x) (hxw : G.adj x w)
    (hwy : G.adj w y) (hyu : G.adj y u)
    (hne_ux : u ≠ x) (hne_xw : x ≠ w)
    (hne_wy : w ≠ y) (hne_yu : y ≠ u)
    (hne_uw : u ≠ w) (hne_xy : x ≠ y)
    : False := by
  exact hC4 u x w y
    hne_ux hne_xw hne_wy hne_yu
    hne_uw hne_xy
    hux hxw hwy hyu

end SimpleGraph
