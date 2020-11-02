variables p q s t : Prop

theorem or_of_or (h : s ∨ t) : t ∨ s :=
begin
  cases h with h₁ h₂,
  { exact or.inr h₁,},
  { show t ∨ s, from or.inl h₂, },
end
namespace hidden
-- BEGIN
theorem or_comm : p ∨ q ↔ q ∨ p :=
begin
  split;
  apply or_of_or
end
-- END
end hidden