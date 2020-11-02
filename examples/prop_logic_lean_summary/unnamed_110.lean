variables p q : Prop

-- BEGIN
example (h : p ∧ q) : q :=
begin
  cases h with hp hq, -- Equivalent to both left and right and elimination.
  exact hq, -- Closes the goal via reiteration using the proof term `hq`
end
-- END