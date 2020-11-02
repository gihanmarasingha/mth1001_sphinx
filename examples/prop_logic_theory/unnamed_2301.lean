variables {p q : Prop}
theorem not_and_not_of_not_or : ¬(p ∨ q) → ¬p ∧ ¬q :=
λ hnpq, ⟨ λ hp, hnpq (or.inl hp) , λ hq, hnpq (or.inr hq) ⟩
theorem not_or_of_not_and_not : ¬p ∧ ¬q → ¬(p ∨ q) :=
λ hnphq hpq, or.elim hpq (λ hp, hnphq.1 hp) (λ hq, hnphq.2 hq)
-- BEGIN
theorem not_or_distrib : ¬(p ∨ q) ↔ ¬p ∧ ¬ q :=
begin
  split,
  { exact not_and_not_of_not_or, },
  { exact not_or_of_not_and_not, },
end
-- END