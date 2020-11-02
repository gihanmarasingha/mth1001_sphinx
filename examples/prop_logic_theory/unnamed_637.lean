variables p q r : Prop
-- BEGIN
example (h₁ : p → q) (h₂ : q → r) (h₃ : p) : r :=
begin
  apply h₂, -- By implication elimination on `h₂`, it suffices to prove `q`.
  apply h₁, -- By implication elimination on `h₁`, it suffices to prove `p`.
  exact h₃, -- This follows by reiteration on `h₃`.
end
-- END