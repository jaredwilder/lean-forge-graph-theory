/-
  C₄-free: pentagon chord spacing constraint.

  A pentagon P = (v₀,v₁,v₂,v₃,v₄) with edges v₀-v₁, v₁-v₂,
  v₂-v₃, v₃-v₄, v₄-v₀.

  Chords: edges between non-consecutive vertices.
  In C₅ there are 5 possible chords: v₀-v₂, v₁-v₃, v₂-v₄, v₃-v₀, v₄-v₁.

  C₄-free constraint on chords:
  - v₀-v₂ chord: C₄ = v₀-v₁-v₂-v₀? No, only 3 vertices.
    C₄ needs 4 distinct vertices. v₀-v₁-v₂-v₀ is a triangle.
    So a single chord v₀-v₂ creates a TRIANGLE, not C₄.

  - TWO chords: v₀-v₂ AND v₁-v₃.
    C₄ = v₀-v₂-v₃-v₁-v₀? Wait, need v₁ adj v₀ (yes, from P).
    Edges: v₀-v₂ (chord), v₂-v₃ (P), v₃-v₁ (chord), v₁-v₀ (P).
    4 distinct vertices: v₀,v₂,v₃,v₁. YES, C₄!

  So: two ADJACENT chords in a pentagon → C₄.
  Adjacent chords = chords that share an endpoint on the pentagon.
  v₀-v₂ and v₁-v₃ share the pentagon arc v₁-v₂ between them,
  creating C₄ from the two chords + two pentagon edges.

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

/-- Two adjacent chords in a pentagon → C₄.
    Pentagon has v₀-v₁-v₂-v₃-v₄-v₀.
    Chord v₀-v₂ and chord v₁-v₃.
    C₄ = v₀-v₂-v₃-v₁-v₀.
    Edges: v₀-v₂ (chord), v₂-v₃ (pentagon), v₃-v₁ (chord), v₁-v₀ (pentagon). -/
theorem c4free_two_adj_chords_pentagon (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v1 v2 v3 : V)
    (hv02 : G.adj v0 v2) (hv23 : G.adj v2 v3)
    (hv31 : G.adj v3 v1) (hv10 : G.adj v1 v0)
    (hne_v0v2 : v0 ≠ v2) (hne_v2v3 : v2 ≠ v3)
    (hne_v3v1 : v3 ≠ v1) (hne_v1v0 : v1 ≠ v0)
    (hne_v0v3 : v0 ≠ v3) (hne_v2v1 : v2 ≠ v1)
    : False := by
  -- C₄: v0-v2-v3-v1-v0. hC4 v0 v2 v3 v1.
  -- Ne1: v0≠v2 = hne_v0v2
  -- Ne2: v2≠v3 = hne_v2v3
  -- Ne3: v3≠v1 = hne_v3v1
  -- Ne4: v1≠v0 = hne_v1v0
  -- Ne5: v0≠v3 = hne_v0v3
  -- Ne6: v2≠v1 = hne_v2v1
  -- Adj1: v0-v2 = hv02 ✓
  -- Adj2: v2-v3 = hv23 ✓
  -- Adj3: v3-v1 = hv31 ✓
  -- Adj4: v1-v0 = hv10 ✓
  exact hC4 v0 v2 v3 v1
    hne_v0v2 hne_v2v3 hne_v3v1 hne_v1v0
    hne_v0v3 hne_v2v1
    hv02 hv23 hv31 hv10

/-- Other pair: chord v₂-v₄ and chord v₃-v₀.
    C₄ = v₂-v₄-v₀-v₃-v₂.
    Edges: v₂-v₄ (chord), v₄-v₀ (pentagon), v₀-v₃ (chord), v₃-v₂ (pentagon). -/
theorem c4free_two_adj_chords_pentagon_24_30 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v0 v2 v3 v4 : V)
    (hv24 : G.adj v2 v4) (hv40 : G.adj v4 v0)
    (hv03 : G.adj v0 v3) (hv32 : G.adj v3 v2)
    (hne_v2v4 : v2 ≠ v4) (hne_v4v0 : v4 ≠ v0)
    (hne_v0v3 : v0 ≠ v3) (hne_v3v2 : v3 ≠ v2)
    (hne_v2v0 : v2 ≠ v0) (hne_v4v3 : v4 ≠ v3)
    : False := by
  -- C₄: v2-v4-v0-v3-v2. hC4 v2 v4 v0 v3.
  exact hC4 v2 v4 v0 v3
    hne_v2v4 hne_v4v0 hne_v0v3 hne_v3v2
    hne_v2v0 hne_v4v3
    hv24 hv40 hv03 hv32

end SimpleGraph
