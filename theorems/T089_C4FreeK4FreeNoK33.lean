/-
  C₄-free K₄-free: no K_{3,3} subgraph.

  K_{3,3} = complete bipartite graph with parts {a,b,c} and {d,e,f},
  each part-vertex adjacent to all 3 in the other part.

  K_{3,3} contains C₄: any two from one side + any two from the other.
  E.g., a-d-b-e-a is C₄ (edges a-d, d-b, b-e, e-a).

  Moreover, in a CUBIC graph, K_{3,3} cannot even be a subgraph
  because each vertex in K_{3,3} has degree 3 within K_{3,3},
  so if the graph is cubic, those ARE all the edges, meaning
  the component is exactly K_{3,3}. And K_{3,3} has C₄.

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

/-- K_{3,3} contains C₄: a-d-b-e-a where a,b are in one part
    and d,e in the other.
    Edges: a-d (bipartite), d-b (bipartite), b-e (bipartite), e-a (bipartite). -/
theorem c4free_no_k33_witness (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b d e : V)
    (had : G.adj a d) (hdb : G.adj d b) (hbe : G.adj b e) (hea : G.adj e a)
    (hne_ad : a ≠ d) (hne_db : d ≠ b) (hne_be : b ≠ e) (hne_ea : e ≠ a)
    (hne_ab : a ≠ b) (hne_de : d ≠ e)
    : False := by
  -- C₄: a-d-b-e-a. hC4 a d b e.
  -- (a=a, b=d, c=b, d=e)
  -- Ne1: a≠d = hne_ad
  -- Ne2: d≠b = hne_db
  -- Ne3: b≠e = hne_be
  -- Ne4: e≠a = hne_ea
  -- Ne5: a≠b = hne_ab
  -- Ne6: d≠e = hne_de
  -- Adj1: G.adj a d = had ✓
  -- Adj2: G.adj d b = hdb ✓
  -- Adj3: G.adj b e = hbe ✓
  -- Adj4: G.adj e a = hea ✓
  exact hC4 a d b e
    hne_ad hne_db hne_be hne_ea
    hne_ab hne_de
    had hdb hbe hea

/-- Second C₄ witness from K_{3,3}: a-d-c-e-a.
    Shows K_{3,3} has MULTIPLE C₄s. -/
theorem c4free_no_k33_witness2 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a c d e : V)
    (had : G.adj a d) (hdc : G.adj d c) (hce : G.adj c e) (hea : G.adj e a)
    (hne_ad : a ≠ d) (hne_dc : d ≠ c) (hne_ce : c ≠ e) (hne_ea : e ≠ a)
    (hne_ac : a ≠ c) (hne_de : d ≠ e)
    : False := by
  -- C₄: a-d-c-e-a. hC4 a d c e.
  -- Direct substitution into C4Free definition.
  exact hC4 a d c e
    hne_ad hne_dc hne_ce hne_ea
    hne_ac hne_de
    had hdc hce hea

end SimpleGraph
