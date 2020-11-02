variables p q : Prop

-- BEGIN
example (h₁ : p → q) (h₂ : p) : q :=
begin
  exact h₁ h₂,
end
-- END