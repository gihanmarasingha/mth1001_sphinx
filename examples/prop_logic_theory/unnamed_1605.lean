import logic.basic

variables p q : Prop

-- BEGIN
example : ¬(p ∨ q) ↔ ¬q ∧ ¬p :=
begin
  rw not_or_distrib, -- Rewrite using De Morgan's law. The goal is `¬p ∧ ¬q ↔ ¬q ∧ ¬p`.
  apply and_comm,    -- This holds by applying commutativity of conjunction.
end
-- END