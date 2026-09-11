/-
  C₄-free triangle vertex partition.

  In a C₄-free graph, if vertex v is in exactly one triangle (v,a,b),
  then every other neighbor c of v (c ≠ a, c ≠ b) satisfies:
  - c is NOT adjacent to a (else C₄: c-v-b-a if c adj a and a adj b...
    wait, need to check carefully)
  - Actually: c adj a creates the path v-c and v-a-c, giving a wedge.
    The C₄ would need c adj to some neighbor of b too.

  More precisely: c adj a AND c adj b → diamond (C₄).
  c adj a alone is allowed UNLESS it creates a second triangle at v.
  But v-a-c is a triangle only if v adj c (which it is) and a adj c
  and v adj a. So if c adj a, then (v,a,c) is a triangle at v.
  Combined with (v,a,b), we have two triangles sharing edge v-a,
  which is a "book" = C₄: c-v-b-a-c (since a adj b and a adj c and
  v adj b and v adj c).

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

/-- Two triangles sharing an edge in C₄-free is impossible.
    Triangles (v,a,b) and (v,a,c) with b ≠ c:
    C₄: c-v-b-a-c. -/
theorem c4free_no_book_at_edge (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hvc : G.adj v c) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : False := by
  -- C₄: c-v-b-a-c. hC4 c v b a.
  -- Slot trace for hC4 c v b a:
  --   Ne slots: c≠v, v≠b, b≠a, a≠c, c≠b, v≠a
  --   Adj slots: c-v, v-b, b-a, a-c
  exact hC4 c v b a
    (ne_flip hne_vc) hne_vb (ne_flip hne_ab) hne_ac
    (ne_flip hne_bc) hne_va
    (G.adj_symm v c hvc) hvb (G.adj_symm a b hab) hac

/-- Similarly: triangles (v,a,b) and (v,b,c) sharing edge v-b.
    C₄: c-v-a-b-c. -/
theorem c4free_no_book_at_other_edge (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hvc : G.adj v c) (hbc : G.adj b c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : False := by
  -- C₄: c-v-a-b-c. hC4 c v a b.
  -- Slot trace for hC4 c v a b:
  --   Ne slots: c≠v, v≠a, a≠b, b≠c, c≠a, v≠b
  --   Adj slots: c-v, v-a, a-b, b-c
  exact hC4 c v a b
    (ne_flip hne_vc) hne_va hne_ab hne_bc
    (ne_flip hne_ac) hne_vb
    (G.adj_symm v c hvc) hva hab hbc

end SimpleGraph
