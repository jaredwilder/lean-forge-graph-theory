/-
  C₄-free: distance-4 shortcut creates C₄.

  Two vertices u,w at distance 4 in a C₄-free graph.
  Path: u-a-b-c-w (length 4).

  If there's a shortcut edge from u to c (distance 3 vertex):
  C₄ = u-a-b-c-u? Wait, that's 3 edges (u-a, a-b, b-c, c-u) = 4 edges.
  4 vertices: u,a,b,c. YES, C₄ = u-a-b-c-u!

  But u adj c means d(u,c) = 1, contradicting d(u,c) = 3 (sub-path).
  Well, d(u,c) being 3 is the SHORTEST path assumption.
  If u adj c: then d(u,c) = 1, which means the "distance 4" path
  u-a-b-c-w has a shortcut, and u-c is an edge.
  C₄ = u-a-b-c-u if all 4 distinct. YES.

  Similarly: a adj w (a is distance 3 from w, and a adj w shortcut).
  C₄ = a-b-c-w-a.

  And: u adj b (distance 2 shortcut).
  C₄ = u-a-b-u? Only 3 vertices, triangle. NOT C₄.
  But: u adj b AND u adj a (already have u-a edge).
  Two common neighbors u has with b: a (via u-a-b) and the direct edge.
  By T122: two length-2 paths → C₄. Path 1: u-a-b. Path 2: u-?-b.
  If u adj b directly, that's a length-1 path, not length-2.

  The correct C₄ from u adj b: need another vertex.
  If u adj b: then u-b is an edge. Combined with u-a-b (path of 2):
  this gives triangle u-a-b, not C₄.

  So the useful shortcuts are:
  - u adj c → C₄ = u-a-b-c-u
  - a adj w → C₄ = a-b-c-w-a

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

/-- Distance-4 path u-a-b-c-w: shortcut u adj c → C₄.
    C₄ = u-a-b-c-u. -/
theorem c4free_d4_shortcut_uc (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u a b c : V)
    (hua : G.adj u a) (hab : G.adj a b) (hbc : G.adj b c) (hcu : G.adj c u)
    (hne_ua : u ≠ a) (hne_ab : a ≠ b) (hne_bc : b ≠ c) (hne_cu : c ≠ u)
    (hne_ub : u ≠ b) (hne_ac : a ≠ c)
    : False := by
  -- C₄: u-a-b-c-u. hC4 u a b c.
  exact hC4 u a b c
    hne_ua hne_ab hne_bc hne_cu
    hne_ub hne_ac
    hua hab hbc hcu

/-- Distance-4 path u-a-b-c-w: shortcut a adj w → C₄.
    C₄ = a-b-c-w-a. -/
theorem c4free_d4_shortcut_aw (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c w : V)
    (hab : G.adj a b) (hbc : G.adj b c) (hcw : G.adj c w) (hwa : G.adj w a)
    (hne_ab : a ≠ b) (hne_bc : b ≠ c) (hne_cw : c ≠ w) (hne_wa : w ≠ a)
    (hne_ac : a ≠ c) (hne_bw : b ≠ w)
    : False := by
  -- C₄: a-b-c-w-a. hC4 a b c w.
  exact hC4 a b c w
    hne_ab hne_bc hne_cw hne_wa
    hne_ac hne_bw
    hab hbc hcw hwa

end SimpleGraph
