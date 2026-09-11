/-
  C₄-free: three paths from v, intermediates pairwise distinct.

  In cubic: v has neighbors a, b, c. Each aᵢ has neighbors
  aᵢ₁, aᵢ₂ besides v. The 6 layer-2 vertices are all distinct
  (T087, T106).

  Further: if two of these layer-2 vertices are adjacent to
  the SAME layer-3 vertex z, that creates C₄ in certain
  configurations.

  Specifically: a₁ adj z AND b₁ adj z (from different branches).
  Then z is a common neighbor of a₁ and b₁.
  If a₁ and b₁ also share parent v at distance 2...
  Actually: a₁-z-b₁ is a path. Is there another path a₁-...-b₁?
  a₁-a-v-b-b₁ has length 4. Not length 2. No immediate C₄.

  But: a₁ adj z AND a₂ adj z (from SAME branch).
  Then z is adjacent to both a₁ and a₂, and a is adjacent to both.
  C₄ = a-a₁-z-a₂-a. YES!

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

/-- Two siblings sharing a layer-3 neighbor → C₄.
    a₁, a₂ ∈ N(a)\{v}. z adj a₁ AND z adj a₂.
    Then a, z are both common neighbors of a₁ and a₂.
    C₄ = a-a₁-z-a₂-a.
    Edges: a-a₁, a₁-z, z-a₂, a₂-a. -/
theorem c4free_siblings_shared_l3_nbr (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a a1 a2 z : V)
    (haa1 : G.adj a a1) (ha1z : G.adj a1 z)
    (hza2 : G.adj z a2) (ha2a : G.adj a2 a)
    (hne_aa1 : a ≠ a1) (hne_a1z : a1 ≠ z)
    (hne_za2 : z ≠ a2) (hne_a2a : a2 ≠ a)
    (hne_az : a ≠ z) (hne_a1a2 : a1 ≠ a2)
    : False := by
  -- C₄: a-a1-z-a2-a. hC4 a a1 z a2.
  exact hC4 a a1 z a2
    hne_aa1 hne_a1z hne_za2 hne_a2a
    hne_az hne_a1a2
    haa1 ha1z hza2 ha2a

/-- Same constraint for branch b. -/
theorem c4free_siblings_shared_l3_nbr_b (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (b b1 b2 z : V)
    (hbb1 : G.adj b b1) (hb1z : G.adj b1 z)
    (hzb2 : G.adj z b2) (hb2b : G.adj b2 b)
    (hne_bb1 : b ≠ b1) (hne_b1z : b1 ≠ z)
    (hne_zb2 : z ≠ b2) (hne_b2b : b2 ≠ b)
    (hne_bz : b ≠ z) (hne_b1b2 : b1 ≠ b2)
    : False := by
  exact hC4 b b1 z b2
    hne_bb1 hne_b1z hne_zb2 hne_b2b
    hne_bz hne_b1b2
    hbb1 hb1z hzb2 hb2b

end SimpleGraph
