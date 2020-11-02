variables p q : Prop

-- BEGIN
example (h : p ↔ q) : p → q :=
begin
  cases h with h₁ h₂,
  exact h₁,
end
-- END