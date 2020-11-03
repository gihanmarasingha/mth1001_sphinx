variables {p q : Prop}
-- BEGIN
theorem mt : (p → q) → (¬q → ¬p) :=
begin
  intros h₁ h₂, -- Assume `h₁ : p → q`, `h₂ : ¬q`. It suffices to prove `¬p`.
  intro h₃,     -- Assume `h₃ : p`. By negation introiduction, it suffices to prove `false`.
  apply h₂,     -- By fale introduction on `h₂`, it suffices to prove `q`.
  exact h₁ h₃,  -- This follows by implication elimination on `h₁` and `h₃`.
end
-- END