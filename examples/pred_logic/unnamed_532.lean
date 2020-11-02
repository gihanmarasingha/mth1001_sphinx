variables (U : Type*) (P Q : U → Prop)
-- BEGIN
example (u : U) (h₁ : P u → Q u) (h₂ : P u) : ∃ x, Q x :=
begin
  have h₃ : Q u, from h₁ h₂, -- We have `Q u` from `→` elim. on `h₁` and `h₂`.
  exact exists.intro u h₃,   -- The result follows from exists intro. on `u` and `h₃`.
end
-- END