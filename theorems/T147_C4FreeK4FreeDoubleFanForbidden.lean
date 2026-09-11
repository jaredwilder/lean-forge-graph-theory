/-
  C₄-free: double fan (bowtie) structure forbidden.

  A "double fan" or "bowtie" at vertex v:
  Two triangles sharing vertex v but otherwise disjoint.
  T₁ = (v,a,b), T₂ = (v,c,d), with {a,b} ∩ {c,d} = ∅.

  Does this contain C₄?
  Vertices of the bowtie: v,a,b,c,d (5 vertices).
  Edges: v-a, v-b, a-b, v-c, v-d, c-d.

  C₄ candidates with 4 vertices from {v,a,b,c,d}:
  - v,a,b,c: edges v-a,a-b,b-v (back to v),v-c. Path: v-a-b-?-c-v.
    Need b adj c. If b adj c: C₄ = v-a-b-c-v? Check:
    Ne: v≠a ✓, a≠b ✓, b≠c (need), c≠v ✓.
    Diag: v≠b ✓, a≠c ✓.
    Adj: v-a ✓, a-b ✓, b-c (need), c-v ✓.
    YES! If b adj c: C₄ = v-a-b-c-v.

  But the bowtie itself doesn't require b adj c.
  So a bowtie WITHOUT cross edges is NOT forbidden by C₄-free.

  The C₄ arises when ANY cross edge connects the two triangles:
  a adj c → C₄ = v-a-c-d-v? Need all 4 distinct. v≠a ✓, a≠c ✓, c≠d ✓, d≠v ✓.
  Diag: v≠c ✓, a≠d ✓. Adj: v-a ✓, a-c (cross), c-d ✓, d-v ✓. C₄!

  So: if bowtie + ANY cross edge → C₄.
  In cubic: v has degree 3. Bowtie uses ALL 3 edges of v (to a,b,c... wait).
  Bowtie at v: v-a, v-b (triangle 1), v-c, v-d (triangle 2).
  That's FOUR edges from v. But v has degree 3!
  So degree-3 vertex CANNOT have a bowtie. Not enough edges.

  In degree ≥ 4: bowtie possible. Cross edge → C₄.

  For cubic: only ONE triangle through v (using 2 of 3 edges),
  third edge goes to non-triangle neighbor.

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

/-- Bowtie cross edge a-c → C₄ = v-a-c-d-v.
    T₁ = (v,a,b). T₂ = (v,c,d). Cross: a adj c.
    C₄ = v-a-c-d-v.
    Edges: v-a, a-c, c-d, d-v. -/
theorem c4free_bowtie_cross_ac (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c d : V)
    (hva : G.adj v a) (hac : G.adj a c)
    (hcd : G.adj c d) (hdv : G.adj d v)
    (hne_va : v ≠ a) (hne_ac : a ≠ c)
    (hne_cd : c ≠ d) (hne_dv : d ≠ v)
    (hne_vc : v ≠ c) (hne_ad : a ≠ d)
    : False := by
  exact hC4 v a c d
    hne_va hne_ac hne_cd hne_dv
    hne_vc hne_ad
    hva hac hcd hdv

/-- Bowtie cross edge b-c → C₄ = v-b-c-d-v.
    T₁ = (v,a,b). T₂ = (v,c,d). Cross: b adj c.
    C₄ = v-b-c-d-v.
    Edges: v-b, b-c, c-d, d-v. -/
theorem c4free_bowtie_cross_bc (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v b c d : V)
    (hvb : G.adj v b) (hbc : G.adj b c)
    (hcd : G.adj c d) (hdv : G.adj d v)
    (hne_vb : v ≠ b) (hne_bc : b ≠ c)
    (hne_cd : c ≠ d) (hne_dv : d ≠ v)
    (hne_vc : v ≠ c) (hne_bd : b ≠ d)
    : False := by
  exact hC4 v b c d
    hne_vb hne_bc hne_cd hne_dv
    hne_vc hne_bd
    hvb hbc hcd hdv

end SimpleGraph
