variables p q : Prop

-- BEGIN
example (h : p ↔ q) : p → q :=
iff.elim_left h
-- END