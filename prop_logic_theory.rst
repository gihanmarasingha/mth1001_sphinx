.. _prop_logic_tutorial:

**************************
Propositional Logic Theory
**************************


Propositions and propositional variables
========================================

From an informal perspective, propositions are statements that can be assigned
a truth value.

The formal perspective, which is more useful when you want to prove a theorem, propositions are
simply expressions that can be constructed recursively by applying connectives to other propositions.

As with any recursive definition, we must begin with a base set of propositions. These are called
*propositional variables*. Technically, we have an infinite list of propositional variables,
labelled :math:`P_1, P_2, \dots, P_n, \dots`. For practical purposes, we often refer to
propositional variables using different letters of the alphabet whether uppercase :math:`P, Q, R, \dots`
or lower case :math:`p, q, r, \dots`.

The five connectives of propositional logic are shown in
:numref:`tab_prop_connectives`, listed in decreasing order of precedence. Negation is a unary
connective, which means that it applies only to one proposition. The remaining connectives are
binary, applying to two propositions.

.. tabularcolumns:: |c|l|

.. _tab_prop_connectives:

.. table:: Connectives of propositional logic and their order of precedence
  :widths: 10 20  

  =========================  ===================
  Connective                    Name
  =========================  ===================
  :math:`\neg`               Negation
  :math:`\land`              Conjunction, And
  :math:`\lor`               Disjunction, Or
  :math:`\to`                Implication
  :math:`\leftrightarrow`    If and only if
  =========================  ===================

.. proof:definition:: Proposition

  A proposition is a propositional variable or one of :math:`(\neg \alpha)`, :math:`(\alpha\land\beta)`,
  :math:`(\alpha\lor\beta)`, :math:`(\alpha\to\beta)`, :math:`(\alpha\leftrightarrow\beta)`, where
  :math:`\alpha` and :math:`\beta` are propostions.


For example, if our propositional variables are :math:`P`, :math:`Q`, and :math:`R`, then all the
following are propositions: :math:`P`, :math:`(\neg P)`, :math:`(\neg(P\land Q))`,
:math:`((P\lor Q)\leftrightarrow(\neg R))`.

To simplify writing propositions, we may always remove the outermost parentheses and remove other
parentheses according to the order of precedence. That is, if :math:`\oplus`
and :math:`\otimes` are (generic) connectives where :math:`\oplus` has a higher order of precedence
than :math:`\otimes`, if  :math:`\alpha`, :math:`\beta`, and :math:`\gamma`
are propositions, then :math:`((\alpha\oplus\beta)\otimes\gamma)` can be replaced with
:math:`\alpha\oplus\beta\otimes\gamma`. Likewise, :math:`(\alpha\otimes(\beta\oplus\gamma))` can
be replaced with :math:`\alpha\otimes\beta\oplus\gamma`. This rule can be applied recursively.

Thus :math:`((P\land Q)\to(P\lor(Q\land(\neg R))))` can be more simply written as
:math:`P\land Q \to P \lor Q \land \neg R`.

The proposition, :math:`((P\land Q)\lor R)` can be written as :math:`(P\land Q)\lor R`, but we
cannot remove the inner parentheses as the connective :math:`\lor` has a lower order of precendence
than :math:`\land`.

Two propositions :math:`\alpha` and :math:`\beta` are considered to be equal if and only if they
are written *identically*, with the exception of parenthesis dropping as described in the previous
paragraph.

Thus :math:`P\land Q` is *not* equal to :math:`Q\land P`. However, :math:`((P\land Q)\lor R)` is
equal to :math:`(P\land Q)\lor R` and to :math:`P\land Q \lor R`.

In :numref:`Section %s <prop_variables>`, we discuss how to represent propositions in Lean.

Derivations and rules of inference
==================================

Propositional logic is concerned with making derivations, based on *premises*, using
*rules of inference*.

Each premise takes the form :math:`h : \alpha`, where :math:`h` is any symbol (usually a lowercase
letter, with or without a subscript) and :math:`\alpha` is a proposition.

Intuitively, the judgment :math:`h : \alpha` is to be read ':math:`h` is a proof of :math:`\alpha`'.
We will give a more rigorous interpretation of this judgment in :numref:`Section %s <sec_types>`.

Here is an example of a rule of inference. This rule is called left conjunction elimination.

  Given :math:`h : P\land Q`, we have a proof of :math:`P`.

In essence, a rule of inference is a black box that takes certain inputs (the premises) and
produces an output. In this case, the output is a proof of :math:`P`. Here, and in every
statement of a rule of interfence, the names of propostions that appear are to be treated as 
generic. Thus :math:`P` and :math:`Q` can be replaced with any propositions.

As an example application of this rule of inference, suppose we have a premise
:math:`h : (P\to Q)\land R`. Left conjunction elimination, applied to :math:`h`, produces a 
proof of :math:`P\to Q`.

