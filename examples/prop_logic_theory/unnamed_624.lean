variables p q r : Prop
-- BEGIN
example (h₁ : p → q) (h₂ : q → r) (h₃ : p) : r :=
begin
  apply h₂,          -- By implication elimination on `h₂`, it suffices to prove `q`.
  show q, from h₁ h₃ -- We show `q` by implication elimination on `h₁` and `h₃`.
end
-- END