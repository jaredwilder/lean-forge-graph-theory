/-
  C₄-free K₄-free cubic: pendant triangle isolation.

  A "pendant triangle" at vertex v: triangle (v,a,b) where v's
  third neighbor c is NOT in any triangle. Since c is a non-triangle
  vertex in a cubic graph, N(c) = {v, c₁, c₂} with no edges among them.

  Key new result: c₁ and c₂ cannot be adjacent to a or b.
  If c₁ adj a: path v-c-c₁-a... but also v adj a. So v-c-c₁ and
  v-a give: if c₁ adj a, then v-c-c₁-a-v... wait, is that C₄?
  v-c-c₁-a-v: edges v-c, c-c₁, c₁-a, a-v. That's C₄ with 4 distinct
  vertices (v,c,c₁,a) IF v≠c≠c₁≠a≠v etc.

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

/-- c₁ (neighbor of non-triangle neighbor c) cannot be adjacent
    to triangle vertex a. If c₁ adj a: C₄ = v-c-c₁-a-v. -/
theorem c4free_pendant_c1_not_adj_a (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c c1 : V)
    (hva : G.adj v a) (hvc : G.adj v c) (hcc1 : G.adj c c1) (hc1a : G.adj c1 a)
    (hne_va : v ≠ a) (hne_vc : v ≠ c) (hne_ac : a ≠ c)
    (hne_cc1 : c ≠ c1) (hne_vc1 : v ≠ c1) (hne_ac1 : a ≠ c1)
    : False := by
  -- C₄: v-c-c1-a-v. hC4 v c c1 a.
  -- (a=v, b=c, c=c1, d=a)
  -- Ne1: v≠c = hne_vc
  -- Ne2: c≠c1 = hne_cc1
  -- Ne3: c1≠a = ne_flip hne_ac1
  -- Ne4: a≠v = ne_flip hne_va
  -- Ne5: v≠c1 = hne_vc1
  -- Ne6: c≠a = ne_flip hne_ac
  -- Adj1: G.adj v c = hvc ✓
  -- Adj2: G.adj c c1 = hcc1 ✓
  -- Adj3: G.adj c1 a = hc1a ✓
  -- Adj4: G.adj a v = adj_symm v a hva
  exact hC4 v c c1 a
    hne_vc hne_cc1 (ne_flip hne_ac1) (ne_flip hne_va)
    hne_vc1 (ne_flip hne_ac)
    hvc hcc1 hc1a (G.adj_symm v a hva)

/-- c₁ cannot be adjacent to b either. C₄ = v-c-c₁-b-v. -/
theorem c4free_pendant_c1_not_adj_b (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v b c c1 : V)
    (hvb : G.adj v b) (hvc : G.adj v c) (hcc1 : G.adj c c1) (hc1b : G.adj c1 b)
    (hne_vb : v ≠ b) (hne_vc : v ≠ c) (hne_bc : b ≠ c)
    (hne_cc1 : c ≠ c1) (hne_vc1 : v ≠ c1) (hne_bc1 : b ≠ c1)
    : False := by
  -- C₄: v-c-c1-b-v. hC4 v c c1 b.
  -- (a=v, b=c, c=c1, d=b)
  -- Ne1: v≠c = hne_vc
  -- Ne2: c≠c1 = hne_cc1
  -- Ne3: c1≠b = ne_flip hne_bc1
  -- Ne4: b≠v = ne_flip hne_vb
  -- Ne5: v≠c1 = hne_vc1
  -- Ne6: c≠b = ne_flip hne_bc
  -- Adj1: G.adj v c = hvc ✓
  -- Adj2: G.adj c c1 = hcc1 ✓
  -- Adj3: G.adj c1 b = hc1b ✓
  -- Adj4: G.adj b v = adj_symm v b hvb
  exact hC4 v c c1 b
    hne_vc hne_cc1 (ne_flip hne_bc1) (ne_flip hne_vb)
    hne_vc1 (ne_flip hne_bc)
    hvc hcc1 hc1b (G.adj_symm v b hvb)

end SimpleGraph
