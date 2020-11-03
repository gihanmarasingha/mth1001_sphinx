.. _sec_prop_logic_tutorial:

*******************
Propositional logic
*******************


Propositions and propositional variables
========================================

From an informal perspective, propositions are statements that can be assigned
a truth value.

From the formal perspective, which is more useful when you want to prove a theorem, propositions are
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
  :math:`\alpha` and :math:`\beta` are propositions.


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

Thus, :math:`((P\land Q)\to(P\lor(Q\land(\neg R))))` can be more simply written as
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
statement of a rule of interfence, the names of propositions that appear are to be treated as 
generic. Thus :math:`P` and :math:`Q` can be replaced with any propositions.

As an example application of this rule of inference, suppose we have a premise
:math:`h : (P\to Q)\land R`. Left conjunction elimination, applied to :math:`h`, produces a 
proof of :math:`P\to Q`.

Rules of inference can be applied in sequence. Suppose we have a premise
:math:`k_1 : (Q \land P) \land R`. Applying left conjunction elimination to :math:`k_1` gives a proof
of :math:`Q\land P`. Let us denote by :math:`k_2` the proof of :math:`Q\land P` that results from
the application of left conjunction elimination to :math:`k_1`. By applying left conjunction
elimination to the hypothesis :math:`k_2`, we have a proof of :math:`Q`.

We use the word *hypothesis* to denote either a premise or a result derived by a rule of inference
during the course of a proof. At any stage in a proof, the entire set of hypotheses developed or
introduced up to that point, together with any variables, is called the *context*. In the above
proof, the context initially consists of the premise :math:`k_1` and the variables :math:`P`,
:math:`Q`, and :math:`R`. After the first application of left conjunction elimination, the context
will also include the hypothesis :math:`k_2`.

Conjunction 
===========

Conjunction elimination
-----------------------

There are two conjunction elimination rules, left and right.

.. proof:mathsrule:: Conjunction elimination

  .. raw:: latex

    \ 

  * (*Left and elimination*) given :math:`h : P \land Q`, we have a proof of :math:`P`.
  * (*Right and elimination*) given :math:`h : P \land Q`, we have a proof of :math:`Q`.

As an example, given that :math:`P` and :math:`Q` are propositions, we can deduce :math:`Q` from
the premise :math:`h : (P \land Q)\land R`. Here is a proof.

  We have :math:`h_2 : P\land Q` by left conjunction elimination on :math:`h`. The result follows
  by right conjunction elimination on :math:`h_2`.

Conjunction elimination in Lean
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
consists of three propositional variables, ``p``, ``q``, and ``r``, together with the premise
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

If a Lean proof can be accomplished with one tactic, one need not use a ``begin`` ... ``end`` block
but can instead write the tactic after ``by``, as below.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : q :=
  by exact (h.left).right
  -- END

This can be written mathematically as follows.

  The result follows by right conjunction elimination applied to the result of left conjunction
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

This can be written mathematically as follows.

  We have :math:`h_2 : p \land q` and :math:`h_3 : r` by left and right conjunction elimination,
  respectively, on :math:`h`. The result follows by right conjunction elimination on :math:`h_2`.

Conjunction introduction
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

  Alternatively, one can use the 'anonymous constructor' notation ``⟨h₃, h₂⟩`` in place of
  ``and.intro h₃ h₂``. Here, ``⟨`` and ``⟩`` are written as ``\<`` and ``\>`` respectively.

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
    split,                -- By and introduction, it suffices to prove both `q` and `p`.
    show q, from h.right, -- We show `q` by right and elimination on `h`.
    show p, from h.left,  -- We show `p` by left and elimination on `h`.
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

The same proof can be represented in Lean. In the last line below (just to show that we can), we
we the anonymous constructor notation to express conjunction introduction.

.. code-block:: lean

  variables p q r : Prop
  -- BEGIN
  example (h : (p ∧ q) ∧ r) : p ∧ (q ∧ r) :=
  begin
    cases h with h₂ h₃,                     -- We have `h₂ : (p ∧ q)`, `h₃ : r` by left & right and elim. on `h`.
    cases h₂ with h₄ h₅,                    -- We have `h₄ : p` and `h₅ : q` by left & right and elim. on `h₂`.
    have h₆ : q ∧ r, from and.intro h₅ h₃,  -- We have `h₆ : q ∧ r` by and introduction on `h₅` and `h₃`.
    show p ∧ (q ∧ r), from ⟨h₄, h₆⟩,         -- We show `p ∧ (q ∧ r)` by and introduction on `h₄` and `h₆`.
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

The *conditional* connective :math:`\to` is read 'implies'.
The proposition :math:`P \to Q` can be read either as ':math:`P` implies :math:`Q`' or as
'if :math:`P`, then :math:`Q`'.

In a proposition of the form :math:`P \to Q`, the proposition :math:`P` is called the *antecedent*
and :math:`Q` is called the *consequent*. The proposition :math:`P\to Q` is called an *implication*
or a *conditional*.

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

The next result requires reiteration.

.. _thm_reflexivity_imp:

.. proof:theorem:: Reflexivity of implication

   Let :math:`P` be a proposition. Then :math:`P \to P`.

.. proof:proof::

  Assume :math:`h : P`. By implication introduction, it suffices to prove :math:`P`. The result
  follows by reiteration on :math:`h`.

.. code-block:: lean

  variables {p : Prop}
  namespace hidden
  -- BEGIN
  theorem id : p → p :=
  begin
    assume h : p,   -- Assume `h : p`. It suffices to prove `p`.
    show p, from h, -- We show `p` by reiteration on `h`.
  end
  -- END
  end hidden

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
notion of 'for all' further in :numref:`Section %s <sec_pred_logic>`.

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
  by exact and_of_and (a → b) (b ∧ a)
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
    intro h,
    exact and.intro (h.right) (h.left)
  end
  -- BEGIN
  example : (a → b) ∧ (b ∧ a) → (b ∧ a) ∧ (a → b) :=
  by exact and_of_and _ _
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
  by exact and_of_and_v2
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
  by apply and_of_and
  -- END

In more interesting examples, Lean cannot automatically close the new goals introduced by ``apply``.

We begin with a juicy theorem whose proof is a good exercise in the rules of inference for
implication.

.. _thm_imp_trans1:

.. proof:theorem:: Transitivity of implication

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

Third, we can peel off the next implication. The theorem then states that given propositions
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

The biconditional connective :math:`\leftrightarrow` is also called 'if and only if' or 'iff'.
The proposition :math:`P \leftrightarrow Q` is read ':math:`P` if and only if :math:`Q`' or
':math:`P` is equivalent to :math:`Q`'.

There are strong parallels between the rules of inference for iff and those for conjunction.

.. proof:mathsrule:: If and only if elimination

  .. raw:: latex

    \ 

  * (*Left iff elimination*) given :math:`h : P \leftrightarrow Q`, we have a proof of :math:`P\to Q`.
  * (*Right iff elimination*) given :math:`h : P \leftrightarrow Q`, we have a proof of :math:`Q\to P`.

In Lean, if ``h : p ↔ q``, then ``h.1`` (alternatively ``iff.elim_left h``) is a proof of ``p → q``.
Likewise, ``h.2`` (alternatively ``iff.elim_right h``) is a proof of ``q → p``.

.. proof:mathsrule:: Iff introduction, forward

  Given :math:`h_1 : P \to Q` and :math:`h_2 : Q\to P`, we have a proof of
  :math:`P\leftrightarrow Q`.

In Lean, given ``h₁ : p → q`` and ``h₂ : q → p``, the term ``iff.intro h₁ h₂`` is
a proof of ``p ↔ q``. The same proof term can be denoted using the anonymous constructor notation
as ``⟨h₁, h₂⟩``. Recall that ``⟨`` and ``⟩`` are written as ``\<`` and ``\>`` respectively.

.. proof:mathsrule:: Iff introduction, backward

  To prove :math:`P\leftrightarrow Q`, it suffices to prove :math:`P\to Q` and :math:`Q\to P`.

We'll use these rules of inference to prove our (almost) final form of commutativity of conjunction.
The proof below uses :numref:`Theorem %s <thm_and_comm2>`, that if :math:`P` and :math:`Q` are
propositions, then :math:`P \land Q\to Q \land P`.

.. _thm_and_comm3:

.. proof:theorem:: Commutativity of conjunction (III)

  Let :math:`R` and :math:`S` be propositions. Then :math:`R \land S \leftrightarrow S \land R`.

.. proof:proof::

  By iff introduction, it suffices to prove 1. :math:`R\land S\to S\land R` and
  2. :math:`S\land R\to R\land S`. We close both goals by :numref:`Theorem %s <thm_and_comm2>`.

In Lean, using one proof to close more than one goal is denoted by the ``;`` tactic combinator, as
used in the proof below.

