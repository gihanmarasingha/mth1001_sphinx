variable p : Prop
-- BEGIN
theorem not_not_of_self : p → ¬¬p :=
begin
  intros h₁ h₂,           -- Assume `h₁ : p`. Assume `h₂ : ¬p`. It suffices to prove `false`.
  show false, from h₂ h₁, -- We show `false` by false introduction on `h₂` and `h₁`.
end
-- END