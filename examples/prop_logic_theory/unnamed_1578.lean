variables p q r : Prop

-- BEGIN
example (h₁ : p ↔ q) (h₂ : q ↔ r) : p ↔ r :=
begin
  rw h₁,    -- Rewriting using `h₁`, the goal is to prove `q ↔ r`.
  exact h₂, -- This holds by reiteration on `h₂`.
end
-- END