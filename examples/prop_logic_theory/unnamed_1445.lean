import data.nat.basic

variables x y z : ℕ
-- BEGIN
example : x * (y + z) = x * z + y * x :=
by rw [mul_add, add_comm, mul_comm x y]
-- END