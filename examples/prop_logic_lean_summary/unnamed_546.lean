variables p : Prop

-- BEGIN
example (h : ¬p) (k : p) : false :=
begin
  apply h, -- This changes the goal to proving `p`.
  exact k,
end
-- END