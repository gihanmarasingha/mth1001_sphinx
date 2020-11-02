variables p q r : Prop
-- BEGIN
example (h : p ∧ (q ∧ r)) : (p ∧ q) ∧ r :=
begin
  cases h with h₂ h₃,
  cases h₃ with h₄ h₅,
  have h₆ : p ∧ q, from sorry,
  sorry,
end
-- END