/-
  C₄-free K₄-free: claw (K_{1,3}) structure.

  Every vertex v in a cubic graph is the center of a claw K_{1,3}
  (v adjacent to 3 independent vertices in TF, or 2 independent +
  1 edge in general). The claw structure propagates constraints:

  In C₄-free K₄-free cubic:
  - If L(v) is empty (no triangle at v): three independent branches.
    Each branch a-a₁, a-a₂ extends the claw. The extended claw has
    v at center, 3 first-level and 6 second-level leaves.
  - If L(v) has one edge (one triangle at v): two branch types.

  The claw at each vertex creates a "tree-like" local structure
  that forces long paths to exist.

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

/-- Extended claw: a₁ (second-level) cannot be adjacent to b
    (first-level, different branch). If a₁ adj b, then
    v-a-a₁-b-v is C₄. Same as T066 cross-part exclusion. -/
theorem c4free_claw_no_cross_branch (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b a1 : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (haa1 : G.adj a a1) (ha1b : G.adj a1 b)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_aa1 : a ≠ a1) (hne_a1b : a1 ≠ b) (hne_va1 : v ≠ a1)
    : False := by
  -- C₄: v-a-a1-b-v. hC4 v a a1 b.
  -- (a=v, b=a, c=a1, d=b)
  -- Ne1: v≠a = hne_va
  -- Ne2: a≠a1 = hne_aa1
  -- Ne3: a1≠b = hne_a1b
  -- Ne4: b≠v = ne_flip hne_vb
  -- Ne5: v≠a1 = hne_va1
  -- Ne6: a≠b = hne_ab
  exact hC4 v a a1 b
    hne_va hne_aa1 hne_a1b (ne_flip hne_vb)
    hne_va1 hne_ab
    hva haa1 ha1b (G.adj_symm v b hvb)

/-- Two second-level vertices from same branch cannot share a
    third-level neighbor (C₄ at the branch root). -/
theorem c4free_claw_same_branch_no_shared (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a a1 a2 x : V)
    (haa1 : G.adj a a1) (haa2 : G.adj a a2)
    (ha1x : G.adj a1 x) (ha2x : G.adj a2 x)
    (hne_a12 : a1 ≠ a2)
    (hne_aa1 : a ≠ a1) (hne_aa2 : a ≠ a2)
    (hne_a1x : a1 ≠ x) (hne_a2x : a2 ≠ x) (hne_ax : a ≠ x)
    : False := by
  -- C₄: a1-a-a2-x-a1. hC4 a1 a a2 x.
  -- (a=a1, b=a, c=a2, d=x)
  -- Ne1: a1≠a = ne_flip hne_aa1
  -- Ne2: a≠a2 = hne_aa2
  -- Ne3: a2≠x = hne_a2x
  -- Ne4: x≠a1 = ne_flip hne_a1x
  -- Ne5: a1≠a2 = hne_a12
  -- Ne6: a≠x = hne_ax
  exact hC4 a1 a a2 x
    (ne_flip hne_aa1) hne_aa2 hne_a2x (ne_flip hne_a1x)
    hne_a12 hne_ax
    (G.adj_symm a a1 haa1) haa2 ha2x (G.adj_symm a1 x ha1x)

end SimpleGraph
