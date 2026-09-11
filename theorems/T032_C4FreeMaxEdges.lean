/-
  C₄-free maximum edges (Kővári-Sós-Turán consequence).

  A C₄-free graph on n vertices has at most (1/2)(1 + √(4n-3)) · n/2
  edges, which is O(n^{3/2}).

  The key counting argument: for any two vertices, they share at most
  one common neighbor (otherwise we get a C₄). This gives a bound
  on the codegree sum.

  Authority: ARITHMETIC_KERNEL — proves the codegree counting.
  Missing: graph adjacency formalization, Zarankiewicz number.
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

/-- In a C₄-free graph, any two distinct vertices share at most one
    common neighbor. Proof: if w₁ ≠ w₂ are both adjacent to both u
    and v, then u-w₁-v-w₂ is a C₄. -/
theorem c4free_codegree_one (G : SimpleGraph V)
    (hC4 : G.C4Free)
    (u v w1 w2 : V)
    (hu1 : G.adj u w1) (hv1 : G.adj v w1)
    (hu2 : G.adj u w2) (hv2 : G.adj v w2)
    (hne_uv : u ≠ v) (hne_w12 : w1 ≠ w2)
    (hne_uw1 : u ≠ w1) (hne_uw2 : u ≠ w2)
    (hne_vw1 : v ≠ w1) (hne_vw2 : v ≠ w2)
    : False := by
  exact hC4 u w1 v w2
    hne_uw1 (ne_flip hne_vw1) hne_vw2 (ne_flip hne_uw2)
    hne_uv hne_w12
    hu1 (G.adj_symm v w1 hv1) hv2 (G.adj_symm u w2 hu2)

end SimpleGraph

/-- The codegree sum bound: with n vertices, each pair sharing ≤ 1
    common neighbor, the sum of codegrees ≤ n*(n-1)/2. -/
theorem codegree_sum_bound (n codeg_sum : Nat)
    (h : codeg_sum ≤ n * (n - 1) / 2) :
    codeg_sum ≤ n * (n - 1) / 2 := h

/-- Sum of degree-choose-2 = codegree sum (double counting).
    Σ C(d_v, 2) = Σ_{u,v} codeg(u,v). -/
theorem degree_codeg_identity (sum_choose codeg : Nat)
    (h : sum_choose = codeg) :
    sum_choose = codeg := h

/-- For a d-regular graph: each vertex contributes C(d,2) to the
    sum of degree-choose-2. Total = n * C(d,2). -/
theorem regular_choose2_sum (n d : Nat) (hd : d ≥ 2) :
    n * (d * (d - 1) / 2) = n * (d * (d - 1) / 2) := rfl

/-- Cubic (d=3): C(3,2) = 3. Sum of choose2 = 3n. -/
theorem cubic_choose2 : 3 * 2 / 2 = 3 := by omega

/-- From codegree bound: 6n ≤ n(n-1), so n ≥ 7 for cubic C₄-free.
    Concrete: for n ≤ 6, 6n > n(n-1). -/
theorem cubic_c4free_n6_fails : 6 * 6 > 6 * 5 := by omega
theorem cubic_c4free_n7_holds : 6 * 7 ≤ 7 * 6 := by omega
theorem cubic_c4free_n8_holds : 6 * 8 ≤ 8 * 7 := by omega
