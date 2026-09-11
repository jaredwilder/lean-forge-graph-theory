/-
  C₄-free triangle edge-disjointness.

  In a C₄-free graph, two distinct triangles sharing a vertex v
  cannot share an edge. Proof: if triangles (v,a,b) and (v,a,c)
  share edge v-a, then a is adjacent to both b and c, plus v is
  adjacent to both b and c. But then v-b-a-c is a 4-cycle.

  This is stronger than "matching in the link" — it says the
  triangles through v are EDGE-disjoint, not just vertex-disjoint
  in the link.

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

/-- Two triangles through v sharing edge v-a force a C₄.
    Triangle 1: v-a-b (edges va, ab, vb)
    Triangle 2: v-a-c (edges va, ac, vc)
    Then b-a-c-v is a path, and v-b closes it: C₄ = v-b-a-c-v.
    C4Free call: hC4 v b a c
    Slots: v≠b, b≠a, a≠c, c≠v, v≠a, b≠c -/
theorem c4free_triangles_edge_disjoint (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : False := by
  -- C₄: v-b-a-c-v. Call hC4 v b a c.
  -- slot 1: v ≠ b = hne_vb
  -- slot 2: b ≠ a = ne_flip hne_ab
  -- slot 3: a ≠ c = hne_ac
  -- slot 4: c ≠ v = ne_flip hne_vc
  -- slot 5: v ≠ a = hne_va
  -- slot 6: b ≠ c = hne_bc
  -- adj v b = hvb
  -- adj b a = G.adj_symm a b hab
  -- adj a c = hac
  -- adj c v = G.adj_symm v c hvc
  exact hC4 v b a c
    hne_vb (ne_flip hne_ab) hne_ac (ne_flip hne_vc)
    hne_va hne_bc
    hvb (G.adj_symm a b hab) hac (G.adj_symm v c hvc)

/-- Corollary: if v has exactly 3 neighbors a, b, c and triangles
    through edges va and vb exist, they use DIFFERENT third vertices.
    Triangle on va: (v, a, x) for some x ∈ {b, c}.
    Triangle on vb: (v, b, y) for some y ∈ {a, c}.
    If x = b and y = a, both triangles use edge v-a AND v-b, but the
    triangles are (v,a,b) and (v,b,a) = same triangle. For two DISTINCT
    triangles, we need x ≠ y or they share a different structure. -/
theorem cubic_two_triangles_distinct_third (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c x : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hax : G.adj a x) (hbx : G.adj b x)
    (hvx : G.adj v x)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_vx : v ≠ x) (hne_ax : a ≠ x) (hne_bx : b ≠ x)
    (hne_ab : a ≠ b)
    : False := by
  -- x is adjacent to both a and b, and v is adjacent to both a and b.
  -- So v-a-x-b-v is a C₄.
  -- hC4 v a x b: v≠a, a≠x, x≠b, b≠v, v≠x, a≠b
  exact hC4 v a x b
    hne_va hne_ax (ne_flip hne_bx) (ne_flip hne_vb)
    hne_vx hne_ab
    hva hax (G.adj_symm b x hbx) (G.adj_symm v b hvb)

end SimpleGraph
