.. _sec_pred_logic:

***************
Predicate logic
***************

.. _sec_types:

Types
=====

Every term in mathematics has a type. For instance, :math:`\mathbb{Z}` is the type of integers.
A statement such as :math:`5 : \mathbb Z` is called a (typing) judgment. This statement can be read
'5 has type :math:`\mathbb Z`' or '5 is an integer'.


We can work with arbitrary terms and types. The judgment :math:`x : U` is read ':math:`x` has type
:math:`U`'.

Propositional variables, as discussed in :numref:`Section %s <prop_variables>`, are terms of type
``Prop``.

Suppose we have ``P : Prop`` and ``Q : Prop``. What is meant by ``h : P ∧ Q``? When a proposition,
such as ``P ∧ Q`` is viewed as a type, it is the type of proofs of that proposition. Thus the
judgment ``h : P ∧ Q`` should be interpreted as '``h`` is a proof of ``P ∧ Q``'.

A new type can be introduced into Lean using the following syntax.

.. code-block:: lean

  variable U : Type* -- This declares `U` to be a type.

Functions and definitions
=========================

A function (also called a definition) is a mathematical object with a name,
zero or more inputs, a body, and a body type.

Below, we define three functions in Lean. The last function has name ``avg``. It 
takes two inputs, ``x`` and ``y``, both of type ``ℤ``, and has a body ``(x + y)/2``,
also of type ``ℤ`` (note that integer division automatically rounds in Lean).

.. code-block:: lean

  def double (x : ℤ) : ℤ := 2 * x
  def square (y : ℤ) : ℤ := y * y
  def avg (x y : ℤ) : ℤ := (x + y)/2

Some functions can be evaluated. For example, with the above definitions, you 
could find the average of 10 and 6 as follows.

.. code-block:: lean

  def avg (x y : ℤ) : ℤ := (x + y)/2
  -- BEGIN
  #eval avg 10 6
  -- END

Here, ``avg 10 6`` represents the result of replacing ``x`` with ``10`` and ``y``
with ``6`` in the body of the defintion of ``avg``.


One may check the type of any Lean object using the ``#check`` directive. On entering the following
commands, Lean will respond with ``double : ℤ → ℤ`` and ``avg : ℤ → ℤ → ℤ``.

.. code-block:: lean

  def double (x : ℤ) : ℤ := 2 * x
  def square (y : ℤ) : ℤ := y * y
  def avg (x y : ℤ) : ℤ := (x + y)/2
  -- BEGIN
  #check double
  #check avg
  -- END

.. index:: type, type; function type

Here, ``ℤ → ℤ`` is the type of functions that take one integer input and produce one integer output,
while ``ℤ → ℤ → ℤ`` is the type of functions that take two integer inputs and produce one integer
output. Can you guess the type of ``square``?

More generally, if ``U`` and ``V`` are types, we can declare, without defining them, functions from
``U`` to ``V``. The following declares a function ``f`` of type ``U → V``. That is, ``f`` is a
function from ``U`` to ``V``.

Here, ``f x`` denotes the result of applying ``f`` to ``x``. Naturally, the type of the result is ``V``.

.. code-block:: lean

  variables U V : Type*
  variable x : U
  variable f : U → V
  #check f
  #check f x

.. _sec_currying:

Currying functions
==================

This section is optional reading.

I lied earlier when I wrote that ``ℤ → ℤ → ℤ`` is the type of functions that take two integer
inputs and produce one integer output. To begin, we should clarify whether ``ℤ → ℤ → ℤ`` means
``ℤ → (ℤ → ℤ)`` or ``(ℤ → ℤ) → ℤ``. By convention, the former meaning, ``ℤ → (ℤ → ℤ)`` is used.
This is chosen to harmonise with the notion of function application, as we'll see at the end of
this section.

In truth, ``ℤ → (ℤ → ℤ)`` is therefore the type of functions that take one integer argument and
returns *a function* of type ``ℤ → ℤ``

Thus ``avg 5`` is a function that takes takes an input, say ``y``, and returns ``(5 + y)/2``.
This is called *partial application* of ``avg``. To make this more transparent, we define a new
function ``avg'`` to be the partial application of ``avg`` at 5.

.. code-block:: lean

  def avg (x y : ℤ) : ℤ := (x + y)/2
  --BEGIN
  def avg' := avg 5

  #eval avg' 17 -- This outputs 11.
  --END

It transpires that this is the most natural way to think of functions of several variables when
proving theorems.

Alternatively, the function ``avgu`` defined below is actually a function that takes a pair of
variables (as indicated by the input type ``ℤ × ℤ``) and returns an integer.

