/-
  C4-free cubic-neighborhood matching theorem

  From Jared Wilder's Erdős-Gyárfás power-cycle theorem inventory.

  Theorem: In a C₄-free graph, the subgraph induced by the three neighbors
  of a degree-3 vertex has maximum degree at most 1.

  Formalized in Lean 4 (standalone, no Mathlib).
-/

universe u

structure SimpleGraph (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

def SimpleGraph.C4Free {V : Type u} (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → b ≠ c → c ≠ d → d ≠ a →
    a ≠ c → b ≠ d →
    G.adj a b → G.adj b c → G.adj c d → G.adj d a → False

-- Helper: flip ≠
theorem ne_symm {α : Type u} {a b : α} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- If `v` has three distinct neighbors `a`, `b`, `c` in a C₄-free graph,
    then `a` is not adjacent to both `b` and `c`.
    Proof: edges ab, bv, vc, ca form a C₄. -/
theorem c4free_cubic_no_double_adj
    {V : Type u} (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    : ¬ (G.adj a b ∧ G.adj a c) := by
  intro ⟨h_ab, h_ac⟩
  -- 4-cycle (a, b, v, c): edges ab, bv, vc, ca
  -- C4Free slots: (a, b, c, d) = (a, b, v, c)
  -- Need: a≠b, b≠v, v≠c, c≠a, a≠v, b≠c
  -- adj: ab, bv, vc, ca
  exact hC4 a b v c
    hab                          -- a ≠ b
    hbv                          -- b ≠ v
    (ne_symm hcv)                -- v ≠ c
    (ne_symm hac)                -- c ≠ a
    hav                          -- a ≠ v
    hbc                          -- b ≠ c
    h_ab                         -- adj a b
    (G.adj_symm v b hvb)         -- adj b v
    hvc                          -- adj v c
    (G.adj_symm a c h_ac)        -- adj c a

/-- Symmetric: `b` is not adjacent to both `a` and `c`. -/
theorem c4free_cubic_no_double_adj_b
    {V : Type u} (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    : ¬ (G.adj b a ∧ G.adj b c) := by
  intro ⟨h_ba, h_bc⟩
  -- 4-cycle (b, a, v, c): edges ba, av, vc, cb
  -- C4Free slots (A,B,C,D) = (b,a,v,c)
  -- A≠B=b≠a, B≠C=a≠v, C≠D=v≠c, D≠A=c≠b, A≠C=b≠v, B≠D=a≠c
  exact hC4 b a v c
    (ne_symm hab)                -- b ≠ a
    hav                          -- a ≠ v
    (ne_symm hcv)                -- v ≠ c
    (ne_symm hbc)                -- c ≠ b
    hbv                          -- b ≠ v
    hac                          -- a ≠ c
    h_ba                         -- adj b a
    (G.adj_symm v a hva)         -- adj a v
    hvc                          -- adj v c
    (G.adj_symm b c h_bc)        -- adj c b

/-- Symmetric: `c` is not adjacent to both `a` and `b`. -/
theorem c4free_cubic_no_double_adj_c
    {V : Type u} (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    : ¬ (G.adj c a ∧ G.adj c b) := by
  intro ⟨h_ca, h_cb⟩
  -- 4-cycle (c, a, v, b): edges ca, av, vb, bc
  -- C4Free slots (A,B,C,D) = (c,a,v,b)
  -- A≠B=c≠a, B≠C=a≠v, C≠D=v≠b, D≠A=b≠c, A≠C=c≠v, B≠D=a≠b
  exact hC4 c a v b
    (ne_symm hac)                -- c ≠ a
    hav                          -- a ≠ v
    (ne_symm hbv)                -- v ≠ b
    hbc                          -- b ≠ c
    hcv                          -- c ≠ v
    hab                          -- a ≠ b
    h_ca                         -- adj c a
    (G.adj_symm v a hva)         -- adj a v
    hvb                          -- adj v b
    (G.adj_symm c b h_cb)        -- adj b c

/-- **Main result: max degree ≤ 1 in the neighborhood subgraph.**
    Among three neighbors of a cubic vertex in a C₄-free graph, no vertex
    is adjacent to both others — the edges form a matching. -/
theorem c4free_cubic_neighborhood_matching
    {V : Type u} (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    : ¬ (G.adj a b ∧ G.adj a c)
    ∧ ¬ (G.adj b a ∧ G.adj b c)
    ∧ ¬ (G.adj c a ∧ G.adj c b) :=
  ⟨c4free_cubic_no_double_adj G hC4 v a b c hva hvb hvc hav hbv hcv hab hac hbc,
   c4free_cubic_no_double_adj_b G hC4 v a b c hva hvb hvc hav hbv hcv hab hac hbc,
   c4free_cubic_no_double_adj_c G hC4 v a b c hva hvb hvc hav hbv hcv hab hac hbc⟩
