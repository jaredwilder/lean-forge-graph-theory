/-
  C₄-free path uniqueness.

  In a C₄-free graph, any two vertices u, w at distance 2 are
  connected by exactly one path of length 2 (unique wedge, T046).

  Extending: at distance 3, the number of paths of length 3 from
  u to w is bounded. Each path u-a-b-w uses intermediate vertices
  a ∈ N(u), b ∈ N(w). By C₄-free uniqueness, the pair (a,b) must
  be unique for any path of length 3 through that particular pair.

  This means: in a cubic C₄-free graph, the number of length-3
  paths from u to w is at most deg(u) × deg(w) = 9 (for cubic),
  but actually much less due to the C₄-free constraint.

  Authority: STRUCTURAL_CORE — graph theorem with adjacency.
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

/-- Two length-3 paths u-a-b-w and u-a-c-w through the same first
    intermediate a create C₄: b-a-c-w-b (if b adj w and c adj w). -/
theorem c4free_length3_unique_second (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u a b c w : V)
    (hua : G.adj u a) (hab : G.adj a b) (hbw : G.adj b w)
    (hac : G.adj a c) (hcw : G.adj c w)
    (hne_bc : b ≠ c)
    (hne_ua : u ≠ a) (hne_ab : a ≠ b) (hne_bw : b ≠ w)
    (hne_ac : a ≠ c) (hne_cw : c ≠ w) (hne_aw : a ≠ w)
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

/-- Two length-3 paths u-a-b-w and u-c-b-w through the same second
    intermediate b create C₄: a-u-c-b-a (if a adj u and c adj u). -/
theorem c4free_length3_unique_first (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u a b c w : V)
    (hua : G.adj u a) (hab : G.adj a b) (hbw : G.adj b w)
    (huc : G.adj u c) (hcb : G.adj c b)
    (hne_ac : a ≠ c)
    (hne_ua : u ≠ a) (hne_ab : a ≠ b) (hne_bw : b ≠ w)
    (hne_uc : u ≠ c) (hne_cb : c ≠ b) (hne_ub : u ≠ b)
    : False := by
  -- C₄: a-u-c-b-a. hC4 a u c b.
  -- (a=a, b=u, c=c, d=b)
  -- Ne1: a≠u = ne_flip hne_ua
  -- Ne2: u≠c = hne_uc
  -- Ne3: c≠b = hne_cb
  -- Ne4: b≠a = ne_flip (ne_flip hne_ua)... no. d≠a = b≠a = ne_flip hne_ab
  -- Ne5: a≠c = hne_ac
  -- Ne6: u≠b = hne_ub
  exact hC4 a u c b
    (ne_flip hne_ua) hne_uc hne_cb (ne_flip hne_ab)
    hne_ac hne_ub
    (G.adj_symm u a hua) huc hcb (G.adj_symm a b hab)

end SimpleGraph
