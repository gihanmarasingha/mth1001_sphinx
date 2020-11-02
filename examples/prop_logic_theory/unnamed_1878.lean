variables s t : Prop

-- BEGIN
theorem or_of_or (h : s ∨ t) : t ∨ s :=
begin
  cases h with h₁ h₂,
  { exact or.inr h₁,},
  { exact or.inl h₂, },
end
-- END