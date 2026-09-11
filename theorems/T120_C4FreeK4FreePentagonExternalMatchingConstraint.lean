/-
  C₄-free cubic girth 5: pentagon external matching constraint.

  Pentagon P = (v₀,v₁,v₂,v₃,v₄). External neighbors: wᵢ = N(vᵢ)\P.
  From T115: consecutive wᵢ are NOT adjacent (w₀ ≠ adj w₁, etc.)
  From T099: wᵢ NOT adj vᵢ₊₂ (skip-two reach forbidden).

  NEW: can wᵢ = wⱼ for non-adjacent i,j on the pentagon?
  If w₀ = w₂: then v₀ adj w₀ and v₂ adj w₀ (= w₂).
  Path v₀-w₀-v₂ has length 2. Path v₀-v₁-v₂ has length 2.
  C₄ = v₀-w₀-v₂-v₁-v₀? Edges: v₀-w₀, w₀-v₂, v₂-v₁, v₁-v₀.
  4 vertices: v₀,w₀,v₂,v₁. Need all distinct. Yes (girth 5, so
  w₀ ∉ {v₀,v₁,v₂,v₃,v₄} since no shorter cycles).
  IS this C₄? v₀-w₀, w₀-v₂, v₂-v₁ (pentagon), v₁-v₀ (pentagon). YES!

  So: w₀ ≠ w₂ (and by symmetry wᵢ ≠ wᵢ₊₂ for all i).

  What about w₀ = w₃? v₀ adj w₀, v₃ adj w₃ = w₀.
  C₄ = v₀-w₀-v₃-v₄-v₀? Edges: v₀-w₀, w₀-v₃, v₃-v₄, v₄-v₀.
  4 distinct vertices. YES, C₄!

  Combined with T115 (w₀ ≠ adj w₁): all 5 external neighbors are
  DISTINCT and pairwise non-adjacent except possibly w₀ adj w₃
  type (non-consecutive, non-skip-two).

  Wait, we just showed w₀ = w₃ creates C₄. What about w₀ ADJ w₃
  (not equal)?
  If w₀ adj w₃: C₄ = v₀-w₀-w₃-v₃-... need to close to v₀.
  v₃-v₄-v₀ is length 2. So path is length 4: v₀-w₀-w₃-v₃ + v₃-v₄-v₀.
  That's 6 vertices, a hexagon. NOT C₄.

  So the equality constraint is the C₄ one. Let me formalize w₀ = w₂.

  If w₀ = w₂ (same vertex): then that vertex is adjacent to both
  v₀ and v₂. C₄ = v₀-w₀-v₂-v₁-v₀.

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

/-- Common external neighbor of skip-two vertices → C₄.
    w adj v₀ and w adj v₂ (pentagon vertices at distance 2).
    C₄ = v₀-w-v₂-v₁-v₀.
    Edges: v₀-w, w-v₂, v₂-v₁ (pentagon), v₁-v₀ (pentagon). -/
theorem c4free_skip_two_common_nbr (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v1 v2 w : V)
    (hv0w : G.adj v0 w) (hwv2 : G.adj w v2)
    (hv2v1 : G.adj v2 v1) (hv1v0 : G.adj v1 v0)
    (hne_v0w : v0 ≠ w) (hne_wv2 : w ≠ v2)
    (hne_v2v1 : v2 ≠ v1) (hne_v1v0 : v1 ≠ v0)
    (hne_v0v2 : v0 ≠ v2) (hne_wv1 : w ≠ v1)
    : False := by
  -- C₄: v0-w-v2-v1-v0. hC4 v0 w v2 v1.
  exact hC4 v0 w v2 v1
    hne_v0w hne_wv2 hne_v2v1 hne_v1v0
    hne_v0v2 hne_wv1
    hv0w hwv2 hv2v1 hv1v0

/-- w adj v₀ and w adj v₃: skip-three.
    C₄ = v₀-w-v₃-v₄-v₀.
    Edges: v₀-w, w-v₃, v₃-v₄ (pentagon), v₄-v₀ (pentagon). -/
theorem c4free_skip_three_common_nbr (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v3 v4 w : V)
    (hv0w : G.adj v0 w) (hwv3 : G.adj w v3)
    (hv3v4 : G.adj v3 v4) (hv4v0 : G.adj v4 v0)
    (hne_v0w : v0 ≠ w) (hne_wv3 : w ≠ v3)
    (hne_v3v4 : v3 ≠ v4) (hne_v4v0 : v4 ≠ v0)
    (hne_v0v3 : v0 ≠ v3) (hne_wv4 : w ≠ v4)
    : False := by
  -- C₄: v0-w-v3-v4-v0. hC4 v0 w v3 v4.
  exact hC4 v0 w v3 v4
    hne_v0w hne_wv3 hne_v3v4 hne_v4v0
    hne_v0v3 hne_wv4
    hv0w hwv3 hv3v4 hv4v0

end SimpleGraph
