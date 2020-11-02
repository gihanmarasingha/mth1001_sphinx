variables p q r : Prop

example (h : (p ∧ q) ∧ r ) : q :=
begin
  have h₂ : p ∧ q, from h.left,
  exact h₂.right
end