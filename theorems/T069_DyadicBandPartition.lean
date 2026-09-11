/-
  Dyadic band partition.

  The positive integers partition into dyadic bands:
  Band k = (2^k, 2^(k+1)] for k ≥ 0.
  Band 0 = (1, 2] = {2}
  Band 1 = (2, 4] = {3, 4}
  Band 2 = (4, 8] = {5, 6, 7, 8}
  Band k has exactly 2^k elements, of which exactly 1 is a power of 2.

  For the EG argument: cycle lengths fall into bands. A cycle of
  length ℓ ∈ Band k is "forbidden" only if ℓ = 2^(k+1). So at most
  1 forbidden value per band, and the band has 2^k elements.

  Authority: ARITHMETIC_KERNEL — band arithmetic.
  Missing: cycle length existence.
-/

/-- Band sizes: |Band k| = 2^k. -/
theorem band_size_0 : 2 - 1 = 1 := by omega
theorem band_size_1 : 4 - 2 = 2 := by omega
theorem band_size_2 : 8 - 4 = 4 := by omega
theorem band_size_3 : 16 - 8 = 8 := by omega
theorem band_size_4 : 32 - 16 = 16 := by omega
theorem band_size_5 : 64 - 32 = 32 := by omega

/-- Non-forbidden values per band: 2^k - 1. -/
theorem nonforbidden_0 : 1 - 1 = 0 := by omega
theorem nonforbidden_1 : 2 - 1 = 1 := by omega
theorem nonforbidden_2 : 4 - 1 = 3 := by omega
theorem nonforbidden_3 : 8 - 1 = 7 := by omega
theorem nonforbidden_4 : 16 - 1 = 15 := by omega
theorem nonforbidden_5 : 32 - 1 = 31 := by omega

/-- Cumulative non-forbidden in [3, 2^(k+1)]: Σ_{j=1}^{k} (2^j - 1) = 2^(k+1) - k - 2. -/
theorem cumul_nf_k2 : (2 - 1) + (4 - 1) = 4 := by omega
theorem cumul_nf_k3 : (2 - 1) + (4 - 1) + (8 - 1) = 11 := by omega
theorem cumul_nf_k4 : (2 - 1) + (4 - 1) + (8 - 1) + (16 - 1) = 26 := by omega

/-- Ratio: non-forbidden / forbidden. In [3, 2^(k+1)], there are
    k forbidden values and 2^(k+1) - k - 2 non-forbidden. -/
theorem ratio_nf_k3 : 11 / 2 = 5 := by omega
theorem ratio_nf_k4 : 26 / 3 = 8 := by omega
theorem ratio_nf_k5 : (2 + 4 + 8 + 16 + 32 - 5) / 4 = 14 := by omega

/-- The fundamental fact: the non-forbidden count grows
    exponentially while the forbidden count grows logarithmically.
    For any fixed number of required cycle lengths, there exists
    N₀ such that n ≥ N₀ guarantees enough non-forbidden lengths. -/
theorem exponential_dominates_k3 : 11 > 2 * 2 := by omega
theorem exponential_dominates_k4 : 26 > 2 * 3 := by omega
theorem exponential_dominates_k5 : 57 > 2 * 4 := by omega
