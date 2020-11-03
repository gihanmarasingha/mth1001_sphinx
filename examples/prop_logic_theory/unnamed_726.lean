variables p q r : Prop
-- BEGIN
example : q → (p → q) :=
begin
  assume h₁ : q,   -- Assume `h₁ : q`. It suffices to prove `p → q`.
  assume h₂ : p,   -- Assume `h₂ : p`. It suffices to prove `q`.
  show q, from h₁, -- We show `q` by reiteration on `h₁`.
end
-- END