/-
  Joint C₄-free + K₄-free structural theorems.

  When G is BOTH C₄-free and K₄-free, the neighborhood of every vertex
  is both triangle-free (from K₄-free) and matching-bounded (from C₄-free).
  Together: N(v) is a matching (max degree 1, triangle-free).

  This is the structural core of the Erdős-Gyárfás argument for
  minimum counterexamples: every link is a matching, so every vertex
  sees at most ⌊deg(v)/2⌋ triangles, all edge-disjoint.

  Authority: STRUCTURAL_CORE — complete graph theorem, no missing semantics.
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

/-- In a C₄-free + K₄-free graph, any two neighbors of v that are
    adjacent to each other cannot BOTH be adjacent to any third
    neighbor of v. (Matching + triangle-free combined.) -/
theorem joint_neighborhood_matching (G : SimpleGraph V)
    (hC4 : G.C4Free) (hK4 : G.K4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    : ¬ (G.adj a b ∧ G.adj a c) := by
  intro ⟨h_ab, h_ac⟩
  -- From C₄-free: v-a-b-?-v and v-a-c-?-v. The general matching
  -- theorem says a can't be adj to both b and c (both neighbors of v).
  -- C₄: a-b-v-c with edges ab, bv, vc, ca
  exact hC4 a b v c
    hab                    -- a ≠ b
    hbv                    -- b ≠ v
    (ne_flip hcv)           -- v ≠ c
    (ne_flip hac)           -- c ≠ a
    hav                    -- a ≠ v
    hbc                    -- b ≠ c
    h_ab                   -- adj a b
    (G.adj_symm v b hvb)    -- adj b v
    hvc                    -- adj v c
    (G.adj_symm a c h_ac)   -- adj c a

/-- K₄-free gives us triangle-free link. If a,b,c are all in N(v) and
    form a triangle, we get K₄. -/
theorem k4free_link_no_triangle (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b) (hbc : G.adj b c) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_bc : b ≠ c) (hne_ac : a ≠ c)
    : False :=
  hK4 v a b c
    hne_va hne_vb hne_vc
    hne_ab hne_ac hne_bc
    hva hvb hvc
    hab hac hbc

/-- In the joint C₄-free + K₄-free setting, every edge in N(v) is
    isolated: if a-b is an edge among neighbors of v, then a and b
    share no other common neighbor in N(v). -/
theorem joint_edge_isolated (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (v a b w : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvw : G.adj v w)
    (hab : G.adj a b)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vw : v ≠ w)
    (hne_ab : a ≠ b) (hne_aw : a ≠ w) (hne_bw : b ≠ w)
    : ¬ (G.adj a w ∧ G.adj b w) := by
  intro ⟨haw, hbw⟩
  exact hK4 v a b w
    hne_va hne_vb hne_vw
    hne_ab hne_aw hne_bw
    hva hvb hvw
    hab haw hbw

end SimpleGraph
