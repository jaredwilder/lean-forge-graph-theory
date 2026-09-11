/-
  Valid suppression neighbor exists (Wilder, Erdős-Gyárfás forge)

  At every cubic vertex y in a C₄-free graph, one neighbor is nonadjacent
  to both others. Corollary of the cubic-neighborhood matching theorem.
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

theorem ne_symm' {α : Type u} {a b : α} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- Core lemma: in C₄-free, no neighbor of a cubic vertex is adj to both others. -/
theorem c4free_no_double {V : Type u} (G : SimpleGraph V) (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    : ¬ (G.adj a b ∧ G.adj a c) := by
  intro ⟨h_ab, h_ac⟩
  exact hC4 a b v c hab hbv (ne_symm' hcv) (ne_symm' hac) hav hbc
    h_ab (G.adj_symm v b hvb) hvc (G.adj_symm a c h_ac)

/-- **Valid suppression neighbor exists.**
    Among three neighbors {a,b,c} of a cubic vertex in a C₄-free graph,
    at least one is nonadjacent to both others.
    This is the existential form: we exhibit `a` as the suppression vertex,
    handling all cases (no edges, or one edge among b-c). -/
theorem valid_suppression_neighbor_exists
    {V : Type u} [DecidableEq V] (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hav : a ≠ v) (hbv : b ≠ v) (hcv : c ≠ v)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c)
    (adj_dec : ∀ (x y : V), Decidable (G.adj x y))
    : (¬ G.adj a b ∧ ¬ G.adj a c)
    ∨ (¬ G.adj b a ∧ ¬ G.adj b c)
    ∨ (¬ G.adj c a ∧ ¬ G.adj c b) := by
  -- By contradiction on each case.
  -- If a is adj to b: then a is NOT adj to c (by c4free_no_double).
  --   If b is adj to c: then b adj a AND b adj c, contradicting c4free_no_double for b.
  --   So b is NOT adj to c. Then check c: c NOT adj to a (symm of a not adj c)... wait.
  -- Let's just case-split.
  by_cases hab_adj : G.adj a b
  · -- a is adj to b. Then a is NOT adj to c.
    have h_not_ac : ¬ G.adj a c := by
      intro h_ac
      exact c4free_no_double G hC4 v a b c hva hvb hvc hav hbv hcv hab hac hbc ⟨hab_adj, h_ac⟩
    -- Now check b: b is adj to a (symm). Is b adj to c?
    by_cases hbc_adj : G.adj b c
    · -- b adj a and b adj c. But that contradicts C4-free (cycle b-a-v-c-b).
      exfalso
      have h_ba : G.adj b a := G.adj_symm a b hab_adj
      -- 4-cycle: b → a → v → c → b
      exact hC4 b a v c (ne_symm' hab) hav (ne_symm' hcv) (ne_symm' hbc)
        hbv hac h_ba (G.adj_symm v a hva) hvc (G.adj_symm b c hbc_adj)
    · -- b NOT adj c. So c is not adj b (will show c is the suppression vertex? no, check c adj a)
      -- c not adj b follows from hbc_adj being false. Is c adj a?
      have h_not_ca : ¬ G.adj c a := by
        intro h_ca
        exact h_not_ac (G.adj_symm c a h_ca)
      have h_not_cb : ¬ G.adj c b := by
        intro h_cb
        exact hbc_adj (G.adj_symm c b h_cb)
      exact Or.inr (Or.inr ⟨h_not_ca, h_not_cb⟩)
  · -- a NOT adj b.
    by_cases hac_adj : G.adj a c
    · -- a adj c but not b. Is a adj b? No. So a has degree 1 among {b,c} — that's fine.
      -- Check c: c adj a (symm). Is c adj b?
      by_cases hcb_adj : G.adj c b
      · -- c adj a AND c adj b. Contradicts C4-free (cycle c-a-v-b-c).
        exfalso
        have h_ca : G.adj c a := G.adj_symm a c hac_adj
        exact hC4 c a v b (ne_symm' hac) hav (ne_symm' hbv) hbc
          hcv hab h_ca (G.adj_symm v a hva) hvb (G.adj_symm c b hcb_adj)
      · -- c NOT adj b. Is b adj a? No (symm of hab_adj). Is b adj c?
        have h_not_ba : ¬ G.adj b a := by
          intro h_ba
          exact hab_adj (G.adj_symm b a h_ba)
        have h_not_bc : ¬ G.adj b c := by
          intro h_bc
          exact hcb_adj (G.adj_symm b c h_bc)
        exact Or.inr (Or.inl ⟨h_not_ba, h_not_bc⟩)
    · -- a NOT adj b AND a NOT adj c. Done.
      exact Or.inl ⟨hab_adj, hac_adj⟩
