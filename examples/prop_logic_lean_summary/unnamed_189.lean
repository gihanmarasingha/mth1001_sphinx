variables p q : Prop

-- BEGIN
example (h₁ : p) (h₂ : q) : p ∧ q :=
⟨h₁, h₂⟩ -- Enter these 'French quotes' with `\<` and  `\>`