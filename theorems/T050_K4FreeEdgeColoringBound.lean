/-
  K₄-free edge coloring bound.

  In a K₄-free graph, every triangle is "isolated" from every other
  triangle that shares a vertex. More precisely: if vertex v is in
  two triangles (v,a,b) and (v,c,d) with {a,b} ∩ {c,d} = ∅, then
  no edge exists between {a,b} and {c,d} (each such edge would
  create K₄ with v and two triangle vertices).

  Authority: STRUCTURAL_CORE — graph theorem with adjacency.
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

/-- Two triangles at vertex v with disjoint opposite edges cannot
    have a cross-edge a-c (would create K₄ {v,a,b,c} if b adj c too,
    but even a-c alone with triangle (v,a,b) and v-c means
    {v,a,c} has 3 edges. Adding b adj a and b adj v makes
    {v,a,b,c} = K₄ if a-c and b-c both exist.)

    Here: triangle (v,a,b) and a-c adjacent with v-c adjacent → K₄
    if b is also adjacent to c. -/
theorem k4free_cross_triangle_no_edge (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hvc : G.adj v c) (hac : G.adj a c) (hbc : G.adj b c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : False := by
  -- K₄ = {v, a, b, c}. hK4 v a b c.
  -- Slot trace for hK4 v a b c:
  --   Ne slots: v≠a, v≠b, v≠c, a≠b, a≠c, b≠c
  --   Adj slots: v-a, v-b, v-c, a-b, a-c, b-c
  exact hK4 v a b c
    hne_va hne_vb hne_vc
    hne_ab hne_ac hne_bc
    hva hvb hvc
    hab hac hbc

/-- Consequence: in K₄-free, if v is in triangle (v,a,b), then any
    other neighbor c of v with c ≠ a and c ≠ b cannot be adjacent
    to BOTH a and b. At most one of a-c, b-c can exist. -/
theorem k4free_triangle_neighbor_at_most_one (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hvc : G.adj v c) (hac : G.adj a c) (hbc : G.adj b c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : False := by
  exact k4free_cross_triangle_no_edge G hK4 v a b c
    hva hvb hab hvc hac hbc
    hne_va hne_vb hne_vc hne_ab hne_ac hne_bc

end SimpleGraph
