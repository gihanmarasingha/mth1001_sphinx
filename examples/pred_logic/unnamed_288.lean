variables (U : Type*) (P : U → Prop) (u : U)
-- BEGIN
example (h : ∀ x, P x) : P u :=
begin
  specialize h u,    -- By for all elimination on `h` and `u`, we have `h : P u`
  show P u, from h,  -- We show `P u` by reiteration on `h`.
end
-- END