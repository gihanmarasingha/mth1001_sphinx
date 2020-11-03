variables (U : Type*) (S T : U → Prop) (u : U)
-- BEGIN
example (h : ∀ x, (S x) ∧ (T x)) : S u :=
begin
  have h₂ : (S u) ∧ (T u), from h u, -- We have `h₂ : (S u) ∧ (T u)` by for all elimination on `h` and `u`.
  show (S u), from h₂.left, -- We show `S u` by left conjunction elimination on `h₂`.
end
-- END