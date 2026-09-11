/-
  K₄-free: triangle-free link neighborhood.

  This is a DEEPER version of T012. In a K₄-free graph, the link
  graph L(v) = N(v) with adjacency inherited from G is triangle-free.

  Proof: if a, b, c ∈ N(v) form a triangle (a-b, b-c, a-c all edges),
  then {v, a, b, c} is K₄ (v adjacent to all three, plus the triangle).

  Combined with C₄-free: L(v) is triangle-free AND C₄-free.
  For cubic v (deg 3): L(v) has 3 vertices and is TF + C4F.
  The only such graphs on 3 vertices are: empty (0 edges),
  single edge (1 edge), or path (2 edges — but path on 3 vertices
  IS a triangle-free graph with 2 edges: a-b-c).

  Wait: a-b, b-c is allowed (path). But in C₄-free cubic, T055
  showed at most 1 edge in L(v). So only 0 or 1 edges.

  Authority: FULL_FORMALIZATION — complete graph theorem.
-/

universe u

structure SimpleGraph (V : Type u) where
  adj : V → V → Prop
  adj_symm : ∀ (a b : V), adj a b → adj b a
  adj_loopless : ∀ (v : V), ¬ adj v v

namespace SimpleGraph

variable {V : Type u}

def K4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → a ≠ c → a ≠ d →
    b ≠ c → b ≠ d → c ≠ d →
    G.adj a b → G.adj a c → G.adj a d →
    G.adj b c → G.adj b d → G.adj c d → False

def C4Free (G : SimpleGraph V) : Prop :=
  ∀ (a b c d : V),
    a ≠ b → b ≠ c → c ≠ d → d ≠ a →
    a ≠ c → b ≠ d →
    G.adj a b → G.adj b c → G.adj c d → G.adj d a → False

theorem ne_flip {a b : V} (h : a ≠ b) : b ≠ a :=
  fun heq => h heq.symm

/-- Triangle in link of v → K₄. The fundamental constraint. -/
theorem k4free_link_triangle_free (G : SimpleGraph V)
    (hK4 : G.K4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b) (hbc : G.adj b c) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_bc : b ≠ c) (hne_ac : a ≠ c)
    : False := by
  -- K₄ = {v, a, b, c}. hK4 v a b c.
  -- (a=v, b=a, c=b, d=c)
  -- Ne: v≠a, v≠b, v≠c, a≠b, a≠c, b≠c
  -- Adj: v-a, v-b, v-c, a-b, a-c, b-c
  exact hK4 v a b c
    hne_va hne_vb hne_vc
    hne_ab hne_ac hne_bc
    hva hvb hvc
    hab hac hbc

/-- In K₄-free + C₄-free cubic: L(v) has at most 1 edge (T055)
    AND that edge's endpoints are not in a triangle with any
    other vertex of L(v). Combined: L(v) is either empty or
    a single isolated edge.

    Here: two edges a-b and a-c in L(v) with v cubic means
    {a,b,c} = N(v), and we get a C₄: b-v-c-a-b. -/
theorem c4free_cubic_link_one_edge (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hvc : G.adj v c)
    (hab : G.adj a b) (hac : G.adj a c)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_vc : v ≠ c)
    (hne_ab : a ≠ b) (hne_ac : a ≠ c) (hne_bc : b ≠ c)
    : False := by
  -- C₄: b-v-c-a-b. hC4 b v c a.
  -- (a=b, b=v, c=c, d=a)
  -- Ne1: b≠v = ne_flip hne_vb
  -- Ne2: v≠c = hne_vc
  -- Ne3: c≠a = ne_flip hne_ac
  -- Ne4: a≠b = hne_ab (wait: d≠a = a≠b? No: d=a, a=b, so d≠a = a≠b)
  -- Ne5: a≠c = b≠c = hne_bc
  -- Ne6: b≠d = v≠a = hne_va
  exact hC4 b v c a
    (ne_flip hne_vb) hne_vc (ne_flip hne_ac) hne_ab
    hne_bc hne_va
    (G.adj_symm v b hvb) hvc (G.adj_symm a c hac) hab

end SimpleGraph
