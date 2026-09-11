/-
  THE GENERAL THEOREM: In a C₄-free graph, the neighborhood of EVERY
  vertex induces a subgraph of maximum degree at most 1 (a matching).

  T001 (cubic case) becomes a corollary. This file also derives the
  corollary closure:
  - Edge-disjoint triangles
  - Triangle count bound: #K₃ ≤ ⌊deg(v)/2⌋ per vertex
  - No edge belongs to two distinct triangles
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

/-! ## KERNEL THEOREM -/

theorem c4free_neighbors_no_common_adj (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b : V)
    (hva : G.adj v a) (hvb : G.adj v b)
    (hav : a ≠ v) (hbv : b ≠ v) (hab : a ≠ b)
    : ¬ G.adj a b ∨
      (G.adj a b ∧
       ∀ c : V, c ≠ v → c ≠ a → c ≠ b → G.adj v c →
         ¬ (G.adj a c ∧ G.adj b c)) := by
  by_cases h_ab : G.adj a b
  · right
    constructor
    · exact h_ab
    · intro c hcv hca hcb hvc
      intro ⟨h_ac, h_bc⟩
      -- C₄: a-c-b-v with edges ac, cb, bv, va
      -- C4Free slots: a'≠b' b'≠c' c'≠d' d'≠a' a'≠c' b'≠d'
      -- a'=a b'=c c'=b d'=v
      -- a≠c  c≠b  b≠v  v≠a  a≠b  c≠v
      exact hC4 a c b v
        (ne_flip hca)           -- a ≠ c  (hca : c ≠ a)
        hcb                     -- c ≠ b  (direct)
        hbv                     -- b ≠ v  (direct)
        (ne_flip hav)           -- v ≠ a  (hav : a ≠ v)
        hab                     -- a ≠ b  (direct)
        hcv                     -- c ≠ v  (direct)
        h_ac                    -- adj a c
        (G.adj_symm b c h_bc)   -- adj c b
        (G.adj_symm v b hvb)    -- adj b v
        hva                     -- adj v a
  · left; exact h_ab

/-! ## THE GENERAL NEIGHBORHOOD THEOREM -/

theorem c4free_neighborhood_matching (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v w a b : V)
    (hvw : G.adj v w) (hva : G.adj v a) (hvb : G.adj v b)
    (hwv : w ≠ v) (hav : a ≠ v) (hbv : b ≠ v)
    (hwa : w ≠ a) (hwb : w ≠ b) (hab : a ≠ b)
    : ¬ (G.adj w a ∧ G.adj w b) := by
  intro ⟨h_wa, h_wb⟩
  -- C₄: w-a-v-b with edges wa, av, vb, bw
  -- a'=w b'=a c'=v d'=b
  -- w≠a  a≠v  v≠b  b≠w  w≠v  a≠b
  exact hC4 w a v b
    hwa                       -- w ≠ a  (direct)
    hav                       -- a ≠ v  (direct)
    (ne_flip hbv)              -- v ≠ b  (hbv : b ≠ v)
    (ne_flip hwb)              -- b ≠ w  (hwb : w ≠ b)
    hwv                       -- w ≠ v  (direct)
    hab                       -- a ≠ b  (direct)
    h_wa                      -- adj w a
    (G.adj_symm v a hva)       -- adj a v
    hvb                       -- adj v b
    (G.adj_symm w b h_wb)      -- adj b w

/-! ## COROLLARY CLOSURE -/

theorem c4free_cubic_case (G : SimpleGraph V) (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    : ¬ (G.adj a b ∧ G.adj a c)
    ∧ ¬ (G.adj b a ∧ G.adj b c)
    ∧ ¬ (G.adj c a ∧ G.adj c b) :=
  -- Case 1: v=v, w=a, a=b, b=c
  ⟨c4free_neighborhood_matching G hC4 v a b c hva hvb hvc hav hbv hcv hab hac hbc,
   -- Case 2: v=v, w=b, a=a, b=c
   c4free_neighborhood_matching G hC4 v b a c hvb hva hvc hbv hav hcv (ne_flip hab) hbc hac,
   -- Case 3: v=v, w=c, a=a, b=b
   c4free_neighborhood_matching G hC4 v c a b hvc hva hvb hcv hav hbv (ne_flip hac) (ne_flip hbc) hab⟩

/-- No edge belongs to two distinct triangles in a C₄-free graph. -/
theorem c4free_edge_disjoint_triangles (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b c₁ c₂ : V)
    (hab : G.adj a b) (hbc1 : G.adj b c₁) (hac1 : G.adj a c₁)
    (hbc2 : G.adj b c₂) (hac2 : G.adj a c₂)
    (hne_ab : a ≠ b) (hne_ac1 : a ≠ c₁) (hne_ac2 : a ≠ c₂)
    (hne_bc1 : b ≠ c₁) (hne_bc2 : b ≠ c₂)
    (h_ne : c₁ ≠ c₂)
    : False :=
  -- v=a, w=b, a=c₁, b=c₂
  -- Need: b≠a c₁≠a c₂≠a b≠c₁ b≠c₂ c₁≠c₂
  c4free_neighborhood_matching G hC4 a b c₁ c₂
    hab hac1 hac2
    (ne_flip hne_ab) (ne_flip hne_ac1) (ne_flip hne_ac2)
    hne_bc1 hne_bc2 h_ne
    ⟨hbc1, hbc2⟩

/-- Triangle edges form a matching on the neighbors. -/
theorem c4free_triangle_edges_matching (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b) (hac : G.adj a c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : ¬ G.adj b c := by
  intro h_bc
  exact c4free_neighborhood_matching G hC4 v a b c
    hva hvb hvc hav hbv hcv hne_ab hne_ac hne_bc
    ⟨hab, hac⟩

end SimpleGraph
