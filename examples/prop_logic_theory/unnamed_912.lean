variables a b : Prop

theorem and_of_and (p q : Prop) : p ∧ q → q ∧ p :=
begin
  intro h,
  exact and.intro (h.right) (h.left)
end
-- BEGIN
example : (a → b) ∧ (b ∧ a) → (b ∧ a) ∧ (a → b) :=
by exact and_of_and _ _
-- END