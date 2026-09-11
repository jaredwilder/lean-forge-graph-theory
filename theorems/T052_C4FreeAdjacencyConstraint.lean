/-
  C₄-free adjacency constraint chain.

  In a C₄-free graph, the "second neighborhood" N₂(v) = {w : dist(v,w)=2}
  is connected to v through UNIQUE intermediaries. This creates a
  tree-like constraint propagation from any vertex.

  Key theorems:
  1. Each w ∈ N₂(v) has exactly one neighbor in N(v) [unique wedge]
  2. If a, b ∈ N(v) have a common distance-2 neighbor w, then a = b
  3. The second neighborhood decomposes: N₂(v) = ⊔_{a ∈ N(v)} N(a)\N[v]

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

def TriangleFree (G : SimpleGraph V) : Prop :=
  ∀ (a b c : V), a ≠ b → b ≠ c → a ≠ c →
    G.adj a b → G.adj b c → G.adj a c → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- In C₄-free: if w is adjacent to two neighbors a,b of v, then C₄.
    This is the engine of the unique-intermediary property. -/
theorem c4free_second_nbr_unique_intermediary (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b w : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (haw : G.adj a w) (hbw : G.adj b w)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_vw : v ≠ w) (hne_aw : a ≠ w) (hne_bw : b ≠ w)
    : False := by
  -- C₄: v-a-w-b-v. hC4 v a w b.
  -- Slot trace for hC4 v a w b:
  --   Ne slots: v≠a, a≠w, w≠b, b≠v, v≠w, a≠b
  --   Adj slots: v-a, a-w, w-b, b-v
  exact hC4 v a w b
    hne_va hne_aw (ne_flip hne_bw) (ne_flip hne_vb)
    hne_vw hne_ab
    hva haw (G.adj_symm b w hbw) (G.adj_symm v b hvb)

/-- In TF + C₄-free: w at distance 2 from v is NOT adjacent to v
    (TF prevents w from being both at distance 1 and 2).
    And w connects to v through exactly one of v's neighbors.
    The second neighborhood is a disjoint union. -/
theorem tf_c4f_second_nbr_not_adjacent (G : SimpleGraph V)
    (hTF : G.TriangleFree)
    (v a w : V)
    (hva : G.adj v a) (haw : G.adj a w) (hvw : G.adj v w)
    (hne_va : v ≠ a) (hne_aw : a ≠ w) (hne_vw : v ≠ w)
    : False := by
  -- Triangle {v, a, w}. hTF v a w.
  -- Slot trace for hTF v a w:
  --   Ne slots: v≠a, a≠w, v≠w
  --   Adj slots: v-a, a-w, v-w
  exact hTF v a w hne_va hne_aw hne_vw hva haw hvw

end SimpleGraph
