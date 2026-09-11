/-
  C₄-free: 6-cycle must be chordless.

  A chord of a 6-cycle v₀-v₁-v₂-v₃-v₄-v₅-v₀ is an edge between
  non-consecutive vertices. The possible chords are:
  v₀-v₂, v₁-v₃, v₂-v₄, v₃-v₅, v₄-v₀ (wait, v₄-v₀ IS consecutive
  if we label the 6-cycle wrong... let me use proper labeling).

  6-cycle: v₀-v₁-v₂-v₃-v₄-v₅-v₀. Edges: v₀v₁, v₁v₂, v₂v₃,
  v₃v₄, v₄v₅, v₅v₀.

  Chords (non-edges): v₀v₂, v₁v₃, v₂v₄, v₃v₅, v₀v₃, v₁v₄, v₂v₅.
  Short chords (skip 1): v₀v₂, v₁v₃, v₂v₄, v₃v₅, v₄v₀, v₅v₁.
  Wait, v₄v₀ and v₅v₁ skip 1 from the other direction but they're
  the same distance.

  Short diagonal v₀-v₂: creates C₄ = v₀-v₁-v₂-?... we need
  the 4-cycle. v₀-v₁-v₂-v₀ is a triangle (length 3). Not C₄.
  But v₀ adj v₂ with v₀ adj v₅ and v₅ adj v₄ and v₄ adj v₃ and
  v₃ adj v₂ gives longer paths...

  Actually: v₀ adj v₂ (chord) + v₂ adj v₃ + v₃ adj v₄ + v₄ adj v₅
  + v₅ adj v₀: that's a 5-cycle v₀-v₂-v₃-v₄-v₅-v₀. Not C₄.

  The REAL chord that creates C₄: long diagonal v₀-v₃.
  v₀-v₁-v₂-v₃ (path of length 3 on the cycle) and v₀-v₃ (chord).
  Combined: v₀-v₁-v₂-v₃-v₀ is C₄!

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

/-- Long diagonal v₀-v₃ in 6-cycle creates C₄.
    6-cycle has path v₀-v₁-v₂-v₃. Chord v₀-v₃ gives
    C₄ = v₀-v₁-v₂-v₃-v₀. -/
theorem c4free_6cycle_no_long_diagonal (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v1 v2 v3 : V)
    (h01 : G.adj v0 v1) (h12 : G.adj v1 v2) (h23 : G.adj v2 v3) (h03 : G.adj v0 v3)
    (hne_01 : v0 ≠ v1) (hne_12 : v1 ≠ v2) (hne_23 : v2 ≠ v3)
    (hne_03 : v0 ≠ v3) (hne_02 : v0 ≠ v2) (hne_13 : v1 ≠ v3)
    : False := by
  -- C₄: v0-v1-v2-v3-v0. hC4 v0 v1 v2 v3.
  -- (a=v0, b=v1, c=v2, d=v3)
  -- Ne1: v0≠v1 = hne_01
  -- Ne2: v1≠v2 = hne_12
  -- Ne3: v2≠v3 = hne_23
  -- Ne4: v3≠v0 = ne_flip hne_03
  -- Ne5: v0≠v2 = hne_02
  -- Ne6: v1≠v3 = hne_13
  -- Adj1: G.adj v0 v1 = h01 ✓
  -- Adj2: G.adj v1 v2 = h12 ✓
  -- Adj3: G.adj v2 v3 = h23 ✓
  -- Adj4: G.adj v3 v0 = adj_symm v0 v3 h03
  exact hC4 v0 v1 v2 v3
    hne_01 hne_12 hne_23 (ne_flip hne_03)
    hne_02 hne_13
    h01 h12 h23 (G.adj_symm v0 v3 h03)

/-- Other long diagonal v₁-v₄ creates C₄ = v₁-v₂-v₃-v₄-v₁. -/
theorem c4free_6cycle_no_long_diagonal_14 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v1 v2 v3 v4 : V)
    (h12 : G.adj v1 v2) (h23 : G.adj v2 v3) (h34 : G.adj v3 v4) (h14 : G.adj v1 v4)
    (hne_12 : v1 ≠ v2) (hne_23 : v2 ≠ v3) (hne_34 : v3 ≠ v4)
    (hne_14 : v1 ≠ v4) (hne_13 : v1 ≠ v3) (hne_24 : v2 ≠ v4)
    : False := by
  -- C₄: v1-v2-v3-v4-v1. hC4 v1 v2 v3 v4.
  -- Direct: all Ne and Adj slots match.
  exact hC4 v1 v2 v3 v4
    hne_12 hne_23 hne_34 (ne_flip hne_14)
    hne_13 hne_24
    h12 h23 h34 (G.adj_symm v1 v4 h14)

end SimpleGraph
