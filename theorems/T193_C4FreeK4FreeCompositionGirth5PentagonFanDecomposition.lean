/-
  COMPOSITION: T127 + T163 + T180 → pentagon fan decomposition.

  Each vertex v in cubic girth 5 has 3 neighbors a,b,c.
  3 neighbor pairs: (a,b), (a,c), (b,c).
  Each pair can generate pentagons through v.

  Pentagon through v using neighbors a,b:
  v-a-x-y-b-v where x ∈ N(a)\{v}, y ∈ N(b)\{v}, x adj y.
  Or v-a-x-y-b-v where the path a-x-y-b has length 3.

  Fan at v: the set of pentagons through v.
  In Petersen: 6 pentagons per vertex (T163).
  3 pairs × 2 pentagons per pair = 6. Each pair contributes exactly 2.

  Why 2 per pair? For pair (a,b):
  a has 2 neighbors besides v: a₁, a₂.
  b has 2 neighbors besides v: b₁, b₂.
  Cross edges: a₁-b₁, a₁-b₂, a₂-b₁, a₂-b₂.
  Each cross edge gives a pentagon.
  C₄-free: at most 1 common neighbor for (a₁,b₁) etc.
  But cross edges are DIRECT, not common neighbors.

  In Petersen: exactly 2 of the 4 potential cross edges exist.
  (The other 2 would create C₄ via T122.)

  Actually: a₁ adj b₁ AND a₁ adj b₂ → a₁ is common neighbor of b₁,b₂.
  But b₁,b₂ are both neighbors of b. So b is also common neighbor.
  Two common neighbors of (b₁,b₂): {a₁, b}. That's 2.
  T122: at most 1 common neighbor. CONTRADICTION.

  So: a₁ can be adjacent to at most ONE of {b₁,b₂}.
  Similarly a₂ can be adjacent to at most one of {b₁,b₂}.
  Total cross edges ≤ 2. In Petersen: exactly 2. ✓

  Authority: FULL_FORMALIZATION — fan decomposition C₄ constraint.
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

/-- a₁ adj b₁ AND a₁ adj b₂, with b adj b₁ and b adj b₂:
    C₄ = b-b₁-a₁-b₂-b. Two common neighbors of (b₁,b₂). -/
theorem c4free_fan_double_cross (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (b b1 a1 b2 : V)
    (hbb1 : G.adj b b1) (hb1a1 : G.adj b1 a1)
    (ha1b2 : G.adj a1 b2) (hb2b : G.adj b2 b)
    (hne1 : b ≠ b1) (hne2 : b1 ≠ a1)
    (hne3 : a1 ≠ b2) (hne4 : b2 ≠ b)
    (hne5 : b ≠ a1) (hne6 : b1 ≠ b2)
    : False := by
  exact hC4 b b1 a1 b2
    hne1 hne2 hne3 hne4 hne5 hne6
    hbb1 hb1a1 ha1b2 hb2b

/-- Similarly: a₁ adj b₁ AND a₂ adj b₁, with a adj a₁ and a adj a₂:
    C₄ = a-a₁-b₁-a₂-a. -/
theorem c4free_fan_double_arrive (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a a1 b1 a2 : V)
    (haa1 : G.adj a a1) (ha1b1 : G.adj a1 b1)
    (hb1a2 : G.adj b1 a2) (ha2a : G.adj a2 a)
    (hne1 : a ≠ a1) (hne2 : a1 ≠ b1)
    (hne3 : b1 ≠ a2) (hne4 : a2 ≠ a)
    (hne5 : a ≠ b1) (hne6 : a1 ≠ a2)
    : False := by
  exact hC4 a a1 b1 a2
    hne1 hne2 hne3 hne4 hne5 hne6
    haa1 ha1b1 hb1a2 ha2a

end SimpleGraph
