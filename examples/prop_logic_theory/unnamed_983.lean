variables a b : Prop
-- BEGIN
theorem and_of_and (p q : Prop) : p ∧ q → q ∧ p :=
begin
  intro h,
  exact and.intro (h.right) (h.left)
end

example (a b : Prop) : (a → b) ∧ (b ∧ a) → (b ∧ a) ∧ (a → b) :=
by apply and_of_and
-- END