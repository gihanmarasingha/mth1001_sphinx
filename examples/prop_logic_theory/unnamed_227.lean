variables p q r : Prop
-- BEGIN
example (h : (p ∧ q) ∧ r) : q :=
by exact (h.left).right
-- END