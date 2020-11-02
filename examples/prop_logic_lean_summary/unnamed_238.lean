variables p q : Prop

-- BEGIN
example (h₁ : p → q) (h₂ : p) : q :=
h₁ h₂ -- h₁ h₂ is the result of implication elimination on h₁ and h₂.
-- END