Rules of inference can be applied in sequence. Suppose we have a premise
:math:`k_1 : (Q \land P) \land R`. Applling left conjunction elimination to :math:`k_1` gives a proof
of :math:`Q\land P`. Let us denote by :math:`k_2` the proof of :math:`Q\land P` that results from
the application of left conjunction elimination to :math:`k_1`. By applying left conjunction
elimination to the hypothesis :math:`k_2`, we have a proof of :math:`Q`.

We use the word *hypothesis* to denote either a premise or a result derived by a rule of inference
during the course of a proof. At any stage in a proof, the entire set of hypotheses developed or
introduced up to that point, together with any variables, is called the *context*. In the above
proof, the context initially consists of thepremise :math:`k_1` and the varialbles :math:`P`,
:math:`Q`, and :math:`R`. After the first application of left conjunction elimination, the context
will also include the hypotheses :math:`k_2`.

Conjunction 
===========

Conjunction Elimination
-----------------------

There are two conjunction elimination rules, left and right.

.. proof:mathsrule:: Conjunction elimination

  .. raw:: latex

    \ 

  * (*Left and elimination*) given :math:`h : P \land Q`, we have a proof of :math:`P`.
  * (*Right and elimination*) given :math:`h : P \land Q`, we have a proof of :math:`Q`.

As an example, given that :math:`P` and :math:`Q` are propositions, we will deduce :math:`Q` from
the premise :math:`h : (P \land Q)\land R`.

  We have :math:`h_2 : P\land Q` by left conjunction elimination on :math:`h`. The result follows
  by right conjunction elimination on :math:`h_2`.

Conjunction Elimination in Lean
-------------------------------

This is expressed in Lean as follows.

.. code-block:: lean

  variables p q r : Prop

  example (h : (p ∧ q) ∧ r ) : q :=
  begin
    have h₂ : p ∧ q, from h.left,
    exact h₂.right 
  end

The ``exact`` tactic is a 'finishing command' that closes the goal with the supplied proof term.
Here, ``h.left`` is the proof term that results from applying left conjunction elimination to ``h``.
The ``have`` tactic introduces a new goal, in this case ``h₂ : p ∧ q``. It should be followed by
a tactic that closes the goal. Here, ``from h.left`` is a synonym for ``exact h.left``.

In the above proof, ``h₂.right`` is the proof term that results from applying conjunction
elimination to ``h₂``. As ``h₂`` is a proof of ``p ∧ q``, we have that ``h₂.right`` is a proof of ``q``.

Tactic-style Lean proofs are designed to be worked with *interactively*, not to be read. If you are
reading this online, click *try it* above to open the code snippet in a browser window. Note that
the first time you press *try it!*, a copy of Lean will be downloaded to your browser. This may take a 
few minutes.

At each point in the proof, Lean displays the *goal* (that which you are trying to prove) and the *context*
in a separate pane of your window.

