/-
  C₄-free: hexagon external constraints.

  A hexagon H = (v₀,v₁,v₂,v₃,v₄,v₅) in a cubic C₄-free graph.
  Each vertex has one external neighbor wᵢ.

  Constraint: w₀ NOT adj v₂ (skip-two).
  If w₀ adj v₂: C₄ = v₀-w₀-v₂-v₁-v₀.
  Edges: v₀-w₀, w₀-v₂, v₂-v₁ (hex), v₁-v₀ (hex). C₄!

  Constraint: w₀ NOT adj v₅ (other skip-one, wrapping).
  If w₀ adj v₅: C₄ = v₀-w₀-v₅-... wait, v₅ adj v₀ (hex).
  C₄ = v₀-w₀-v₅-... can't close in 4 without going through v₀.
  Actually: v₀-w₀-v₅-v₀ is only 3 vertices (triangle). Not C₄.
  Need: w₀ adj v₅ to close as C₄, need 4 distinct.
  v₀, w₀, v₅ are 3 distinct. The 4th? v₀ adj v₅ (hex) and
  w₀ adj v₅ and w₀ adj v₀. That's a TRIANGLE, not C₄. Skip.

  Better constraint: w₀ adj v₃ (opposite vertex).
  C₄ = v₀-w₀-v₃-v₂-v₁-v₀? That's 5 edges (C₅). Not C₄.
  C₄ = v₀-w₀-v₃-v₄-v₅-v₀? Also C₅. Not C₄.

  So for hexagons, only skip-two creates C₄.
  w₀ NOT adj v₂: C₄ = v₀-w₀-v₂-v₁-v₀.
  w₀ NOT adj v₄: C₄ = v₀-w₀-v₄-v₅-v₀.

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

/-- w₀ NOT adj v₂ in hexagon: skip-two external reach.
    C₄ = v₀-w₀-v₂-v₁-v₀. -/
theorem c4free_hex_ext_skip2 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v1 v2 w0 : V)
    (hv0w0 : G.adj v0 w0) (hw0v2 : G.adj w0 v2)
    (hv2v1 : G.adj v2 v1) (hv1v0 : G.adj v1 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0v2 : w0 ≠ v2)
    (hne_v2v1 : v2 ≠ v1) (hne_v1v0 : v1 ≠ v0)
    (hne_v0v2 : v0 ≠ v2) (hne_w0v1 : w0 ≠ v1)
    : False := by
  exact hC4 v0 w0 v2 v1
    hne_v0w0 hne_w0v2 hne_v2v1 hne_v1v0
    hne_v0v2 hne_w0v1
    hv0w0 hw0v2 hv2v1 hv1v0

/-- w₀ NOT adj v₄: other skip-two direction.
    C₄ = v₀-w₀-v₄-v₅-v₀.
    Edges: v₀-w₀, w₀-v₄, v₄-v₅ (hex), v₅-v₀ (hex). -/
theorem c4free_hex_ext_skip2_rev (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v4 v5 w0 : V)
    (hv0w0 : G.adj v0 w0) (hw0v4 : G.adj w0 v4)
    (hv4v5 : G.adj v4 v5) (hv5v0 : G.adj v5 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0v4 : w0 ≠ v4)
    (hne_v4v5 : v4 ≠ v5) (hne_v5v0 : v5 ≠ v0)
    (hne_v0v4 : v0 ≠ v4) (hne_w0v5 : w0 ≠ v5)
    : False := by
  exact hC4 v0 w0 v4 v5
    hne_v0w0 hne_w0v4 hne_v4v5 hne_v5v0
    hne_v0v4 hne_w0v5
    hv0w0 hw0v4 hv4v5 hv5v0

end SimpleGraph
