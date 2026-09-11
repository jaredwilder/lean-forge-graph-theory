/-
  COMPOSITION: T136 + T144 + T160 → block decomposition from K₄⁻/K₄ + vertex cuts.

  T136: Diamond (K₄⁻) and K₄ both contain C₄.
  T144: Vertex cut with cross edge → C₄.
  T160: Block decomposition arithmetic.

  Composition insight: in C₄-free graphs, every 2-connected block
  is K₄⁻-free (since K₄⁻ contains C₄ by T136).
  Combined with T144: no cross edges between cut components.

  A 2-connected C₄-free graph has NO K₄⁻ subgraph.
  K₄⁻ = 4 vertices, 5 edges (K₄ minus one edge).
  K₄⁻ on {a,b,c,d} with edges: ab,ac,ad,bc,bd (missing cd).
  C₄ = a-c-b-d-a. Check: a≠c, c≠b, b≠d, d≠a, a≠b, c≠d. All distinct.
  Adj: a-c, c-b, b-d, d-a. All edges present in K₄⁻.

  So C₄-free → K₃-based: max clique = triangle (K₃).
  Triangle count in cubic: each vertex in ≤ 1 triangle
  (3 edges, triangle uses 2, third goes out).

  Actually: cubic vertex v adj a,b,c. Triangle needs a adj b (say).
  Then v-a-b is a triangle. v's third neighbor c goes elsewhere.
  Can v be in TWO triangles? v-a-b and v-a-c. Needs a adj b AND a adj c.
  But a has degree 3: v, b, c. a adj b, a adj c, a adj v. OK, deg(a)=3.
  Then b: adj v, adj a. Third edge to some x.
  And c: adj v, adj a. Third edge to some y.
  If b adj c: triangle b-a-c. And v-b-c? Only if v adj c (yes) and b adj c.
  Then v-a-b, v-a-c, v-b-c AND a-b-c. That's K₄ = {v,a,b,c}!
  K₄ contains C₄ by T136. FORBIDDEN in C₄-free.

  So: max 1 triangle through each edge a-b (only one common neighbor).
  This IS T122. The composition confirms: T122 + T136 → triangle sparsity.

  Authority: FULL_FORMALIZATION — K₄⁻ C₄ extraction.
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

/-- K₄⁻ on {a,b,c,d} (missing edge c-d) → C₄ = a-c-b-d-a. -/
theorem c4free_no_diamond (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c d : V)
    (hab : G.adj a b) (hac : G.adj a c) (had : G.adj a d)
    (hbc : G.adj b c) (hbd : G.adj b d)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_ad : a ≠ d)
    (hne_bc : b ≠ c) (hne_bd : b ≠ d) (hne_cd : c ≠ d)
    : False := by
  exact hC4 a c b d
    hne_ac (ne_flip hne_bc) hne_bd (ne_flip hne_ad)
    hne_ab hne_cd
    hac (G.adj_symm b c hbc) hbd (G.adj_symm a d had)

/-- K₄ on {a,b,c,d} (all 6 edges) also → C₄ (same cycle as K₄⁻). -/
theorem c4free_no_k4 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c d : V)
    (hab : G.adj a b) (hac : G.adj a c) (had : G.adj a d)
    (hbc : G.adj b c) (hbd : G.adj b d) (_hcd : G.adj c d)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_ad : a ≠ d)
    (hne_bc : b ≠ c) (hne_bd : b ≠ d) (hne_cd : c ≠ d)
    : False := by
  exact c4free_no_diamond G hC4 a b c d
    hab hac had hbc hbd
    hne_ab hne_ac hne_ad hne_bc hne_bd hne_cd

/-- Two triangles sharing an edge ab: v-a-b triangle, w-a-b triangle.
    v ≠ w. Then {v,w,a,b} form K₄⁻ (missing v-w). → C₄. -/
theorem c4free_edge_in_one_triangle (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v w a b : V)
    (hva : G.adj v a) (hvb : G.adj v b) (_hab : G.adj a b)
    (hwa : G.adj w a) (hwb : G.adj w b)
    (hne_vw : v ≠ w) (hne_va : v ≠ a) (hne_vb : v ≠ b)
    (hne_wa : w ≠ a) (hne_wb : w ≠ b) (hne_ab : a ≠ b)
    : False := by
  exact hC4 v a w b
    hne_va (ne_flip hne_wa) hne_wb (ne_flip hne_vb)
    hne_vw hne_ab
    hva (G.adj_symm w a hwa) hwb (G.adj_symm v b hvb)

end SimpleGraph
