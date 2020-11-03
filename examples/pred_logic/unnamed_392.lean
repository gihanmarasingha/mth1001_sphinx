import data.int.basic
-- BEGIN
example : (∀ x : ℤ, x^2 ≥ 0) → ((-(4 : ℤ))^2 ≥ 0) :=
begin
  intro h,
  exact h (-4),
end
-- END