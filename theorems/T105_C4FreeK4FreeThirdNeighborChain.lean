/-
  C₄-free K₄-free cubic: third-neighbor chain constraint.

  In a cubic C₄-free K₄-free graph with triangle (v,a,b):
  - v's third neighbor: c
  - a's third neighbor: a₁
  - b's third neighbor: b₁

  Already proven:
  - c NOT adj a, c NOT adj b (T079)
  - a₁ NOT adj v, b₁ NOT adj v (T077)
  - c NOT adj a₁, c NOT adj b₁ (T083)

  NEW: a₁ NOT adj b₁. If a₁ adj b₁: path a-a₁-b₁-b has length 3.
  Combined with a-b (edge from triangle): this creates a 4-cycle?
  No: a-a₁-b₁-b-a is C₄ only if we have 4 distinct vertices.
  a₁ ≠ a, a₁ ≠ b (since a₁ ∉ {v,b} by degree constraint),
  b₁ ≠ a, b₁ ≠ b. So C₄ = a-a₁-b₁-b-a with edges a-a₁, a₁-b₁,
  b₁-b, b-a. Yes, that's C₄.

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

/-- a₁ NOT adj b₁: C₄ = a-a₁-b₁-b-a.
    From triangle (v,a,b), a₁ = other nbr of a, b₁ = other nbr of b. -/
theorem c4free_triangle_ext_nbrs_not_adj (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b a1 b1 : V)
    (haa1 : G.adj a a1) (ha1b1 : G.adj a1 b1) (hb1b : G.adj b1 b) (hab : G.adj a b)
    (hne_aa1 : a ≠ a1) (hne_a1b1 : a1 ≠ b1) (hne_b1b : b1 ≠ b)
    (hne_ab : a ≠ b) (hne_ab1 : a ≠ b1) (hne_a1b : a1 ≠ b)
    : False := by
  -- C₄: a-a1-b1-b-a. hC4 a a1 b1 b.
  -- (a=a, b=a1, c=b1, d=b)
  -- Ne1: a≠a1 = hne_aa1
  -- Ne2: a1≠b1 = hne_a1b1
  -- Ne3: b1≠b = hne_b1b
  -- Ne4: b≠a = ne_flip hne_ab
  -- Ne5: a≠b1 = hne_ab1
  -- Ne6: a1≠b = hne_a1b
  -- Adj1: G.adj a a1 = haa1 ✓
  -- Adj2: G.adj a1 b1 = ha1b1 ✓
  -- Adj3: G.adj b1 b = hb1b ✓
  -- Adj4: G.adj b a = adj_symm a b hab
  exact hC4 a a1 b1 b
    hne_aa1 hne_a1b1 hne_b1b (ne_flip hne_ab)
    hne_ab1 hne_a1b
    haa1 ha1b1 hb1b (G.adj_symm a b hab)

/-- Symmetric: b₁ NOT adj a₁ (same theorem, but verifying
    the symmetric C₄ direction). C₄ = b-b₁-a₁-a-b. -/
theorem c4free_triangle_ext_nbrs_not_adj_sym (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b a1 b1 : V)
    (hbb1 : G.adj b b1) (hb1a1 : G.adj b1 a1) (ha1a : G.adj a1 a) (hab : G.adj a b)
    (hne_bb1 : b ≠ b1) (hne_b1a1 : b1 ≠ a1) (hne_a1a : a1 ≠ a)
    (hne_ab : a ≠ b) (hne_ba1 : b ≠ a1) (hne_b1a : b1 ≠ a)
    : False := by
  -- C₄: b-b1-a1-a-b. hC4 b b1 a1 a.
  -- (a=b, b=b1, c=a1, d=a)
  -- Ne1: b≠b1 = hne_bb1
  -- Ne2: b1≠a1 = hne_b1a1
  -- Ne3: a1≠a = hne_a1a
  -- Ne4: a≠b = hne_ab
  -- Ne5: b≠a1 = hne_ba1
  -- Ne6: b1≠a = hne_b1a
  -- Adj1: G.adj b b1 = hbb1 ✓
  -- Adj2: G.adj b1 a1 = hb1a1 ✓
  -- Adj3: G.adj a1 a = ha1a ✓
  -- Adj4: G.adj a b = hab ✓
  exact hC4 b b1 a1 a
    hne_bb1 hne_b1a1 hne_a1a hne_ab
    hne_ba1 hne_b1a
    hbb1 hb1a1 ha1a hab

end SimpleGraph
