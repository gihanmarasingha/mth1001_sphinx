def avg_three (x y z : ℤ) : ℤ := (x + y + z)/2

#check avg_three  -- `avg_three` has type `ℤ → ℤ → ℤ → ℤ`, i.e., `ℤ → (ℤ → (ℤ → ℤ))`
#check (avg_three 10)      -- `avg_three 10` has type `ℤ → (ℤ → ℤ)`.
#check (avg_three 10 5)    -- `avg_three 10 5` has type `ℤ → ℤ`.
#check (avg_three 10 5 6)  -- `avg_three 10 5 6` has type `ℤ`, i.e. is an integer.