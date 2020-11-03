variables p q r : Prop
-- BEGIN
example : q → (p → q) :=
begin
  intro h₁,        -- Assume `h₁ : q`. It suffices to prove `p → q`.
  intro h₂,        -- Assume `h₂ : p`. It suffices to prove `q`.
  show q, from h₁, -- We show `q` by reiteration on `h₁`.
end
-- END