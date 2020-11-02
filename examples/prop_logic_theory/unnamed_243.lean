variables p q r : Prop
-- BEGIN
example (h : (p ∧ q) ∧ r) : q :=
begin
  cases h with h₂ h₃, -- We have `h₂ : p` and `h₃ : q` by left and right conjunction elimination on `h`.
  exact h₂.right      -- The result follows by right conjunction elimination on `h₂`.
end
-- END