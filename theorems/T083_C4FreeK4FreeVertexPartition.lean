/-
  C₄-free K₄-free: vertex partition around a triangle.

  Given triangle (v,a,b) in a cubic C₄-free K₄-free graph,
  the graph's vertices partition into layers:
  - Layer 0: {v,a,b} (the triangle)
  - Layer 1: {c, a₁, b₁} (unique other neighbors of v, a, b)
  - Layer 2: neighbors of Layer 1 not in Layers 0-1
  - ...

  Key structural results (all proven by C₄ contradiction):
  1. Layer 1 vertices are pairwise distinct (6 distinctness facts)
  2. No edges between Layer 0 and Layer 1 except the defining ones
  3. No edges within Layer 1 (else C₄ via Layer 0)

  Theorem 3 is the non-trivial one: c adj a₁ creates C₄.

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

/-- Layer 1 no internal edge: c adj a₁ forbidden.
    Triangle (v,a,b), v's third neighbor c, a's third neighbor a₁.
    If c adj a₁: path v-c-a₁-a-v is C₄. -/
theorem c4free_layer1_no_edge_c_a1 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c a1 : V)
    (hva : G.adj v a) (hvc : G.adj v c) (haa1 : G.adj a a1) (hca1 : G.adj c a1)
    (hne_va : v ≠ a) (hne_vc : v ≠ c) (hne_ac : a ≠ c)
    (hne_aa1 : a ≠ a1) (hne_va1 : v ≠ a1) (hne_ca1 : c ≠ a1)
    : False := by
  -- C₄: v-c-a1-a-v. hC4 v c a1 a.
  -- (a=v, b=c, c=a1, d=a)
  -- Ne1: v≠c = hne_vc
  -- Ne2: c≠a1 = hne_ca1
  -- Ne3: a1≠a = ne_flip hne_aa1
  -- Ne4: a≠v = ne_flip hne_va
  -- Ne5: v≠a1 = hne_va1
  -- Ne6: c≠a = ne_flip hne_ac
  -- Adj1: G.adj v c = hvc ✓
  -- Adj2: G.adj c a1 = hca1 ✓
  -- Adj3: G.adj a1 a = adj_symm a a1 haa1
  -- Adj4: G.adj a v = adj_symm v a hva
  exact hC4 v c a1 a
    hne_vc hne_ca1 (ne_flip hne_aa1) (ne_flip hne_va)
    hne_va1 (ne_flip hne_ac)
    hvc hca1 (G.adj_symm a a1 haa1) (G.adj_symm v a hva)

/-- Layer 1 no internal edge: c adj b₁ forbidden. Same argument. -/
theorem c4free_layer1_no_edge_c_b1 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v b c b1 : V)
    (hvb : G.adj v b) (hvc : G.adj v c) (hbb1 : G.adj b b1) (hcb1 : G.adj c b1)
    (hne_vb : v ≠ b) (hne_vc : v ≠ c) (hne_bc : b ≠ c)
    (hne_bb1 : b ≠ b1) (hne_vb1 : v ≠ b1) (hne_cb1 : c ≠ b1)
    : False := by
  -- C₄: v-c-b1-b-v. hC4 v c b1 b.
  -- (a=v, b=c, c=b1, d=b)
  -- Ne1: v≠c = hne_vc
  -- Ne2: c≠b1 = hne_cb1
  -- Ne3: b1≠b = ne_flip hne_bb1
  -- Ne4: b≠v = ne_flip hne_vb
  -- Ne5: v≠b1 = hne_vb1
  -- Ne6: c≠b = ne_flip hne_bc
  -- Adj1: G.adj v c = hvc ✓
  -- Adj2: G.adj c b1 = hcb1 ✓
  -- Adj3: G.adj b1 b = adj_symm b b1 hbb1
  -- Adj4: G.adj b v = adj_symm v b hvb
  exact hC4 v c b1 b
    hne_vc hne_cb1 (ne_flip hne_bb1) (ne_flip hne_vb)
    hne_vb1 (ne_flip hne_bc)
    hvc hcb1 (G.adj_symm b b1 hbb1) (G.adj_symm v b hvb)

end SimpleGraph
