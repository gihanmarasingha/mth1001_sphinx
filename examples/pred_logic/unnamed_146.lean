def avg_three_u : (ℤ × ℤ × ℤ) → ℤ
| (x, y, z) := (x + y + z)/3
#check avg_three_u -- `avg_three_u` has type `ℤ × ℤ × ℤ → ℤ`
#eval avg_three_u (10, 5, 6) -- This is 7.