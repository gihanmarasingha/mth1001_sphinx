import tactic
namespace hidden
def even (a : ℕ) := ∃ b, a = 2 * b
-- BEGIN
example (n : ℕ) (h : even n) : even (5*n) :=
begin
  unfold even at h, -- Using the definition of even, `h : ∃ b, n = 2 * b`
  unfold even, -- Using the definition of even, the goal is `∃ b, 5n = 2b`
  cases h with c k, -- By exists elimination on `h`, it suffices to prove the goal assuming `c : ℕ` and `k : n = 2c`.
  use (5*c), -- * By exists introduction on `5*c`, it suffices to prove `5*n = 2*(5*c)`.
  rw k, -- Rewriting using `k`, the goal is to prove `5 * (2 * c) = 2 * (5 * c)`.
  ring, -- This holds by standard properties of the natural numbers (note the `ring` tactic simplifies many 'algebraic' expressions).
end
-- END
end hidden