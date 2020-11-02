variables (U : Type*) (P : U → Prop) (u : U)
-- BEGIN
example (h : ∀ x, P x) : P u :=
by apply h
-- END