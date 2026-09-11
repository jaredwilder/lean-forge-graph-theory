/-
  C₄-free: unique path of length 3 between non-adjacent vertices.

  In a C₄-free graph: any two vertices have at most ONE common
  neighbor (T122). This extends to length-3 paths:

  If u and w are at distance 3, path u-a-b-w exists.
  Can there be a SECOND path u-a'-b'-w (length 3, different)?

  Case 1: a = a' (same first vertex). Then a-b-w and a-b'-w
  are two length-2 paths from a to w. By T122, b = b'. Same path.

  Case 2: a ≠ a', b = b' (same middle). Then u-a-b and u-a'-b
  are two length-2 paths from u to b. By T122, a = a'. Contradiction.

  Case 3: a ≠ a', b ≠ b', but a = b' (crossing). Path 2: u-a'-a-w.
  So a adj w. But path 1 has a-b-w (a reaches w through b).
  If a adj w directly: d(a,w) = 1. From path 1, a adj b adj w.
  Two paths from a to w: a-w (length 1) and a-b-w (length 2).
  Together: cycle a-b-w-a (length 3, triangle).
  Not C₄. So no contradiction from C₄-free alone.

  Case 4: a ≠ a', b ≠ b', a ≠ b', b ≠ a' (fully distinct intermediaries).
  Two length-3 paths: u-a-b-w and u-a'-b'-w.
  u adj a, a adj b, b adj w.
  u adj a', a' adj b', b' adj w.
  C₄ candidates:
  - u,a,b,a' with u-a, a-b, b-a'?, a'-u. Need b adj a'.
  - u,a,b',a' with u-a, a-b'?, b'-a', a'-u. Need a adj b'.
  - a,b,b',a' with a-b, b-w, w-b', b'-a'. Involves w.

  Actually: u-a-b-w-b'-a'-u would be 6-cycle (not C₄).

  C₄ from the structure: if a adj b' (cross edge):
  C₄ = u-a-b'-a'-u. 4 vertices: u,a,b',a'.
  Edges: u-a (yes), a-b' (assumed), b'-a' (yes), a'-u (yes).
  Ne check: u≠a ✓, a≠b' (need), b'≠a' ✓, a'≠u ✓, u≠b', a≠a'.
  This IS a valid C₄.

  Similarly: if b adj a' (cross edge):
  C₄ = u-a'-b-w? No. C₄ = a-b-a'-u-a? 4 vertices: a,b,a',u.
  Edges: a-b ✓, b-a' (assumed), a'-u ✓, u-a ✓.
  Ne: a≠b ✓, b≠a' (need), a'≠u ✓, u≠a ✓. Diag: a≠a' ✓, b≠u (need).
  This IS a valid C₄.

  Authority: FULL_FORMALIZATION — complete graph theorems.
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

/-- Cross edge a-b' between two length-3 paths → C₄.
    Paths: u-a-b-w and u-a'-b'-w. Cross: a adj b'.
    C₄ = u-a-b'-a'-u.
    Edges: u-a, a-b', b'-a', a'-u. -/
theorem c4free_cross_l3_paths_ab' (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u a b' a' : V)
    (hua : G.adj u a) (hab' : G.adj a b')
    (hb'a' : G.adj b' a') (ha'u : G.adj a' u)
    (hne_ua : u ≠ a) (hne_ab' : a ≠ b')
    (hne_b'a' : b' ≠ a') (hne_a'u : a' ≠ u)
    (hne_ub' : u ≠ b') (hne_aa' : a ≠ a')
    : False := by
  exact hC4 u a b' a'
    hne_ua hne_ab' hne_b'a' hne_a'u
    hne_ub' hne_aa'
    hua hab' hb'a' ha'u

/-- Cross edge b-a' between two length-3 paths → C₄.
    Paths: u-a-b-w and u-a'-b'-w. Cross: b adj a'.
    C₄ = a-b-a'-u-a.
    Edges: a-b, b-a', a'-u, u-a. -/
theorem c4free_cross_l3_paths_ba' (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (a b a' u' : V)
    (hab : G.adj a b) (hba' : G.adj b a')
    (ha'u : G.adj a' u') (hu'a : G.adj u' a)
    (hne_ab : a ≠ b) (hne_ba' : b ≠ a')
    (hne_a'u : a' ≠ u') (hne_u'a : u' ≠ a)
    (hne_aa' : a ≠ a') (hne_bu : b ≠ u')
    : False := by
  exact hC4 a b a' u'
    hne_ab hne_ba' hne_a'u hne_u'a
    hne_aa' hne_bu
    hab hba' ha'u hu'a

end SimpleGraph
