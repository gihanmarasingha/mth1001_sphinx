variables {p q : Prop}
-- BEGIN
example (h₁ : ¬p) (h₂ : p) : q :=
begin
  contradiction
end
-- END