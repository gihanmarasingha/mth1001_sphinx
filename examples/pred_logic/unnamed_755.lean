import tactic
namespace hidden
def even (a : ℕ) := ∃ b, a = 2 * b
-- BEGIN
example (h : 10 = 2 * 5) : even 10 :=
begin
  use 5,   -- By exists introduction on `5`, it suffices to prove `10 = 2 * 5`.
  exact h  -- This follows by reiteration on `h`.
end
-- END
end hidden