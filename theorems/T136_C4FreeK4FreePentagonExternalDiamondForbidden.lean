/-
  C₄-free: pentagon external "diamond" pattern forbidden.

  Pentagon P = (v₀,v₁,v₂,v₃,v₄). External neighbors wᵢ of vᵢ.

  A "diamond" is K₄ minus an edge = two triangles sharing an edge.
  In C₄-free: K₄ is forbidden (K₄ contains 3 copies of C₄).
  But diamond = K₄⁻ needs checking separately.

  Diamond on {a,b,c,d}: edges ab,ac,ad,bc,bd but NOT cd.
  C₄ in diamond: a-c-b-d-a. 4 vertices, edges a-c,c-b,b-d,d-a. YES.
  So diamond contains C₄. Diamond is FORBIDDEN in C₄-free.

  More concretely for pentagon externals:
  If w₀ adj w₁ and both adj to some vertex z:
  w₀-z-w₁ and w₀-w₁ create a triangle.
  Plus w₀-v₀-v₁-w₁ is a path of length 3.
  w₀ adj w₁ means path w₀-w₁ (length 1).
  Cycle: w₀-v₀-v₁-w₁-w₀ (length 4). C₄!

  Wait — that's simpler. Just w₀ adj w₁ already creates C₄
  (which is already T115). The diamond adds nothing beyond that.

  So let me formalize the K₄⁻ (diamond) containment of C₄ instead.
  This is a fundamental structural result.

  Diamond = {a,b,c,d} with all edges EXCEPT c-d.
  C₄ = a-c-b-d-a.
  Ne: a≠c, c≠b, b≠d, d≠a, a≠b, c≠d.
  Adj: a-c, c-b, b-d, d-a.

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

/-- K₄⁻ (diamond) contains C₄.
    Diamond {a,b,c,d}: all edges except c-d.
    C₄ = a-c-b-d-a. -/
theorem c4free_forbids_diamond (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c d : V)
    (hac : G.adj a c) (hcb : G.adj c b)
    (hbd : G.adj b d) (hda : G.adj d a)
    (hne_ac : a ≠ c) (hne_cb : c ≠ b)
    (hne_bd : b ≠ d) (hne_da : d ≠ a)
    (hne_ab : a ≠ b) (hne_cd : c ≠ d)
    : False := by
  -- C₄: a-c-b-d-a. hC4 a c b d.
  exact hC4 a c b d
    hne_ac hne_cb hne_bd hne_da
    hne_ab hne_cd
    hac hcb hbd hda

/-- K₄ contains C₄ (trivially, since K₄ ⊃ K₄⁻).
    K₄ = {a,b,c,d} with ALL 6 edges.
    Same C₄ = a-c-b-d-a applies. -/
theorem c4free_forbids_k4 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c d : V)
    (hac : G.adj a c) (hcb : G.adj c b)
    (hbd : G.adj b d) (hda : G.adj d a)
    (_hab : G.adj a b) (_hcd : G.adj c d)
    (hne_ac : a ≠ c) (hne_cb : c ≠ b)
    (hne_bd : b ≠ d) (hne_da : d ≠ a)
    (hne_ab : a ≠ b) (hne_cd : c ≠ d)
    : False := by
  exact hC4 a c b d
    hne_ac hne_cb hne_bd hne_da
    hne_ab hne_cd
    hac hcb hbd hda

end SimpleGraph
