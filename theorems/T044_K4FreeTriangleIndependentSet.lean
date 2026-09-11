/-
  K₄-free triangle independent set.

  In a K₄-free graph, the non-edge vertices of any triangle form a
  constraint: no vertex can be adjacent to all three triangle vertices.

  More precisely: if (a,b,c) is a triangle, then for any vertex w
  adjacent to two of {a,b,c}, w is NOT adjacent to the third
  (otherwise {a,b,c,w} = K₄).

  This is the structural core of the EG argument: every triangle
  "blocks" further adjacencies, constraining the growth of the
  neighborhood.

  Authority: FULL_FORMALIZATION — complete graph theorem.
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

/-- In a K₄-free graph, no vertex can be adjacent to all three
    vertices of a triangle. w adjacent to a, b, c with triangle
    (a,b,c) gives K₄. -/
theorem k4free_no_triangle_dominator (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (a b c w : V)
    (hab : G.adj a b) (hac : G.adj a c) (hbc : G.adj b c)
    (hwa : G.adj w a) (hwb : G.adj w b) (hwc : G.adj w c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    (hne_wa : w ≠ a) (hne_wb : w ≠ b) (hne_wc : w ≠ c)
    : False := by
  -- K₄ = {w, a, b, c}. hK4 w a b c.
  -- Slot trace for hK4 w a b c:
  --   Ne slots: w≠a, w≠b, w≠c, a≠b, a≠c, b≠c
  --   Adj slots: w-a, w-b, w-c, a-b, a-c, b-c
  exact hK4 w a b c
    hne_wa hne_wb hne_wc
    hne_ab hne_ac hne_bc
    hwa hwb hwc
    hab hac hbc

/-- Contrapositive form: in a K₄-free graph, if w is adjacent to
    a and b (which are adjacent), and a is adjacent to c, and
    b is adjacent to c, then w is NOT adjacent to c.
    (Otherwise {a,b,c,w} = K₄.) -/
theorem k4free_triangle_blocks_third_edge (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (a b c w : V)
    (hab : G.adj a b) (hac : G.adj a c) (hbc : G.adj b c)
    (hwa : G.adj w a) (hwb : G.adj w b) (hwc : G.adj w c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    (hne_wa : w ≠ a) (hne_wb : w ≠ b) (hne_wc : w ≠ c)
    : False := by
  exact k4free_no_triangle_dominator G hK4 a b c w
    hab hac hbc hwa hwb hwc
    hne_ab hne_ac hne_bc hne_wa hne_wb hne_wc

/-- Two triangles sharing an edge in a K₄-free graph must use
    disjoint third vertices. If (a,b,c) and (a,b,d) are both
    triangles, then c and d cannot be adjacent (otherwise
    {a,c,d,b} forms K₄ or a C₄-like structure).
    Here we prove: c adj to d + c adj to a + d adj to a → K₄. -/
theorem k4free_shared_edge_third_nonadj (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (a b c d : V)
    (hab : G.adj a b) (hac : G.adj a c) (hbc : G.adj b c)
    (had : G.adj a d) (hbd : G.adj b d) (hcd : G.adj c d)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_ad : a ≠ d)
    (hne_bc : b ≠ c) (hne_bd : b ≠ d) (hne_cd : c ≠ d)
    : False := by
  -- K₄ = {a, c, d, b}. hK4 a c d b.
  -- Slot trace for hK4 a c d b:
  --   Ne slots: a≠c, a≠d, a≠b, c≠d, c≠b, d≠b
  --   Adj slots: a-c, a-d, a-b, c-d, c-b, d-b
  exact hK4 a c d b
    hne_ac hne_ad hne_ab
    hne_cd (ne_flip hne_bc) (ne_flip hne_bd)
    hac had hab
    hcd (G.adj_symm b c hbc) (G.adj_symm b d hbd)

end SimpleGraph
