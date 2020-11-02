variables p q r : Prop
-- BEGIN
example (h₁ : p → q) (h₂ : q → r) (h₃ : p) : r :=
begin
  show r, from h₂ (h₁ h₃)
end
-- END