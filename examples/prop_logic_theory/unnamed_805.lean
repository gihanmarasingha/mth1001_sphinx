variables p q : Prop
-- BEGIN
theorem and_of_and : p ∧ q → q ∧ p :=
begin
  assume h : p ∧ q,                 -- Assume `h : p ∧ q`. It suffices to prove `q ∧ p`.
  have h₂ : q, from h.right,        -- We have `h₂ : q` by right conjunction elimination on `h`.
  have h₃ : p, from h.left,         -- We have `h₃ : p` by left conjunction elimination on `h`.
  show q ∧ p, from and.intro h₂ h₃, -- We show `q ∧ p` from conjunction introduction on `h₂` and `h₃`.
end
-- END