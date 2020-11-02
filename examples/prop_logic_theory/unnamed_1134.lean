variables p q r s t u : Prop

theorem and_assoc1 : (p ∧ q) ∧ r → p ∧ (q ∧ r) :=
λ h, ⟨h.1.1, h.1.2, h.2⟩

theorem and_of_and : p ∧ q → q ∧ p :=
λ h, ⟨h.2, h.1⟩
-- BEGIN
theorem and_assoc2 : s ∧ (t ∧ u) → (s ∧ t) ∧ u :=
begin
  intro h,
  sorry,
end
-- END