/-
  C₄-free + K₄-free: triangle isolation.

  In a C₄-free K₄-free graph, triangles are maximally isolated:
  1. Edge-disjoint (C₄-free, T043)
  2. A vertex in a triangle can share at most one triangle-edge
     with any other vertex (C₄-free, T057)
  3. No vertex outside a triangle can be adjacent to all three
     vertices of the triangle (K₄-free, T044)
  4. No vertex outside can be adjacent to two triangle vertices
     that share an edge (would create a book = C₄)

  The combined effect: each triangle is an "island" — connected to
  the rest of the graph only through edges that don't participate
  in any other triangle.

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

def K4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → a ≠ c → a ≠ d →
    b ≠ c → b ≠ d → c ≠ d →
    G.adj a b → G.adj a c → G.adj a d →
    G.adj b c → G.adj b d → G.adj c d → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- No external vertex can be adjacent to two vertices of a triangle
    if those two are edge-connected. Triangle (a,b,c), w adj a and
    w adj b: book (a,b,c) + (a,b,w) → C₄: w-a-c-b-w. -/
theorem triangle_island_no_edge_neighbor (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c w : V)
    (hab : G.adj a b) (hbc : G.adj b c) (hac : G.adj a c)
    (hwa : G.adj w a) (hwb : G.adj w b)
    (hne_ab : a ≠ b) (hne_bc : b ≠ c) (hne_ac : a ≠ c)
    (hne_wa : w ≠ a) (hne_wb : w ≠ b) (hne_wc : w ≠ c)
    : False := by
  -- C₄: w-a-c-b-w. hC4 w a c b.
  -- (a=w, b=a, c=c, d=b)
  -- Ne1: w≠a = hne_wa
  -- Ne2: a≠c = hne_ac
  -- Ne3: c≠b = ne_flip hne_bc
  -- Ne4: b≠w = ne_flip hne_wb
  -- Ne5: w≠c = hne_wc
  -- Ne6: a≠b = hne_ab
  exact hC4 w a c b
    hne_wa hne_ac (ne_flip hne_bc) (ne_flip hne_wb)
    hne_wc hne_ab
    hwa hac (G.adj_symm b c hbc) (G.adj_symm w b hwb)

/-- Combined with K₄-free: w adjacent to all three → K₄. -/
theorem triangle_island_no_dominator (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (a b c w : V)
    (hab : G.adj a b) (hbc : G.adj b c) (hac : G.adj a c)
    (hwa : G.adj w a) (hwb : G.adj w b) (hwc : G.adj w c)
    (hne_ab : a ≠ b) (hne_bc : b ≠ c) (hne_ac : a ≠ c)
    (hne_wa : w ≠ a) (hne_wb : w ≠ b) (hne_wc : w ≠ c)
    : False := by
  -- K₄ = {w, a, b, c}. hK4 w a b c.
  -- Ne: w≠a, w≠b, w≠c, a≠b, a≠c, b≠c
  -- Adj: w-a, w-b, w-c, a-b, a-c, b-c
  exact hK4 w a b c
    hne_wa hne_wb hne_wc
    hne_ab hne_ac hne_bc
    hwa hwb hwc
    hab hac hbc

end SimpleGraph