.. code-block:: lean

  variables p q s r : Prop
  theorem and_of_and : p ∧ q → q ∧ p :=
  begin
    intro h,                   -- Assume `h : p ∧ q`. It suffices to prove `q ∧ p`.
    split,                     -- By `∧` intro., it suffices to prove both `q` and `p`.
    { show q, from h.right, }, -- We show `q` from right `∧` elimination on `h`.
    { show p, from h.left, },  -- We show `p` from left `∧` elimination on `h`.
  end
  namespace hidden
  -- BEGIN
  theorem and_comm : r ∧ s ↔ s ∧ r :=
  begin
    split;
    apply and_of_and,
  end
  -- END
  end hidden

Converse
--------

Given a conditional :math:`P\to Q`, its *converse* is the conditional :math:`Q\to P`. The rules of
inference for iff effectively assert that to prove a biconditional :math:`P \leftrightarrow Q`
is to prove a conditional :math:`P\to Q` and its converse :math:`Q\to P`.


.. _sec_refl_sym_trans_iff:

Reflexivity, symmetry, transitivity of iff
------------------------------------------

Iff has some particularly nice properties.

* Reflexivity. For every proposition :math:`P`, we have :math:`P\leftrightarrow P`.

* Symmetry. For all propositions :math:`P` and :math:`Q`, given :math:`h : P \leftrightarrow Q`,
  we have :math:`Q \leftrightarrow P`.

* Transitivity. For all propositions :math:`P`, :math:`Q`, and :math:`R`, given
  :math:`h_1 : P \leftrightarrow Q` and :math:`h_2 : Q \leftrightarrow R`, we have
  :math:`P \leftrightarrow R`.

.. proof:proof:: Reflexivity

  By iff introduction, it suffices to prove :math:`P\to P` and :math:`P \to P`. Both these goals
  are closed by :numref:`Theorem %s <thm_reflexivity_imp>`, the reflexivity of implication.

.. code-block:: lean

  variables (p : Prop)

  -- BEGIN
  example : p ↔ p :=
  begin
    split,                   -- By iff introduction, it suffices to prove `p → p` and `p → p`
    { show p → p, from id }, -- We show `p → p` from reflexivity of implication.
    { show p → p, from id }, -- We show `p → p` from reflexivity of implication.
  end
  -- END

As in our Lean proof of :numref:`Theorem %s <thm_and_comm3>`, we may employ the  ``;`` tactic
combinator to combine the proofs of the two subgoals that arise from the use of the ``split`` tactic.

.. code-block:: lean

  variables (p : Prop)

  -- BEGIN
  example : p ↔ p :=
  begin
    split;        -- By iff introduction, it suffices to prove `p → p` and `p → p`.
    { exact id }, -- We close both subgoals by reflexivity of implication.
  end
  -- END

The proof of symmetry of iff is almost identical to the proof of
:numref:`Exampe %s <example_and_comm1>`, the commutativity of conjunction.

.. proof:proof:: Symmetry of iff

  By iff introduction, it suffices to prove :math:`Q\to P` and :math:`P \to Q`.
  We show :math:`Q \to P` by right iff elimination on :math:`h`. We show :math:`P\to Q` by left iff
  elimination on :math:`h`.

The Lean proof is virtually identical that that of :numref:`Exampe %s <example_and_comm1>`

.. code-block:: lean
 
  variables (p q : Prop)

  -- BEGIN
  example (h : p ↔ q) : q ↔ p :=
  begin
    split,                    -- By iff introduction, it suffices to prove `q → p` and `p → q`.
    { show q → p, from h.2 }, -- We show `q → p` by right iff elimination on `h`.
    { show p → q, from h.1 }, -- We show `p → q` by left iff elimination on `h`.
  end
  -- END

We now proof transitivity. That is, given :math:`h_1 : P \leftrightarrow Q` and
:math:`h_2 : Q \leftrightarrow R`, we have a proof of :math:`P \leftrightarrow R`.

.. proof:proof:: Transitivity of iff

  By iff introduction, it suffices to prove 1. :math:`P\to R` and 2. :math:`R\to P`.

  1. We show :math:`P\to R`. Applying the transtivity of implication
     (:numref:`Theorem %s <thm_imp_trans1>`), it suffices to prove a. :math:`P\to A` and
     b. :math:`A\to R` (for some proposition :math:`A`).

     a. We show :math:`P\to Q` by left iff eliminiation on :math:`h_1`.

     b. We show :math:`Q\to R` by left iff elimination on :math:`h_2`.

  2. The proof of :math:`R\to P` is similar and is left to the reader.


.. code-block:: lean

  variables p q r : Prop

  theorem imp_trans1 : (p → q) → (q → r) → (p → r) :=
  λ h₁ h₂ h₃, h₂ (h₁ h₃)
  -- BEGIN
  example (h₁ : p ↔ q) (h₂ : q ↔ r) : p ↔ r :=
  begin
    split,                            -- By iff intro., it suffices to prove `p → r` and `r → p`.
    { show p → r, apply imp_trans1,   -- We show `p → r`. By transitivity of `→`, it suffices to prove `p → ?` and `? → r`. 
      { show p → q, from h₁.1, },     -- We show `p → q` by left iff elimination on `h₁`.
      { show q → r, from h₂.1, }, },  -- We show `q → r` by left iff elimination on `h₂`.
   { show r → p, sorry  },            -- The proof of `r → p` is left to the reader.
  end
  -- END

.. _sec_rewriting:

Rewriting
=========

Whenever two propositions :math:`P` and :math:`Q` are judged to be equal, the proposition :math:`P`
can be replaced with :math:`P`, wherever :math:`P` appears. This process is called *rewriting*.
Technically, equality is a notion of predicate logic rather than propositional logic.

Rewriting a goal
----------------

We'll use rewriting in proving the following result.

.. proof:example::

  Let :math:`x, y, z` be natural numbers. Then :math:`x * (y + z) = x * z + y * x`.

Our proof will call on the following intermediate results (which will be proved in due course).

.. proof:theorem:: (Left) distributivity of multiplication over addition

  Let :math:`a, b, c` be natural numbers. Then :math:`a * (b + c) = a * b + a * c`.

.. proof:theorem:: Commutativity of addition

  Let :math:`a` and :math:`b` be natural numbers. Then :math:`a + b = b + a`.

.. proof:theorem:: Commutativity of multiplication

  Let :math:`a` and :math:`b` be natural numbers. Then :math:`a * b = b * a`.

Returning to the example, we have to prove :math:`x * (y + z) = x * z + y * x`. As a first
step, we can rewrite this using the left distributivity of multiplication over addition (or, more
simply, distributivity) applied to :math:`x`, :math:`y` and :math:`z`. By application, I mean that the
variables :math:`x`, :math:`y` and :math:`z` take the roles of :math:`a`, :math:`b` and :math:`c`,
respectively in the distributive law.

The distributive law with these varaibles subsituted reads :math:`x * (y + z) = x * y + x * z`.
We rewrite the goal using the proposition. The left side of the goal is replaced with the right side
of the preceding equation, changing the goal to one of proving :math:`x * y + x * z = x * z + y * x`.

