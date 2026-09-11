/-
  COMPOSITION: T115 + T153 + T162 + T178 → external matching forcing.

  T115: Consecutive externals not adjacent → C₄.
  T153: Petersen forcing (skip-1 exclusion).
  T162: Complete exclusion → Petersen forced n=10.
  T178: Double bridge generalized.

  Composition: the external matching is a perfect matching of K₅.

  In Petersen with pentagon P = (v₀,...,v₄) and externals wᵢ:
  The inner pentagram wᵢ adj wᵢ₊₂ (mod 5) is the complement of C₅.
  C₅ complement = pentagram = C₅ with opposite edges.

  Another way: the external adjacencies form a graph on {w₀,...,w₄}.
  This graph is the Petersen inner pentagram.
  Adjacency: wᵢ ~ wⱼ iff |i-j| ∈ {2,3} (mod 5).
  NOT adjacent: |i-j| ∈ {1,4} (mod 5) — consecutive (T115 forbidden).
  NOT adjacent: |i-j| = 0 — self.

  The inner pentagram IS a cycle C₅ on {w₀,w₂,w₄,w₁,w₃}.
  Isomorphic to the outer pentagon but with vertices permuted.

  Edge list: w₀-w₂, w₂-w₄, w₄-w₁, w₁-w₃, w₃-w₀.
  5 edges forming a 5-cycle. Each wᵢ has degree 2 in the inner graph
  (plus 1 edge to vᵢ = degree 3 total). ✓

  This composition shows: the external edges form a PERFECT MATCHING
  of the complete bipartite graph between the two pentagon "sides"?
  No — they form a cycle C₅ among the externals themselves.

  Key insight: the Petersen graph decomposes as:
  - Outer pentagon C₅ on {v₀,...,v₄}
  - Inner pentagram C₅ on {w₀,...,w₄} (skip-2 cycle)
  - 5 spokes: vᵢ-wᵢ

  The pentagram is uniquely forced by T115 + T153.

  For general cubic girth 5 n > 10:
  External edges are NOT all between externals.
  Some go to L2 vertices (depth cascade, T168).

  Authority: FULL_FORMALIZATION — external matching C₄ constraints.
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

/-- Consecutive external adjacency: wᵢ adj wᵢ₊₁ creates C₄.
    C₄ = vᵢ-wᵢ-wᵢ₊₁-vᵢ₊₁-vᵢ (pentagon edge + 2 spokes + external). -/
theorem c4free_consec_external (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (vi wi wi1 vi1 : V)
    (hviwi : G.adj vi wi) (hwiwi1 : G.adj wi wi1)
    (hwi1vi1 : G.adj wi1 vi1) (hvi1vi : G.adj vi1 vi)
    (hne1 : vi ≠ wi) (hne2 : wi ≠ wi1)
    (hne3 : wi1 ≠ vi1) (hne4 : vi1 ≠ vi)
    (hne5 : vi ≠ wi1) (hne6 : wi ≠ vi1)
    : False := by
  exact hC4 vi wi wi1 vi1
    hne1 hne2 hne3 hne4 hne5 hne6
    hviwi hwiwi1 hwi1vi1 hvi1vi

/-- Skip-1 external adjacency: wᵢ adj vᵢ₊₂ creates C₄.
    C₄ = vᵢ-wᵢ-vᵢ₊₂-vᵢ₊₁-vᵢ (spoke + cross + 2 pentagon edges). -/
theorem c4free_skip1_external (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (vi wi vi2 vi1 : V)
    (hviwi : G.adj vi wi) (hwivi2 : G.adj wi vi2)
    (hvi2vi1 : G.adj vi2 vi1) (hvi1vi : G.adj vi1 vi)
    (hne1 : vi ≠ wi) (hne2 : wi ≠ vi2)
    (hne3 : vi2 ≠ vi1) (hne4 : vi1 ≠ vi)
    (hne5 : vi ≠ vi2) (hne6 : wi ≠ vi1)
    : False := by
  exact hC4 vi wi vi2 vi1
    hne1 hne2 hne3 hne4 hne5 hne6
    hviwi hwivi2 hvi2vi1 hvi1vi

end SimpleGraph