.. code-block:: lean

  def avgu : ℤ × ℤ → ℤ
  | (x, y) := (x + y)/2

  #eval avgu (10,6)  -- This displays 8.

.. index:: currying, uncurrying

Producing ``avg``, a function that produces a function, from ``avgu``, a function of many variabes,
is called *currying*, after American mathematician Haskell Curry.
The reverse process is called *uncurrying*.

One may consider functions of more than two variables.

.. code-block:: lean

  def avg_three_u : (ℤ × ℤ × ℤ) → ℤ
  | (x, y, z) := (x + y + z)/3
  #check avg_three_u -- `avg_three_u` has type `ℤ × ℤ × ℤ → ℤ`
  #eval avg_three_u (10, 5, 6) -- This is 7.

Consider the curried version of this function, which we call ``avg_three``.

.. code-block:: lean

  def avg_three (x y z : ℤ) : ℤ := (x + y + z)/2

  #check avg_three  -- `avg_three` has type `ℤ → ℤ → ℤ → ℤ`, i.e., `ℤ → (ℤ → (ℤ → ℤ))`
  #check (avg_three 10)      -- `avg_three 10` has type `ℤ → (ℤ → ℤ)`.
  #check (avg_three 10 5)    -- `avg_three 10 5` has type `ℤ → ℤ`.
  #check (avg_three 10 5 6)  -- `avg_three 10 5 6` has type `ℤ`, i.e. is an integer.

``avg_three`` has type ``ℤ → (ℤ → (ℤ → ℤ))``. That is, it takes an integer input and
outputs a term of type ``ℤ → (ℤ → ℤ)``. But a term of this type *is* a function that takes
an integer input and outputs a term of type ``ℤ → ℤ``. In its turn this is a function that takes
an integer input and outputs a term of type ``ℤ``.

We see this through successive partial applications of ``avg_three``.

Indeed, when we write something like ``avg 10 6``, we really mean ``(avg 10) 6``.
That is we take the function ``avg 10`` and apply it to ``6``.

