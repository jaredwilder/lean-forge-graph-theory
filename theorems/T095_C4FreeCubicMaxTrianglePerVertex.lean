/-
  C₄-free cubic: at most one triangle per vertex.

  Vertex v in cubic graph: N(v) = {a,b,c}, degree 3.
  If triangle (v,a,b): uses edges v-a, v-b, a-b.
  If second triangle at v: must use v-c and one of {v-a, v-b}.
  Case 1: triangle (v,a,c): shares edge v-a with (v,a,b).
    Book at v-a → C₄: b-v-c-a-b.
  Case 2: triangle (v,b,c): shares edge v-b with (v,a,b).
    Book at v-b → C₄: a-v-c-b-a.

  So: at most ONE triangle per vertex.

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

/-- Case 1: second triangle (v,a,c) with first (v,a,b).
    Book at v-a → C₄: b-v-c-a-b. -/
theorem c4free_cubic_one_triangle_case1 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hvc : G.adj v c) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_vc : v ≠ c) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : False := by
  -- C₄: b-v-c-a-b. hC4 b v c a.
  -- (a=b, b=v, c=c, d=a)
  -- Ne1: b≠v = ne_flip hne_vb
  -- Ne2: v≠c = hne_vc
  -- Ne3: c≠a = ne_flip hne_ac
  -- Ne4: a≠b = hne_ab
  -- Ne5: b≠c = hne_bc
  -- Ne6: v≠a = hne_va
  -- Adj1: G.adj b v = adj_symm v b hvb
  -- Adj2: G.adj v c = hvc ✓
  -- Adj3: G.adj c a = adj_symm a c hac
  -- Adj4: G.adj a b = hab ✓
  exact hC4 b v c a
    (ne_flip hne_vb) hne_vc (ne_flip hne_ac) hne_ab
    hne_bc hne_va
    (G.adj_symm v b hvb) hvc (G.adj_symm a c hac) hab

/-- Case 2: second triangle (v,b,c) with first (v,a,b).
    Book at v-b → C₄: a-v-c-b-a. -/
theorem c4free_cubic_one_triangle_case2 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hvc : G.adj v c) (hbc : G.adj b c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_vc : v ≠ c) (hne_bc : b ≠ c) (hne_ac : a ≠ c)
    : False := by
  -- C₄: a-v-c-b-a. hC4 a v c b.
  -- (a=a, b=v, c=c, d=b)
  -- Ne1: a≠v = ne_flip hne_va
  -- Ne2: v≠c = hne_vc
  -- Ne3: c≠b = ne_flip hne_bc
  -- Ne4: b≠a = ne_flip hne_ab
  -- Ne5: a≠c = hne_ac
  -- Ne6: v≠b = hne_vb
  -- Adj1: G.adj a v = adj_symm v a hva
  -- Adj2: G.adj v c = hvc ✓
  -- Adj3: G.adj c b = adj_symm b c hbc
  -- Adj4: G.adj b a = adj_symm a b hab
  exact hC4 a v c b
    (ne_flip hne_va) hne_vc (ne_flip hne_bc) (ne_flip hne_ab)
    hne_ac hne_vb
    (G.adj_symm v a hva) hvc (G.adj_symm b c hbc) (G.adj_symm a b hab)

end SimpleGraph
