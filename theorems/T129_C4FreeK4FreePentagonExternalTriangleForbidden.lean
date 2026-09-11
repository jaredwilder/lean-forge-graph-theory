/-
  C₄-free: pentagon external vertex cannot form a triangle
  with two consecutive pentagon vertices through their external edges.

  Pentagon P = (v₀,v₁,v₂,v₃,v₄). External neighbors wᵢ.
  From T115: w₀ NOT adj w₁ (consecutive ext nbrs).
  From T120: w₀ ≠ w₂, w₀ ≠ w₃ (skip common ext nbrs create C₄).

  NEW: can w₀ adj v₁? (External neighbor of v₀ adjacent to
  the NEXT pentagon vertex.)
  If w₀ adj v₁: path v₀-w₀-v₁ has length 2. Also v₀-v₁ has length 1.
  Triangle v₀-w₀-v₁. Length 3. Not C₄.

  Can w₀ adj v₁ in a C₄-FREE graph? Yes, a single such adjacency
  doesn't create C₄. But it creates a TRIANGLE (v₀,w₀,v₁).

  In TRIANGLE-FREE (girth ≥ 4): w₀ NOT adj v₁.
  In girth ≥ 5: w₀ NOT adj v₁ (since v₀-w₀-v₁ would be length 2,
  v₁-v₀ length 1, cycle v₀-w₀-v₁-v₀ length 3 < girth 5). ✗

  So in girth 5: w₀ NOT adj v₁ is automatic (no triangle).
  No explicit C₄-free proof needed — it's a girth constraint.

  What IS a C₄ constraint: w₀ adj w₂.
  If w₀ adj w₂: consider v₀-w₀-w₂-v₂. And v₀-v₁-v₂ (length 2).
  Two paths from v₀ to v₂ of length 2 (v₀-w₀-w₂-v₂ is length 3,
  not 2). Not C₄.

  Better: w₀ adj w₂ with v₂ adj w₂ and v₀ adj w₀.
  Is there a common neighbor structure?
  v₁ adj v₀ and v₁ adj v₂. So v₁ is a common neighbor of v₀,v₂.
  w₀ adj v₀ (external). If w₀ also adj v₂: that's T120 (forbidden).
  w₂ adj v₂ (external). If w₂ also adj v₀: that's T120 (forbidden).

  What if w₀ adj w₂ (neither touches the other's pentagon vertex)?
  v₀-w₀-w₂-v₂ is a path of length 3. Combined with v₀-v₁-v₂
  (length 2): total cycle v₀-w₀-w₂-v₂-v₁-v₀ has length 5 (pentagon).
  Not C₄.

  So w₀ adj w₂ creates a SECOND pentagon, sharing edge v₀-v₁ with P!
  Wait: (v₀,w₀,w₂,v₂,v₁) is a pentagon. It shares v₀-v₁ with P if
  the last edge is v₁-v₀. Check: v₀-w₀-w₂-v₂-v₁-v₀. Edges:
  v₀-w₀, w₀-w₂, w₂-v₂, v₂-v₁, v₁-v₀. YES, it shares edge v₁-v₀
  (= v₀-v₁) with P. By T126 pigeonhole argument: shared edge → 8-cycle!

  But this is structural reasoning. Let me formalize a direct C₄.

  Actually: the simplest new C₄ from pentagon externals:
  If w₀ = w₃ (not just adjacent, but EQUAL — already in T120).
  If w₀ adj w₃ (adjacent, not equal):
  v₀-w₀-w₃-v₃-v₄-v₀ is a 5-cycle. Creates second pentagon sharing
  edge v₄-v₀ with P. But no C₄.

  The C₄-free pentagon constraints are already well-covered.
  Let me formalize a NEW structure instead.

  NEW: external neighbor reaching two hops into pentagon.
  w₀ adj v₂ is forbidden by T099 (skip-two).
  w₀ adj v₃ is forbidden by T099 (skip-three, other direction).

  What about w₀'s OWN neighbors (layer 3 from v₀)?
  w₀ has degree 3: one edge to v₀, two to new vertices x₀, y₀.
  If x₀ adj v₂: C₄ = v₀-w₀-x₀-v₂-v₁-v₀ is 5-cycle. Not C₄.
  If x₀ adj v₁: C₄ = v₀-w₀-x₀-v₁-v₀ is 4 vertices. C₄!

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

/-- Depth-2 from external: x₀ (neighbor of w₀) NOT adj v₁.
    C₄ = v₀-w₀-x₀-v₁-v₀.
    Edges: v₀-w₀ (external), w₀-x₀ (depth-2), x₀-v₁ (cross), v₁-v₀ (pentagon). -/
theorem c4free_ext_depth2_not_adj_next (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v1 w0 x0 : V)
    (hv0w0 : G.adj v0 w0) (hw0x0 : G.adj w0 x0)
    (hx0v1 : G.adj x0 v1) (hv1v0 : G.adj v1 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0x0 : w0 ≠ x0)
    (hne_x0v1 : x0 ≠ v1) (hne_v1v0 : v1 ≠ v0)
    (hne_v0x0 : v0 ≠ x0) (hne_w0v1 : w0 ≠ v1)
    : False := by
  -- C₄: v0-w0-x0-v1-v0. hC4 v0 w0 x0 v1.
  exact hC4 v0 w0 x0 v1
    hne_v0w0 hne_w0x0 hne_x0v1 hne_v1v0
    hne_v0x0 hne_w0v1
    hv0w0 hw0x0 hx0v1 hv1v0

/-- Symmetric: x₀ NOT adj v₄ (other neighbor of v₀ on pentagon).
    C₄ = v₀-w₀-x₀-v₄-v₀.
    Edges: v₀-w₀, w₀-x₀, x₀-v₄, v₄-v₀ (pentagon). -/
theorem c4free_ext_depth2_not_adj_prev (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v4 w0 x0 : V)
    (hv0w0 : G.adj v0 w0) (hw0x0 : G.adj w0 x0)
    (hx0v4 : G.adj x0 v4) (hv4v0 : G.adj v4 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0x0 : w0 ≠ x0)
    (hne_x0v4 : x0 ≠ v4) (hne_v4v0 : v4 ≠ v0)
    (hne_v0x0 : v0 ≠ x0) (hne_w0v4 : w0 ≠ v4)
    : False := by
  exact hC4 v0 w0 x0 v4
    hne_v0w0 hne_w0x0 hne_x0v4 hne_v4v0
    hne_v0x0 hne_w0v4
    hv0w0 hw0x0 hx0v4 hv4v0

end SimpleGraph
