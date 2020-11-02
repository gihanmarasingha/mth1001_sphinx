variables p q r : Prop
-- BEGIN
example (h₁ : p ∧ q → r) (h₂ : p) (h₃ : q) : r :=
begin
  apply h₁, -- By implication elimination on `h₁`, it suffices to prove `p ∧ q`.
  sorry
end
-- END