/-
  C₄-free: two length-2 paths with common endpoints → C₄.

  If u and w are connected by two distinct length-2 paths:
  Path 1: u-x-w. Path 2: u-y-w. With x ≠ y.
  Then C₄ = u-x-w-y-u.
  Edges: u-x, x-w, w-y, y-u. 4 distinct vertices: u,x,w,y.

  This is the FUNDAMENTAL C₄-free constraint: at most one
  common neighbor between any two vertices.

  Equivalently: |N(u) ∩ N(w)| ≤ 1 for all u,w.

  Authority: FULL_FORMALIZATION — foundational C₄-free property.
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

/-- Two length-2 paths from u to w through different intermediates → C₄.
    Path 1: u-x-w. Path 2: u-y-w.
    C₄ = u-x-w-y-u. -/
theorem c4free_unique_common_neighbor (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u w x y : V)
    (hux : G.adj u x) (hxw : G.adj x w)
    (hwy : G.adj w y) (hyu : G.adj y u)
    (hne_ux : u ≠ x) (hne_xw : x ≠ w)
    (hne_wy : w ≠ y) (hne_yu : y ≠ u)
    (hne_uw : u ≠ w) (hne_xy : x ≠ y)
    : False := by
  -- C₄: u-x-w-y-u. hC4 u x w y.
  -- Ne1: u≠x = hne_ux
  -- Ne2: x≠w = hne_xw
  -- Ne3: w≠y = hne_wy
  -- Ne4: y≠u = hne_yu
  -- Ne5: u≠w = hne_uw
  -- Ne6: x≠y = hne_xy
  exact hC4 u x w y
    hne_ux hne_xw hne_wy hne_yu
    hne_uw hne_xy
    hux hxw hwy hyu

/-- Reformulated: two common neighbors of u,w create C₄.
    x,y ∈ N(u) ∩ N(w) with x ≠ y.
    C₄ = x-u-y-w-x.
    Edges: x-u, u-y, y-w, w-x. -/
theorem c4free_at_most_one_common_nbr (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u w x y : V)
    (hxu : G.adj x u) (huy : G.adj u y)
    (hyw : G.adj y w) (hwx : G.adj w x)
    (hne_xu : x ≠ u) (hne_uy : u ≠ y)
    (hne_yw : y ≠ w) (hne_wx : w ≠ x)
    (hne_xy : x ≠ y) (hne_uw : u ≠ w)
    : False := by
  -- C₄: x-u-y-w-x. hC4 x u y w.
  -- Ne1: x≠u = hne_xu
  -- Ne2: u≠y = hne_uy
  -- Ne3: y≠w = hne_yw
  -- Ne4: w≠x = hne_wx
  -- Ne5: x≠y = hne_xy
  -- Ne6: u≠w = hne_uw
  exact hC4 x u y w
    hne_xu hne_uy hne_yw hne_wx
    hne_xy hne_uw
    hxu huy hyw hwx

end SimpleGraph
