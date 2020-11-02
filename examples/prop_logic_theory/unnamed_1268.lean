variables (p : Prop)

-- BEGIN
example : p ↔ p :=
begin
  split;        -- By iff introduction, it suffices to prove `p → p` and `p → p`.
  { exact id }, -- We close both subgoals by reflexivity of implication.
end
-- END