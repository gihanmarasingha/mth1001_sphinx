import logic.basic

variables p q : Prop

-- BEGIN
example (k : ¬(p ∨ q)) : ¬q ∧ ¬p :=
begin
  rw not_or_distrib at k, -- Rewriting using De Morgan's law at `k`, we have `k : ¬p ∧ ¬q`.
  rw and_comm,            -- Rewriting using commutativity of conjunction, the goal is `¬p ∧ ¬q`.
  exact k,                -- This holds by reiteration on `k`.
end
-- END