variables {p q : Prop}
theorem not_or_not_of_not_and : ¬(p ∧ q) → ¬p ∨ ¬q :=
λ hnpq, or.elim (classical.em p) (λ hp, or.inr (λ hq, hnpq ⟨hp, hq⟩)) (λ hnp, or.inl hnp)
theorem not_and_of_not_or_not : ¬p ∨ ¬q → ¬(p ∧ q) :=
λ hnpnq hpq, or.elim hnpnq (λ hnp, hnp hpq.1) (λ hnq, hnq hpq.2)
-- BEGIN
theorem not_and_distrib : ¬(p ∧ q) ↔ ¬p ∨ ¬ q :=
begin
  split,
  { exact not_or_not_of_not_and, },
  { exact not_and_of_not_or_not, },
end
-- END