/-
  COMPOSITION: T137 + T145 + T134 → theta/multi-path structure.

  T137: Three internally disjoint paths from v → shared penultimate → C₄.
  T134: Unique path length 3 / cross-edge forbidden → C₄.
  T145: Theta graph Θ(2,3,3) cross edge → C₄.

  Composition: multi-path structure in C₄-free graphs.

  Theta graph Θ(a,b,c): two vertices u,v connected by 3 internally
  disjoint paths of lengths a,b,c.

  T145: Θ(2,3,3) with cross edge → C₄. But even without cross edge:
  Θ(2,2,k) for any k: paths of length 2 and 2 from u to v.
  u-a-v and u-b-v. Then C₄ = u-a-v-b-u. ALWAYS FORBIDDEN.

  So: C₄-free → no Θ(2,2,k). At most ONE path of length 2 between
  any pair u,v. (T122 restated: at most 1 common neighbor.)

  Θ(2,3,k): path u-a-v (length 2) and path u-b₁-b₂-v (length 3).
  No C₄ directly from these two paths (lengths 2+3 = 5-cycle).

  Θ(2,3,3): path u-a-v, path u-b₁-b₂-v, path u-c₁-c₂-v.
  From paths 2 and 3: u-b₁-b₂-v-c₂-c₁-u = 6-cycle.
  No direct C₄ without cross edge.

  T145: if b₁ adj c₁ (cross edge): C₄ = u-b₁-c₁-u... triangle!
  Wait: u adj b₁ and u adj c₁. If b₁ adj c₁: triangle u-b₁-c₁.
  Girth ≥ 4 forbids. This is even simpler than C₄.

  Actual cross edge in Θ(2,3,3): b₁ adj c₂.
  C₄ = b₁-b₂-v-c₂-b₁. Edges: b₁-b₂, b₂-v, v-c₂, c₂-b₁.
  4 vertices, 4 edges. Yes! C₄.
  Ne: b₁≠b₂, b₂≠v, v≠c₂, c₂≠b₁, b₁≠v(?), b₂≠c₂.

  Θ(3,3,3): all paths length 3.
  u-a₁-a₂-v, u-b₁-b₂-v, u-c₁-c₂-v.
  Cross edge a₁-b₂: C₄ = a₁-a₂-v-b₂-a₁.
  Cross edge a₂-b₁: C₄ = u-a₁... wait: a₂-b₁, hmm.
  u-b₁-a₂-a₁-u? Need b₁ adj a₂ and a₁ adj u and b₁ adj u.
  C₄ = u-a₁-a₂-b₁-u. Edges: u-a₁, a₁-a₂, a₂-b₁, b₁-u. Valid!

  Authority: FULL_FORMALIZATION — theta graph C₄ extractions.
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

/-- Θ(2,2,k): two paths of length 2 between u,v.
    u-a-v and u-b-v. C₄ = u-a-v-b-u. -/
theorem c4free_no_theta_22k (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u a v b : V)
    (hua : G.adj u a) (hav : G.adj a v)
    (hvb : G.adj v b) (hbu : G.adj b u)
    (hne1 : u ≠ a) (hne2 : a ≠ v)
    (hne3 : v ≠ b) (hne4 : b ≠ u)
    (hne5 : u ≠ v) (hne6 : a ≠ b)
    : False := by
  exact hC4 u a v b
    hne1 hne2 hne3 hne4 hne5 hne6
    hua hav hvb hbu

/-- Θ(2,3,3) cross edge b₁-c₂: C₄ = b₁-b₂-v-c₂-b₁.
    Paths: u-a-v, u-b₁-b₂-v, u-c₁-c₂-v.
    Cross: b₁ adj c₂. -/
theorem c4free_theta_233_cross (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (b1 b2 v c2 : V)
    (hb1b2 : G.adj b1 b2) (hb2v : G.adj b2 v)
    (hvc2 : G.adj v c2) (hc2b1 : G.adj c2 b1)
    (hne1 : b1 ≠ b2) (hne2 : b2 ≠ v)
    (hne3 : v ≠ c2) (hne4 : c2 ≠ b1)
    (hne5 : b1 ≠ v) (hne6 : b2 ≠ c2)
    : False := by
  exact hC4 b1 b2 v c2
    hne1 hne2 hne3 hne4 hne5 hne6
    hb1b2 hb2v hvc2 hc2b1

/-- Θ(3,3,3) cross edge a₂-b₁: C₄ = u-a₁-a₂-b₁-u.
    Paths: u-a₁-a₂-v, u-b₁-b₂-v.
    Cross: a₂ adj b₁. -/
theorem c4free_theta_333_cross (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u a1 a2 b1 : V)
    (hua1 : G.adj u a1) (ha1a2 : G.adj a1 a2)
    (ha2b1 : G.adj a2 b1) (hb1u : G.adj b1 u)
    (hne1 : u ≠ a1) (hne2 : a1 ≠ a2)
    (hne3 : a2 ≠ b1) (hne4 : b1 ≠ u)
    (hne5 : u ≠ a2) (hne6 : a1 ≠ b1)
    : False := by
  exact hC4 u a1 a2 b1
    hne1 hne2 hne3 hne4 hne5 hne6
    hua1 ha1a2 ha2b1 hb1u

/-- Θ(3,3,3) deep cross a₁-b₂: C₄ = a₁-a₂-v-b₂-a₁.
    Same theta, different cross edge position. -/
theorem c4free_theta_333_deep_cross (G : SimpleGraph V)
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

end SimpleGraph
