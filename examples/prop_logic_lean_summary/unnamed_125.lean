variables p q : Prop

-- BEGIN
example (h : p ∧ q) : q :=
h.right -- Term-style right and elimination.
-- END