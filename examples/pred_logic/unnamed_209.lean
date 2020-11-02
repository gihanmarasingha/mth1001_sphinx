variable U : Type*       -- Declare a type, `U`.
variable x : U           -- Declare a term `x`, of type `U`.
variable P : U → Prop    -- Declare a predicate `P` on `U`.

#check P x               -- `P x` has type `Prop`
#check P                 -- `P` has type `U → Prop`