.. proof:proof::

  Rewriting using distributivity applied to :math:`x`, :math:`y`, and :math:`z`, the goal is to prove
  :math:`x * y + x * z = x * z + y * x`.

  Rewriting using commutativity of addition applied to :math:`x * y` and :math:`x * z`, the goal is
  to prove :math:`x * z + x * y = x * z + y * x`.

  Rewriting using commutativity of multiplication applied to  :math:`x` and :math:`y`, the goal is 
  to prove :math:`x * z + y * x = x * z + y * x`.

  This is trivially true (formally, it's true by reflexivity of :math:`=`).

With two of the above rewrites, it isn't stricly necessary to identify the variables being used.
For example, in the initial goal, the distributivity law could only possibly apply to the variables
:math:`x`, :math:`y`, and :math:`z` as there is no expression of the form :math:`a * (b + c)` in
the goal except for :math:`x * (y + z)`.

In Lean, we use the ``rw`` tactic to denote rewriting. Given ``h : P = Q``, the tactic ``rw h``
will replace the first occurrence (reading left-to-right) of ``P`` with ``Q``. If the
expression ``h`` depends on variables or other hypotheses, then Lean will look for the first
expression in the goal that matches the shape of ``h`` and instantiate variables as necessary.

In the code below, ``mul_add`` is the theorem that for all natural numbers ``a``, ``b``, and ``c``,
we have ``a * (b + c) = a * b + a * c``. Lean matches the left side of this equation with
``x * (y + z)`` after instantiating ``a`` as ``x``, ``b`` as ``y`` and ``c`` as ``z``.

Having performed that rewrite, the goal becomes ``x * y + x * z = x * z + y * x``.

The ``add_comm`` states that for all natural numbers ``a`` and ``b``, we have ``a + b = b + a``.
There are *two* subexpressions in the goal ``x * y + x * z = x * z + y * x`` that match with
``add_comm``, namely ``x * y + x * z`` and  ``x * z + y * x``. However, Lean performs the rewrite on
the first subexpression that matches. In this case, it's ``x * y + x * z``.

Having performed ``rw add_comm``, the goal becomes ``x * z + x * y = x * z + y * x``.

We need to be precise is our last rewrite. This rewrite involves the theorem ``mul_comm`` which
states that for all natural numbers ``a`` and ``b``, we have ``a * b = b * a``. The first
subexpression of the goal to which this theorem applies is ``x * z``. That is, the result of
performing ``rw mul_comm`` would be identical to the result of performing ``rw x z``, namely to
change the goal to ``z * x + x * y = x * z + y * x``. 


However, rewriting ``x * z`` as ``z * x``
doesn't resolve the goal! Instead, we need to rewrite applying ``mul_comm`` to ``x`` and ``y``.

This leaves, as a goal, ``x * z + y * x = x * z + y * x``. Lean automatically closes this goal
by the reflexivity of ``=`` (viz. the fact that ``a = a``, for every ``a``).


.. code-block:: lean

  import data.nat.basic
  
  variables x y z : ℕ
  -- BEGIN
  example : x * (y + z) = x * z + y * x :=
  begin
    rw mul_add,
    rw add_comm,
    rw mul_comm x y,
  end
  -- END

Several rewrites can be combined by enclosing them in brackets, as below.

.. code-block:: lean

  import data.nat.basic
  
  variables x y z : ℕ
  -- BEGIN
  example : x * (y + z) = x * z + y * x :=
  by rw [mul_add, add_comm, mul_comm x y]
  -- END

Rewriting a hypothesis
----------------------

Given a hypothesis :math:`h : P = Q`, we can rewrite any other hypothesis :math:`k` by replacing
occurrences of :math:`P` in :math:`k` with :math:`Q`.

.. proof:example::

  Let :math:`x, y, z` be natural numbers. Given :math:`k : y * x = z`, we have 
  :math:`x * (y + z) = z + x * z`.

.. proof:proof::

  Rewrite using commutativity of multiplication at :math:`k` to give :math:`k : x * y = z`.

  Rewrite using distributivity. The goal is :math:`x * y + x * z = z + x * z`.

  Rewrite using :math:`k`. The goal is :math:`z + x * z = z + x * z`, which is trivially true.

The Lean version of 'rewrite using :math:`h` at :math:`k`' is ``rw h at k`` as shown below.

.. code-block:: lean

  import data.nat.basic
  
  variables x y z : ℕ
  -- BEGIN
  example (k : y * x = z) : x * (y + z) = z + x * z :=
  begin
    rw mul_comm at k,
    rw mul_add,
    rw k,
  end
  -- END

Rewriting in reverse
--------------------

Given a hypothesis :math:`h : P = Q`, we've seen that we  can rewrite the goal (or another hypothesis)
by replacing occurrences of :math:`P` with :math:`Q`. However, by symmetry of :math:`=`, we can
express :math:`h` as :math:`h : Q = P` and then go on to replace occurrences of :math:`Q` in the
goal (or another hypothesis) by :math:`P`.

We may refer to this process as 'rewriting using :math:`h` in reverse'.

Recall that the distributive law states :math:`a * (b + c) = a * b + a * c`.
We can use this (in reverse) to rewrite the expression :math:`x * y + x * z = (z + y) * x` as
:math:`x * (y + z) = (z + y) * x`. This is the first step in the proof of the following result.

.. proof:example::

  Let :math:`x`, :math:`y` and :math:`z` be natural numbers. Then
  :math:`x * y + x * z = (z + y) * x`.

.. proof:proof::

  Rewriting using the distributive law (in reverse), the goal is :math:`x * (y + z) = (z + y) * x`.

  Rewriting using the commutativity of multiplication, the goal is :math:`(y + z) * x = (z + y) * x`.

  Rewriting using the commutativity of addition, the goal is :math:`(z + y) * x = (z + y) * x`. 
  This is trivially true.

In Lean, we denote rewriting using ``h`` in reverse as ``rw ←mul_add``, as in the example below.

.. code-block:: lean

  import data.nat.basic
  
  variables x y z : ℕ
  -- BEGIN
  example : x * y + x * z = (z + y) * x :=
  begin
    rw ←mul_add,
    rw add_comm,
    rw mul_comm,
  end
  -- END

Propositional extensionality and rewriting
==========================================

In advanced courses on mathematical logic (for the avoidance of doubt, this is not an advanced course),
one typically proves theorems *about* systems of logic. One such theorem is that given propositions
:math:`P` and :math:`Q` and given :math:`h : P \leftrightarrow Q`, if the proposition :math:`Q` is
substituted for :math:`P` wherever :math:`P` appears in a theorem then result will still be a
theorem. 

We will not prove this theorem of meta propositional logic but we pause to note that the reflexivity,
symmetry, and transitivity properties of :math:`\leftrightarrow`, when taken together, suggest
very strongly that propositions :math:`P` and :math:`Q` should be treated as equal if
:math:`P\leftrightarrow Q`.

To simplify matters, we will take treat this theorem as a rule, the principle of propositional
extensionality.

.. proof:mathsrule:: Propositional extensionality

  Let :math:`P` and :math:`Q` be propositions. Given :math:`h : P \leftrightarrow Q`, we have
  :math:`P = Q`.

Rewriting a goal 
----------------

Given :math:`h : P \leftrightarrow Q`, we can denote the use of propositional extensionality on the
by writing, 'Rewriting using :math:`h`, the goal is ...', as in :numref:`Section %s <sec_rewriting>`.
We use this form of expression in the examples below.

In our first example, we use propositional extensionality to give a quick proof of transitivity of
implication. Given :math:`h_1 : P \leftrightarrow Q` and :math:`h_2 : Q \leftrightarrow R` we have
a proof of :math:`P \leftrightarrow R`.

.. proof:proof::

  Rewriting using :math:`h_1`, the goal is to prove prove :math:`Q \leftrightarrow R`.
  This holds by reiteration on :math:`h_2`.

Compare this to the rather more involved proof given in :numref:`Section %s <sec_refl_sym_trans_iff>`.

In Lean, we use the ``rw`` tactic to rewrite the goal.

.. code-block:: lean

  variables p q r : Prop

  -- BEGIN
  example (h₁ : p ↔ q) (h₂ : q ↔ r) : p ↔ r :=
  begin
    rw h₁,    -- Rewriting using `h₁`, the goal is to prove `q ↔ r`.
    exact h₂, -- This holds by reiteration on `h₂`.
  end
  -- END

In the next example, we rewrite using De Morgan's law [#]_ :math:`\neg(P \lor Q) \leftrightarrow
\neg P \land \neg Q` and our commtativity of conjunction result,
:numref:`Theorem %s <thm_and_comm3>`.

.. proof:example::

  Let :math:`P` and :math:`Q` be propositions. Then :math:`\neg(P \lor Q) \leftrightarrow 
  \neg Q \land \neg P`.

.. proof:proof::

  Rewriting using De Morgan's law, the goal is to prove
  :math:`\neg P \land \neg Q \leftrightarrow \neg Q \land\neg P`. This holds by applying
  commutativity of conjunction.

In the Lean proof below, ``not_or_distrib`` is the name of the relvant De Morgan's law.

.. code-block:: lean

  import logic.basic

  variables p q : Prop

  -- BEGIN
  example : ¬(p ∨ q) ↔ ¬q ∧ ¬p :=
  begin
    rw not_or_distrib, -- Rewrite using De Morgan's law. The goal is `¬p ∧ ¬q ↔ ¬q ∧ ¬p`.
    apply and_comm,    -- This holds by applying commutativity of conjunction.
  end
  -- END

.. [#] We'll prove this later as :numref:`Theorem %s <thm_not_or_distrib>`. Another of De Morgan's
       laws is :numref:`Theorem %s <thm_not_and_distrib>`, which asserts
       :math:`\neg(P\land Q) \leftrightarrow\neg P\lor\neg Q`.

Rewriting a hypothesis
----------------------

We can use rewriting (i.e. propositional extensionality) on hypotheses just as we can on goals.

.. _example_rumtumtugger:

.. proof:example::

  Let :math:`P` and :math:`Q` be propositions. Given :math:`k : \neg(P \lor Q)`, we have a proof of
  :math:`\neg Q \land \neg P`.

.. proof:proof::

  Rewriting using De Morgan's law at :math:`k`, we have :math:`k : \neg P \land \neg Q`.
  Rewriting using commutativity of conjunction, the goal is :math:`\neg P \land \neg Q`.
  The result follows by reiteration on :math:`k`.

.. code-block:: lean

  import logic.basic

  variables p q : Prop

  -- BEGIN
  example (k : ¬(p ∨ q)) : ¬q ∧ ¬p :=
  begin
    rw not_or_distrib at k, -- Rewriting using De Morgan's law at `k`, we have `k : ¬p ∧ ¬q`.
    rw and_comm,            -- Rewriting using commutativity of conjunction, the goal is `¬p ∧ ¬q`.
    exact k,                -- This holds by reiteration on `k`.
  end
  -- END

Rewriting in reverse
--------------------

Given :math:`h : P \leftrightarrow Q` to rewrite using :math:`h` in reverse is to replace occurrences
of :math:`Q` in the goal (or in another hypothesis) with :math:`P`.

By rewriting in reverse, we give an alternative proof of :numref:`Example %s <example_rumtumtugger>`.
For this, we need the commutative law of disjunction (to be proved later). Namely, given propositions
:math:`S` and :math:`T`, we have :math:`S \lor T \leftrightarrow T \lor S`.

We are now in a position to prove :numref:`Example %s <example_rumtumtugger>`.

.. proof:proof::

  Rewriting using De Morgan's law in reverse, the goal is :math:`\neg(Q \lor P)`.

  Rewriting using commutativity of disjunction, the goal is :math:`\neg(P \lor Q)`.

  We close the goal by reiteration on :math:`k`.

As in :numref:`Section %s <sec_rewriting>`, we denote rewriting using ``h`` in reverse as
``rw ←mul_add``, as in the example below.


.. code-block:: lean

  import logic.basic

  variables p q : Prop

  -- BEGIN
  example (h : ¬(p ∨ q)) : ¬q ∧ ¬p :=
  begin
    rw ←not_or_distrib, 
    rw or_comm,        
    exact h,          
  end
  -- END

Disjunction
===========

Disjunction introduction
------------------------

There are two disjunction introduction rules, left and right. Each comes in both a forward and a
backward flavour.

.. proof:mathsrule:: Disjunction introduction, forward

  .. raw:: latex

    \ 

  * (*Left or introduction*) given :math:`h : P`, we have a proof of :math:`P \lor Q`.
  * (*Right or introduction*) given :math:`h : Q`, we have a proof of :math:`P \lor Q`.

.. _example_s_or_t_or_u_intro:

.. proof:example::

  Let :math:`S`, :math:`T`, and :math:`U` be propositions. Given :math:`h : T`, we have
  :math:`S \lor (T \lor U)`.

.. proof:proof:: Forward

  We have :math:`h_2 : T \lor U` by left or introduction on :math:`h`. The result follows by right
  or introduction on :math:`h_2`.

In Lean, given ``h : p``, the expression ``or.inl h`` is a proof term for ``p ∨ q``. Given, ``h : q``,
the expression ``or.inr h`` is a proof term for ``p ∨ q``.

.. code-block:: lean

  variables s t u : Prop

  -- BEGIN
  example (h : t) : s ∨ (t ∨ u) :=
  begin
    have h₂ : t ∨ u, from or.inl h,
    exact or.inr h₂,
  end
  -- END

.. proof:mathsrule:: Disjunction introduction, backward

  .. raw:: latex

    \ 

  * (*Left or introduction*) to prove :math:`P \lor Q`, it suffices to prove :math:`P`.
  * (*Right or introduction*) to prove :math:`P \lor Q`, it suffices to prove :math:`Q`.

We give a backward proof of :numref:`Example %s <example_s_or_t_or_u_intro>`.

.. proof:proof:: Backward

  We show :math:`S \lor (T \lor U)`. By backward right or introduction, it suffices to prove
  :math:`T\lor U`. By backward left introduction, it suffices to prove :math:`T`.
  We show :math:`T` by reiteration on :math:`h`.

The Lean tactic for backward left or introduction is ``left``. That for backward right or
introduction is ``right``.

.. code-block:: lean

  variables s t u : Prop

  -- BEGIN
  example (h : t) : s ∨ (t ∨ u) :=
  begin
    right,           -- By right or introduction, it suffices to prove `t ∨ u`.
    left,            -- By left or introduction, it suffice to prove `t`.
    show t, from h,  -- We show `t` by reiteration on `h`.
  end
  -- END

Disjunction elimination
-----------------------

This is the most challenging rule so far. We start with an example.

Suppose we know of Peggy that she keeps rabbits or she grows strawberries.
Further, we have 1. if Peggy keeps rabbits, then she needs straw as bedding material for the rabbits.
We also have 2. if Peggy grows strawberries, then she needs straw to keep the strawberries off the
ground and help keep them clean. We deduce that Peggy needs straw.

The deduction here is an application of disjunction elimination.

.. proof:mathsrule:: Disjunction elimination, backward

  Let :math:`P`, :math:`Q`, and :math:`R` be propositions. Given :math:`h : P \lor Q`, to prove
  :math:`R`, it suffices 1. to show :math:`R` on the assumption :math:`h_1 : P` and 2. to show
  :math:`R` on the assumption :math:`h_2 : Q`.

Here is an archetypal example of backward disjunction elimination.

.. proof:example::

  Let :math:`P`, :math:`Q`, and :math:`R` be propositions. Given :math:`h : P \lor Q`,
  :math:`k_1 : P \to R`, and :math:`k_2 : Q\to R`, we have a proof of :math:`R`.

.. proof:proof::

  By or elimination on :math:`h`, it suffices 1. to show :math:`R` on the assumption :math:`h_1 : P`
  and 2. to show :math:`R` on the assumption :math:`h_2 : Q`.
  
  1. We show :math:`R` by implication elimination on :math:`k_1` and :math:`h_1`.

  2. We show :math:`R` by implication elimination on :math:`k_2` and :math:`h_2`.


The Lean tactic used for decomposing a conjunction is ``cases``. Suppose the current goal is ``r``.
Given ``h : p ∨ q``, the expression ``cases h with h₁ h₂`` causes Lean to create two new goals.
1. to prove ``r`` with ``h₁ : p`` added to the context and 2. to prove ``r`` with ``h₂ : q`` added
to the context. 

.. code-block:: lean

  variables p q r : Prop

  -- BEGIN
  example (h : p ∨ q) (k₁ : p → r) (k₂ : q → r) : r :=
  begin
  -- By or elim. on `h`, it suffices
    -- 1. to show `r` on the assumption `h₁ : p` and 
    -- 2. to show `r` on the assumption `h₂ : q`.
    cases h with h₁ h₂, 
    { show r, from k₁ h₁, }, -- We show `r` by implication elimination on `k₁` and `h₁`.
    { show r, from k₂ h₂, }, -- We show `r` by implication elimination on `k₂` and `h₂`.
  end
  -- END

The forward disjunction elimination rule is a restatement of the result just proved.

.. proof:mathsrule:: Disjunction elimination, forward

  Let :math:`P`, :math:`Q`, and :math:`R` be propositions. Given :math:`h : P \lor Q`, 
  :math:`k_1 : P \to R` and :math:`k_2 : Q \to R`, we have a proof of :math:`R`.

The parallel between the forward and backward versions of disjunction elimination are evident when
one realises that to prove :math:`k_1 : P \to R`, for example, is to assume :math:`h_1 : P` and to
deduce :math:`R`.


In Lean, given ``h : p ∨ q``, ``k₁ : p → r``, and ``k₂ : q → r``, the expression ``or.elim h k₁ k₂``
is a proof term for ``r``. This considerably shortens the proof of the previous result.

.. code-block:: lean

  variables p q r : Prop

  -- BEGIN
  example (h : p ∨ q) (k₁ : p → r) (k₂ : q → r) : r :=
  by exact or.elim h k₁ k₂
  -- END

Commutativity and associativity of disjunction
----------------------------------------------

As a more interesting example, we have a preliminary result on the commutativity of disjunction.

.. _thm_or_comm1:

.. proof:theorem:: Commutativity of disjunction (I)

  Let :math:`S` and :math:`T` be propositions. Given :math:`h : S \lor T`, we have :math:`T \lor S`.

We give a proof via backward or elimination and forward or introduction.

.. proof:proof::

  By or elimination on :math:`h`, it suffices 1. to assume :math:`h_1 : S` and deduce
  :math:`T \lor S` and 2. to assume :math:`h_2 : T` and deduce :math:`T \lor S`.

  1. Assume :math:`h_1 : S`. We show :math:`T\lor S` by right or introduction on :math:`h_1`.

  2. Assume :math:`h_2 : T`. We show :math:`T\lor S` by left or introduction on :math:`h_2`.


.. code-block:: lean

  variables s t : Prop

  -- BEGIN
  theorem or_of_or (h : s ∨ t) : t ∨ s :=
  begin
    cases h with h₁ h₂, 
    { exact or.inr h₁,}, 
    { exact or.inl h₂, },
  end
  -- END

Using the above result, we can prove a more symmetrical version of the commutativity result.

.. proof:theorem:: Commutativity of disjunction (II)

  Let :math:`P` and :math:`Q` be propositions. Then :math:`P \lor Q \leftrightarrow Q\lor P`.

.. proof:proof::

  By iff introduction, it suffices to prove 1. :math:`P\lor Q\to Q\lor P` and 2.
  :math:`Q\lor P\to P\lor Q`. Both these goals can be closed by applying
  :numref:`Theorem %s <thm_or_comm1>`.

.. code-block:: lean

  variables p q s t : Prop

  theorem or_of_or (h : s ∨ t) : t ∨ s :=
  begin
    cases h with h₁ h₂, 
    { exact or.inr h₁,}, 
    { show t ∨ s, from or.inl h₂, },
  end
  namespace hidden
  -- BEGIN
  theorem or_comm : p ∨ q ↔ q ∨ p :=
  begin
    split;
    apply or_of_or
  end
  -- END
  end hidden

The associativity result is more involved. We give a partial Lean proof of the result. Fill in
the ``sorry`` s below to complete the proof.

.. code-block:: lean

  variables {p q r : Prop}
  namespace hidden
  -- BEGIN
  theorem or_assoc : (p ∨ q) ∨ r ↔ p ∨ (q ∨ r) :=
  begin
    split,
    { intro h,
      cases h with h₁ h₂,
      { cases h₁ with m₁ m₂,
        { left, exact m₁, },
        { right, left, exact m₂, }, },
      { sorry, }, },
    { sorry, },
  end
  -- END
  end hidden

False and negation
==================

Rules for false and negation
----------------------------

The symbol :math:`\bot`, read 'arbitrary contradiction' or 'false' is a constant proposition.
Its use is governed most fundamentally by the principle *ex falso sequitur quodlibet*, 'out of false,
whatever you like follows', also called false elimination.

This principle is illustrated by such English-language phrases as, 'If Torquay United wins the FA Cup,
then I'm a monkey's uncle'. The premise 'Torquay United wins the FA Cup' being considered a
contradiction, I can derive anything from its assumption.

.. proof:mathsrule:: False elimination (*ex falso*), forward

  Given :math:`h : \bot`, we have a proof of :math:`P`.

.. proof:mathsrule:: False elimination (*ex falso*), backward

  To prove :math:`P`, it suffices to prove :math:`\bot`.

.. _ex_neg_elim:

.. proof:example::

  Let :math:`P` and :math:`Q` be propositions. We have :math:`(P \to \bot) \to (P \to Q)`.

.. proof:proof::

  * Assume :math:`h_1 : P \to bot`. It suffices to prove :math:`P \to Q` (by implication intro.).

  * Assume :math:`h_2 : P`. It suffice to prove :math:`Q` (by implication intro.).

  * By false elimination, it suffices to prove :math:`\bot`.

  * We show :math:`\bot` by implication elimination on :math:`h_1` and :math:`h_2`.

``false`` is the Lean equivalent of :math:`\bot`. If ``h`` is a proof term for ``false``, then
``false.elim h`` is a proof term for ``p`` (where ``p`` is the current goal).

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  example : (p → false) → (p → q) :=
  begin
    assume h₁ : p → false,
    assume h₂ : p,
    show q, from false.elim (h₁ h₂)
  end
  -- END

Alternativly, the tactic ``exfalso`` can be used to change the current goal to one of proving
``false``.

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  example : (p → false) → (p → q) :=
  begin
    assume h₁ : p → false,
    assume h₂ : p,
    exfalso,
    show false, from h₁ h₂
  end
  -- END

We write :math:`\neg P` as a shorthand for :math:`P \to \bot`. The expression :math:`\neg P` is read
'the negation of :math:`P`' or 'not :math:`P`'. With this notation, we can re-express the above
example. 

.. proof:theorem::

  Let :math:`P` and :math:`Q` be propositions. Given :math:`h_1 : \neg P` and :math:`h_2 : P`, we
  have a proof of :math:`Q`.

This follows on applying :numref:`Example %s <ex_neg_elim>` with :math:`h_1` and :math:`h_2`.

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  example (h₁ : ¬p) (h₂ : p) : q :=
  begin
    exfalso,
    show false, from h₁ h₂
  end
  -- END

Alternatively, the powerful ``contradiction`` tactic searches the context for a contradition (viz.
the appearance of a proposition and its neagation in the context) and uses it to close the goal.

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  example (h₁ : ¬p) (h₂ : p) : q :=
  begin
    contradiction
  end
  -- END

In the special case where :math:`Q` is :math:`\bot`, this result is called *false introduction* and
is often treated as a rule of inference, though it is really just implication elimination in
disguise.

.. proof:theorem:: False introduction, forward

  Given :math:`h_1 : \neg P` and :math:`h_2 : P`, we have a proof of :math:`\bot`.

.. proof:theorem:: False introduction, backward

  Given :math:`h_1 : \neg P`, to prove :math:`\bot`, it suffices to prove :math:`P`.

Another derived result is negation introduction, which is implication introduction in
disguise.

.. proof:theorem:: Negation introduction

  Let :math:`P` be a proposition. To prove :math:`\neg P` is to assume :math:`\bot` and derive
  :math:`P`.

Applications of false and negation
----------------------------------

.. proof:example::

  Let :math:`P` and :math:`Q` be propositions. Given :math:`h : \neg(P\lor Q)`, we have :math:`\neg P`.

Here's a proof using negation introduction and backward false introduction.

.. proof:proof::

  Assume :math:`h_1 : P`. By negation introduction, it suffices to derive :math:`\bot`.
  By false introduction on :math:`h`, it suffices to prove :math:`p \lor q`. This follows by left
  or introduction on :math:`h_1`.

In the Lean proof below, we use ``apply`` to prove invoke (backward) false introduction, just as we
would when invoking implication elimination. This is because false introduction *is* implication
elimination.

Likewise, we use ``assume`` for negation introduction, just as we do for implication introduction.

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  example (h : ¬(p ∨ q)) : ¬p :=
  begin
    assume h₁ : p,   -- It suffices to prove `false`.
    apply h,         -- By false introduction on `h`, it suffices to prove `p ∨ q`.
    exact or.inl h₁, -- This follows by left or introduction on `h₁`.
  end
  -- END

The next example shows one can derive the implication :math:`P\to Q` given the hypothesis
:math:`\neg P \lor Q`. We'll later show the converse of this assertion.

.. proof:example:: One direction of material conditional

  Let :math:`P` and :math:`Q` be propositions. Then :math:`\neg P \lor Q \to (P\to Q)`.

.. proof:proof::

  Assume :math:`h_1 : \neg P\lor Q`. Assume :math:`h_2 : P`. It suffices to prove :math:`Q`.
  By or elimination on :math:`h_1`, it suffices to 1. assume :math:`h_3 : \neg P` and derive
  :math:`Q` and 2. assume :math:`h_4 : Q` and derive :math:`Q`.

  1. Assume :math:`h_3 : \neg P`. By false elimination, it suffices to prove :math:`\bot`. We show this by
     false introduction on :math:`h_3` and :math:`h_2`.

  2. Assume :math:`h_4 : Q`. We show :math:`Q` by reiteration on :math:`h_4`.

In the Lean proof below we write ``h₃ h₂`` for a forward false introduction using ``h₃`` and ``h₂``.
This is because we are really doing implication elimination on ``h₃`` and ``h₂``.

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  example : (¬p ∨ q) → (p → q) :=
  begin
    intros h₁ h₂,                  -- Assume `h₁ : ¬p ∨ q`. Assume `h₂ : p`. It suffices to prove `q`.
    -- By or elim. on `h₁`, it suffices to 1. assume `h₃ : ¬p` and derive `q` and 2. assume `h₄ : q` and derive `q`
    cases h₁ with h₃ h₄,        
    { exfalso,                    -- By false elimination, it suffices to prove `false`.
      show false, from h₃ h₂, },  -- We show false by false introduction on `h₃` and `h₂`.
    { show q, from h₄, },         -- We show `q` by reiteration on `h₄`.
  end
  -- END

The next result is one half of a result that shows :math:`P` is equivalent to :math:`\neg\neg P`.
We prove the other half of this result in :numref:`Section %s <sec_classical_reasoning>`.

.. _thm_not_not_of_self:

.. proof:theorem:: One direction of double negation

  Let :math:`P` be a proposition. We have :math:`P\to\neg\neg P`.

.. proof:proof::

  * Assume :math:`h_1 : P`. It suffices to prove :math:`\neg\neg P`.

  * Assume :math:`h_2 : \neg P`. By negation introduction, it suffices to prove :math:`\bot`.

  * We show :math:`\bot` by false introduction on :math:`h_2` and :math:`h_1`.

.. code-block:: lean

  variable p : Prop
  -- BEGIN
  theorem not_not_of_self : p → ¬¬p :=
  begin
    intros h₁ h₂,           -- Assume `h₁ : p`. Assume `h₂ : ¬p`. It suffices to prove `false`.
    show false, from h₂ h₁, -- We show `false` by false introduction on `h₂` and `h₁`.
  end
  -- END

The contrapositive of a conditional :math:`P\to Q` is the proposition :math:`\neg Q\to\neg P`.
In :numref:`Section %s <sec_classical_reasoning>`, we'll prove that a proposition is equivalent to
its contrapositive. We'll prove one half of that assertion now.

.. _thm_mt:

.. proof:theorem:: One direction of contrapositive theorem, *modus tollens*

  Let :math:`P` and :math:`Q` be propositions. Then :math:`(P\to Q)\to(\neg Q\to\neg P)`.

We give the Lean proof below with the corresponding mathematical proof in the comments.
Note I could have replaced the first two lines with a single line, ``intros h₁ h₂ h₃``.   

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  theorem mt : (p → q) → (¬q → ¬p) :=
  begin
    intros h₁ h₂, -- Assume `h₁ : p → q`, `h₂ : ¬q`. It suffices to prove `¬p`.
    intro h₃,     -- Assume `h₃ : p`. By negation introiduction, it suffices to prove `false`.
    apply h₂,     -- By fale introduction on `h₂`, it suffices to prove `q`.
    exact h₁ h₃,  -- This follows by implication elimination on `h₁` and `h₃`.
  end
  -- END

De Morgan's laws state 1. :math:`\neg(P \land Q)\leftrightarrow\neg P\lor \neg Q` and 2.
:math:`\neg(P\lor Q)\leftrightarrow\neg P \land \neg Q`.

In total, there are four directions to prove. We give proofs of three directions in this section
and the remaining direction in :numref:`Section %s <sec_classical_reasoning>`. 

.. _thm_not_or_of_not_and_not:

.. proof:theorem:: De Morgan, 'not or of not and not'

  Let :math:`P` and :math:`Q` be propositions. Then :math:`\neg P \land\neg Q\to\neg(P\lor Q)`.

Our first proof uses each rule of inference explicitly.

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  theorem not_or_of_not_and_not : ¬p ∧ ¬q →  ¬(p ∨ q) :=
  begin
    assume h₁ : ¬p ∧ ¬q, -- Assume `h₁ : ¬p ∧ ¬q`. By implication introduction, it suffices to prove `¬(p ∨ q)`.
    cases h₁ with h₃ h₄, -- We have `h₃ : ¬p` and `h₄ : ¬q` by left and right `∧` elim. on `h₁`.
    assume h₅ : p ∨ q,   -- Assume `h₅ : p ∨ q`. By negation introduction, it suffices to prove `false`.
    -- By or elimination on `h₅`, it suffices to 1. assume `h₆ : p` and derive `false` and 2. assume `h₇ : q` and derive `false`.
    cases h₅ with h₆ h₇,
    { exact h₃ h₆, },    -- The goal in the first case is closed by false introduction on `h₃` and `h₆`.
    { exact h₄ h₇, },    -- The goal in the second case is closed by false introduction on `h₄` and `h₇`.

  end 
  -- END

The second proof greatly simplifies this by using the ``rintro`` tactic, which introduces an
assumption and decomposes it recursively. That is, it applies ``cases`` recursively to each
introduced hypothesis.

Note the differences in how we use ``rintro``. In our first application, we use ``rintro ⟨h₃, h₄⟩``
to introduce and decompose a hypothesis representing the conjunction ``¬p ∧ ¬q``.
The anonymous-constructor-like notation ``⟨h₃, h₄⟩`` appears here because the conjunction connective
has one constructor, ``and.intro``. The decomposition introduces ``h₃ : ¬p`` and ``h₄ : ¬q`` into
the context.

We next use ``rintro (h₆ | h₇)`` to introduce and decompose a hypothesis representing the
disjuction ``p ∨ q``. As disjunction has two constructors, ``or.inl`` and ``or.inr``, the
decomposition introduces *two* new goals. This corresponds to or elimination.

.. code-block:: lean

  import tactic.rcases
  variables {p q : Prop}
  -- BEGIN
  theorem not_or_of_not_and_not : ¬p ∧ ¬q →  ¬(p ∨ q) :=
  begin
    rintro ⟨h₃, h₄⟩,   -- By `→` intro and left and right `∧` elim, we have `h₃ : ¬p` and `h₄ : ¬q`.
    -- By `→` intro and or elim., it suffices to 1. assume `h₆ : p` and derive `false` and 2. assume `h₇ : q` and derive `false`.
    rintro (h₆ | h₇),
    { exact h₃ h₆, }, -- The goal in the first case is closed by false introduction on `h₃` and `h₆`.
    { exact h₄ h₇, }, -- The goal in the second case is closed by false introduction on `h₄` and `h₇`.
  end 
  -- END

Several successive ``rintro`` lines can be combined, albeit with some loss of readability.

.. code-block:: lean

  import tactic.rcases
  variables {p q : Prop}
  -- BEGIN
  theorem not_or_of_not_and_not : ¬p ∧ ¬q →  ¬(p ∨ q) :=
  begin
    rintro ⟨h₃, h₄⟩ (h₆ | h₇),
    { exact h₃ h₆, }, -- The goal in the first case is closed by false introduction on `h₃` and `h₆`.
    { exact h₄ h₇, }, -- The goal in the second case is closed by false introduction on `h₄` and `h₇`.
  end 
  -- END

.. _thm_not_and_not_of_not_or:

.. proof:theorem:: De Morgan, 'not and not of not or'

  Let :math:`P` and :math:`Q` be propositions. Then :math:`\neg(P\lor Q)\to\neg P\land\neg Q`.

Here is a partial Lean proof. Fill in the ``sorry`` s. Hint: you've already seen the proof of the
first subgoal earlier in this section.

.. code-block:: lean

  variables {p q : Prop}

  -- BEGIN
  theorem not_and_not_of_not_or : ¬(p ∨ q) → ¬p ∧ ¬q :=
  begin
    intro h₁, -- Assume `h₁ : ¬(p ∨ q)`. It suffices to prove `¬p ∧ ¬q`.
    split,    -- By and introduction, it suffices to prove 1. `¬p` and 2. `¬q`.
    { sorry },
    { sorry },
  end 
  -- END

By iff introduction on :numref:`Theorem %s <thm_not_or_of_not_and_not>` and
:numref:`Theorem %s <thm_not_and_not_of_not_or>`, we have our first complete De Morgan's law.

.. _thm_not_or_distrib:

.. proof:theorem:: De Morgan, 'not or distrib'

  Let :math:`P` and :math:`Q` be propositions. Then
  :math:`\neg(P\lor Q)\leftrightarrow\neg P\land\neg Q`.


.. code-block:: lean

  variables {p q : Prop}
  theorem not_and_not_of_not_or : ¬(p ∨ q) → ¬p ∧ ¬q :=
  λ hnpq, ⟨ λ hp, hnpq (or.inl hp) , λ hq, hnpq (or.inr hq) ⟩
  theorem not_or_of_not_and_not : ¬p ∧ ¬q → ¬(p ∨ q) :=
  λ hnphq hpq, or.elim hpq (λ hp, hnphq.1 hp) (λ hq, hnphq.2 hq)
  -- BEGIN
  theorem not_or_distrib : ¬(p ∨ q) ↔ ¬p ∧ ¬ q :=
  begin
    split,
    { exact not_and_not_of_not_or, },
    { exact not_or_of_not_and_not, },
  end
  -- END


.. _thm_not_and_of_not_or_not:

.. proof:theorem:: De Morgan, 'not and of not or not'

  Let :math:`P` and :math:`Q` be propositions. Then :math:`\neg P \lor\neg Q\to\neg(P\land Q)`.


Here's part of the Lean proof. Fill in the ``sorry``.

.. code-block:: lean

  import tactic.rcases
  variables {p q : Prop}
  namespace hidden
  -- BEGIN
  theorem not_and_of_not_or_not : ¬p ∨ ¬q → ¬(p ∧ q) :=
  begin
    assume h₁ : ¬p ∨ ¬q, -- Assume `h₁ : ¬p ∨ ¬q`. It suffices to prove `¬(p ∧ q)`.
    rintro ⟨h₂, h₃⟩,      -- Introduce `p ∧ q`. By and elim., `h₂ : p` and `h₃ : q`. By neg. intro, it suffices to prove `false`.
    -- By or elim. on `h₁`, it suffices to 1. assume `h₄ : ¬p` and prove `false` and 2. assume `h₅ : ¬q` and prove `false`.
    cases h₁ with h₄ h₅, 
    { exact h₄ h₂, }, -- This follows by negation introduction on `h₁` and `h₃`.
    { sorry },
  end 
  -- END
  end hidden

.. _sec_classical_reasoning:

Classical reasoning
===================

Intuitionistic and constructive reasoning
-----------------------------------------

You've now seen all the rules of inference for 'intuitionistic' propositional logic.
Congratulations! Intuitionistic logic (more generally 'constructive reasoning') is a form of
reasoning first investigated by L. E. J. Brouwer in the early 20th century.

From a constructive proof of a theorem, one can extract a method for constructing the described
mathematical object. Almost all school mathematics is constructive.

For example, in school you prove that every quadratic equation :math:`ax^2 + bx  +c = 0`, where
:math:`a, b, c` are real (or complex) numbers with :math:`a\ne0`, has a (real or complex) solution

.. math::

  \frac{-b + \sqrt{a^2-4ac}}{2a}.

This is an explicit construction of a root of the quadratic. Can you conceive of a proof of
existence that *doesn't* involve the construction of a root?

For a more elementary example, let :math:`P` be a proposition. Can you prove :math:`P \lor \neg P`?
Using constructive reasoning you can't. In general, a constructive proof of :math:`A \lor B`
requires that you prove :math:`A` or that you prove :math:`B`.

A mathematician using constructive reasoning will not be able to say, 'The Queen likes tea or the
Queen doesn't like tea' unless they can prove either that the Queen likes tea or that the Queen
doesn't like tea.

The law of the excluded middle
------------------------------

To resolve this issue, 'classical reasoning' takes :math:`P\lor\neg P` as an axiom [#]_, called the
law of the excluded middle.

.. proof:axiom:: Law of the excluded middle

  Let :math:`P` be a proposition. Then we have a proof of :math:`P\lor\neg P`.

A mathematician using this law can deduce, 'The Queen likes tea or the Queen doesn't like tea',
without any knowledge of the Queen's beverage preferences.

In Lean, the law of the excluded middle is a theorem called ``classical.em``. Here's a very short
example in which we prove ``q ∨ ¬q``.

.. code-block:: lean

  variables {q : Prop}
  -- BEGIN
  example : q ∨ ¬q := classical.em q
  -- END

We'll give a proof of the result below, using the law of the excluded middle. The proof needs
elements of predicate logic together with results on even and odd numbers. We will cover this
in-depth in :numref:`Section %s <sec_pred_logic>`.

.. _ex_x_xplus3_even:

.. proof:example::

  Let :math:`x` be an integer. Then :math:`x(x+3)` is even.

.. proof:proof::

  By definition of 'even', our goal is to prove that there exists an integer :math:`m` such that
  :math:`x(x+3)=2m`. 
  
  Let :math:`P` denote ':math:`x` is even'. By the law of the excluded middle, applied to :math:`P`,
  we have :math:`h_1 : P\lor\neg P`.

  By or elimination on :math:`h_1`, it suffices to 1. assume :math:`h_2 : P` and derive the goal
  and 2. assume :math:`h_3 : \neg P` and derive the goal.

  1. Assume :math:`h_2 : P`. That is, :math:`x` is even. By definition, there exists an integer
  :math:`k` such that :math:`x = 2k`. Assume :math:`k` is an integer for which :math:`x = 2k`. Then

  .. math::

    x(x+3) = 2k(x+3) = 2(k(x+3)).

  Take :math:`m := k(x+3)`. Then there is an integer :math:`m` such that :math:`x(x+3)=2m`.

  2. Assume :math:`h_3 : \neg P`. That is, :math:`x` is not even. Thus (why?) :math:`x` is odd.
  So there is an integer :math:`k` such that :math:`x = 2k + 1`. Assume :math:`k` is an integer
  for which :math:`x = 2k+1`. Then :math:`x+3 = (2k+1)+3=2(k+2)`.
  We deduce
  
  .. math::
    x(x+3) = x\times(2(k+2)) = 2(x(k+2)).
    
  Take :math:`m := x(k+2)`. Then there is an integer :math:`m` such that :math:`x(x+3)=2m`.

  This completes the proof.

.. [#] Technically,many systems that use classical reasoning, including Lean, assume the
   *axiom of choice*, a rather more sophisticated statement, and use it to deduce the law of the
   excluded middle.

Proof by cases
--------------

:numref:`Example %s <ex_x_xplus3_even>` is an instance of a method of proof called *proof by cases*.
Below, give a proof of the general proof method.

.. proof:theorem:: Proof by cases

  Let :math:`A` and :math:`B` be propositions. Given :math:`h_1 : A \to B` and
  :math:`h_2 : \neg A \to B`, we have a proof of :math:`B`.

.. proof:proof::

  By the law of the excluded middle, applied to :math:`A`, we have :math:`h : A \lor \neg A`.
  By or elimination applied to :math:`h`, to prove :math:`B`, it suffices to
  1. assume :math:`k_1 : A` and derive :math:`B` and 2. assume :math:`k_2 : \neg A` and derive
  :math:`B`.

  1. Assume :math:`k_1 : A`. We show :math:`B` by implication elimination on :math:`h_1` and
  :math:`k_1`.

  2. Assume :math:`k_2 : \neg A`. We show :math:`B` by implication elimination on :math:`h_2` and
  :math:`k_2`.

As an application of proof by cases, we show the remaining direction of De Morgan's law.

.. _thm_not_or_not_of_not_and:

.. proof:theorem:: De Morgan's law, 'not or not of not and'

  Let :math:`P` and :math:`Q` be propositions. Then :math:`\neg(P\land Q)\to\neg P\lor\neg Q`.

.. proof:proof::

  Assume :math:`h_1 : \neg(P\land Q)`. It suffices to prove :math:`\neg P\lor\neg Q`.

  Via proof by cases, it suffices to 1. assume :math:`h_2 : P` and derive :math:`\neg P\lor\neg Q`
  and 2. assume :math:`h_2 : \neg P` and derive :math:`\neg P\lor\neg Q`.

  1. Assume :math:`h_2 : P`. By right or introduction, it suffices to prove :math:`\neg Q`.
     Assume :math:`h_3 : Q`. By negation introduction, it suffices to prove :math:`\bot`.
     By false introduction on :math:`h_1`, it suffices to prove :math:`P\land Q`.
     This follows by and introduction on :math:`h_1` and :math:`h_2`.

  2. We leave this part of the proof as an exercise for the reader.

This method of reasoning is represented in Lean with the ``by_cases`` tactic. Depending on your
version of Lean, you may need to declare that propositions are 'decidable' using the command
``local attribute [instance] classical.prop_decidable``. Fill in the ``sorry`` below.

.. code-block:: lean

  variables {p q : Prop}
  -- BEGIN
  local attribute [instance] classical.prop_decidable

  theorem not_or_not_of_not_and : ¬(p ∧ q) → ¬p ∨ ¬q :=
  begin
    assume h₁ : ¬(p ∧ q),    -- Assume `h₁ : ¬(p ∧ q)`. It suffices to prove `¬p ∨ ¬q`.
    -- Via proof by cases, it suffices to prove we can derive `¬p ∨ ¬q` 1. assuming `h₂ : p` and 2. assuming `h₂ : ¬p`.
    by_cases h₂ : p,         
    { right,                 -- Assume `h₂ : p`. By right or introduction, it suffices to prove `¬q`.
      assume h₃ : q,         -- Assume `h₃ : q`. By negation introduction, it suffices to prove `false`.
      apply h₁,              -- By false introduction on `h₁`, it suffices to prove `p ∧ q`.
      exact ⟨h₂, h₃⟩, },      -- This follows by and introduction on `h₂` and `h₃`.
    { sorry }, 
  end
  -- END

By iff introduction on our previous :numref:`Theorem %s <thm_not_and_of_not_or_not>` and
:numref:`Theorem %s <thm_not_or_not_of_not_and>`, we deduce the final iff De Morgan's law.

.. _thm_not_and_distrib:

.. proof:theorem:: De Morgan's law, 'not and distrib'

  Let :math:`P` and :math:`Q` be propositions. Then
  :math:`\neg(P\land Q)\leftrightarrow\neg P\lor\neg Q`.

.. code-block:: lean

  variables {p q : Prop}
  theorem not_or_not_of_not_and : ¬(p ∧ q) → ¬p ∨ ¬q :=
  λ hnpq, or.elim (classical.em p) (λ hp, or.inr (λ hq, hnpq ⟨hp, hq⟩)) (λ hnp, or.inl hnp)
  theorem not_and_of_not_or_not : ¬p ∨ ¬q → ¬(p ∧ q) :=
  λ hnpnq hpq, or.elim hnpnq (λ hnp, hnp hpq.1) (λ hnq, hnq hpq.2)
  -- BEGIN
  theorem not_and_distrib : ¬(p ∧ q) ↔ ¬p ∨ ¬ q :=
  begin
    split,
    { exact not_or_not_of_not_and, },
    { exact not_and_of_not_or_not, },
  end
  -- END

Double negation
---------------

.. _thm_double_negation:

.. proof:theorem:: Double negation

  Let :math:`P` be a proposition. Then :math:`\neg\neg P \leftrightarrow P`.

.. proof:proof::

  By iff introduction, it suffices to prove 1. :math:`\neg\neg P \to P` and 2. :math:`P\to\neg\neg P`.

  1. Assume :math:`h_1 : \neg\neg P`. It suffices to prove :math:`P`.
     Via proof by cases, it suffices to prove :math:`P` separately on the assumptions a. :math:`h_2 : P`
     and b. :math:`h_2 : \neg P`.
 
     a. Assume :math:`h_2 : P`. We show :math:`P` by reiteration on :math:`h_2`.

     b. Assume :math:`h_2 : \neg P`. By false elimination, it suffices to prove :math:`\bot`.
        We show :math:`\bot` by false introduction on :math:`h_1` and :math:`h_2`.

  2. This follows by :numref:`Theorem %s <thm_not_not_of_self>`.

.. code-block:: lean

  variables {p : Prop}
  theorem not_not_of_self : p → ¬¬p := λ hp hnp, hnp hp
  local attribute [instance] classical.prop_decidable
  -- BEGIN
  theorem not_not : ¬¬p ↔ p :=
  begin
    split,                      -- By iff intro., it suffices to prove 1. `p → ¬¬p` and 2. `¬¬p → p`.
    { assume h₁ : ¬¬p,          -- Assume `h₁ : ¬¬p`. It suffices to prove `p`.
      by_cases h₂ : p,          -- We'll show `p` via proof by cases on `p`. 
      { exact h₂,  },           -- Assume `h₂ : p`. The goal, `p` follows by reiteration on `h₂`.
      { exfalso,                -- By false elimination, it suffices to prove `false`.
        exact h₁ h₂, }, },      -- This follows by false introduction on `h₁` and `h₂`.
    { exact not_not_of_self, }, -- Goal 2. follows by a previously-proved theorem.
  end
  -- END

As an example application, we give another proof of 
::numref:`Theorem %s <thm_not_or_not_of_not_and>`, this time using double negation instead of
proof by cases. Recall that ``not_or_distrib`` is our constructive result ``¬(a ∨ b) ↔ ¬a ∧ ¬b``.

.. code-block:: lean

  import logic.basic
  variables {p q : Prop}
  local attribute [instance] classical.prop_decidable
  -- BEGIN
  example : ¬(p ∧ q) → ¬p ∨ ¬ q :=
  begin
    assume h₁ : ¬(p ∧ q), -- Assume `h₁ : ¬(p ∧ q)`. It sfufice to prove `¬p ∨ ¬q`.
    have h₂ : ¬¬(¬p ∨ ¬q) ↔ ¬p ∨ ¬q, from not_not, -- By double negation, we have `¬¬(¬p ∨ ¬q) ↔ ¬p ∨ ¬q`.
    rw ←h₂,                 -- Rewriting with `h₂`, the goal is to show `¬¬(¬p ∨ ¬q)`.
    rw not_or_distrib,      -- Rewriting with `not_or_distrib`, the goal is to show `¬(¬¬p ∧ ¬¬q)`
    repeat { rw not_not, }, -- Repeatedly rewriting with double negation, the goal is to show `¬(p ∧ q)`.
    show ¬(p ∧ q), from h₁, -- We show `¬(p ∧ q)` from `h₁`.
  end
  -- END



Proof by contradiction
----------------------

Negation introduction is the (derived) rule that :math:`\neg P` is proved by assuming :math:`P`
and deriving :math:`\bot`. Proof by contradiction (also called *reductio ad absurdum*) is a similar
result, formed by subsituting :math:`Q` for :math:`\neg P` and using double negation.

.. proof:theorem:: Proof by contradiction

  Let :math:`Q` be a proposition. To prove :math:`Q`, it suffices to assume :math:`\neg Q` and
  derive :math:`\bot`.

This theorem is really just a restatement of one direction of the double negation result.

.. proof:proof::

  By left iff elimination on the double negation result, :numref:`Theorem %s <thm_double_negation>`, 
  we have :math:`\neg\neg Q \to Q`.

  By implication introduction, this means :math:`Q` follows on the assumption :math:`\neg\neg Q`
  By definition of :math:`\neg`, to prove :math:`\neg\neg Q` is to assume :math:`\neg Q` and
  derive :math:`\bot`.

In Lean, we invoke proof by contradiction using the ``by_contradiction`` tactic. We see this in
use below in yet another proof of :numref:`Theorem %s <thm_not_or_not_of_not_and>`

.. code-block:: lean

  import logic.basic
  variables {p q : Prop}
  local attribute [instance] classical.prop_decidable
  -- BEGIN
  example : ¬(p ∧ q) → ¬p ∨ ¬ q :=
  begin
    assume h₁ : ¬(p ∧ q),      -- Assume `h₁ : ¬(p ∧ q)`. It sfufice to prove `¬p ∨ ¬q`.
    by_contradiction h₂,       -- For a contradiciton, assume `h₂ : ¬(¬p ∨ ¬q)`. It suffices to prove `false`.
    rw not_or_distrib at h₂,   -- Rewriting using De Morgan's law `not_or_distrib`, `h₂` is `¬¬p ∧ ¬¬q`.
    repeat {rw not_not at h₂}, -- Repeatedly using double negation, `h₂` is `p ∧ q`.
    show false, from h₁ h₂,    -- We show false by false introduction on `h₁` and `h₂`. 
  end
  -- END

Proof by contrapositive
-----------------------

Recall that the contrapositive of a conditional :math:`P\to Q` is the proposition
:math:`\neg Q\to\neg P`. Using constructive reasoning, we previously proved
:numref:`Theorem %s <thm_mt>`, that :math:`(P\to Q)\to(\neg Q\to\neg P)`.

By proving the converse of this result we will have, by iff introduction,
:math:`(\neg Q\to\neg P) \leftrightarrow (P\to Q)`.

.. proof:theorem:: Proof by contrapositive, 'not imp not'

  Let :math:`P` and :math:`Q` be propositions. Then :math:`\neg Q\to\neg P \leftrightarrow P\to Q`.

.. proof:proof::

  By iff introduction, it suffices to prove 1. :math:`(\neg Q\to\neg P)\to (P\to Q)`. and
  2. :math:`(P\to Q)\to(\neg Q\to\neg P)`.

  1. Assume :math:`h_1 : \neg Q\to\neg P`. It suffices to prove :math:`P\to Q`.
     Assume :math:`h_2 : P`. It suffices to prove :math:`Q`.
     For a contradiction, assume :math:`h_3 : \neg Q`. It suffices to prove :math:`\bot`.
     We have :math:`h_4 : \neg P` from implication elimination on :math:`h_1` and :math:`h_3`.
     We show :math:`\bot` by false introduction on :math:`h_4` and :math:`h_2`.

  2. We show :math:`(P\to Q)\to(\neg Q\to\neg P)` by :numref:`Theorem %s <thm_mt>`, modus tollens. 

.. code-block:: lean

  import logic.basic
  variables {p q : Prop}
  local attribute [instance] classical.prop_decidable
  namespace hidden
  -- BEGIN
  theorem not_imp_not : (¬q → ¬p) ↔ (p → q) :=
  begin
    split, -- By iff intro., it suffices to prove 1. `¬q → ¬p → p → q` and 2. `p → q → ¬q → ¬p`.
    { intros h₁ h₂, -- Assume `h₁ : ¬q → ¬p`, `h₂ : p`. It suffices to prove `q`.
      by_contradiction h₃, -- For a contradiction, assume `h₃ : ¬q`. It suffices to prove `false`.
      have h₄ : ¬p, from h₁ h₃, -- We have `h₄ : ¬p` by implication elimination on `h₁` and `h₃`.
      show false, from h₄ h₂, -- We show `false` by false introduction on `h₄` and `h₂`.
    },
    { exact mt }, -- We show `(p → q) → (¬q → ¬p)` by modus tollens.
  end
  -- END
  end hidden

As an example, we'll use proof by contrapositive to give another proof of
:numref:`Theorem %s <thm_not_or_not_of_not_and>`.

.. code-block:: lean

  import logic.basic
  variables {p q : Prop}
  local attribute [instance] classical.prop_decidable
  -- BEGIN
  example : ¬(p ∧ q) → ¬p ∨ ¬ q :=
  begin
    rw ←not_imp_not, -- It suffices to prove the contrapositive, `¬(¬p ∨ ¬q) → ¬¬(p ∧ q)`.
    rw not_or_distrib, -- By De Morgan's Law `not_or_distrib`, it suffices to prove `¬¬p ∧ ¬¬q → ¬¬(p ∧ q)`.
    repeat {rw not_not}, -- By repeated double negation, it suffices to prove `p ∧ q → p ∧ q`.
    exact id, -- This follows by `id`, the reflexivity of implication.
  end
  -- END
