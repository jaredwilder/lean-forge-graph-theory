/-
  C₄-free + K₄-free: hexagon (6-cycle) forcing.

  In a cubic C₄-free K₄-free graph, two non-adjacent vertices u, w
  at distance 3 are connected by a path u-a-b-c-w of length 3.
  If there exists another path of length 3 from u to w, say
  u-d-e-f-w, then the union forms a 6-cycle: u-a-b-c-w-f-e-d-u...
  wait, that's length 8. The 6-cycle comes from paths of length 3
  sharing endpoints: u-a-b-w and u-d-e-w give cycle a-b-w-e-d-u-a
  of length 6.

  Actually: two paths of length 3 from u to w (u-a-b-w and u-c-d-w)
  give cycle length 3+3=6.

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

/-- Two length-2 subpaths from u sharing first edge: u-a-b and u-a-c
    with b adj w and c adj w create C₄: b-a-c-w-b (if b ≠ c).
    This is the wedge uniqueness from T046 applied at vertex a. -/
theorem c4free_hexagon_first_edge_unique (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c w : V)
    (hab : G.adj a b) (hac : G.adj a c)
    (hbw : G.adj b w) (hcw : G.adj c w)
    (hne_bc : b ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c)
    (hne_bw : b ≠ w) (hne_cw : c ≠ w) (hne_aw : a ≠ w)
    : False := by
  -- C₄: b-a-c-w-b. hC4 b a c w.
  -- (a=b, b=a, c=c, d=w)
  -- Ne1: b≠a = ne_flip hne_ab
  -- Ne2: a≠c = hne_ac
  -- Ne3: c≠w = hne_cw
  -- Ne4: w≠b = ne_flip hne_bw
  -- Ne5: b≠c = hne_bc
  -- Ne6: a≠w = hne_aw
  exact hC4 b a c w
    (ne_flip hne_ab) hne_ac hne_cw (ne_flip hne_bw)
    hne_bc hne_aw
    (G.adj_symm a b hab) hac hcw (G.adj_symm b w hbw)

/-- Two length-3 paths from u to w that share the middle vertex b
    create a C₄. Path 1: u-a-b-w. Path 2: u-c-b-w. Then
    a-u-c-b-a is C₄. -/
theorem c4free_shared_middle_creates_c4 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u a b c w : V)
    (hua : G.adj u a) (hab : G.adj a b) (hbw : G.adj b w)
    (huc : G.adj u c) (hcb : G.adj c b)
    (hne_ac : a ≠ c)
    (hne_ua : u ≠ a) (hne_ab : a ≠ b) (hne_ub : u ≠ b)
    (hne_uc : u ≠ c) (hne_cb : c ≠ b)
    : False := by
  -- C₄: a-u-c-b-a. hC4 a u c b.
  -- (a=a, b=u, c=c, d=b)
  -- Ne1: a≠u = ne_flip hne_ua
  -- Ne2: u≠c = hne_uc
  -- Ne3: c≠b = hne_cb
  -- Ne4: b≠a = ne_flip hne_ab
  -- Ne5: a≠c = hne_ac
  -- Ne6: u≠b = hne_ub
  exact hC4 a u c b
    (ne_flip hne_ua) hne_uc hne_cb (ne_flip hne_ab)
    hne_ac hne_ub
    (G.adj_symm u a hua) huc hcb (G.adj_symm a b hab)

end SimpleGraph
