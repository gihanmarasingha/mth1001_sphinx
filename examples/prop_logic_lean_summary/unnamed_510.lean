variables p q : Prop

-- BEGIN
example (h : false) : p :=
begin
  exfalso, -- This changes the goal from `p` to `false`.
  exact h, -- We close the goal with `h`.
end
-- END