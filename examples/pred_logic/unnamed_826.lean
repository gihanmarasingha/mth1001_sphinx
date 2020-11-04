import tactic
namespace hidden
def even (a : ℕ) := ∃ b, a = 2 * b

def odd (a : ℕ) := ∃ b, a = 2 * b + 1

def parity : ℕ → ℕ
| 0              := 0
| (nat.succ n)   := ite (parity n = 0) 1 0

lemma parity_eq_zero_or_one (n : ℕ) : parity n = 0 ∨ parity n = 1 :=
begin
  induction n with k hk,
  { left, refl, },
  unfold parity at *,
  by_cases h : parity k = 0,
  { rw h, right, refl, },
  { left, exact if_neg h, },
end

lemma parity_eq_zero_of_even (n : ℕ) : even n → parity n = 0 :=
begin
  rintro ⟨b, rfl⟩,
  induction b with k hk,
  { refl, },
  { rw nat.mul_succ,
    unfold parity,
    refine if_neg _,
    rw [hk, if_pos],
    { contradiction, },
    { refl, }, },
end

lemma parity_eq_one_of_odd (n : ℕ) : odd n → parity n = 1 :=
begin
  rintro ⟨b, rfl⟩,
  induction b with k hk,
  { refl, },
  { rw nat.mul_succ,
    unfold parity at *,
    rw if_pos,
    rw if_neg,
    rw hk,
    trivial, },
end

-- BEGIN
theorem not_even_iff_odd (n : ℕ) : ¬even n ↔ odd n :=
begin
  induction n with k hk,
  { exact ⟨(λ h, false.elim (h ⟨0, rfl⟩)), (λ ⟨n,hn⟩ _, nat.succ_ne_zero (2*n) hn.symm)⟩, },
  { cases (parity_eq_zero_or_one k) with k₀ k₁,
    { have : even k, from (show ¬odd k → even k, by {contrapose!, exact hk.mp})
      ((mt (parity_eq_one_of_odd k)) (k₀.symm ▸ nat.zero_ne_one)),
      rcases this with ⟨b, rfl⟩,
      split,
      { exact λ _, ⟨b, rfl⟩, },
      { have h₃ : parity(nat.succ (2*b)) = 1, from if_pos k₀,
        exact (λ _, (mt (parity_eq_zero_of_even _)) (h₃.symm ▸ nat.zero_ne_one.symm )) }, },
    { have h₁ : ¬(parity k = 0), { intro h, rw h at k₁, contradiction, },
      rcases (hk.mp) ((mt (parity_eq_zero_of_even k )) h₁) with ⟨b, rfl⟩,
      split,
      { exact λ h₂, false.elim (h₂ ⟨b+1, rfl⟩), },
      { have h₃ : parity(nat.succ (2*b+1)) = 0, from if_neg h₁,
        exact (λ h₄, false.elim ((nat.zero_ne_one) (h₃ ▸ (parity_eq_one_of_odd _ h₄)))), }, }, },
end
-- END
end hidden