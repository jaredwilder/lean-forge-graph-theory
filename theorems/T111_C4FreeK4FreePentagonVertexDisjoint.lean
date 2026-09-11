/-
  C₄-free K₄-free cubic: vertex-disjoint pentagon constraints.

  Two vertex-disjoint pentagons P₁ = (u₀,u₁,u₂,u₃,u₄) and
  P₂ = (w₀,w₁,w₂,w₃,w₄). In cubic C₄-free:

  Cross-edges between P₁ and P₂ are constrained.
  If u₀ adj w₀: can u₁ adj w₁?
  u₀-u₁-... and w₀-w₁-... with u₀ adj w₀ and u₁ adj w₁:
  C₄ = u₀-u₁-w₁-w₀-u₀? Wait: need w₁ adj w₀. Yes from P₂.
  So edges: u₀-u₁ (P₁), u₁-w₁ (cross), w₁-w₀ (P₂), w₀-u₀ (cross).
  That IS C₄ if u₀,u₁,w₁,w₀ are 4 distinct vertices. ✓

  So: if u₀ adj w₀, then u₁ NOT adj w₁ (consecutive cross-edges
  create C₄).

  Similarly: u₀ adj w₀ ⟹ u₄ NOT adj w₄ (other direction along
  pentagon). C₄ = u₀-u₄-w₄-w₀-u₀.

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

/-- Consecutive cross-edges between pentagons create C₄.
    u₀ adj w₀ (cross) and u₁ adj w₁ (cross).
    P₁ has u₀-u₁, P₂ has w₀-w₁.
    C₄ = u₀-u₁-w₁-w₀-u₀. -/
theorem c4free_parallel_cross_edge_forbidden (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u0 u1 w0 w1 : V)
    (hu01 : G.adj u0 u1) (hu1w1 : G.adj u1 w1)
    (hw1w0 : G.adj w1 w0) (hw0u0 : G.adj w0 u0)
    (hne_u0u1 : u0 ≠ u1) (hne_u1w1 : u1 ≠ w1)
    (hne_w1w0 : w1 ≠ w0) (hne_w0u0 : w0 ≠ u0)
    (hne_u0w1 : u0 ≠ w1) (hne_u1w0 : u1 ≠ w0)
    : False := by
  -- C₄: u0-u1-w1-w0-u0. hC4 u0 u1 w1 w0.
  -- Ne1: u0≠u1 = hne_u0u1
  -- Ne2: u1≠w1 = hne_u1w1
  -- Ne3: w1≠w0 = hne_w1w0
  -- Ne4: w0≠u0 = hne_w0u0
  -- Ne5: u0≠w1 = hne_u0w1
  -- Ne6: u1≠w0 = hne_u1w0
  -- Adj1: u0-u1 = hu01 ✓
  -- Adj2: u1-w1 = hu1w1 ✓
  -- Adj3: w1-w0 = hw1w0 ✓
  -- Adj4: w0-u0 = hw0u0 ✓
  exact hC4 u0 u1 w1 w0
    hne_u0u1 hne_u1w1 hne_w1w0 hne_w0u0
    hne_u0w1 hne_u1w0
    hu01 hu1w1 hw1w0 hw0u0

/-- Other direction: u₀ adj w₀ ⟹ u₄ NOT adj w₄.
    P₁ has u₄-u₀, P₂ has w₄-w₀.
    C₄ = u₀-u₄-w₄-w₀-u₀. -/
theorem c4free_parallel_cross_edge_forbidden_rev (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u0 u4 w0 w4 : V)
    (hu40 : G.adj u4 u0) (hu4w4 : G.adj u4 w4)
    (hw4w0 : G.adj w4 w0) (hw0u0 : G.adj w0 u0)
    (hne_u0u4 : u0 ≠ u4) (hne_u4w4 : u4 ≠ w4)
    (hne_w4w0 : w4 ≠ w0) (hne_w0u0 : w0 ≠ u0)
    (hne_u0w4 : u0 ≠ w4) (hne_u4w0 : u4 ≠ w0)
    : False := by
  -- C₄: u0-u4-w4-w0-u0. hC4 u0 u4 w4 w0.
  -- Adj1: u0-u4 = adj_symm u4 u0 hu40
  -- Adj2: u4-w4 = hu4w4 ✓
  -- Adj3: w4-w0 = hw4w0 ✓
  -- Adj4: w0-u0 = hw0u0 ✓
  exact hC4 u0 u4 w4 w0
    hne_u0u4 hne_u4w4 hne_w4w0 hne_w0u0
    hne_u0w4 hne_u4w0
    (G.adj_symm u4 u0 hu40) hu4w4 hw4w0 hw0u0

end SimpleGraph
