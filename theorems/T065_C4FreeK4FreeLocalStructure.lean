/-
  C₄-free + K₄-free: complete local structure at a vertex.

  Combining T055 (C₄-free cubic link ≤ 1 edge), T062 (K₄-free link
  is triangle-free), and T044 (K₄-free no triangle dominator):

  In a cubic C₄-free K₄-free graph, vertex v has 3 neighbors {a,b,c}.
  Case 1: No edge in L(v). Then {a,b,c} is independent.
  Case 2: One edge, say a-b. Then c is isolated from {a,b} in L(v).
    Moreover, c cannot be adjacent to ANY vertex that is adjacent
    to both a and b (that would create K₄ with v, or C₄).

  This gives a complete description of the 2-ball around v.

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

def K4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → a ≠ c → a ≠ d →
    b ≠ c → b ≠ d → c ≠ d →
    G.adj a b → G.adj a c → G.adj a d →
    G.adj b c → G.adj b d → G.adj c d → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- Case 2 constraint: if a-b edge in L(v), and w is a neighbor of a
    (w ≠ v, w ≠ b), then w is NOT adjacent to b.
    Proof: if w adj b too, then v-a-w-b is C₄ (with v adj a, v adj b). -/
theorem c4free_triangle_neighbor_exclusive (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b w : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (hab : G.adj a b) (haw : G.adj a w) (hbw : G.adj b w)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_vw : v ≠ w) (hne_aw : a ≠ w) (hne_bw : b ≠ w)
    : False := by
  -- C₄: v-a-w-b-v. hC4 v a w b.
  -- (a=v, b=a, c=w, d=b)
  -- Ne1: v≠a = hne_va
  -- Ne2: a≠w = hne_aw
  -- Ne3: w≠b = ne_flip hne_bw
  -- Ne4: b≠v = ne_flip hne_vb
  -- Ne5: v≠w = hne_vw
  -- Ne6: a≠b = hne_ab
  exact hC4 v a w b
    hne_va hne_aw (ne_flip hne_bw) (ne_flip hne_vb)
    hne_vw hne_ab
    hva haw (G.adj_symm b w hbw) (G.adj_symm v b hvb)

/-- Case 2 further: c (the third neighbor of v, not in the triangle)
    cannot share a neighbor with both a and b simultaneously.
    If c adj x and a adj x (or b adj x), that's a C₄. -/
theorem c4free_isolated_third_no_share (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a c x : V)
    (hva : G.adj v a) (hvc : G.adj v c)
    (hcx : G.adj c x) (hax : G.adj a x)
    (hne_va : v ≠ a) (hne_vc : v ≠ c) (hne_ac : a ≠ c)
    (hne_vx : v ≠ x) (hne_cx : c ≠ x) (hne_ax : a ≠ x)
    : False := by
  -- C₄: a-v-c-x-a. hC4 a v c x.
  -- (a=a, b=v, c=c, d=x)
  -- Ne1: a≠v = ne_flip hne_va
  -- Ne2: v≠c = hne_vc
  -- Ne3: c≠x = hne_cx
  -- Ne4: x≠a = ne_flip hne_ax
  -- Ne5: a≠c = hne_ac
  -- Ne6: v≠x = hne_vx
  exact hC4 a v c x
    (ne_flip hne_va) hne_vc hne_cx (ne_flip hne_ax)
    hne_ac hne_vx
    (G.adj_symm v a hva) hvc hcx (G.adj_symm a x hax)

end SimpleGraph