Likeiwse, ``avg_three 10 5 6`` really means ``(((avg_three 10) 5) 6``. Note how the bracketing
convention for function application is the opposite of the convention for function types.

.. index:: predicate

Predicates
==========

A predicate is a function whose body type is ``Prop``. Below, we define the predicate ``even``
so that ``even x`` is the proposition ``∃ m : ℤ, x = 2 *m``. The symbol ``∃`` is read
'there exists'. So this proposition can be interpreted as, 'there exists an integer :math:`m` such
that :math:`x = 2m`'.

.. code-block:: lean

  def even (x : ℤ) : Prop := ∃ m : ℤ, x = 2 *m
  #check even
  #check even 5

The result of ``#check`` assures us that ``even`` has type ``ℤ → Prop``. It is a function that takes
one input of type ``ℤ`` and has a body of type ``Prop``. Moreover ``even 5`` has type ``Prop``.

.. code-block:: lean

  def even (x : ℤ) : Prop := ∃ m : ℤ, x = 2 *m
  -- BEGIN
  #check even
  #check even 5
  -- END

Predicates can take more than one input. The following predicate takes two integer inputs ``a`` and
``b`` and has body ``∃ m : ℤ, b = a * m``. In familiar language, it represents the notion that ``a``
divides (i.e. is a factor of) ``b``.

.. code-block:: lean
  
  def divides (a b : ℤ) : Prop := ∃ m : ℤ, b = a * m


When working abstractly, we can declare, without definining it, a predicate on an arbitrary type.

.. code-block:: lean

  variable U : Type*       -- Declare a type, `U`.
  variable x : U           -- Declare a term `x`, of type `U`.
  variable P : U → Prop    -- Declare a predicate `P` on `U`.

  #check P x               -- `P x` has type `Prop`
  #check P                 -- `P` has type `U → Prop`


Here, ``P x`` is the result of applying ``P`` to ``x``. It has type ``Prop``, while ``P`` itself
has type ``U → Prop``.

We may define abstract predicates on more than one type.

.. code-block:: lean

  variables (U : Type*) (V : Type*) -- Declare types `U` and `V`.
  variables (x : U) (y : V)         -- Declare terms `x` of type `U` and `y` of type `V`.

  variable Q : U → V → Prop    -- Declare a predicate `Q` on `U` and `V`.

  #check Q     -- `Q` is a predicate with type `U → V → Prop`.
  #check Q x   -- `Q x` is a predicate with type `V → Prop`.
  #check Q x y -- `Q x y` has type `Prop`, i.e. is a proposition.

The next two paragraphs are technical and may be omitted if you have not read
:numref:`Section %s <sec_currying>`.

When viewed through the lens of currying functions, the predicate ``Q`` can be thought of as a
function that takes an input of type ``U`` and outputs a function of type ``V → Prop``.

The observant reader will note that this contradicts by previous definition that a predicate is a
function with body type ``Prop``. That's because I lied to keep things simple.
Really, I mean that for a function to be a predicate, its *uncurried* version should have body type
``Prop``. The uncurried version of ``Q`` has type ``U × V → Prop``, so indeed its body type is
``Prop``. 

Universal quantification
========================

The universal quantifier, written :math:`\forall` is one of the two operators of predicate logic.
It is read 'for all', 'for every', or 'for each'. Informally, :math:`\forall x, P(x)` is the
assertion that :math:`P(x)` holds for every :math:`x`.

Usually, the type of :math:`x` in the above expression can be inferred from the type of :math:`P`.
To be explicit, we can use a type ascription :math:`x : U` as in the expression
:math:`\forall (x : U), P(x)`.

Formally, the meaning of the universal quantifier is defined by two rules of inference.

For all elimination
-------------------

.. proof:mathsrule:: For all elimination, forward

  Let :math:`U` be a type and let :math:`P` be a predicate on :math:`U`. Given
  :math:`h : \forall x, P(x)` and given :math:`u : U`, we have :math:`P(u)`.

In Lean, if ``P : U → Prop`` is a predicate, given ``h : ∀ x, P x`` and given ``u : U``, the
expression ``h u`` is a proof term for ``P u``. Note the similarity between this and the Lean
notation for implication elimination.

.. code-block:: lean

  variables (U : Type*) (P : U → Prop) (u : U)

  example (h : ∀ x, P x) : P u :=
  by exact h u

Alternatively, the ``specialize`` tactic applies to a universally quantified statement
``h : ∀ x, P x``. Writing ``specialize h u`` replaces ``h`` with ``h : P u``.

.. code-block:: lean

  variables (U : Type*) (P : U → Prop) (u : U)
  -- BEGIN
  example (h : ∀ x, P x) : P u :=
  begin
    specialize h u,    -- By for all elimination on `h` and `u`, we have `h : P u`
    show P u, from h,  -- We show `P u` by reiteration on `h`.
  end
  -- END

.. proof:mathsrule:: For all elimination, backward

  Let :math:`U` be a type and let :math:`P` be a predicate on :math:`U`. To prove :math:`P(u)`,
  :math:`h : \forall x, P(x)` and given :math:`u : U`, we have :math:`P(u)`.

In Lean, we invoke backward for all elimination using the ``apply`` tactic, just as we did for
backward implication elimination. Below, Lean is clever enough to close the goal immediately after
``apply h`` as ``u : U`` is in the context.

.. code-block:: lean

  variables (U : Type*) (P : U → Prop) (u : U)
  -- BEGIN
  example (h : ∀ x, P x) : P u :=
  by apply h
  -- END

Let's do something a little more interesting.

.. proof:example::

  Let :math:`S` and :math:`T` be prediates on a type :math:`U`. Given :math:`h_1 : \forall x, S(x)`,
  :math:`h_2 : \forall y, S(y)\to T(y)` and :math:`u : U`, we have :math:`T(u)`.

We give first a forward proof.

.. code-block:: lean

  variables (U : Type*) (S T : U → Prop) (u : U)

  example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
  begin
    have h₃ : S u, from h₁ u,  -- We have `h₃ : S u` by for all elim. on `h₁` and `u`.
    have h₄ : S u → T u, from h₂ u, -- We have `h₄ : S u → T u` by for all elim. on `h₂` and `u`
    show T u, from h₄ h₃, -- We show `T u` by implication elimination on `h₄` and `h₃`.
  end

The same proof can be written more concisely using ``specialize``.

.. code-block:: lean

  variables (U : Type*) (S T : U → Prop) (u : U)
  -- BEGIN
  example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
  begin
    specialize h₁ u,  -- We have `h₁ : S u` by for all elim. on `h₁` and `u`.
    specialize h₂ u, -- We have `h₂ : S u → T u` by for all elim. on `h₂` and `u`
    show T u, from h₂ h₁, -- We show `T u` by implication elimination on `h₂` and `h₁`.
  end
  -- END

In the following backward Lean proof, ``apply h₂`` invokes for all elimination followed by
implication elimination on the hypothesis ``h₂``.

.. code-block:: lean

  variables (U : Type*) (S T : U → Prop) (u : U)
  -- BEGIN
  example (h₁ : ∀ x, S x) (h₂ : ∀ y, S y → T y) (u : U) : T u :=
  begin
    apply h₂, -- By for all elim. on `h₂` and `u`, followed by imp. elim., it suffices to prove `S u`.
    apply h₁, -- The result follows by for all elim. on `h₁` and `u`.
  end
  -- END

In the next example, we construct a predicate using two others.

Below, we have predicates ``S`` and ``T`` on a type ``U``. The function that takes ``x : U`` to
``(S x) ∧ (T x)`` is also a predicate. We assume the universally quantified statement
``h : ∀ x, (S x) ∧ (T x)``. By for all elimination applied to ``h`` and ``u : U``, we have
``(S u) ∧ (T u)``. We can extract ``S u`` from this by left conjunction elimination.

.. code-block:: lean

  variables (U : Type*) (S T : U → Prop) (u : U)
  -- BEGIN
  example (h : ∀ x, (S x) ∧ (T x)) : S u :=
  begin
    have h₂ : (S u) ∧ (T u), from h u, -- We have `h₂ : (S u) ∧ (T u)` by for all elimination on `h` and `u`.
    show (S u), from h₂.left, -- We show `S u` by left conjunction elimination on `h₂`.
  end
  -- END

For a more familiar example, we'll show :math:`(\forall x : \mathbb Z, x^2 \ge 0) \to (-4)^2 \ge 0`.

.. proof:proof::

  Assume :math:`h : \forall x : \mathbb Z, x^2 \ge 0`. It suffices to prove :math:`(-4)^2\ge0`.
  But :math:`-4 : \mathbb Z`. The result follows by for all elimination on :math:`h` and :math:`-4`.

In the Lean code below, we need to use the type ascription ``4 : ℤ``. The reason is that Lean, by
default, interprets numerals as terms of type ``ℕ``. It then balks at ``-4``.

.. code-block:: lean

  import data.int.basic
  -- BEGIN
  example : (∀ x : ℤ, x^2 ≥ 0) → ((-(4 : ℤ))^2 ≥ 0) :=
  begin
    intro h,
    exact h (-4),
  end
  -- END

For all introduction
--------------------

.. proof:mathsrule:: For all introduction

  Let :math:`P` be a predicate on a type :math:`U`. To prove :math:`\forall x, P(x)` is to assume
  :math:`u : U` and derive :math:`P(u)`.

Again, note the similarity between this rule and implication introduction.

All the results we've seen so far that begin with, 'Let :math:`P` and :math:`Q` be propositions'
can be replaced with universally quantified statements that don't specify the names of the
propositions.

.. proof:theorem:: Commutativity of conjunction (IV)

  We have :math:`\forall P : \mathrm{Prop}, \forall Q : \mathrm{Prop}, P \land Q \leftrightarrow Q\land P`.

.. proof:proof::

  Assume :math:`R` and :math:`S` are propositions. It suffices to show
  :math:`R\land S \leftrightarrow S\land R`. But this follows by
  :numref:`Theorem %s <thm_and_comm3>`. 

In Lean, we use ``intro`` to denote for all introduction (as we do for implication introduction).

.. code-block:: lean

  example : ∀ p q : Prop, p ∧ q ↔ q ∧ p :=begin
    intros r s, -- Assume `r : Prop` and `s : Prop`. It suffices to prove `r ∧ s ↔ s ∧ r`.
    split; -- By iff intro., it suffices to prove 1. `r ∧ s → s ∧ r` and 2. `s ∧ r → r ∧ s`. We'll use the same proof in each case.
    { intro h, exact ⟨h.2, h.1⟩, }, -- Assume the antecedent, `h`. The goal is closed by and intro. on `h.1` and `h.2`
  end

Our final example uses both for all introduction and for all elimination.

.. proof:example::

  Let :math:`P` and :math:`Q` be predicates on a type :math:`U`. We have

  .. math::

    (\forall x, P(x)\land Q(x))\to(\forall y, Q(y)\land P(y)).

Here is the Lean proof, with the matheatical proof given in the comments.

.. code-block:: lean

  variables (U : Type*) (P Q : U → Prop)
  
  example : (∀ x, P x ∧ Q x) → (∀ y, Q y ∧ P y) :=
  begin
    intro h, -- Assume `h : ∀ x, P x ∧ Q x`. By `→` intro., it suffices to prove `∀ y, Q y ∧ P y`.
    intro u, -- Assume `u : U`. By `∀` intro, it suffices to prove `Q u ∧ P u`.
    rw and_comm,  -- By commutativity of conjunction, it suffices to prove `P u ∧ Q u`.
    exact h u, -- This follows by `∀` elim. on `h` and `u`.
  end





Existential quantification
==========================

The existential quantifier, written :math:`\exists` is read 'there exists', 'there is', or
'for some'. Informally, :math:`\exists x, P(x)` is the assertion that there is some :math:`u` for
which :math:`P(u)` holds.

As with the universal quantifier, we can make the types explicit via a type ascription,
writing :math:`\exists (x : U), P(x)`, for example.

Formally, the meaning of the universal quantifier is defined by two rules of inference.

Exists introduction
-------------------

.. proof:mathsrule:: Exists introduction, forward

  Let :math:`P` be a predicate on a type :math:`U`. Given :math:`u : U` and :math:`h : P(u)`,
  we have a proof of :math:`\exists x, P(x)`.

.. proof:example::

  Given :math:`5 : \mathbb N` and :math:`h : 5 \ge 3`, we have :math:`\exists x, x \ge 3`.

The proof is simply an application of exists introduction to :math:`5 : \mathbb N` and :math:`h`.

In Lean, if ``u : U`` and ``h : P u``, then ``exists.intro u h`` is a proof of ``∃ x, P x``

.. code-block:: lean

  example (h : 5 ≥ 3) : ∃ x, x ≥ 3 :=
  by exact exists.intro 5 h

To be more concise, we can use the anonymous constructor notation.

.. code-block:: lean

  example (h : 5 ≥ 3) : ∃ x, x ≥ 3 :=
  by exact ⟨5, h⟩


.. proof:mathsrule:: Exists introduction, backward

  Let :math:`P` be a predicate on a type :math:`U`. Given :math:`u : U`, to prove
  :math:`\exists x, P(x)`, it suffices to prove :math:`P(u)`.

.. proof:example::

  Let :math:`P` and :math:`Q` be predictes on a type :math:`U`. Given :math:`u : U`,
  :math:`h_1 : P(u)\to Q(u)` and :math:`h_2 : P(u)`, we have a proof of :math:`\exists x, Q(x)`.

.. proof:proof::

  By exists introduction on :math:`u`, it suffices to prove :math:`Q(u)`.
  But this follows by implication elimination on :math:`h_1` and :math:`h_2`.

In Lean, the ``use`` tactic indicates backward exists introduction. We use this to give a Lean
proof of the example above.

.. code-block:: lean

  import tactic.interactive
  variables (U : Type*) (P Q : U → Prop)
  -- BEGIN
  example (u : U) (h₁ : P u → Q u) (h₂ : P u) : ∃ x, Q x :=
  begin
    use u,       -- By `∃` intro. on `u`, it suffices to prove `Q u`
    exact h₁ h₂, -- This follows by `→` elim. on `h₁` and `h₂`.
  end
  -- END

Here is a forward Lean proof of the same result.

.. code-block:: lean

  variables (U : Type*) (P Q : U → Prop)
  -- BEGIN
  example (u : U) (h₁ : P u → Q u) (h₂ : P u) : ∃ x, Q x :=
  begin
    have h₃ : Q u, from h₁ h₂, -- We have `Q u` from `→` elim. on `h₁` and `h₂`.
    exact exists.intro u h₃,   -- The result follows from exists intro. on `u` and `h₃`.
  end
  -- END

Exists elimination
------------------

Suppose you want to prove, 'A person in Britain has competed in the Olympics' and you have a
hypothesis :math:`h`, 'there exists a person in Britain who has won a gold medal at the Olympics'.

By :math:`h`, we can take :math:`u`, a person in Britain for which we have hypothesis :math:`k`,
':math:`u` has one a gold medal at the Olmpics'. To prove the original goal, it suffices to
prove the goal with the assumption of :math:`u` and :math:`k`. This observation is the essence
of exists elimination, the rule of inference used to eliminate the existential quantifier.

.. proof:mathsrule:: Exists elimination, backward

  Let :math:`P` be a predicate on a type :math:`U`. Given :math:`h : \exists x, P(x)`, to prove
  :math:`C`, it suffices to derive :math:`C` under the assumptions :math:`u : U` and
  :math:`k : P(u)`.

This rule should be reminscent of disjunction eliminiation.

.. _example_exsandt_to_exs:

.. proof:example::

  Let :math:`S` and :math:`T` be predicates on a type :math:`U`. Given :math:`h : \exists x, S(x) \land T(x)`,
  we have :math:`\exists y, S(y)`.

.. proof:proof::

  By exists elimination, it suffices to prove :math:`\exists y, S(y)` under the assumptions :math:`u : U`
  and :math:`k : S(u)\land T(u)`.

  By exists introduction on :math:`u : U`, it suffices to prove :math:`S(u)`. This follows by
  left conjunction eliminiation on :math:`k`.

In Lean, we use the ``cases`` tactic for backward exists elimination. Suppose ``h : ∃ (x : U), P x``,
then ``cases h with u k`` removes ``h`` from the context and replaces it with ``u : U`` and ``k : P u``.
Below, we give a Lean version of the proof above.

.. code-block:: lean

  import tactic.interactive
  variables (U : Type*) (S T : U → Prop)
  -- BEGIN
  example (h : ∃ x, S x ∧ T x) : ∃ y, S y :=
  begin
    cases h with u k, -- By exists elim. on `h`, it suffices to prove the goal assuming `u : U` and `k : S u ∧ T u`.
    use u, -- By exists intro. on `u`, it suffices to prove `S u`.
    exact k.left, -- This follows by left `∧` elim. on `k`.
  end
  -- END

.. proof:mathsrule:: Exists elimination, forward

  Let :math:`P` be a predicate on a type :math:`U`. Given :math:`h_1 : \exists (x : U), P(x)` and
  :math:`h_2 : \forall (y : U), P(y) \to C`, we have a proof of :math:`C`.

We give a forward proof of :numref:`Example %s <example_exsandt_to_exs>` in Lean below. 
The Lean function used in a forward exists elimination proof is ``exists.elim``. Given
``h₁ : ∃ (x : U), P x`` and ``h₂ : ∀ (y : U), P y → C``, the expression ``exists.elim h₁ h₂``
is a proof term for ``C``.

.. code-block:: lean

  import tactic.interactive
  variables (U : Type*) (S T : U → Prop)
  -- BEGIN
  example (h₁ : ∃ x, S x ∧ T x) : ∃ y, S y :=
  begin
    have h₂ : ∀ y, S y ∧ T y → ∃ y, S y, -- We'll show `h₂ : ∀ y, S y ∧ T y → ∃ y, S y`.
    { assume u : U, -- Assume `u : U`. It suffices to prove `S u ∧ T u → ∃ y, S y`.
      assume k₁ : S u ∧ T u, -- Assume `S u ∧ T u`. It suffices to prove `∃ y, S y`.
      have h₃ : S u, from k₁.left, -- We have `h₃ : S u` by left `∧` elim. on `k₁`,
      show ∃ y, S y, from exists.intro u h₃, }, -- We show `∃ y, S y` by exists intro. on `u` and `h₃`.
    exact exists.elim h₁ h₂, -- The result follows by exists elim. on `h₁` and `h₂`.
  end
  -- END

.. index:: quantifiers; negating, negating 

Negating quantifiers
====================

If you had to prove that *not* every matheamtician is a billionaire, you'd merely have to point to
me and show that I'm not a billionaire. Intuitively, the negation, :math:`\neg(\forall x, P(x))`,
of a universally quantified statement is just the existentially quantified statement
:math:`\exists x, \neg P(x)` in which the predicate has been negated. 

Likewise, if you had to prove it's not the case that there is a mathemtician who lives on Pluto,
you would have to show that every mathematician does not live on Pluto. That is, the negation,
:math:`\neg(\exists x, P(x))`, of an existentially quantified statement is the universally
quantified statement :math:`\forall x, \neg P(x)` in which the predicate has been negated.

These are claims that require proof.

.. proof:theorem:: Negation of an existentially quantified statement

  Let :math:`P` be a predicate on a type :math:`U`. then

  .. math::

    \neg(\exists x, P(x)) \leftrightarrow \forall x, \neg P(x).

Here is a Lean proof.

.. code-block:: lean 

  import tactic.interactive
  variables {U : Type*} {P : U → Prop}
  namespace hidden
  -- BEGIN
  theorem not_exists : ¬(∃ x, P x) ↔ ∀ x, ¬P x :=
  begin
    -- By iff intro., it suffices to prove 1. `¬(∃ x, P x) → ∀ x, ¬P x` and 2. `∀ x, ¬P x → ¬(∃ x, P x)`
    split, 
    { intro h₁,    -- Case 1. Assume `h₁ : ¬(∃ x, P x)`. By `→` intro, it suffices to prove `∀ x, ¬P x`.
      intro u,     -- Assume `u : U`. By for all intro., it suffices to show `¬P u`.
      intro h₂,    -- Assume `h₂ : P u`. By negation introduction, it suffices to prove `false`.
      apply h₁,    -- By false introduction on `h₁`, it suffices to prove `∃ x, P x`.
      use u,       -- By `∃` intro on `u`, it suffices to prove `P u`.
      exact h₂, }, -- This follows by reiteration on `h₂`.
    { intro h₁,    -- Assume `h₁ : ∀ x, ¬P x`. It suffices to prove `¬∃ x, P x`.
      intro h₂,   --- Assume `h₂ : ∃ x, P x`. By negation introduction, it suffices to prove `false`.
      -- By `∃` elim. on `h₂`, it suffices to prove `false` assuming `u : U` and `hu : P u`.
      cases h₂ with u hu,
      have h₃ : ¬P u, from h₁ u, -- By `∀` elim. on `h₁` applied to `u`, we have `h₃ : ¬P u`.
      exact h₃ hu, }, -- We show the goal by false introduction on `h₃` and `hu`.
  end
  -- END
  end hidden


.. proof:theorem:: Negation of a universally quantified statement

  Let :math:`P` be a predicate on a type :math:`U`. then

  .. math::

    \neg(\forall x, P(x)) \leftrightarrow \exists x, \neg P(x).

Complete the following proof of the above theorem.

.. code-block:: lean

  import tactic.interactive
  variables {U : Type*} {P : U → Prop}
  namespace hidden
  -- BEGIN
  theorem not_forall : ¬(∀ x, P x) ↔ ∃ x, ¬P x :=
  begin
    -- By iff intro., it suffices to prove 1. `¬(∀ x, P x) → ∃ x, ¬P x` and 2. `∃ x, ¬P x → ¬(∀ x, P x)`
    split, 
    { intro h₁, -- Case 1. Assume `h₁ : ¬(∀ x, P x)`. It suffices to prove `∃ x, ¬P x`.
      by_contradiction h₂, -- For a contradiction, suppose `h₂ : ¬(∃ x, ¬P x)`. It suffices to prove `false`.
      sorry, },
    { intro h₁, -- Case 2. Assume `h₁ : ∃ x, ¬P x`. It suffices to prove `¬(∀ x, P x)`.
      intro h₂, -- Assume `h₂ : ∀ x, P x`. By negation introduction, it suffices to prove `false`.
      cases h₁ with u hu, -- By `∃` elim. on `h₁`, it suffices to prove the goal assuming `u : U` and `hu : ¬P u`.
      apply hu, -- By false introduction on `hu`, it suffices to prove `P u`.
      exact h₂ u, } -- The result follows by for all elimination on `h₂` and `u`.
  end
  -- END
  end hidden

Even and odd numbers
====================

Even numbers
------------

As a practical example, we consider the definition of even numbers.

.. proof:definition::

  Let :math:`a` be an natural number. :math:`a` is even means :math:`\exists (b : \mathbb N), a = 2b`.

Note that for a given term :math:`a`, :math:`\exists b, a = 2b` is a proposition.
Thus :math:`\mathrm{even}` is a predicate. To harmonise this definition with the language of
predicate logic, we may write :math:`\mathrm{even}\ a` to denote the proposition
:math:`\exists b, a = 2b`.

For example, :math:`\mathrm{even}\ 10` is the proposition :math:`\exists b, 10 = 2b`. Just as
:math:`\mathrm{even}\ 7` is the proposition :math:`\exists b, 7 = 2b`.

Suppose we already know :math:`h : 10 = 2\times5`. We can use this fact to prove
:math:`\mathrm{even}\ 10`.

.. proof:example::

  Given :math:`h : 10 = 2\times5`, we have :math:`\mathrm{even}\ 10`.

The proof is merely an application of exists introduction to :math:`5 : \mathbb N` and :math:`h`.

Let's see this in Lean. The first line below is the definition of ``even``. The expression
``exists.intro 5 h`` is a proof term for ``even 10``. This is a forward proof.

.. code-block:: lean

  def even (a : ℕ) := ∃ b, a = 2 * b

  example (h : 10 = 2 * 5) : even 10 :=
  begin
    exact exists.intro 5 h
  end

Alternatively, we can give a backward proof. This proof employs the ``use`` tactic.

.. code-block:: lean

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

The proof of the next example involves both exists introduction and exists elimination.
We make use of some properties of natural numbers that we have not yet proved.

.. proof:example::

  Let :math:`n : \mathbb N`. Given :math:`h : \mathrm{even}\ n`, we have
  :math:`\mathrm{even}\ 5n`.

.. proof:proof::

  Using the definition of even, we have :math:`h : \exists b, n = 2b`.
  The goal is to prove :math:`\exists b, 5n = 2b` (note this is not necessarily the same :math:`b`
  that appears in :math:`h`).
  
  By exists elimination on :math:`h`, it suffices prove this goal under the assumptions
  :math:`c : \mathbb N` and :math:`k : n = 2c`.

  By exists introduction on :math:`5c`, it suffices to prove :math:`5n=2(5c)` (essentially, this is
  taking :math:`b` in the goal to be :math:`5c`).

  Rewriting using :math:`k`, the goal is to prove :math:`5(2c)=2(5c)`. This follows by standard
  properties of the natural numbers.

.. code-block:: lean

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

Odd numbers
-----------

.. proof:definition::

  Let :math:`a : \mathbb N` be an integer. Then :math:`\mathrm{odd}\ a` means
  :math:`\exists (b : \mathbb N), a = 2b + 1`.

.. proof:theorem::

  Given :math:`n : \mathbb N`, we have
  :math:`\neg\mathrm{even}\ n \leftrightarrow\mathrm{odd}\ n`.

The above theorem is suprisingly difficult to prove! You don't need to understand the proof, but 
I give it below if you're interested (click 'try it!' to see the proofs of all the required lemmas).

.. code-block:: lean

  import tactic
  namespace hidden
  def even (a : ℕ) := ∃ b, a = 2 * b

  def odd (a : ℕ) := ∃ b, a = 2 * b + 1

  def parity : ℕ → ℕ
  | 0              := 0
  | (nat.succ n)   := ite (parity n = 0) 1 0

  lemma parity_eq_zero_or_one (n : ℕ) : parity n = 0 ∨ parity n = 1 :=
  begin
    induction n with k hk,
    { left, refl, },
    unfold parity at *,
    by_cases h : parity k = 0,
    { rw h, right, refl, },
    { left, exact if_neg h, },
  end

  lemma parity_eq_zero_of_even (n : ℕ) : even n → parity n = 0 :=
  begin
    rintro ⟨b, rfl⟩,
    induction b with k hk,
    { refl, },
    { rw nat.mul_succ,
      unfold parity,
      refine if_neg _,
      rw [hk, if_pos],
      { contradiction, },
      { refl, }, },
  end

  lemma parity_eq_one_of_odd (n : ℕ) : odd n → parity n = 1 :=
  begin
    rintro ⟨b, rfl⟩,
    induction b with k hk,
    { refl, },
    { rw nat.mul_succ,
      unfold parity at *,
      rw if_pos,
      rw if_neg,
      rw hk,
      trivial, },
  end

  -- BEGIN
  theorem not_even_iff_odd (n : ℕ) : ¬even n ↔ odd n :=
  begin
    induction n with k hk,
    { exact ⟨(λ h, false.elim (h ⟨0, rfl⟩)), (λ ⟨n,hn⟩ _, nat.succ_ne_zero (2*n) hn.symm)⟩, },
    { cases (parity_eq_zero_or_one k) with k₀ k₁, 
      { have : even k, from (show ¬odd k → even k, by {contrapose!, exact hk.mp})
        ((mt (parity_eq_one_of_odd k)) (k₀.symm ▸ nat.zero_ne_one)),
        rcases this with ⟨b, rfl⟩,
        split,
        { exact λ _, ⟨b, rfl⟩, },
        { have h₃ : parity(nat.succ (2*b)) = 1, from if_pos k₀,
          exact (λ _, (mt (parity_eq_zero_of_even _)) (h₃.symm ▸ nat.zero_ne_one.symm )) }, },
      { have h₁ : ¬(parity k = 0), { intro h, rw h at k₁, contradiction, },
        rcases (hk.mp) ((mt (parity_eq_zero_of_even k )) h₁) with ⟨b, rfl⟩,
        split,
        { exact λ h₂, false.elim (h₂ ⟨b+1, rfl⟩), },
        { have h₃ : parity(nat.succ (2*b+1)) = 0, from if_neg h₁,
          exact (λ h₄, false.elim ((nat.zero_ne_one) (h₃ ▸ (parity_eq_one_of_odd _ h₄)))), }, }, },
  end
  -- END
  end hidden

.. proof:example::

  Given :math:`a, b, c, d : \mathbb N`, given :math:`h_1 : c = 2a`, and :math:`h_2 : d = 2b+1`.
  We have :math:`\mathrm{odd} (c+d)`.

.. proof:proof::

  By definition of :math:`\mathrm{odd} (c+d)`, we have to prove :math:`\exists x, c + d = 2x+1`.
  Note that I've changed the variable name from :math:`b` to :math:`x` in applying the definition
  to avoid a clash with the variable :math:`b`.

  By exists introduction on :math:`a+b`, it suffices to prove :math:`c + d = 2(a+b)+1`.
  Rewriting using :math:`h_1` and :math:`h_2`, the goal is to prove
  :math:`2a + (2b+1) = 2(a+b)+1`. This follows by standard arithmetic results.

Mixing quantifiers
==================

Functions and equality
======================