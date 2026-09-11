/-
  K₄-free: two triangles sharing two edges form K₄.

  If triangles (a,b,c) and (a,b,d) share edge a-b AND vertex c=d,
  they're the same triangle. If c ≠ d: they share edge a-b, and
  we need to check if this creates K₄.

  Two triangles sharing edge a-b: (a,b,c) and (a,b,d).
  The 4 vertices {a,b,c,d} have edges: a-b, a-c, b-c, a-d, b-d.
  For K₄ we also need c-d. Without c-d: it's a "diamond" (K₄ minus
  one edge). With c-d: K₄.

  But even without c-d: in C₄-free, two triangles sharing an edge
  give C₄ (book structure): c-a-d-b-c is C₄.

  This theorem: K₄ from two triangles sharing two edges.
  If triangles share edges a-b and a-c: then b and c are in both
  triangles. Triangle 1 = (a,b,c). Triangle 2 must have a 4th vertex d
  adjacent to both b and c (and a). That gives K₄ = {a,b,c,d}.

  Authority: STRUCTURAL_CORE — graph theorem with K₄.
-/

universe u

structure SimpleGraph (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

namespace SimpleGraph

variable {V : Type u}

def K4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → a ≠ c → a ≠ d →
    b ≠ c → b ≠ d → c ≠ d →
    G.adj a b → G.adj a c → G.adj a d →
    G.adj b c → G.adj b d → G.adj c d → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- K₄-free: vertex adjacent to all 3 vertices of a triangle → K₄.
    Triangle (a,b,c), vertex d adj a, d adj b, d adj c → K₄. -/
theorem k4free_no_triangle_dominator (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (a b c d : V)
    (hab : G.adj a b) (hac : G.adj a c) (hbc : G.adj b c)
    (hda : G.adj d a) (hdb : G.adj d b) (hdc : G.adj d c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    (hne_da : d ≠ a) (hne_db : d ≠ b) (hne_dc : d ≠ c)
    : False := by
  -- K₄: {d, a, b, c}. hK4 d a b c.
  -- Ne: d≠a, d≠b, d≠c, a≠b, a≠c, b≠c
  -- Adj: d-a, d-b, d-c, a-b, a-c, b-c
  exact hK4 d a b c
    hne_da hne_db hne_dc hne_ab hne_ac hne_bc
    hda hdb hdc hab hac hbc

end SimpleGraph
