variables s t u : Prop

-- BEGIN
example (h : t) : s ∨ (t ∨ u) :=
begin
  have h₂ : t ∨ u, from or.inl h,
  exact or.inr h₂,
end
-- END