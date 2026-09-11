/-
  C₄-free K₄-free cubic: pentagon neighbor independence.

  For a pentagon P = (v₀,v₁,v₂,v₃,v₄) in a cubic graph,
  each vertex has one edge NOT on the pentagon (the "external" edge).
  Let wᵢ be the external neighbor of vᵢ.

  Constraint: wᵢ NOT adj vⱼ for non-adjacent j.
  Already: wᵢ NOT adj vᵢ₊₂ and wᵢ NOT adj vᵢ₋₂ (T099).

  NEW: w₀ NOT adj w₁ (consecutive external neighbors not adjacent).
  If w₀ adj w₁: C₄ = v₀-w₀-w₁-v₁-v₀.
  Edges: v₀-w₀ (external), w₀-w₁ (new), w₁-v₁ (external), v₁-v₀ (pentagon).
  4 distinct vertices (w₀,w₁ are external, v₀,v₁ on pentagon). C₄!

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

/-- w₀ NOT adj w₁: external neighbors of consecutive pentagon vertices.
    C₄ = v₀-w₀-w₁-v₁-v₀.
    Edges: v₀-w₀, w₀-w₁, w₁-v₁, v₁-v₀. -/
theorem c4free_pentagon_ext_nbrs_not_adj (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v1 w0 w1 : V)
    (hv0w0 : G.adj v0 w0) (hw0w1 : G.adj w0 w1)
    (hw1v1 : G.adj w1 v1) (hv1v0 : G.adj v1 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0w1 : w0 ≠ w1)
    (hne_w1v1 : w1 ≠ v1) (hne_v1v0 : v1 ≠ v0)
    (hne_v0w1 : v0 ≠ w1) (hne_w0v1 : w0 ≠ v1)
    : False := by
  -- C₄: v0-w0-w1-v1-v0. hC4 v0 w0 w1 v1.
  exact hC4 v0 w0 w1 v1
    hne_v0w0 hne_w0w1 hne_w1v1 hne_v1v0
    hne_v0w1 hne_w0v1
    hv0w0 hw0w1 hw1v1 hv1v0

/-- w₄ NOT adj w₀: wrapping around the pentagon.
    C₄ = v₀-w₀-w₄-v₄-v₀.
    Edges: v₀-w₀, w₀-w₄, w₄-v₄, v₄-v₀. -/
theorem c4free_pentagon_ext_nbrs_not_adj_wrap (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v4 w0 w4 : V)
    (hv0w0 : G.adj v0 w0) (hw0w4 : G.adj w0 w4)
    (hw4v4 : G.adj w4 v4) (hv4v0 : G.adj v4 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0w4 : w0 ≠ w4)
    (hne_w4v4 : w4 ≠ v4) (hne_v4v0 : v4 ≠ v0)
    (hne_v0w4 : v0 ≠ w4) (hne_w0v4 : w0 ≠ v4)
    : False := by
  -- C₄: v0-w0-w4-v4-v0. hC4 v0 w0 w4 v4.
  exact hC4 v0 w0 w4 v4
    hne_v0w0 hne_w0w4 hne_w4v4 hne_v4v0
    hne_v0w4 hne_w0v4
    hv0w0 hw0w4 hw4v4 hv4v0

end SimpleGraph
