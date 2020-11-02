variables p q : Prop
-- BEGIN
example (h : p ∧ q) : q :=
begin
  have h₂ : q, from h.right, -- We have `h₂ : q` by right and elimination on `h`.
  show q, from h₂,           -- We show `q` by reiteration on `h₂`.
end
-- END