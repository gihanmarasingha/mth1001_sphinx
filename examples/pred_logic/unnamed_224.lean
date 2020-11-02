variables (U : Type*) (V : Type*) -- Declare types `U` and `V`.
variables (x : U) (y : V)         -- Declare terms `x` of type `U` and `y` of type `V`.

variable Q : U → V → Prop    -- Declare a predicate `Q` on `U` and `V`.

#check Q     -- `Q` is a predicate with type `U → V → Prop`.
#check Q x   -- `Q x` is a predicate with type `V → Prop`.
#check Q x y -- `Q x y` has type `Prop`, i.e. is a proposition.