/-
  C₄-free: non-adjacent vertices have disjoint neighborhoods.

  If u NOT adj w (u ≠ w), and some vertex x ∈ N(u) ∩ N(w),
  that does NOT create C₄ by itself — it just means x is a
  common neighbor. But if |N(u) ∩ N(w)| ≥ 2, say x,y ∈ N(u) ∩ N(w),
  then u-x-w-y-u is C₄.

  So C₄-free ⟹ codegree ≤ 1: any two vertices share at most one
  common neighbor. This is the fundamental expansion property.

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

/-- Codegree ≤ 1: two common neighbors x,y of {u,w} create C₄.
    u adj x, x adj w, u adj y, y adj w, x ≠ y → C₄: u-x-w-y-u. -/
theorem c4free_codegree_one (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u w x y : V)
    (hux : G.adj u x) (hxw : G.adj x w)
    (huy : G.adj u y) (hyw : G.adj y w)
    (hne_xy : x ≠ y)
    (hne_ux : u ≠ x) (hne_xw : x ≠ w) (hne_uy : u ≠ y)
    (hne_yw : y ≠ w) (hne_uw : u ≠ w)
    : False := by
  -- C₄: u-x-w-y-u. hC4 u x w y.
  -- (a=u, b=x, c=w, d=y)
  -- Ne1: u≠x = hne_ux
  -- Ne2: x≠w = hne_xw
  -- Ne3: w≠y = ne_flip hne_yw
  -- Ne4: y≠u = ne_flip hne_uy
  -- Ne5: u≠w = hne_uw
  -- Ne6: x≠y = hne_xy
  -- Adj1: G.adj u x = hux ✓
  -- Adj2: G.adj x w = hxw ✓
  -- Adj3: G.adj w y = adj_symm y w hyw
  -- Adj4: G.adj y u = adj_symm u y huy
  exact hC4 u x w y
    hne_ux hne_xw (ne_flip hne_yw) (ne_flip hne_uy)
    hne_uw hne_xy
    hux hxw (G.adj_symm y w hyw) (G.adj_symm u y huy)

end SimpleGraph
