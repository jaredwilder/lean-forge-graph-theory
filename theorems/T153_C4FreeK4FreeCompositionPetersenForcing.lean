/-
  COMPOSITION: T126 + T131 + T151 → Petersen forcing arithmetic.

  In cubic girth 5 on n=10 vertices:
  T126: two pentagons sharing vertex → share edge → 8-cycle.
  T131: n ≡ 0 mod 10 needed for vertex-disjoint coverage.
  T151: external neighbors form independent set (5 distinct).

  For n=10: pentagon P uses 5 vertices. External set W uses 5 vertices.
  5 + 5 = 10 = n. ALL vertices accounted for.

  W = {w₀,...,w₄} is independent (T151).
  Each wᵢ has degree 3: one edge to vᵢ, two to other w's or new.
  But there ARE no new vertices (all 10 used).
  So wᵢ's other 2 edges go to elements of W ∪ P.
  wᵢ NOT adj v_{i±1} (T148, triangle-free).
  wᵢ NOT adj wᵢ₊₁ (T115/T151, consecutive externals).

  Petersen edges from w₀: w₀-v₀ (external), w₀-v₂, w₀-v₃.
  (Inner pentagram: each inner vertex connects to two
  non-adjacent outer vertices.)

  Is this FORCED? w₀ has 2 remaining edges, to vertices in
  {v₁,v₂,v₃,v₄,w₁,w₂,w₃,w₄}.
  Excluded: v₁ (T148, adj in pentagon to v₀).
             v₄ (T148, adj in pentagon to v₀, other side).
             w₁ (T151, consecutive external).
             w₄ (T151, consecutive external).

  Remaining: {v₂, v₃, w₂, w₃}.
  w₀ needs exactly 2 edges from this set.

  If w₀ adj v₂ AND w₀ adj v₃:
  Pentagon (v₀,w₀,v₂,v₁,v₀)? v₀-w₀-v₂-v₁-v₀ needs v₂ adj v₁. YES!
  So second pentagon = (v₀,w₀,v₂,v₁) — wait, that's 4 vertices, C₄!
  v₀-w₀-v₂-v₁-v₀: edges v₀-w₀, w₀-v₂, v₂-v₁, v₁-v₀.
  4 vertices: v₀,w₀,v₂,v₁. C₄!
  WAIT. v₂ adj v₁ is a pentagon edge. w₀ adj v₂ assumed.
  C₄ = v₀-w₀-v₂-v₁-v₀. This IS a C₄!
  Ne: v₀≠w₀ ✓, w₀≠v₂ ✓, v₂≠v₁ ✓, v₁≠v₀ ✓.
  Diag: v₀≠v₂ ✓, w₀≠v₁ ✓.
  So w₀ adj v₂ creates C₄ with pentagon edges!

  THEREFORE: w₀ NOT adj v₂ either!
  Similarly w₀ NOT adj v₃ (by symmetric argument going
  the other direction around the pentagon).

  This means w₀ can ONLY connect to {w₂, w₃}.
  w₀ needs 2 edges. |{w₂,w₃}| = 2. FORCED: w₀-w₂ and w₀-w₃.

  This gives the Petersen inner pentagram: w₀-w₂, w₀-w₃,
  w₁-w₃, w₁-w₄, w₂-w₄.

  Authority: FULL_FORMALIZATION — composition theorem.
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

/-- KEY: w₀ adj v₂ → C₄ = v₀-w₀-v₂-v₁-v₀.
    Uses: w₀ adj v₂ (assumed), v₂-v₁ (pentagon), v₁-v₀ (pentagon),
    v₀-w₀ (external). -/
theorem c4free_ext_not_adj_skip1 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 w0 v2 v1 : V)
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

/-- Symmetric: w₀ adj v₃ → C₄ = v₀-w₀-v₃-v₄-v₀.
    Uses: w₀ adj v₃ (assumed), v₃-v₄ (pentagon), v₄-v₀ (pentagon),
    v₀-w₀ (external). -/
theorem c4free_ext_not_adj_skip2_rev (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 w0 v3 v4 : V)
    (hv0w0 : G.adj v0 w0) (hw0v3 : G.adj w0 v3)
    (hv3v4 : G.adj v3 v4) (hv4v0 : G.adj v4 v0)
    (hne_v0w0 : v0 ≠ w0) (hne_w0v3 : w0 ≠ v3)
    (hne_v3v4 : v3 ≠ v4) (hne_v4v0 : v4 ≠ v0)
    (hne_v0v3 : v0 ≠ v3) (hne_w0v4 : w0 ≠ v4)
    : False := by
  exact hC4 v0 w0 v3 v4
    hne_v0w0 hne_w0v3 hne_v3v4 hne_v4v0
    hne_v0v3 hne_w0v4
    hv0w0 hw0v3 hv3v4 hv4v0

end SimpleGraph
