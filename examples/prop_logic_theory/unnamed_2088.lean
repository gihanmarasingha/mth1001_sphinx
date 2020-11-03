variables {p q : Prop}
-- BEGIN
example (h : ¬(p ∨ q)) : ¬p :=
begin
  assume h₁ : p,   -- It suffices to prove `false`.
  apply h,         -- By false introduction on `h`, it suffices to prove `p ∨ q`.
  exact or.inl h₁, -- This follows by left or introduction on `h₁`.
end
-- END