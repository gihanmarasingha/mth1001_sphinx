import logic.basic

variables p q : Prop

-- BEGIN
example (h : ¬(p ∨ q)) : ¬q ∧ ¬p :=
begin
  rw ←not_or_distrib,
  rw or_comm,
  exact h,
end
-- END