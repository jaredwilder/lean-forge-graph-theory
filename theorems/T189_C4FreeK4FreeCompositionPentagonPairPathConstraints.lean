/-
  COMPOSITION: T134 + T137 + T152 + T167 → path constraints between pentagon pairs.

  T134: Unique path length 3 / cross-edge.
  T137: Three paths / shared penultimate.
  T152: Distance rigidity.
  T167: Theta multi-path.

  Composition: path structure between two pentagons.

  In C₄-free cubic girth 5, consider two pentagons P₁, P₂.
  What paths can connect them?

  Between vertex u ∈ P₁ and vertex v ∈ P₂ (disjoint pentagons):
  The shortest path u→v has length ≥ 2 (since they're in different pentagons
  and u,v not adjacent — unless there's a bridge edge).

  Number of vertex-disjoint paths u→v:
  Menger's theorem: max disjoint paths = min vertex cut.
  3-connected (Petersen): at least 3 vertex-disjoint paths.

  But in C₄-free: multiple short paths create C₄.
  T167: Θ(2,2,k) → C₄. So at most ONE path of length 2 between any pair.
  T167: Θ(2,3,3) with cross edge → C₄.

  If u and v have a common neighbor w (path of length 2):
  u-w-v. Only ONE such w allowed (T122 / Θ(2,2) forbidden).
  Any other path u→v must have length ≥ 3.

  Two paths of length 3: u-a₁-a₂-v and u-b₁-b₂-v.
  This is Θ(3,3). Cross edges create C₄ (T167):
  If a₁ adj b₂: C₄ = u-a₁-b₂-v... wait: u-a₁-a₂-v and u-b₁-b₂-v.
  a₁ adj b₂: C₄ = a₁-a₂-v-b₂-a₁. ✓
  b₁ adj a₂: C₄ = u-b₁-a₂-a₁-u. ✓

  So: two length-3 paths → internal vertices must be non-adjacent.
  {a₁,a₂} and {b₁,b₂} form an independent set? No, just no cross edges.

  Authority: FULL_FORMALIZATION — path constraint C₄ extractions.
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

/-- Two length-3 paths, cross edge a₁-b₂:
    C₄ = a₁-a₂-v-b₂-a₁. -/
theorem c4free_parallel_paths_cross1 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a1 a2 v b2 : V)
    (ha1a2 : G.adj a1 a2) (ha2v : G.adj a2 v)
    (hvb2 : G.adj v b2) (hb2a1 : G.adj b2 a1)
    (hne1 : a1 ≠ a2) (hne2 : a2 ≠ v)
    (hne3 : v ≠ b2) (hne4 : b2 ≠ a1)
    (hne5 : a1 ≠ v) (hne6 : a2 ≠ b2)
    : False := by
  exact hC4 a1 a2 v b2
    hne1 hne2 hne3 hne4 hne5 hne6
    ha1a2 ha2v hvb2 hb2a1

/-- Two length-3 paths, cross edge b₁-a₂:
    C₄ = u-b₁-a₂-a₁-u. -/
theorem c4free_parallel_paths_cross2 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u b1 a2 a1 : V)
    (hub1 : G.adj u b1) (hb1a2 : G.adj b1 a2)
    (ha2a1 : G.adj a2 a1) (ha1u : G.adj a1 u)
    (hne1 : u ≠ b1) (hne2 : b1 ≠ a2)
    (hne3 : a2 ≠ a1) (hne4 : a1 ≠ u)
    (hne5 : u ≠ a2) (hne6 : b1 ≠ a1)
    : False := by
  exact hC4 u b1 a2 a1
    hne1 hne2 hne3 hne4 hne5 hne6
    hub1 hb1a2 ha2a1 ha1u

/-- Length-2 and length-3 path:
    u-w-v (length 2) and u-a₁-a₂-v (length 3).
    Θ(2,3). If w adj a₂: C₄ = w-v-a₂-? No...
    w-a₂: C₄ = u-w-a₂-a₁-u. -/
theorem c4free_paths_23_cross (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u w a2 a1 : V)
    (huw : G.adj u w) (hwa2 : G.adj w a2)
    (ha2a1 : G.adj a2 a1) (ha1u : G.adj a1 u)
    (hne1 : u ≠ w) (hne2 : w ≠ a2)
    (hne3 : a2 ≠ a1) (hne4 : a1 ≠ u)
    (hne5 : u ≠ a2) (hne6 : w ≠ a1)
    : False := by
  exact hC4 u w a2 a1
    hne1 hne2 hne3 hne4 hne5 hne6
    huw hwa2 ha2a1 ha1u

end SimpleGraph
