variables {p q : Prop}
-- BEGIN
example : (p → false) → (p → q) :=
begin
  assume h₁ : p → false,
  assume h₂ : p,
  show q, from false.elim (h₁ h₂)
end
-- END