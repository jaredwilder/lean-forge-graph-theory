/-
  C₄-free distance-two structure.

  The distance-2 neighborhood N₂(v) in a C₄-free graph has a
  partition property: each w ∈ N₂(v) has EXACTLY ONE neighbor
  in N(v). This creates a tree-like structure in the 2-ball.

  For cubic C₄-free:
  - N₁(v) = {a, b, c}, |N₁| = 3
  - Each of a, b, c has 2 other neighbors (degree 3, minus v)
  - All 6 distance-2 vertices are distinct (C₄-free prevents overlap)
  - So |N₂(v)| = 6, |B₂(v)| = 10

  The partition: N₂(v) = {a₁,a₂} ∪ {b₁,b₂} ∪ {c₁,c₂}
  where a₁,a₂ ∈ N(a)\{v}, etc. No edges between these parts
  (C₄-free prevents cross-edges).

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

/-- Cross-part exclusion: a₁ (neighbor of a, distance 2 from v) is
    NOT adjacent to b (another neighbor of v). If a₁ adj b, then
    v-a-a₁-b-v is C₄. -/
theorem c4free_d2_no_cross_edge (G : SimpleGraph V)
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

/-- Same-part exclusion: a₁ and a₂ (both neighbors of a, distance 2
    from v) cannot BOTH be adjacent to the same vertex w outside the
    2-ball. If a₁ adj w and a₂ adj w, then a₁-a-a₂-w-a₁ is C₄. -/
theorem c4free_d2_same_part_no_shared_d3 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a a1 a2 w : V)
    (haa1 : G.adj a a1) (haa2 : G.adj a a2)
    (ha1w : G.adj a1 w) (ha2w : G.adj a2 w)
    (hne_a12 : a1 ≠ a2)
    (hne_aa1 : a ≠ a1) (hne_aa2 : a ≠ a2)
    (hne_a1w : a1 ≠ w) (hne_a2w : a2 ≠ w) (hne_aw : a ≠ w)
    : False := by
  -- C₄: a1-a-a2-w-a1. hC4 a1 a a2 w.
  -- (a=a1, b=a, c=a2, d=w)
  -- Ne1: a1≠a = ne_flip hne_aa1
  -- Ne2: a≠a2 = hne_aa2
  -- Ne3: a2≠w = hne_a2w
  -- Ne4: w≠a1 = ne_flip hne_a1w
  -- Ne5: a1≠a2 = hne_a12
  -- Ne6: a≠w = hne_aw
  exact hC4 a1 a a2 w
    (ne_flip hne_aa1) hne_aa2 hne_a2w (ne_flip hne_a1w)
    hne_a12 hne_aw
    (G.adj_symm a a1 haa1) haa2 ha2w (G.adj_symm a1 w ha1w)

end SimpleGraph
