/-
  C₄-free K₄-free cubic: triangle vs non-triangle edge split.

  In a cubic C₄-free K₄-free graph with t triangles (t ≤ n/3):
  - Triangle edges: 3t (each triangle contributes 3 edges)
  - Non-triangle edges: 3n/2 - 3t
  - Vertices in triangles: 3t (pairwise disjoint by C₄-free book)
  - Vertices NOT in triangles: n - 3t

  A non-triangle vertex v has N(v) = {a,b,c} with no edges among
  them (in TF) or at most zero triangle edges among its neighbors
  (since v is not in a triangle, none of its edges is a triangle
  edge, but its neighbors COULD be in other triangles).

  Wait: if a ∈ N(v) is in triangle (a,x,y), then edge v-a is NOT
  a triangle edge (v is not in this triangle). But a is in a
  triangle. So triangle and non-triangle vertices can be adjacent.

  Authority: STRUCTURAL_CORE — edge partition theorem.
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

/-- If v not in any triangle, and a,b ∈ N(v), and a adj x, b adj x,
    then v-a-x-b-v is C₄. So even non-triangle vertices have
    disjoint second neighborhoods (same as T087). -/
theorem c4free_nontriangle_vertex_disjoint_d2 (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (v a b x : V)
    (hva : G.adj v a) (hvb : G.adj v b) (hax : G.adj a x) (hbx : G.adj b x)
    (hne_ab : a ≠ b) (hne_xv : x ≠ v)
    (hne_va : v ≠ a) (hne_vb : v ≠ b)
    (hne_ax : a ≠ x) (hne_bx : b ≠ x)
    : False := by
  -- C₄: v-a-x-b-v. hC4 v a x b.
  -- (a=v, b=a, c=x, d=b)
  -- Ne1: v≠a = hne_va
  -- Ne2: a≠x = hne_ax
  -- Ne3: x≠b = ne_flip hne_bx
  -- Ne4: b≠v = ne_flip hne_vb
  -- Ne5: v≠x = ne_flip hne_xv
  -- Ne6: a≠b = hne_ab
  -- Adj1: G.adj v a = hva ✓
  -- Adj2: G.adj a x = hax ✓
  -- Adj3: G.adj x b = adj_symm b x hbx
  -- Adj4: G.adj b v = adj_symm v b hvb
  exact hC4 v a x b
    hne_va hne_ax (ne_flip hne_bx) (ne_flip hne_vb)
    (ne_flip hne_xv) hne_ab
    hva hax (G.adj_symm b x hbx) (G.adj_symm v b hvb)

end SimpleGraph
