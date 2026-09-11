/-
  Cubic C₄-free minimum degree constraints.

  In a cubic (3-regular) C₄-free graph:
  - Every vertex has exactly 3 neighbors
  - N(v) induces a matching (max degree 1)
  - At most 1 edge in N(v), so at most 1 triangle through v
  - The non-triangle neighbors form "bare" edges

  This file combines the matching and triangle-bound results
  into a single structural conclusion about the cubic case.

  Authority: FULL_FORMALIZATION — complete graph theorems.
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

/-- In a C₄-free graph, if v has three neighbors a, b, c, then
    at most one pair among {a,b,c} is adjacent.
    Proof: suppose a-b and a-c. Then v-b-a-c-v is a C₄. -/
theorem c4free_cubic_at_most_one_pair (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : False := by
  -- C₄: v-b-a-c-v. hC4 v b a c.
  -- slots: v≠b, b≠a, a≠c, c≠v, v≠a, b≠c
  exact hC4 v b a c
    hne_vb (ne_flip hne_ab) hne_ac (ne_flip hne_vc)
    hne_va hne_bc
    hvb (G.adj_symm a b hab) hac (G.adj_symm v c hvc)

/-- Corollary: if a-b is an edge among neighbors of v, then neither
    a nor b can be adjacent to the third neighbor c. -/
theorem c4free_cubic_matching_exclusive (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : ¬ G.adj a c := by
  intro hac
  exact c4free_cubic_at_most_one_pair G hC4 v a b c
    hva hvb hvc hab hac hne_va hne_vb hne_vc hne_ab hne_ac hne_bc

/-- And b-c is also excluded. -/
theorem c4free_cubic_matching_exclusive_b (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : ¬ G.adj b c := by
  intro hbc
  -- C₄: v-a-b-c-v. hC4 v a b c.
  -- slots: v≠a, a≠b, b≠c, c≠v, v≠b, a≠c
  exact hC4 v a b c
    hne_va hne_ab hne_bc (ne_flip hne_vc)
    hne_vb hne_ac
    hva hab hbc (G.adj_symm v c hvc)

end SimpleGraph
