variables {p q : Prop}
-- BEGIN
example : (p → false) → (p → q) :=
begin
  assume h₁ : p → false,
  assume h₂ : p,
  exfalso,
  show false, from h₁ h₂
end
-- END