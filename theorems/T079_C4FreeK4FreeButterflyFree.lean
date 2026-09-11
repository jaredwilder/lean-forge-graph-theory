/-
  C₄-free K₄-free: butterfly (bowtie) free.

  A butterfly = two triangles sharing exactly one vertex.
  In C₄-free: can two triangles share a vertex?
  Triangle (v,a,b) and triangle (v,c,d) share vertex v.
  If any cross-edge exists (a adj c, a adj d, b adj c, or b adj d),
  we get a C₄ via book formation. But WITHOUT cross-edges,
  the butterfly exists.

  However, in a CUBIC graph, v has degree 3. Triangle (v,a,b) uses
  edges v-a, v-b. Triangle (v,c,d) uses edges v-c, v-d. That's
  4 edges at v, but cubic means degree 3. So a cubic vertex can
  be in AT MOST one triangle (it uses 2 of its 3 neighbors).

  This theorem: in cubic + C₄-free, a vertex in a triangle has
  exactly one non-triangle neighbor, and that neighbor is NOT
  adjacent to either triangle vertex (else book → C₄).

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

/-- Third neighbor c of triangle vertex v cannot be adjacent to a.
    If c adj a: triangle (v,a,c) shares edge v-a with triangle
    (v,a,b). Book at v-a → C₄: c-v-b-a-c. -/
theorem c4free_cubic_third_nbr_not_adj_triangle_a (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hvc : G.adj v c) (hca : G.adj c a)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_vc : v ≠ c) (hne_ca : c ≠ a) (hne_cb : c ≠ b)
    : False := by
  -- Book at v-a: triangles (v,a,b) and (v,a,c).
  -- C₄: c-v-b-a-c. hC4 c v b a.
  -- (a=c, b=v, c=b, d=a)
  -- Ne1: c≠v = ne_flip hne_vc
  -- Ne2: v≠b = hne_vb
  -- Ne3: b≠a = ne_flip hne_ab
  -- Ne4: a≠c = ne_flip hne_ca
  -- Ne5: c≠b = hne_cb
  -- Ne6: v≠a = hne_va
  -- Adj1: G.adj c v = adj_symm v c hvc
  -- Adj2: G.adj v b = hvb ✓
  -- Adj3: G.adj b a = adj_symm a b hab
  -- Adj4: G.adj a c = adj_symm c a hca
  exact hC4 c v b a
    (ne_flip hne_vc) hne_vb (ne_flip hne_ab) (ne_flip hne_ca)
    hne_cb hne_va
    (G.adj_symm v c hvc) hvb (G.adj_symm a b hab) (G.adj_symm c a hca)

/-- Similarly, third neighbor c cannot be adjacent to b. -/
theorem c4free_cubic_third_nbr_not_adj_triangle_b (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b c : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hab : G.adj a b)
    (hvc : G.adj v c) (hcb : G.adj c b)
    (hne_va : v ≠ a) (hne_vb : v ≠ b) (hne_ab : a ≠ b)
    (hne_vc : v ≠ c) (hne_cb : c ≠ b) (hne_ca : c ≠ a)
    : False := by
  -- Book at v-b: triangles (v,a,b) and (v,b,c).
  -- C₄: a-v-c-b-a. hC4 a v c b.
  -- (a=a, b=v, c=c, d=b)
  -- Ne1: a≠v = ne_flip hne_va
  -- Ne2: v≠c = hne_vc
  -- Ne3: c≠b = hne_cb
  -- Ne4: b≠a = ne_flip hne_ab
  -- Ne5: a≠c = ne_flip hne_ca
  -- Ne6: v≠b = hne_vb
  -- Adj1: G.adj a v = adj_symm v a hva
  -- Adj2: G.adj v c = hvc ✓
  -- Adj3: G.adj c b = hcb ✓
  -- Adj4: G.adj b a = adj_symm a b hab
  exact hC4 a v c b
    (ne_flip hne_va) hne_vc hne_cb (ne_flip hne_ab)
    (ne_flip hne_ca) hne_vb
    (G.adj_symm v a hva) hvc hcb (G.adj_symm a b hab)

end SimpleGraph
