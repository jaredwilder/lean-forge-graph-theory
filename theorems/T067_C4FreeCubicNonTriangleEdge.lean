/-
  C₄-free cubic non-triangle edge structure.

  In a cubic C₄-free graph, consider an edge v-a where v is NOT in
  a triangle involving a (i.e., no neighbor of v other than a is
  adjacent to a). Then the other two neighbors of v, call them b and c,
  each contribute paths of length 2 from v to N₂(v) that are completely
  independent of a's subtree.

  This means: non-triangle edges produce "branches" in the 2-ball
  that are structurally independent, yielding longer cycles when
  these branches reconnect at distance ≥ 3.

  Authority: STRUCTURAL_CORE — graph theorem with adjacency.
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

/-- If edge v-a is not in a triangle, then no neighbor b₁ of a
    (b₁ ≠ v) can be adjacent to any neighbor b of v (b ≠ a).
    If b₁ adj b, then v-a-b₁-b-v is C₄. -/
theorem c4free_nontriangle_branch_disjoint (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b b1 : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (hab1 : G.adj a b1) (hb1b : G.adj b1 b)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_ab1 : a ≠ b1) (hne_b1b : b1 ≠ b) (hne_vb1 : v ≠ b1)
    : False := by
  -- C₄: v-a-b1-b-v. hC4 v a b1 b.
  -- (a=v, b=a, c=b1, d=b)
  -- Ne1: v≠a = hne_va
  -- Ne2: a≠b1 = hne_ab1
  -- Ne3: b1≠b = hne_b1b
  -- Ne4: b≠v = ne_flip hne_vb
  -- Ne5: v≠b1 = hne_vb1
  -- Ne6: a≠b = hne_ab
  exact hC4 v a b1 b
    hne_va hne_ab1 hne_b1b (ne_flip hne_vb)
    hne_vb1 hne_ab
    hva hab1 hb1b (G.adj_symm v b hvb)

/-- Symmetric: neighbor c₁ of a cannot be adjacent to c either. -/
theorem c4free_nontriangle_branch_disjoint_sym (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c c1 : V)
    (hva : G.adj v a) (hvc : G.adj v c)
    (hac1 : G.adj a c1) (hc1c : G.adj c1 c)
    (hne_va : v ≠ a) (hne_vc : v ≠ c) (hne_ac : a ≠ c)
    (hne_ac1 : a ≠ c1) (hne_c1c : c1 ≠ c) (hne_vc1 : v ≠ c1)
    : False := by
  exact c4free_nontriangle_branch_disjoint G hC4 v a c c1
    hva hvc hac1 hc1c
    hne_va hne_vc hne_ac hne_ac1 hne_c1c hne_vc1

end SimpleGraph