At the start of the proof above, Lean will display the following, indicating that the context
consists of three propositional variables, ``p`, ``q``, and ``r``, together with the premise
``h : (p ∧ q) ∧ r``. The goal (indicated with the *turnstile* symbol ``⊢``) is that of proving ``q``.

.. code-block:: lean

  p q r : Prop,
  h : (p ∧ q) ∧ r
  ⊢ q

If you place your cursor after the line with the ``have`` statement, the context changes to the
following, in which ``h₂ : p ∧ q`` has been added.

.. code-block:: lean

  p q r : Prop,
  h : (p ∧ q) ∧ r,
  h₂ : p ∧ q
  ⊢ q

To make the proof more readable, you can use the ``show`` tactic. This tactic announces what
remains to be proved. Below, we follow ``show q,`` with ``from h₂.right``, which is a synonym
for ``exact h₂.right``.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r ) : q :=
  begin
    have h₂ : p ∧ q, from h.left,
    show q, from h₂.right,
  end
  -- END

The above is a Lean representation of the following mathematical proof.

  We have :math:`h_2 : P\land Q` by left conjunction elimination on :math:`h`. We show :math:`q`
  by right conjunction elimination on :math:`h_2`.

Rather than introducing an intermediate hypothesis ``h₂``, the proof can be carried out in one line.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : q :=
  begin
    show q, from (h.left).right
  end
  -- END

This can be written mathematically as follows.

  We show :math:`q` by right conjunction elimination applied to the result of left conjunction
  elimination applied to :math:`h`.

Alternatively, we can use the ``cases`` tactic, which performs left and right and elimination
simultaneously.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : q :=
  begin
    cases h with h₂ h₃, -- We have `h₂ : p` and `h₃ : q` by left and right conjunction elimination on `h`.
    exact h₂.right      -- The result follows by right conjunction elimination on `h₂`.
  end
  -- END

A mathematical statement of this proof would be:

This can be written mathematically as follows.

  We have :math:`h_2 : p \land q` and :math:`h_3 : r` by left and right conjunction elimination,
  respectively, on :math:`h`. The result follows by right conjunction elimination on :math:`h_2`.

Conjunction Introduction
------------------------

The rule of conjunction introduction can be expressed in two forms, forward and backward.

.. proof:mathsrule:: Conjunction introduction, forward

  Given :math:`h_1 : P` and :math:`h_2 : Q`, we have a proof of :math:`P\land Q`.

.. proof:mathsrule:: Conjunction introduction, backward

  To prove :math:`P\land Q`, it suffices to prove :math:`P` and :math:`Q`.

.. _example_and_comm1:

.. proof:example:: Commutativity of conjunction (I)

  Let :math:`P` and :math:`Q` be propositions. Given :math:`h : P \land Q`, we have a proof of :math:`Q \land P`.

We'll give both a forward and a backward proof.

.. proof:proof:: Forward Proof

  We have :math:`h_2 : P` and :math:`h_3 : Q` by left and right conjunction elimination on :math:`h`.
  The result follows by conjunction introduction on :math:`h_3` and :math:`h_2`.

Lean uses ``and.intro`` to represent forward conjunction introduction.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  example (h : p ∧ q) : q ∧ p :=
  begin
    have h₂ : p, from h.left,
    have h₃ : q, from h.right,
    exact and.intro h₃ h₂,
  end
  -- END

.. proof:proof:: Backward Proof

  By conjunction introduction, it suffices to prove 1. :math:`Q` and 2. :math:`P`.

  #. We show :math:`Q` from right conjunction introduction on :math:`h`.
  #. We show :math:`P` from left conjunction elimination on :math:`h`

Lean uses ``split`` to represent backward conjunction introduction. As used below, the ``split``
tactic replaces the goal of proving ``q ∧ p`` with two goals 1. to prove ``q`` and 2. to prove ``p``.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  example (h : p ∧ q) : q ∧ p :=
  begin
    split,
    show q, from h.right, 
    show p, from h.left,
  end
  -- END

If a rule of inference introduces multiple goals, it is good practice (though not required)
to enclose the proof of each new goal in braces. For good measure, I throw in a ``show``
at the start of the proof to demonstrate that ``show`` need not be followed by a tactic that
immediately closes the goal (such as ``from`` or ``exact``). Here, the scope of ``show`` is the
entire proof.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  example (h : p ∧ q) : q ∧ p :=
  begin
    show q ∧ p, split,
    { show q, from h.right, },
    { show p, from h.left, },  
  end
  -- END

Associativity of conjunction, in parts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _example_and_assoc1_0:

.. proof:example::
  
  Let :math:`P`, :math:`Q`, and :math:`R` be propositions. Given :math:`h : (P \land Q)\land R`, we
  have a proof of :math:`P \land (Q\land R)`.

Here's a forward proof.

.. proof:proof::

  - We have :math:`h_2 : P\land Q` and :math:`h_3 : R` by left and right conjunction elimination on :math:`h`.

  - We have :math:`h_4 : P` and :math:`h_5 : Q` by left and right conjunction elimination on :math:`h_2`.

  - We have :math:`h_6 : Q \land R` by conjunction introduction on :math:`h_5` and :math:`h_3`.

  - The result follows by conjunction introduction on :math:`h_4` and :math:`h_6`.

The same proof can be represented in Lean.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : p ∧ (q ∧ r) :=
  begin
    cases h with h₂ h₃,     -- h₂ : (p ∧ q), h₃ : r
    cases h₂ with h₄ h₅,    -- h₄ : p, h₅ : q
    have h₆ : q ∧ r, from and.intro h₅ h₃,
    show p ∧ (q ∧ r), from and.intro h₄ h₆,
  end
  -- END

Here's a proof of :numref:`Example %s <example_and_assoc1_0>` that combines forward and backward reasoning.
reasoning. The reiteration tactic is discussed more fully in
:numref:`Section %s <sec_reiteration>`. 

.. proof:proof::

  - We have :math:`h_2 : P\land Q` and :math:`h_3 : R` by left and right conjunction elimination on :math:`h`.

  - By conjunction introduction, it suffices to prove 1. :math:`P` and 2. :math:`Q \land R`.

    1. We show :math:`P` from left conjunction elimination on :math:`h_2`.

    2. We show :math:`Q\land R`. By conjunction introduction, it suffices to show 1. :math:`Q` and 2. :math:`R`.

       a. We show :math:`Q` from right conjunction elimination on :math:`h_2`.

       b. We show :math:`R` by reiteration on :math:`h_3`.

This proof can also be represented in Lean.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : p ∧ (q ∧ r) :=
  begin
    cases h with h₂ h₃,           -- We have `h₂ : p ∧ q` and `h₃ : r` by left and right conjunction elimination on `h`.
    split,                        -- By conjunction introduction, it suffices to prove `p` and `q ∧ r`.
    { show p, from h₂.left, },    -- We show `p` by left and elimination on `h₂`.
    { show q ∧ r, split,          -- We show `q ∧ r`. By conjunction introduction, it suffices to prove `q` and `r`.
      { show q, from h₂.right, }, -- We show `q` by right and elimination on `h₂`.
      { show r, from h₃ }, } ,    -- We show `r` by reiteration on `h₃`.
  end
  -- END


Of course, associativity also works in the other direction.

.. _example_and_assoc2_0:

.. proof:example::
  
  Let :math:`P`, :math:`Q`, and :math:`R` be propositions. Given :math:`h : P \land (Q\land R)`,
  we have a proof of :math:`(P \land Q)\land R`.

Here is an (incomplete) forward proof. Fill in each 'sorry' to complete the proof.

.. proof:proof::

  - We have :math:`h_2 : P` and :math:`h_3 : \text{sorry}` by sorry on :math:`h`.

  - We have :math:`h_4 : \text{sorry}` and :math:`h_5 : R` by left and right conjunction elimination on :math:`h_3`.

  - We have :math:`h_6 : P \land Q` by sorry.

  - The result follows by sorry.

Likewise, fill in each ``sorry`` to complete the forward Lean proof below.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : p ∧ (q ∧ r)) : (p ∧ q) ∧ r :=
  begin
    cases h with h₂ h₃,
    cases h₃ with h₄ h₅,
    have h₆ : p ∧ q, from sorry,
    sorry,
  end
  -- END

As an exercise, replace each sorry below to give a mixed forward and backward proof of
:numref:`Example %s <example_and_assoc2_0>`.

.. proof:proof::

  - We have :math:`h_2 : P` and :math:`h_3 : \text{sorry}` by sorry on :math:`h`.

  - By conjunction introduction, it suffices to prove 1. sorry and 2. sorry.

    #. sorry

    #. sorry

Likewise, fill in each ``sorry`` to complete the forward and backward Lean proof below.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : p ∧ (q ∧ r)) : (p ∧ q) ∧ r :=
  begin
    cases h with h₂ h₃,
    split,
    { split,
      { sorry, },
      { sorry, }, },
    { sorry, },
  end
  -- END

.. _sec_reiteration:

Reiteration
===========

.. proof:mathsrule:: Reiteration

  Given :math:`P`, we have a proof of :math:`P`.

Reiteration is a slighly unusual rule. Though we can often avoid using reiteration, it is
required in proving statements such as :math:`P \to P`.

For the moment, we present a silly example in which we use reiteration, albeit needlessly.

.. proof:example::

  Let :math:`P` and :math:`Q` be propositions. Given :math:`h : P \land Q`, we have a proof of :math:`Q`.

.. proof:proof::

  We have :math:`h_2 : Q` by right conjunction elimination on :math:`h`.
  The result follows by reiteration on :math:`h_2`.

Reiteration is represented in Lean via the ``exact`` (or ``from``) tactic applied to an
already-deduced proof term. The code below shows a Lean representation of the proof above.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  example (h : p ∧ q) : q :=
  begin
    have h₂ : q, from h.right, -- We have `h₂ : q` by right and elimination on `h`.
    exact h₂,                  -- The result follows by reiteration on `h₂`.
  end
  -- END

A more verbose mathematical proof concludes by reminding the reader of the goal. Below, for example,
we write, 'We show :math:`Q` by ...' in place of 'The result follows by ...'.

.. proof:proof::

  We have :math:`h_2 : Q` by right conjunction elimination on :math:`h`.
  We show :math:`Q` by reiteration on :math:`h_2`.

The Lean equivalent is the combination of the ``show`` and ``from`` tactics.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  example (h : p ∧ q) : q :=
  begin
    have h₂ : q, from h.right, -- We have `h₂ : q` by right and elimination on `h`.
    show q, from h₂,           -- We show `q` by reiteration on `h₂`.
  end
  -- END

Implication
===========

The symbol :math:`\to` is read 'implies'. The proposition :math:`P \to Q` can be read either as
':math:`P` implies :math:`Q`' or as 'if :math:`P`, then :math:`Q`'.

In a proposition of the form :math:`P \to Q`, the proposition :math:`P` is called the *antecedent*
and :math:`Q` is called the *consequent*.

.. _sec_imp_elim:

Implication elimination
-----------------------

.. proof:mathsrule:: Implication elimination, forward

  Given :math:`h_1 : P \to Q` and :math:`h_2 : P`, we have a proof of :math:`Q`.

.. proof:mathsrule:: Implication elimination, backward

  Given :math:`h_1 : P \to Q`, to prove :math:`Q`, it suffices to prove :math:`P`.

Here's an example application of implication elimination.

.. _example_imp_trans1:

.. proof:example::
  
  Let :math:`P`, :math:`Q`, and :math:`R` be propositions. Given :math:`h_1 : P \to Q`,
  :math:`h_2 : Q \to R` and :math:`h_3 : P`, we have a proof of :math:`R`.

We'll give two proofs of this. One using forward reasoning and one with backward reasoning.

.. proof:proof:: Forward proof

  By implication elimination on :math:`h_1` and :math:`h_3`, we have :math:`h_4 : Q`.
  We show :math:`R` by implication elimination on :math:`h_2` and :math:`h_4`.

In Lean, the proof of ``q`` from ``h₁ : p → q`` and ``h₂ : p`` is simply denoted ``h₁ h₂``. The
Lean translation of the foward proof of :numref:`Example %s <example_imp_trans1>` is given below.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h₁ : p → q) (h₂ : q → r) (h₃ : p) : r :=
  begin
    have h₄ : q, from h₁ h₃, -- We have `h₄ : q`, by implication elimination on `h₁` and  `h₃`. 
    show r, from h₂ h₄       -- We show `r` by implication elimination on `h₂` and `h₄`.
  end
  -- END

Another approach it to dispose of :math:`h_4` entirely. This is harder to read, but quicker to write.

.. proof:proof:: Short forward proof

  :math:`R` follows by implication elimination on :math:`h_2` and the result of implication
  elimination on :math:`h_1` and :math:`h_3`.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h₁ : p → q) (h₂ : q → r) (h₃ : p) : r :=
  begin
    show r, from h₂ (h₁ h₃)
  end
  -- END

The next proof uses one backward application and one forward application of implication elimination.

.. proof:proof:: Backward proof

  To prove :math:`R`, it suffices, by implication elimination on :math:`h_2` to prove :math:`Q`.
  We show :math:`Q` by implication elimination on :math:`h_1` and :math:`h_3`.

In Lean, given ``h₁ : p → q`` and a goal to prove ``q``, we transform the goal into one of proving
``p`` using ``apply h₁``. We use this to translate the above backward proof of
:numref:`Example %s <example_imp_trans1>`.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h₁ : p → q) (h₂ : q → r) (h₃ : p) : r :=
  begin
    apply h₂,          -- By implication elimination on `h₂`, it suffices to prove `q`.
    show q, from h₁ h₃ -- We show `q` by implication elimination on `h₁` and `h₃`.
  end
  -- END

If desired, we could give an entirely backward proof, finishing with reiteration.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h₁ : p → q) (h₂ : q → r) (h₃ : p) : r :=
  begin
    apply h₂, -- By implication elimination on `h₂`, it suffices to prove `q`.
    apply h₁, -- By implication elimination on `h₁`, it suffices to prove `p`.
    exact h₃, -- This follows by reiteration on `h₃`.
  end
  -- END

Here's an exercise in which the first line of the proof uses backward implication elimination.
You'll also have to use conjunction introduction.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h₁ : p ∧ q → r) (h₂ : p) (h₃ : q) : r :=
  begin 
    apply h₁, -- By implication elimination on `h₁`, it suffices to prove `p ∧ q`.
    sorry  
  end
  -- END

To really test your understanding of implication elimination, see if you can do the following
exercise.

.. code-block:: lean

  variables a b c d e f : Prop
  -- BEGIN
  example (h₁ : d → a) (h₂ : f → b) (h₃ : e → c) (h₄ : e → a)
          (h₅ : d → e) (h₆ : b → e) (h₇ : c) (h₈ : f) : a :=
  begin 
    sorry  
  end
  -- END

.. _sec_imp_intro:

Implication introduction
------------------------

Implication introduction is one of the most important rules of inference. It is the only rule, in
propositional logic, that permits us to derive a goal on *no premises*. Due to this, impliciation
introduction only has a backward form.

.. proof:mathsrule:: Implication introduction

  To prove :math:`P \to Q` is to assume :math:`h : P` and derive :math:`Q`.

.. _example_imp_intro:

.. proof:example::
  
  Let :math:`P` and :math:`Q` be propositions. Then :math:`Q \to (P \to Q)`.

.. proof:proof::

  * By implication introduction, it suffices to assume :math:`h_1 : Q` and deduce :math:`P \to Q`.

  * To show :math:`P \to Q`, it suffices, by implication introduction, to assume :math:`h_2 : P` and
    derive :math:`Q`.

  * We show :math:`Q` by reiteration on :math:`h_1`.

In Lean, to prove ``p → q``, we begin with the ``intro`` tactic to admit the assumption of the
antecedent ``p`` into the context and to change the goal to that of proving ``q``. For example,
if the initial goal is to prove ``p → q``, then ``intro h`` adds ``h : p`` into the context and
changes the goal to that of proving ``p``.

Here's a Lean proof of the theorem above.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example : q → (p → q) :=
  begin
    intro h₁,        -- Assume `h₁ : q`. It suffices to prove `p → q`.
    intro h₂,        -- Assume `h₂ : p`. It suffices to prove `q`.
    show q, from h₁, -- We show `q` by reiteration on `h₁`.
  end
  -- END

To make explicit what is being assumed, you may instead use the ``assume`` tactic. Below,
``assume h₁ : q`` has an identical effect to ``intro h₁`` above. The only difference is that
``assume`` explicitly asserts that ``h₁`` is an assumption of ``q``. This aids the human reader.

.. code-block:: lean 

  variables p q r : Prop
  -- BEGIN
  example : q → (p → q) :=
  begin
    assume h₁ : q,   -- Assume `h₁ : q`. It suffices to prove `p → q`.
    assume h₂ : p,   -- Assume `h₂ : p`. It suffices to prove `q`.
    show q, from h₁, -- We show `q` by reiteration on `h₁`.
  end
  -- END

.. _thm_and_comm2:

.. proof:theorem:: Commutativity of conjunction (II)
  
  Let :math:`P` and :math:`Q` be propositions. Then :math:`P \land Q \to Q \land P`.

.. proof:proof::

  * By implication introduction, it suffices to assume :math:`h : P \land Q` and deduce
    :math:`Q \land P`.

  * To show :math:`P \land Q`, it suffices, by conjunction introduction, to prove both 1. :math:`Q`
    and 2. :math:`P`.

    #. We show :math:`Q` from right conjunction elimination on :math:`h`.

    #. We show :math:`P` from left conjunction elimination on :math:`h`.

Here is the same proof in Lean. Note that we use ``theorem`` below instead of ``example``. This
produces a named result. Here, we call the result ``and_of_and``. We'll discuss theorems further
in :numref:`Section %s <sec_theorems>`.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  theorem and_of_and : p ∧ q → q ∧ p :=
  begin
    intro h,                   -- Assume `h : p ∧ q`. It suffices to prove `q ∧ p`.
    split,                     -- By `∧` intro., it suffices to prove both `q` and `p`.
    { show q, from h.right, }, -- We show `q` from right `∧` elimination on `h`.
    { show p, from h.left, },  -- We show `p` from left `∧` elimination on `h`.
  end
  -- END

The proof above uses backward conjunction introduction to prove ``q ∧ p``. We can alternatively use
forward conjunction introduction. Additionally, I use ``assume`` below instead of ``intro`` to
improve readability.

.. code-block:: lean

  variables p q : Prop
  -- BEGIN
  theorem and_of_and : p ∧ q → q ∧ p :=
  begin
    assume h : p ∧ q,                 -- Assume `h : p ∧ q`. It suffices to prove `q ∧ p`.
    have h₂ : q, from h.right,        -- We have `h₂ : q` by right conjunction elimination on `h`.
    have h₃ : p, from h.left,         -- We have `h₃ : p` by left conjunction elimination on `h`.
    show q ∧ p, from and.intro h₂ h₃, -- We show `q ∧ p` from conjunction introduction on `h₂` and `h₃`.
  end
  -- END

If you've been paying close attention, you'll note that the proofs above virtually the same as
our proofs of :numref:`Example %s <example_and_comm1>`, the result that given :math:`h : P \land Q`,
we have a proof of :math:`Q \land P`. The only difference is the addition of ``intro h`` as the
first line of the Lean proof or 'Assume :math:`h : P \land Q`, it suffices to prove
:math:`Q \land P`' as the first line of the mathematical proof.

In general, by enough applications of implication introduction, one can transform a result that
involves premises into a result with no premises.


.. _sec_theorems:

Theorems
========

Reusing results
---------------

One great thing about mathematics is that we don't constantly have to reinvent the wheel. Once
a result is proved, we can use it to prove other results.

A *theorem* is a named result. In the previous section, we have a mathematical theorem we can refer
to by number as :numref:`Theorem %s <thm_and_comm2>` or by name as the :ref:`thm_and_comm2` theorem.
We called the corresponding Lean theorem ``and_of_and``.

Think about how you might prove the following.

.. _example_and_comm_funny:

.. proof:example::

  Let :math:`A` and :math:`B` be propositions. Then
  :math:`(A \to B) \land (B\land A) \to (B\land A) \land (A\to B)`.

We can get our hands dirty and leap straight into a proof as follows.

.. proof:proof:: From the rules of inference

  Assume :math:`h : (A\to B)\land(B\land A)`. It suffices to prove :math:`(B\land A)\land(A\to B)`.
  By conjunction introduction, it suffices to prove both 1. :math:`B\land A` and 2. :math:`A\to B`.

  #. This follows from right conjunction elimination on :math:`h`.

  #. This follows from left conjunction elimination on :math:`h`.

But this proof is virtually identical to our proof of :numref:`Theorem %s <thm_and_comm2>`.
Indeed, the *statement* of :numref:`Example %s <example_and_comm_funny>` is essentially that of
:numref:`Theorem %s <thm_and_comm2>`, only with :math:`A\to B` in place of :math:`P` and
:math:`B\land A` in place of :math:`Q`.

Indeed, one should think of :numref:`Theorem %s <thm_and_comm2>` as stating that
:math:`P \land Q \to Q \land P` *for all* propositions :math:`P` and :math:`Q`. We will develop the
notion of 'for all' further in :numref:`Section %s <pred_logic>`.

For the moment, we should think of the variables :math:`P` and :math:`Q` that appear in the
statement of :numref:`Theorem %s <thm_and_comm2>` as being *placeholders*, *inputs* or *parameters*
that we can replace with any given terms, called *arguments*.

For example, taking :math:`A\to B` and :math:`B\land A` as arguments to the theorem gives a
one-line proof of :numref:`Example %s <example_and_comm_funny>`.

.. proof:proof:: Using a previously proved theorem with explicit arguments

  The result follows by :numref:`Theorem %s <thm_and_comm2>` applied to :math:`A \to B` and
  :math:`B \land A`.


A Lean proof of the result above uses the theorem ``and_of_and``, our Lean version of
:numref:`Theorem %s <thm_and_comm2>`. We repeat (a more concise version of) this theorem below along
with our proof of the new result.

.. code-block:: lean

  variables a b : Prop
  -- BEGIN
  theorem and_of_and (p q : Prop) : p ∧ q → q ∧ p :=
  begin
    intro h,
    exact and.intro (h.right) (h.left)
  end

  example : (a → b) ∧ (b ∧ a) → (b ∧ a) ∧ (a → b) :=
  begin
    exact and_of_and (a → b) (b ∧ a)
  end
  -- END

Placeholders
------------

Often, it isn't necessary to present the arguments explicitly. There are two alternatives. One is
the use of the Lean placeholder, denoted by an underscore character, ``_``. Whenever Lean
encounters an ``_``, it tries to *infer* an appropriate term. In the example below, Lean will infer
that the first and second underscores should be replaced with ``a → b`` and ``b ∧ a`` respectively.


.. code-block:: lean

  variables a b : Prop
 
  theorem and_of_and (p q : Prop) : p ∧ q → q ∧ p :=
  begin
    assume h,
    exact and.intro (h.right) (h.left)
  end
  -- BEGIN
  example : (a → b) ∧ (b ∧ a) → (b ∧ a) ∧ (a → b) :=
  begin
    exact and_of_and _ _
  end
  -- END



Implicit arguments
------------------

In situations like the above, it is evident that the arguments *must be* :math:`A\to B` and
:math:`B\land A` because those are the arguments that match
the form of the theorem with the form of the goal. It is typical in such situations not to
state the arguments explicity in a mathematical proof but to leave them implicit.

Here's our shortened proof of :numref:`Example %s <example_and_comm_funny>`.

.. proof:proof:: Using a previously proved theorem with implicit arguments

  The result follows by :numref:`Theorem %s <thm_and_comm2>`.


To enable the use of implicit arguments in Lean, we need to use a special syntax when stating our
theorem. In the statement of theorem ``and_of_and_v2`` below, we enclose the variable declarations
in braces ``{p q : Prop}`` in contrast to the parentheses ``(p q : Prop)`` in the earlier version.

In application of the theorem, we write merely ``exact and_of_and_v2`` in place of our
previous ``exact and_of_and (a → b) (b ∧ a)``. In the new proof, the arguments ``a → b`` and
``b ∧ a`` to the theorem ``and_of_and_v2`` are implicit. 

.. code-block:: lean

  variables a b : Prop
  -- BEGIN
  theorem and_of_and_v2 {p q : Prop} : p ∧ q → q ∧ p :=
  begin
    assume h,
    exact and.intro (h.right) (h.left)
  end

  example : (a → b) ∧ (b ∧ a) → (b ∧ a) ∧ (a → b) :=
  begin
    exact and_of_and_v2
  end
  -- END
  
Using theorems with the ``apply`` tactic
----------------------------------------

Another way to use a theorem is via the ``apply`` tactic. In :numref:`Section %s <sec_imp_elim>`,
we used ``apply`` with terms of type ``p → q`` when the goal is of type ``q``. In that case, the
apply tactic replaces the goal with one of proving ``p``.

More generally, the ``apply`` tactic can be used on a term ``h`` whenever the type of the goal
matches the 'conclusion' of the type of ``h``. The ``apply`` tactic replaces the goal with as many
subgoals as there are 'premises' of ``h`` and tries to close the goal by inference.

Let's see how ``apply`` works when used with the theorem ``and_or_and`` which states, for all
propositions ``p`` and ``q`` that ``p ∧ q → q ∧ p``. The goal is to prove ``(b ∧ a) ∧ (a → b)``.
The ``apply`` tactic matches the goal with the conclusion ``p ∧ q → q ∧ p`` and introduces
new goals for ``p`` and ``q``. Lean automatically infers that
``p`` should be replaced with ``b ∧ a`` and that ``q`` should be replaced with ``a → b``, closing
these new goals.

.. code-block:: lean

  variables a b : Prop
  -- BEGIN
  theorem and_of_and (p q : Prop) : p ∧ q → q ∧ p :=
  begin
    intro h,
    exact and.intro (h.right) (h.left)
  end

  example (a b : Prop) : (a → b) ∧ (b ∧ a) → (b ∧ a) ∧ (a → b) :=
  begin
    apply and_of_and, 
  end
  -- END

In more interesting examples, Lean cannot automatically close the new goals introduced by ``apply``.

We begin with a juicy theorem whose proof is a good exercise in the rules of inference for
implication.

.. _thm_imp_trans1:

.. proof:theorem::

  Let :math:`P`, :math:`Q`, and :math:`R` be propositions.
  Then :math:`(P\to Q)\to((Q\to R)\to (P \to R))`.

.. proof:proof::

  Assume :math:`h_1 : P\to Q`. By implication introduction, it suffices to prove
  :math:`(Q\to R)\to (P \to R)`.

  Assume :math:`h_2 : Q \to R`. By implication introduction, it suffices to prove :math:`P \to R`.

  Asssume :math:`h_3 : P`. By implication introduction, it suffices to prove :math:`R`.

  By implication eliminiation on :math:`h_2`, it suffices to prove :math:`Q`.

  We show :math:`Q` by implication elimination on :math:`h_1` and :math:`h_3`.

The proof has a direct translation into Lean.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  theorem imp_trans1 : (p → q) → (q → r) → (p → r) :=
  begin
    assume h₁ : p → q,  -- Assume `h₁ : p → q`. By implication introduction, it suffices to prove `(q → r) → (p → r)`.
    assume h₂ : q → r,  -- Assume `h₂ : q → r`. By implication introduction, it suffices to prove `p → r`.
    assume h₃ : p,      -- Assume `h₃ : p`. It suffices to prove `r`.
    apply h₂,           -- By implication elimination on `h₂`, it suffices to prove `q`.
    show q, from h₁ h₃, -- We show `q` by implication elimination on `h₁` and `h₃`.
  end
  -- END


There are several ways to think about :numref:`Theorem %s <thm_imp_trans1>`. 


First, it can be seen as a statement with propositional parameters :math:`P`, :math:`Q`,
and :math:`R` that can be replaced with arguments, say :math:`S`, :math:`T`, and :math:`U` to
give a proof of

.. math::
  (S \to T) \to ((T\to U)\to (S\to U)).

Second, we can develop this idea via the rules of inference for implication to 'peel off' the antecedent
of the theorem and intepret it as stating that for given propositions :math:`S`, :math:`T`, and
:math:`U` *and* given :math:`h_1 : S \to T`, we have a proof of :math:`(T \to U) \to (S \to U)`.

Third, we can peel off the next implication. The theorem then states that given propostions
:math:`S`, :math:`T`, and :math:`U`, given :math:`h_1 : S \to T` and :math:`h_2 : T\to U`, we have
a proof of :math:`S\to U`. There's even a fourth option that I leave for the reader to
determine.

We use the third interpretation of the theorem in proving the result below.

.. proof:example::

  Let :math:`S`, :math:`T`, and :math:`U` be propositions. Given :math:`k_1 : S \to T \land S` and
  :math:`k_2 : T \to U`, we have a proof of :math:`S \to U`.

.. proof:proof::

  Applying :numref:`Theorem %s <thm_imp_trans1>` (to propositions :math:`S`, :math:`T\land S`, and
  :math:`U`),
  it suffices to prove :math:`S \to T\land S` and :math:`T\land S \to U`.

  #. We show :math:`S\to T\land S` by reiteration on :math:`k_1`.

  #. We show :math:`T\land S\to U` as follows. Assume :math:`k_3 : T\land S`. By implication
     introduction, it suffices to prove :math:`U`.
     We have :math:`k_4 : T` by left conjunction elimination on :math:`k_3`. The result follows by
     implication elimination on :math:`k_2` and :math:`k_4`.

This translates neatly into Lean via the ``apply`` tactic.

.. code-block:: lean

  variables p q r s t u : Prop

  theorem imp_trans1 : (p → q) → (q → r) → (p → r) :=
  λ h₁ h₂ h₃, h₂ (h₁ h₃)
  -- BEGIN
  example (k₁ : s → t ∧ s) (k₂ : t → u) : s → u :=
  begin
    apply imp_trans1,
    { show s → t ∧ s, from k₁, },
    { show t ∧ s → u,    
      assume k₃ : t ∧ s,
      have k₄ : t, from k₃.left,
      show u, from k₂ k₄, },
  end
  -- END

Exercises
---------

Prove the following result, a variant (with no premises) of our previous result
:numref:`Example %s <example_and_assoc1_0>`.

.. proof:theorem:: Associativity of conjunction

  Let :math:`P`, :math:`Q`, and :math:`R` be propositions. Then
  :math:`(P \land Q)\land R \to P\land(Q\land R)`.

Here's a Lean template for the proof.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  theorem and_assoc1 : (p ∧ q) ∧ r → p ∧ (q ∧ r) :=
  begin
    sorry
  end
  -- END


As an exercise in applying theorems, prove the following, subject to the following restrictions.
Your proof must begin with implication introduction. It must end with reiteration.
All other steps must be applications of either the above theorem or our result on the commutativity
of conjunction, :numref:`Theorem %s <example_and_comm1>`

.. proof:theorem::

  Let :math:`S`, :math:`T`, and :math:`U` be propositions. Then
  :math:`S\land(T\land U) \to (S\land T)\land U`.

Here is a Lean template for the proof.

.. code-block:: lean

  variables p q r s t u : Prop
  
  theorem and_assoc1 : (p ∧ q) ∧ r → p ∧ (q ∧ r) :=
  λ h, ⟨h.1.1, h.1.2, h.2⟩

  theorem and_of_and : p ∧ q → q ∧ p :=
  λ h, ⟨h.2, h.1⟩
  -- BEGIN
  theorem and_assoc2 : s ∧ (t ∧ u) → (s ∧ t) ∧ u :=
  begin
    intro h,
    sorry,
  end
  -- END

If and only if
==============

Rewriting and implicit theorems
===============================

An introduction to existential quantification
=============================================

Disjunction
===========

False and negation
==================

Classical reasoning
===================