variables {p q : Prop}
-- BEGIN
example (h₁ : ¬p) (h₂ : p) : q :=
begin
  exfalso,
  show false, from h₁ h₂
end
-- END