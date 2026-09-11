/-
  C₄-free K₄-free cubic: forced pentagon extension.

  Given a pentagon (5-cycle) v₀-v₁-v₂-v₃-v₄-v₀ in a cubic
  C₄-free K₄-free graph, each vᵢ has exactly one neighbor
  outside the pentagon (call it wᵢ).

  Constraints on wᵢ:
  1. wᵢ ≠ wⱼ for non-adjacent i,j (else shared neighbor → C₄)
     Actually: if wᵢ = wⱼ for adjacent i,j, say w₀ = w₁,
     then w₀ adj v₀ and w₀ adj v₁, but v₀ adj v₁.
     Triangle {v₀, v₁, w₀}. With v₀ also adj v₄:
     if w₀ adj v₄... need to check.

  Actually the first constraint is simpler:
  wᵢ NOT adj vⱼ for any vⱼ not adjacent to vᵢ in the pentagon,
  else C₄ through the pentagon path.

  Example: w₀ adj v₂ (v₀ and v₂ at distance 2 in pentagon).
  Path in pentagon: v₀-v₁-v₂. Path via w₀: v₀-w₀-v₂.
  Combined: v₀-v₁-v₂-w₀-v₀ is C₄.

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

/-- w₀ adj v₂ forbidden: C₄ = v₀-v₁-v₂-w₀-v₀.
    Pentagon has v₀-v₁-v₂, and w₀ adj v₀. If w₀ adj v₂:
    v₀-v₁-v₂-w₀-v₀ is C₄. -/
theorem c4free_pentagon_ext_w0_not_adj_v2 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v1 v2 w0 : V)
    (h01 : G.adj v0 v1) (h12 : G.adj v1 v2) (h0w : G.adj v0 w0) (hw2 : G.adj w0 v2)
    (hne_01 : v0 ≠ v1) (hne_12 : v1 ≠ v2)
    (hne_0w : v0 ≠ w0) (hne_w2 : w0 ≠ v2)
    (hne_02 : v0 ≠ v2) (hne_1w : v1 ≠ w0)
    : False := by
  -- C₄: v0-v1-v2-w0-v0. hC4 v0 v1 v2 w0.
  -- (a=v0, b=v1, c=v2, d=w0)
  -- Ne1: v0≠v1 = hne_01
  -- Ne2: v1≠v2 = hne_12
  -- Ne3: v2≠w0 = ne_flip hne_w2
  -- Ne4: w0≠v0 = ne_flip hne_0w
  -- Ne5: v0≠v2 = hne_02
  -- Ne6: v1≠w0 = hne_1w
  -- Adj1: G.adj v0 v1 = h01 ✓
  -- Adj2: G.adj v1 v2 = h12 ✓
  -- Adj3: G.adj v2 w0 = adj_symm w0 v2 hw2
  -- Adj4: G.adj w0 v0 = adj_symm v0 w0 h0w
  exact hC4 v0 v1 v2 w0
    hne_01 hne_12 (ne_flip hne_w2) (ne_flip hne_0w)
    hne_02 hne_1w
    h01 h12 (G.adj_symm w0 v2 hw2) (G.adj_symm v0 w0 h0w)

/-- w₀ adj v₃ forbidden: path v₀-v₄-v₃ in pentagon (length 2).
    C₄ = v₀-v₄-v₃-w₀-v₀. -/
theorem c4free_pentagon_ext_w0_not_adj_v3 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v3 v4 w0 : V)
    (h04 : G.adj v0 v4) (h43 : G.adj v4 v3) (h0w : G.adj v0 w0) (hw3 : G.adj w0 v3)
    (hne_04 : v0 ≠ v4) (hne_43 : v4 ≠ v3)
    (hne_0w : v0 ≠ w0) (hne_w3 : w0 ≠ v3)
    (hne_03 : v0 ≠ v3) (hne_4w : v4 ≠ w0)
    : False := by
  -- C₄: v0-v4-v3-w0-v0. hC4 v0 v4 v3 w0.
  -- (a=v0, b=v4, c=v3, d=w0)
  -- Ne1: v0≠v4 = hne_04
  -- Ne2: v4≠v3 = hne_43
  -- Ne3: v3≠w0 = ne_flip hne_w3
  -- Ne4: w0≠v0 = ne_flip hne_0w
  -- Ne5: v0≠v3 = hne_03
  -- Ne6: v4≠w0 = hne_4w
  -- Adj1: G.adj v0 v4 = h04 ✓
  -- Adj2: G.adj v4 v3 = h43 ✓
  -- Adj3: G.adj v3 w0 = adj_symm w0 v3 hw3
  -- Adj4: G.adj w0 v0 = adj_symm v0 w0 h0w
  exact hC4 v0 v4 v3 w0
    hne_04 hne_43 (ne_flip hne_w3) (ne_flip hne_0w)
    hne_03 hne_4w
    h04 h43 (G.adj_symm w0 v3 hw3) (G.adj_symm v0 w0 h0w)

end SimpleGraph
