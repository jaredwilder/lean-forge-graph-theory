/-
  C₄-free: two edge-disjoint u-w paths constraint.

  Menger's theorem: if κ'(u,w) ≥ 2 (2 edge-disjoint paths from
  u to w), then these paths create a cycle. Let P₁ have length
  ℓ₁ and P₂ have length ℓ₂. The cycle has length ℓ₁ + ℓ₂.

  If ℓ₁ = ℓ₂ = 2: cycle length 4, forbidden by C₄-free.
  So if u,w have two edge-disjoint paths, not both can have length 2.

  NEW theorem: if P₁ has length 2 (u-x-w) and P₂ has length 2
  (u-y-w), this creates C₄ = u-x-w-y-u. Already in T085/T091.

  DISTINCT new result: if P₁ has length 2 (u-x-w) and P₂ has
  length 3 (u-a-b-w), then: the cycle u-x-w-b-a-u has length 5.
  This is NOT forbidden. But if additionally a adj x:
  C₄ = u-a-x-?... no. u-x-w-b-a-u length 5 is fine.
  The constraint: x ≠ a, x ≠ b (edge-disjoint means no shared
  edges, but can share vertices). If x = a: paths u-a-w and u-a-b-w
  share edge u-a, not edge-disjoint.

  The real new theorem: a NOT adj x (else C₄ = a-x-w-b-a if a≠b≠w≠x).

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

/-- Path u-x-w (length 2) and path u-a-b-w (length 3):
    a NOT adj x. If a adj x: C₄ = a-x-w-b-a. -/
theorem c4free_mixed_paths_no_cross (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a x w b : V)
    (hax : G.adj a x) (hxw : G.adj x w) (hbw : G.adj b w) (hab : G.adj a b)
    (hne_ax : a ≠ x) (hne_xw : x ≠ w) (hne_bw : b ≠ w)
    (hne_ab : a ≠ b) (hne_aw : a ≠ w) (hne_xb : x ≠ b)
    : False := by
  -- C₄: a-x-w-b-a. hC4 a x w b.
  -- (a=a, b=x, c=w, d=b)
  -- Ne1: a≠x = hne_ax
  -- Ne2: x≠w = hne_xw
  -- Ne3: w≠b = ne_flip hne_bw
  -- Ne4: b≠a = ne_flip hne_ab
  -- Ne5: a≠w = hne_aw
  -- Ne6: x≠b = hne_xb
  -- Adj1: G.adj a x = hax ✓
  -- Adj2: G.adj x w = hxw ✓
  -- Adj3: G.adj w b = adj_symm b w hbw
  -- Adj4: G.adj b a = adj_symm a b hab
  exact hC4 a x w b
    hne_ax hne_xw (ne_flip hne_bw) (ne_flip hne_ab)
    hne_aw hne_xb
    hax hxw (G.adj_symm b w hbw) (G.adj_symm a b hab)

/-- Similarly: b NOT adj x. If b adj x: C₄ = x-b-a-u-x? No.
    Actually b adj x with x adj w and b adj w: triangle {x,w,b}
    if x ≠ b ≠ w. Triangle, not C₄. Need 4 vertices.
    b adj x with b adj w (from path 2) and x adj w (from path 1):
    if we also have u adj x: C₄ = u-x-b-a-u? Need a adj u.
    Hmm, let me think. b adj x creates C₄ = b-x-w-?... no,
    w adj b already, so b-x-w-b is a triangle (length 3).
    But we need 4 distinct vertices. u-x-b-a-u: edges u-x, x-b,
    b-a, a-u. All 4 needed. -/
theorem c4free_mixed_paths_no_cross_bx (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u x b a : V)
    (hux : G.adj u x) (hxb : G.adj x b) (hba : G.adj b a) (hau : G.adj a u)
    (hne_ux : u ≠ x) (hne_xb : x ≠ b) (hne_ba : b ≠ a)
    (hne_au : a ≠ u) (hne_ub : u ≠ b) (hne_xa : x ≠ a)
    : False := by
  -- C₄: u-x-b-a-u. hC4 u x b a.
  -- (a=u, b=x, c=b, d=a)
  -- Ne1: u≠x = hne_ux
  -- Ne2: x≠b = hne_xb
  -- Ne3: b≠a = hne_ba
  -- Ne4: a≠u = hne_au
  -- Ne5: u≠b = hne_ub
  -- Ne6: x≠a = hne_xa
  -- Adj1: G.adj u x = hux ✓
  -- Adj2: G.adj x b = hxb ✓
  -- Adj3: G.adj b a = hba ✓
  -- Adj4: G.adj a u = hau ✓
  exact hC4 u x b a
    hne_ux hne_xb hne_ba hne_au
    hne_ub hne_xa
    hux hxb hba hau

end SimpleGraph
