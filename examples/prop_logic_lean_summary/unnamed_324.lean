variables p q : Prop

-- BEGIN
example (h : p) : p ∨ q :=
begin
  left, -- This changes the goal, by left or introduction, to proving p
  exact h,
end
-- END