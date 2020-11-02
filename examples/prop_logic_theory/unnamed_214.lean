variables p q r : Prop
-- BEGIN
example (h : (p ∧ q) ∧ r) : q :=
begin
  show q, from (h.left).right
end
-- END