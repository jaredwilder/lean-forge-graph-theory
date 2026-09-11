/-
  C₄-free: two triangles cannot share a vertex AND have a cross-edge.

  If triangles (a,b,c) and (a,d,e) share vertex a, and there exists
  any edge between {b,c} and {d,e}, a C₄ is created.

  Example: b adj d → C₄: b-a-d-?... need a path back.
  Actually: b adj d with a adj b and a adj d means we have edges
  a-b, a-d, b-d. That's a triangle {a,b,d}, not a C₄.
  For C₄ we need 4 vertices. b adj e with b adj a, a adj e:
  then b-a-e-?-b needs a 4th vertex adjacent to both e and b.

  The real constraint: b adj d AND c adj e (cross-edges between
  the two triangles' non-shared vertices) creates C₄: b-c-a-d or
  similar... Let me think more carefully.

  Two triangles sharing vertex a: (a,b,c) and (a,d,e).
  If b adj d: C₄ needs b-d-?-?-b with 4 distinct. Consider
  b-a-d-e and if e adj b: then a-b-e-d-a is C₄ (4 vertices a,b,e,d).

  Actually simplest: if b adj d, then {a,b,d} is a second triangle
  sharing edge a-b with triangle (a,b,c). This is a BOOK at edge
  a-b: triangles (a,b,c) and (a,b,d). Book → C₄: c-a-d-b-c.

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

/-- Book at edge a-b: triangles (a,b,c) and (a,b,d) with c ≠ d → C₄.
    C₄: c-a-d-b-c. -/
theorem c4free_book_at_edge (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c d : V)
    (hab : G.adj a b) (hac : G.adj a c) (hbc : G.adj b c)
    (had : G.adj a d) (hbd : G.adj b d)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    (hne_ad : a ≠ d) (hne_bd : b ≠ d) (hne_cd : c ≠ d)
    : False := by
  -- C₄: c-a-d-b-c. hC4 c a d b.
  -- (a=c, b=a, c=d, d=b)
  -- Ne1: c≠a = ne_flip hne_ac
  -- Ne2: a≠d = hne_ad
  -- Ne3: d≠b = ne_flip hne_bd
  -- Ne4: b≠c = hne_bc
  -- Ne5: c≠d = hne_cd
  -- Ne6: a≠b = hne_ab
  exact hC4 c a d b
    (ne_flip hne_ac) hne_ad (ne_flip hne_bd) hne_bc
    hne_cd hne_ab
    (G.adj_symm a c hac) had (G.adj_symm b d hbd) hbc

/-- Vertex-sharing triangles with cross-edge d adj c: if (a,b,c) is
    a triangle and d adj a and d adj c, then {a,c,d} is a triangle
    sharing edge a-c with (a,b,c). Book at a-c → C₄: b-a-d-c-b. -/
theorem c4free_vertex_share_cross_edge (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c d : V)
    (hab : G.adj a b) (hac : G.adj a c) (hbc : G.adj b c)
    (had : G.adj a d) (hdc : G.adj d c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    (hne_ad : a ≠ d) (hne_dc : d ≠ c) (hne_bd : b ≠ d)
    : False := by
  -- C₄: b-a-d-c-b. hC4 b a d c.
  -- (a=b, b=a, c=d, d=c)
  -- Ne1: b≠a = ne_flip hne_ab
  -- Ne2: a≠d = hne_ad
  -- Ne3: d≠c = hne_dc
  -- Ne4: c≠b = ne_flip hne_bc
  -- Ne5: b≠d = hne_bd
  -- Ne6: a≠c = hne_ac
  exact hC4 b a d c
    (ne_flip hne_ab) hne_ad hne_dc (ne_flip hne_bc)
    hne_bd hne_ac
    (G.adj_symm a b hab) had hdc (G.adj_symm b c hbc)

end SimpleGraph
