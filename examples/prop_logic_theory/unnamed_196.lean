variables p q r : Prop
-- BEGIN
example (h : (p ∧ q) ∧ r ) : q :=
begin
  have h₂ : p ∧ q, from h.left,
  show q, from h₂.right,
end
-- END