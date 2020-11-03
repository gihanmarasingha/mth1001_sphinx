variables {p q r : Prop}
namespace hidden
-- BEGIN
theorem or_assoc : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) :=
begin
  split,
  { intro h,
    cases h with h₁ h₂,
    { cases h₁ with m₁ m₂,
      { left, exact m₁, },
      { right, left, exact m₂, }, },
    { sorry, }, },
  { sorry, },
end
-- END
end hidden