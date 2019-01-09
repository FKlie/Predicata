####################################################################################################
##
##  This file defines the functions, which convert a string or a PredicataFormula into Predicaton.
##
####################################################################################################
##
#F  PredicataGrammar()
##
##  Returns the accepted grammar as string.
##
DeclareGlobalFunction( "PredicataGrammar" );
####################################################################################################
##
#F  PredicataPredefinedPredicates()
##
##  Returns the predefined predicates as string.
##
DeclareGlobalFunction( "PredicataPredefinedPredicates" );
####################################################################################################
##
#F  PredicataFormulaToPredicaton(f, V)
##
##  Converts a PredicataFormula to a Predicaton
##
##  Calls literally everything.
##
DeclareGlobalFunction( "PredicataFormulaToPredicaton" );
####################################################################################################
##
#F  StringToPredicaton(F, V)
##
##  Converts a String to a Predicaton, doesn't allow own predicates.
##
##  Calls PredicataFormulaToPredicaton.
##
DeclareGlobalFunction( "StringToPredicaton" );
####################################################################################################
##
#F  VariableAdjustedPredicaton(P, V)
##
##  Adjusts the Predicaton to match the variables in a different order, sorts the alphabet, 
##  for example for the current VariableListOfPred(P)=["x", "y"] and V:=["y","x"],
##  letters are swapped, and the transition matrix rows are moved accordingly
##  Compare with SetVariablePositionList(P, l) or PermutedPred 
##  Note that SetVariableList(P, V) is just a simple renaming.
##
DeclareGlobalFunction( "VariableAdjustedPredicaton" );
####################################################################################################
##
#F  VariableAdjustedPredicata(P1, P2, V)
##
##  Adjusts the Predicata to match with the variable names, same as VariableAdjustedPred
##  just with two Predicata at the same time.
##
DeclareGlobalFunction( "VariableAdjustedPredicata" );
####################################################################################################
##
#F  AndPredicata(P1, P2, V)
##
##  Creates the intersection of two Predicata regarding the variables names!
##
DeclareGlobalFunction( "AndPredicata" );
####################################################################################################
##
#F  OrPredicata(P1, P2, V)
##
##  Creates the union of two Predicata regarding the variables names!
##
DeclareGlobalFunction( "OrPredicata" );
####################################################################################################
##
#F  NotPredicaton(P1, V)
##
##  Creates the negation of one Predicata regarding the variables names!
##
DeclareGlobalFunction( "NotPredicaton" );
####################################################################################################
##
#F  ImpliesPredicata(P1, P2, V)
##
##  Creates the implication of two Predicata regarding the variables names!
##
DeclareGlobalFunction( "ImpliesPredicata" );
####################################################################################################
##
#F  EquivalentPredicata(P1, P2, V)
##
##  Creates the implication of two Predicata regarding the variables names!
##
DeclareGlobalFunction( "EquivalentPredicata" );
DeclareSynonym( "EquivPredicata", EquivalentPredicata );
####################################################################################################
##
#F  ExistsPredicaton(P, v, V)
##
##  Creates the existence quantifier of a Predicata and a variable regarding the variables names!
##
DeclareGlobalFunction( "ExistsPredicaton" );
####################################################################################################
##
#F  ForallPredicaton(P, v, V)
##
##  Creates the forall quantifier of a Predicata and a variable regarding the variables names!
##
DeclareGlobalFunction( "ForallPredicaton" );
####################################################################################################
##
#F  LeastAcceptedNumber(A, args...)
##
##  Returns the least accepted natural number from a given Predicaton with one variable, 
##  optional parameter true asks for the smallest greater zero, otherwise greater equal zero.
##
DeclareGlobalFunction( "LeastAcceptedNumber" );
####################################################################################################
##
#F  GreatestAcceptedNumber(A, args...)
##
##  Returns the greatest accepted natural number from a given Predicaton with one variable.
##
DeclareGlobalFunction( "GreatestAcceptedNumber" );
####################################################################################################
##
#F  LeastNonAcceptedNumber(A)
##
##  Returns the smallest nonaccepted natural number from a given Predicaton with one variable.
##
DeclareGlobalFunction( "LeastNonAcceptedNumber" );
####################################################################################################
##
#F  GreatestNotAcceptedNumber(A)
##
##  Returns the greatest nonaccepted natural number from a given Predicaton with one variable.
##
DeclareGlobalFunction( "GreatestNonAcceptedNumber" );
####################################################################################################
##
#F  PresentPredicaton(F, V)
##
##  Calls PredicataFormula, PredicataFormulaToPredicaton and DrawAut.
##
DeclareGlobalFunction( "PresentPredicaton" );
####################################################################################################
##
#F  FindCircleInPredicaton(A, V, t, d)
##
##  Unfolds the Predicaton (Predicaton, Visited final states, state, depth)
##
DeclareGlobalFunction( "FindCircleInPredicaton" );
####################################################################################################
##
#F  FinitelyManyWordsAccepted(A)
##
##  Checks if the number of solutions is finite, except 0-completion (leading zeros).
##  optional argument = true for an already formatted Predicaton (minimal DFA with 0-completion)
##
DeclareGlobalFunction( "FinitelyManyWordsAccepted" );
####################################################################################################
##
#F  LinearSolveOverN(A, b, args...)
##
##  Solves the linear equation A * x = b, A in Z^(m x n) and b in Z^m for x in N^n.
##
DeclareGlobalFunction( "LinearSolveOverN" );
####################################################################################################
##
#F  NullSpaceOverN(A, args...)
##
##  Solves the linear equation A * x = 0, A in Z^(m x n) for x in N^n.
##
DeclareGlobalFunction( "NullSpaceOverN" );
####################################################################################################
##
#F  InterpretedPredicaton(A)
##
##  Returns true if the Predicaton A can be interpreted as true, otherwise false.
##
DeclareGlobalFunction( "InterpretedPredicaton" );
####################################################################################################
##
#F  AreEquivalentPredicata(A, B, args...)
##
##  Checks if two Predicata are equivalent, the optional parameter = true computes w.r.t. to the 
##  variable list, otherwise w.r.t. variable POSITION list
##
DeclareGlobalFunction( "AreEquivalentPredicata" );
##
#E
##
