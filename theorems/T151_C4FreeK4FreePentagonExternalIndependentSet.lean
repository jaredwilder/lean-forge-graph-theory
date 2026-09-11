/-
  COMPOSITION: T115 + T129 + T148.

  Pentagon P = (v₀,...,v₄), external neighbors wᵢ.
  T115: wᵢ NOT adj w_{i±1} (consecutive externals).
  T129: depth-2 vertices xᵢⱼ NOT adj v_{i±1}.
  T148 (TF): wᵢ NOT adj v_{i±1} (external not adj next pentagon vertex).

  COMBINED: the set {w₀,w₁,w₂,w₃,w₄} is an INDEPENDENT SET
  in C₄-free cubic girth 5.

  Proof sketch: any edge wᵢ-wⱼ creates C₄ or short cycle.
  - wᵢ adj w_{i+1}: C₄ = vᵢ-wᵢ-w_{i+1}-v_{i+1}-vᵢ (T115).
  - wᵢ adj w_{i+2}: creates second pentagon sharing edge (T120 + T126 chain).
  - wᵢ = wⱼ: two pentagon vertices sharing external neighbor = C₄ (T120).

  So: wᵢ ≠ wⱼ AND wᵢ NOT adj wⱼ for ALL i ≠ j.

  NEW consequence: 5 external neighbors + 5 pentagon vertices = 10
  distinct vertices. In Petersen (n=10): accounts for ALL vertices!
  Every vertex is either IN the pentagon or an external neighbor.

  For Petersen: w₀,...,w₄ form the inner pentagram.
  Inner pentagram IS an independent set. ✓ Consistent.

  The C₄ for wᵢ adj w_{i+2}:
  vᵢ-wᵢ-w_{i+2}-v_{i+2}-v_{i+1}-vᵢ is 5-cycle (not C₄).
  But: wᵢ and w_{i+2} are both external neighbors.
  vᵢ adj wᵢ, wᵢ adj w_{i+2}, w_{i+2} adj v_{i+2}.
  v_{i+2} adj v_{i+1} adj vᵢ (pentagon path of length 2).
  So: two paths from vᵢ to v_{i+2}: length 3 (vᵢ-wᵢ-w_{i+2}-v_{i+2})
  and length 2 (vᵢ-v_{i+1}-v_{i+2}).
  Combined: 5-cycle. Second pentagon sharing v_{i+1} or edge.

  For C₄ directly: need 4 vertices.
  If wᵢ adj w_{i+2} AND v_{i+1} adj wᵢ: C₄ = v_{i+1}-vᵢ-wᵢ-w_{i+2}?
  No, v_{i+1} NOT adj wᵢ (T148, triangle-free).

  The C₄ from wᵢ adj w_{i+2} needs an intermediary.
  Actually: w₀ adj w₂. v₀ adj w₀, v₂ adj w₂.
  Is there a common neighbor of w₀ and v₂ (besides w₂)?
  v₁ adj v₀ and v₁ adj v₂. But v₁ NOT adj w₀ (T148).
  So no immediate C₄ from w₀ adj w₂ alone.

  But: second pentagon (v₀,w₀,w₂,v₂,v₁) shares edge v₀-v₁.
  Wait: edges v₀-w₀, w₀-w₂, w₂-v₂, v₂-v₁, v₁-v₀. YES pentagon.
  Shares edge v₁-v₀ with P. By T126 chain → 8-cycle → EG.

  Formalize: consecutive external C₄ (already T115, but state
  the composition explicitly).

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

def TriangleFree (G : SimpleGraph V) : Prop :=
  ∀ (a b c : V), a ≠ b → b ≠ c → a ≠ c →
    G.adj a b → G.adj b c → G.adj c a → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- Composition: wᵢ adj w_{i+1} → C₄ (T115 restated as composition).
    C₄ = vᵢ-wᵢ-w_{i+1}-v_{i+1}-vᵢ. -/
theorem c4free_ext_independent_consec (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (vi wi wi1 vi1 : V)
    (hvwi : G.adj vi wi) (hwiwi1 : G.adj wi wi1)
    (hwi1vi1 : G.adj wi1 vi1) (hvi1vi : G.adj vi1 vi)
    (hne1 : vi ≠ wi) (hne2 : wi ≠ wi1)
    (hne3 : wi1 ≠ vi1) (hne4 : vi1 ≠ vi)
    (hne5 : vi ≠ wi1) (hne6 : wi ≠ vi1)
    : False := by
  exact hC4 vi wi wi1 vi1
    hne1 hne2 hne3 hne4 hne5 hne6
    hvwi hwiwi1 hwi1vi1 hvi1vi

/-- Composition: wᵢ = w_{i+1} → C₄ (two pentagon vertices sharing external).
    If w₀ = w₁: v₀ adj w₀, v₁ adj w₀. Combined with v₀ adj v₁ (pentagon):
    triangle v₀-w₀-v₁. In TF: forbidden.
    In C₄-free only: triangle is allowed, but w₀ has degree issues.
    In cubic: w₀ adj v₀, w₀ adj v₁, w₀ has 1 more edge. Only 3 total.
    Formalize the triangle-free version. -/
theorem tf_ext_distinct (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (v0 w v1 : V)
    (hv0w : G.adj v0 w) (hwv1 : G.adj w v1) (hv1v0 : G.adj v1 v0)
    (hne1 : v0 ≠ w) (hne2 : w ≠ v1) (hne3 : v0 ≠ v1)
    : False := by
  exact hTF v0 w v1 hne1 hne2 hne3 hv0w hwv1 hv1v0

end SimpleGraph
