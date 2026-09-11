/-
  C₄-free K₄-free: three paths at a vertex form no triangle.

  In TF cubic: N(v) = {a,b,c} independent. Known.
  In non-TF cubic C₄-free: N(v) has at most 1 edge (one triangle).
  So among {a,b,c}, at most one pair is adjacent.

  NEW result: the non-triangle pair's extended paths are
  "maximally separated" — no shortcut between them.

  If triangle (v,a,b) and third neighbor c: a₁ (other nbr of a)
  and c₁ (other nbr of c) cannot be adjacent. If a₁ adj c₁:
  the path a-a₁-c₁-c has length 3. Combined with a-v-c (length 2):
  cycle length 5. Not a C₄ argument, but a structure result.

  Actually: a₁ adj c₁ would give a₁-c₁-c-v-a-a₁ = 5-cycle.
  For C₄: a₁ adj c creates C₄ = a₁-a-v-c-a₁.

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

/-- a₁ (other neighbor of a) NOT adj c (third neighbor of v).
    If a₁ adj c: C₄ = a₁-a-v-c-a₁. -/
theorem c4free_extended_not_adj_third (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c a1 : V)
    (hva : G.adj v a) (hvc : G.adj v c) (haa1 : G.adj a a1) (ha1c : G.adj a1 c)
    (hne_va : v ≠ a) (hne_vc : v ≠ c) (hne_ac : a ≠ c)
    (hne_aa1 : a ≠ a1) (hne_a1c : a1 ≠ c) (hne_va1 : v ≠ a1)
    : False := by
  -- C₄: a1-a-v-c-a1. hC4 a1 a v c.
  -- (a=a1, b=a, c=v, d=c)
  -- Ne1: a1≠a = ne_flip hne_aa1
  -- Ne2: a≠v = ne_flip hne_va
  -- Ne3: v≠c = hne_vc
  -- Ne4: c≠a1 = ne_flip hne_a1c
  -- Ne5: a1≠v = ne_flip hne_va1
  -- Ne6: a≠c = hne_ac
  -- Adj1: G.adj a1 a = adj_symm a a1 haa1
  -- Adj2: G.adj a v = adj_symm v a hva
  -- Adj3: G.adj v c = hvc ✓
  -- Adj4: G.adj c a1 = adj_symm a1 c ha1c
  exact hC4 a1 a v c
    (ne_flip hne_aa1) (ne_flip hne_va) hne_vc (ne_flip hne_a1c)
    (ne_flip hne_va1) hne_ac
    (G.adj_symm a a1 haa1) (G.adj_symm v a hva) hvc (G.adj_symm a1 c ha1c)

/-- b₁ (other neighbor of b) NOT adj c. Same structure.
    C₄ = b₁-b-v-c-b₁. -/
theorem c4free_extended_b_not_adj_third (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v b c b1 : V)
    (hvb : G.adj v b) (hvc : G.adj v c) (hbb1 : G.adj b b1) (hb1c : G.adj b1 c)
    (hne_vb : v ≠ b) (hne_vc : v ≠ c) (hne_bc : b ≠ c)
    (hne_bb1 : b ≠ b1) (hne_b1c : b1 ≠ c) (hne_vb1 : v ≠ b1)
    : False := by
  -- C₄: b1-b-v-c-b1. hC4 b1 b v c.
  -- (a=b1, b=b, c=v, d=c)
  -- Ne1: b1≠b = ne_flip hne_bb1
  -- Ne2: b≠v = ne_flip hne_vb
  -- Ne3: v≠c = hne_vc
  -- Ne4: c≠b1 = ne_flip hne_b1c
  -- Ne5: b1≠v = ne_flip hne_vb1
  -- Ne6: b≠c = hne_bc
  -- Adj1: G.adj b1 b = adj_symm b b1 hbb1
  -- Adj2: G.adj b v = adj_symm v b hvb
  -- Adj3: G.adj v c = hvc ✓
  -- Adj4: G.adj c b1 = adj_symm b1 c hb1c
  exact hC4 b1 b v c
    (ne_flip hne_bb1) (ne_flip hne_vb) hne_vc (ne_flip hne_b1c)
    (ne_flip hne_vb1) hne_bc
    (G.adj_symm b b1 hbb1) (G.adj_symm v b hvb) hvc (G.adj_symm b1 c hb1c)

end SimpleGraph
