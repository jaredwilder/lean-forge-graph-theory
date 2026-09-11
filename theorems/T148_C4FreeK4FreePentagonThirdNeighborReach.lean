/-
  C₄-free cubic girth 5: pentagon vertex third-neighbor reach constraints.

  Pentagon P = (v₀,v₁,v₂,v₃,v₄). Each vᵢ is cubic, 2 edges in P,
  1 external edge to wᵢ.

  wᵢ is cubic: edge to vᵢ, plus 2 edges to new vertices xᵢ₁, xᵢ₂.

  From T129: xᵢⱼ NOT adj to v_{i±1} (adjacent pentagon vertex).
  From T115: wᵢ NOT adj w_{i±1} (consecutive external neighbors).
  From T120: wᵢ ≠ w_{i±2}, wᵢ ≠ w_{i±3} (skip common).

  NEW: can xᵢⱼ be adjacent to w_{i+1}?
  If x₀₁ adj w₁: path v₀-w₀-x₀₁-w₁-v₁. Length 4.
  Also v₀-v₁ is direct edge (pentagon).
  v₀-w₀-x₀₁-w₁-v₁-v₀ is a 5-cycle (pentagon!). Not C₄.

  But: v₀ adj w₀, w₀ adj x₀₁, x₀₁ adj w₁, w₁ adj v₁, v₁ adj v₀.
  The cycle v₀-w₀-x₀₁-w₁-v₁-v₀ has 5 vertices. Pentagon.
  Shares edge v₀-v₁ with P. By T126 reduction → 8-cycle.

  No, T126 says two pentagons sharing a VERTEX in cubic
  must share an edge. They DO share v₀-v₁ (edge). So the
  symdiff = 5+5-2 = 8. 8-cycle exists!

  But this means the graph has EG (8 = 2³).
  So: if x₀₁ adj w₁, EG is satisfied.
  The question is whether this MUST happen.

  For C₄-free alone: what if x₀₁ adj w₂ (skip-one)?
  v₀-w₀-x₀₁-w₂-v₂. Also v₀-v₁-v₂. Two paths from v₀ to v₂.
  Length 4 and length 2. No C₄.
  But: w₀-x₀₁-w₂ has w₀ reaching w₂ through x₀₁ (2 hops).
  Combined with w₀-v₀-v₁-v₂-w₂ (4 hops through pentagon).
  Cycle: w₀-x₀₁-w₂-v₂-v₁-v₀-w₀. Length 6. Hexagon.

  What about x₀₁ adj x₁₁ (depth-2 vertices from adjacent pentagon
  vertices)?
  v₀-w₀-x₀₁-x₁₁-w₁-v₁-v₀. Length 6. Hexagon.
  If also x₀₁ adj v₁: C₄ = v₀-w₀-x₀₁-v₁-v₀. Already T129.

  So the NEW C₄ structure:
  If x₀₁ = x₁₁ (same vertex at depth 2 from both w₀ and w₁):
  C₄ = w₀-x₀₁-w₁? Only 3 vertices (w₀, x₀₁=x₁₁, w₁). Triangle.
  In girth 5: triangle forbidden. So x₀₁ ≠ x₁₁ (automatically).

  If x₀₁ = w₁: then w₀ adj w₁. Already T115 (forbidden).

  So FORMAL C₄ from L3 common target:
  x₀₁ and x₁₁ both reach some vertex z.
  C₄ = w₀-x₀₁-z-x₁₁-w₁ is 5 vertices. Not C₄.
  C₄ from w₀ and w₁: both adj to some vertex q.
  v₀-w₀-q-w₁-v₁-v₀ is 5 vertices. Pentagon.
  Wait: C₄ = w₀-q-w₁-v₁? Need v₁ adj w₀. But w₀ is v₀'s external,
  and v₁ adj v₀ (pentagon). If w₀ adj v₁: triangle v₀-w₀-v₁.
  In girth 5: forbidden.

  Authority: FULL_FORMALIZATION — depth-2 pentagon external reach.
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

def TriangleFree (G : SimpleGraph V) : Prop :=
  ∀ (a b c : V), a ≠ b → b ≠ c → a ≠ c →
    G.adj a b → G.adj b c → G.adj c a → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- In girth ≥ 4: w₀ NOT adj v₁ (would create triangle v₀-w₀-v₁).
    Triangle = v₀-w₀-v₁-v₀. -/
theorem tf_external_not_adj_next (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (v0 w0 v1 : V)
    (hv0w0 : G.adj v0 w0) (hw0v1 : G.adj w0 v1) (hv1v0 : G.adj v1 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0v1 : w0 ≠ v1) (hne_v0v1 : v0 ≠ v1)
    : False := by
  exact hTF v0 w0 v1
    hne_v0w0 hne_w0v1 hne_v0v1
    hv0w0 hw0v1 hv1v0

/-- In girth ≥ 4: x₀₁ = w₁ implies w₀ adj w₁ → triangle w₀-w₁-v₁?
    No. w₀ adj x₀₁ = w₁. w₁ adj v₁. Is w₀ adj v₁?
    Not necessarily. But: v₀-w₀-w₁-v₁-v₀ is 4-cycle!
    C₄ = v₀-w₀-w₁-v₁-v₀. -/
theorem c4free_x01_eq_w1 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 w0 w1 v1 : V)
    (hv0w0 : G.adj v0 w0) (hw0w1 : G.adj w0 w1)
    (hw1v1 : G.adj w1 v1) (hv1v0 : G.adj v1 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0w1 : w0 ≠ w1)
    (hne_w1v1 : w1 ≠ v1) (hne_v1v0 : v1 ≠ v0)
    (hne_v0w1 : v0 ≠ w1) (hne_w0v1 : w0 ≠ v1)
    : False := by
  exact hC4 v0 w0 w1 v1
    hne_v0w0 hne_w0w1 hne_w1v1 hne_v1v0
    hne_v0w1 hne_w0v1
    hv0w0 hw0w1 hw1v1 hv1v0

end SimpleGraph
