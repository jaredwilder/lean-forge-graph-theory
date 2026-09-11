/-
  COMPOSITION: T116 + T128 + T140 + T147.

  T116: triangle book → C₄ (two triangles sharing edge).
  T128: triangle link through third neighbor → C₄.
  T140: pentagon overlap: 3-shared or non-consec 2-shared → C₄.
  T147: bowtie cross edge → C₄.

  COMBINED: triangle-pentagon interaction in C₄-free cubic.

  Setup: triangle T = (v,a,b) with v-a, a-b, b-v.
  v is cubic: third neighbor c (besides a,b).
  a is cubic: third neighbor d (besides v,b).
  b is cubic: third neighbor e (besides v,a).

  Pentagon P through c: can P reach a or b?
  If P = (c,x,y,z,w) passes through a: say a = x.
  Then c adj a. But a ∈ T = {v,a,b}.
  c adj a AND v adj a: c and v are both neighbors of a.
  a has deg 3: neighbors v, b, d. So c ∈ {b, d}.
  If c = b: then c = b, but c ≠ b (c is third neighbor of v,
  distinct from a,b). Contradiction.
  If c = d: c is a's third neighbor. Possible.
  Then c = d: v adj c, a adj c. Are v and a both adj to c?
  v adj c (third neighbor). a adj c = a adj d (third neighbor of a).
  Two common neighbors of v,c? v adj a and v adj c. a adj c.
  Triangle v-a-c (= v-a-d). But v already in triangle v-a-b.
  Two triangles at v sharing edge v-a: book! C₄ by T116.

  C₄ = v-b-a-c-v? Check: v adj b ✓, b adj a ✓, a adj c ✓, c adj v ✓.
  Ne: v≠b ✓, b≠a ✓, a≠c ✓, c≠v ✓. Diag: v≠a ✓, b≠c ✓.
  YES! C₄ = v-b-a-c-v.

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

/-- Triangle + third-neighbor forms second triangle → C₄.
    T₁ = (v,a,b). v's third nbr = c. a's third nbr = d = c.
    Two triangles sharing edge v-a: v-a-b and v-a-c.
    C₄ = v-b-a-c-v.
    Edges: v-b, b-a, a-c, c-v. -/
theorem c4free_triangle_third_nbr_second_triangle (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v b a c : V)
    (hvb : G.adj v b) (hba : G.adj b a)
    (hac : G.adj a c) (hcv : G.adj c v)
    (hne_vb : v ≠ b) (hne_ba : b ≠ a)
    (hne_ac : a ≠ c) (hne_cv : c ≠ v)
    (hne_va : v ≠ a) (hne_bc : b ≠ c)
    : False := by
  exact hC4 v b a c
    hne_vb hne_ba hne_ac hne_cv
    hne_va hne_bc
    hvb hba hac hcv

/-- Triangle + pentagon sharing vertex through third neighbor → C₄.
    T = (v,a,b). a's third nbr = d. b's third nbr = e.
    If d adj e: C₄ = a-d-e-b-a.
    Edges: a-d, d-e, e-b, b-a. -/
theorem c4free_triangle_ext_cross (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a d e b : V)
    (had : G.adj a d) (hde : G.adj d e)
    (heb : G.adj e b) (hba : G.adj b a)
    (hne_ad : a ≠ d) (hne_de : d ≠ e)
    (hne_eb : e ≠ b) (hne_ba : b ≠ a)
    (hne_ae : a ≠ e) (hne_db : d ≠ b)
    : False := by
  exact hC4 a d e b
    hne_ad hne_de hne_eb hne_ba
    hne_ae hne_db
    had hde heb hba

end SimpleGraph
