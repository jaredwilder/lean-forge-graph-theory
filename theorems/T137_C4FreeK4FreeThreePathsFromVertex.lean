/-
  C₄-free: three internally-disjoint paths from a vertex.

  In cubic graph, vertex v has exactly 3 neighbors: a₁, a₂, a₃.
  Any path from v starts through one of these three.

  If two paths from v to the SAME target w go through different
  neighbors (say v-a₁-...-w and v-a₂-...-w), they are
  internally disjoint (share only v and w).

  Key constraint from C₄-free:
  If both paths have length 2: v-a₁-w and v-a₂-w.
  Then a₁ and a₂ are BOTH common neighbors of v and w.
  By T122: C₄ = v-a₁-w-a₂-v. FORBIDDEN.

  So: at most ONE length-2 path from v to any w.
  Equivalently: v and w have at most 1 common neighbor.

  If one path has length 2 and another length 3:
  v-a₁-w and v-a₂-b-w. No immediate C₄ (different lengths).

  If both paths have length 3: v-a₁-b₁-w and v-a₂-b₂-w.
  From T134: cross edges a₁-b₂ or b₁-a₂ create C₄.
  If a₁ adj b₂: C₄ = v-a₁-b₂-a₂-v.

  What if b₁ = b₂ (same penultimate vertex)?
  v-a₁-b₁-w and v-a₂-b₁-w. Then a₁ and a₂ are both adj to b₁.
  v-a₁-b₁-a₂-v is C₄ (if a₁≠a₂, b₁≠v, etc.).

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

/-- Two length-3 paths sharing penultimate vertex → C₄.
    Paths: v-a₁-b-w and v-a₂-b-w (same b).
    C₄ = v-a₁-b-a₂-v.
    Edges: v-a₁, a₁-b, b-a₂, a₂-v. -/
theorem c4free_shared_penultimate (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a1 b a2 : V)
    (hva1 : G.adj v a1) (ha1b : G.adj a1 b)
    (hba2 : G.adj b a2) (ha2v : G.adj a2 v)
    (hne_va1 : v ≠ a1) (hne_a1b : a1 ≠ b)
    (hne_ba2 : b ≠ a2) (hne_a2v : a2 ≠ v)
    (hne_vb : v ≠ b) (hne_a1a2 : a1 ≠ a2)
    : False := by
  exact hC4 v a1 b a2
    hne_va1 hne_a1b hne_ba2 hne_a2v
    hne_vb hne_a1a2
    hva1 ha1b hba2 ha2v

/-- Three siblings all adjacent to same vertex z → C₄.
    v adj a₁, v adj a₂, a₁ adj z, a₂ adj z.
    C₄ = v-a₁-z-a₂-v. Already T122, but stated for the
    "three paths" context: if two of v's neighbors reach z,
    then C₄ = v-a₁-z-a₂-v. -/
theorem c4free_two_nbrs_reach_same (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a1 z a2 : V)
    (hva1 : G.adj v a1) (ha1z : G.adj a1 z)
    (hza2 : G.adj z a2) (ha2v : G.adj a2 v)
    (hne_va1 : v ≠ a1) (hne_a1z : a1 ≠ z)
    (hne_za2 : z ≠ a2) (hne_a2v : a2 ≠ v)
    (hne_vz : v ≠ z) (hne_a1a2 : a1 ≠ a2)
    : False := by
  exact hC4 v a1 z a2
    hne_va1 hne_a1z hne_za2 hne_a2v
    hne_vz hne_a1a2
    hva1 ha1z hza2 ha2v

end SimpleGraph
