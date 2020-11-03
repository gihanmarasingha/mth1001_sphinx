variables p q : Prop
-- BEGIN
example (h : p ∧ q) : q ∧ p :=
begin
  show q ∧ p, split,
  { show q, from h.right, },
  { show p, from h.left, },
end
-- END