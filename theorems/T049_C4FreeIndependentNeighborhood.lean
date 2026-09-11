/-
  C₄-free independent neighborhood.

  In a C₄-free graph, if v has two non-adjacent neighbors a and b,
  then a and b share no common neighbor other than v.

  Proof: if w ≠ v is adjacent to both a and b, then v-a-w-b-v is C₄.

  This means: in the link graph L(v) of vertex v, every independent
  edge {a,b} in L(v) has the property that a and b are "exclusively
  connected" through v at distance 2.

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

/-- Non-adjacent neighbors of v in a C₄-free graph share no
    common neighbor besides v. -/
theorem c4free_independent_exclusive (G : SimpleGraph V)
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

/-- If v has neighbors a, b, c all pairwise non-adjacent (independent
    set in link), then no vertex w ≠ v can be adjacent to two of them.
    (Adjacent to a and b → C₄ via v.) -/
theorem c4free_independent_triple_isolated (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c w : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (haw : G.adj a w) (hbw : G.adj b w)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_vw : v ≠ w) (hne_aw : a ≠ w) (hne_bw : b ≠ w)
    : False := by
  exact c4free_independent_exclusive G hC4 v a b w
    hva hvb haw hbw
    hne_va hne_vb hne_ab hne_vw hne_aw hne_bw

/-- Distance-2 uniqueness: if a and b are at distance 2 from each
    other (both adjacent to v, not adjacent to each other), then in
    C₄-free, v is the UNIQUE common neighbor of a and b.
    Any other common neighbor w creates C₄. -/
theorem c4free_distance2_unique_witness (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b v w : V)
    (hav : G.adj a v) (hbv : G.adj b v)
    (haw : G.adj a w) (hbw : G.adj b w)
    (hne_vw : v ≠ w)
    (hne_ab : a ≠ b) (hne_av : a ≠ v) (hne_bv : b ≠ v)
    (hne_aw : a ≠ w) (hne_bw : b ≠ w)
    : False := by
  -- C₄: a-v-b-w-a. hC4 a v b w.
  -- Slot trace for hC4 a v b w:
  --   Ne slots: a≠v, v≠b, b≠w, w≠a, a≠b, v≠w
  --   Adj slots: a-v, v-b, b-w, w-a
  exact hC4 a v b w
    hne_av (ne_flip hne_bv) hne_bw (ne_flip hne_aw)
    hne_ab hne_vw
    hav (G.adj_symm b v hbv) hbw (G.adj_symm a w haw)

end SimpleGraph
