/-
  C₄-free: independent paths constraint.

  Two internally-disjoint paths P₁ = u-a-b-w and P₂ = u-c-d-w
  of length 3 from u to w. In C₄-free:
  a ≠ c (else shared first vertex after u)
  b ≠ d (else shared last vertex before w)
  a NOT adj c (else a-u-c-?... but u-a and u-c are edges, so
    a-u-c is a path. If a adj c: triangle {u,a,c}, not C₄)
  a NOT adj d: if a adj d, then u-a-d-w is a path of length 3.
    Combined with u-a-b-w: shared prefix u-a. If b ≠ d, then
    a-b-w-d-a is C₄ (4 vertices: a,b,w,d, edges a-b, b-w, w-d, d-a).
  Similarly b NOT adj c.

  The key C₄: a-b-w-d-a from a adj d.

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

/-- Two length-3 paths u-a-b-w and u-c-d-w: a NOT adj d.
    If a adj d: C₄ = a-b-w-d-a. -/
theorem c4free_independent_paths_no_cross_ad (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b w d : V)
    (hab : G.adj a b) (hbw : G.adj b w) (hdw : G.adj d w) (had : G.adj a d)
    (hne_ab : a ≠ b) (hne_bw : b ≠ w) (hne_dw : d ≠ w)
    (hne_ad : a ≠ d) (hne_bd : b ≠ d) (hne_aw : a ≠ w)
    : False := by
  -- C₄: a-b-w-d-a. hC4 a b w d.
  -- (a=a, b=b, c=w, d=d)
  -- Ne1: a≠b = hne_ab
  -- Ne2: b≠w = hne_bw
  -- Ne3: w≠d = ne_flip hne_dw
  -- Ne4: d≠a = ne_flip hne_ad
  -- Ne5: a≠w = hne_aw
  -- Ne6: b≠d = hne_bd
  -- Adj1: G.adj a b = hab ✓
  -- Adj2: G.adj b w = hbw ✓
  -- Adj3: G.adj w d = adj_symm d w hdw
  -- Adj4: G.adj d a = adj_symm a d had
  exact hC4 a b w d
    hne_ab hne_bw (ne_flip hne_dw) (ne_flip hne_ad)
    hne_aw hne_bd
    hab hbw (G.adj_symm d w hdw) (G.adj_symm a d had)

/-- Symmetric: b NOT adj c. If b adj c: C₄ = b-a-?... no.
    Actually: paths u-a-b-w and u-c-d-w. b adj c gives
    C₄ = c-b-w-d-c (if c ≠ b, b ≠ d, c ≠ w). -/
theorem c4free_independent_paths_no_cross_bc (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (b c w d : V)
    (hbw : G.adj b w) (hcb : G.adj c b) (hcd : G.adj c d) (hdw : G.adj d w)
    (hne_bw : b ≠ w) (hne_cb : c ≠ b) (hne_cd : c ≠ d)
    (hne_dw : d ≠ w) (hne_bd : b ≠ d) (hne_cw : c ≠ w)
    : False := by
  -- C₄: c-b-w-d-c. hC4 c b w d.
  -- (a=c, b=b, c=w, d=d)
  -- Ne1: c≠b = hne_cb
  -- Ne2: b≠w = hne_bw
  -- Ne3: w≠d = ne_flip hne_dw
  -- Ne4: d≠c = ne_flip hne_cd
  -- Ne5: c≠w = hne_cw
  -- Ne6: b≠d = hne_bd
  -- Adj1: G.adj c b = hcb ✓
  -- Adj2: G.adj b w = hbw ✓
  -- Adj3: G.adj w d = adj_symm d w hdw
  -- Adj4: G.adj d c = adj_symm c d hcd
  exact hC4 c b w d
    hne_cb hne_bw (ne_flip hne_dw) (ne_flip hne_cd)
    hne_cw hne_bd
    hcb hbw (G.adj_symm d w hdw) (G.adj_symm c d hcd)

end SimpleGraph
