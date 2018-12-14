####################################################################################################
##
##  This file declares special functions on Predicata, it precalls also some Predicatas.
##
####################################################################################################
##
#F  IsValidInputList(l, n)
##
##  Checks the input for the following functions.
##
DeclareGlobalFunction( "IsValidInputList" );
####################################################################################################
##
#F  BooleanPredicaton(B, n)
##
##  Returns the predicate which consists of one state. This state is a 
##  final state for B = "true" and a non-final state for B = "false".
##
DeclareGlobalFunction( "BooleanPredicaton" );
####################################################################################################
##
#F  EqualPredicaton(l, n[, base] )
##
##  Returns the Predicaton that recognizes x = y 
##  with final variable position list n and inital variable position list l
##  where the order still matters, see also PredFromAut and PermutedAlphabetPred.
##
DeclareGlobalFunction( "EqualPredicaton" );
####################################################################################################
##
#F  EqualNPredicaton(N, l, n)
##
##  Returns the Predicaton that recognizes x = N for N >= 0.
##
DeclareGlobalFunction( "EqualNPredicaton" );
####################################################################################################
##
#F  AdditionPredicaton(l, n)
##
##  Returns the Predicaton that recognizes x + y = z 
##  with final variable position list n and inital variable position list l
##  where the order still matters, see also PredFromAut and PermutedAlphabetPred.
##
DeclareGlobalFunction( "AdditionPredicaton" );
####################################################################################################
##
#F  SumOfProductsPredicaton(l, m, n)
##
##  Returns the Predicaton that recognizes m_1*x_1 + ... + m_N*x_N = 0, for integers t_i,
##  with inital variable position list l, where the order still matters
##  and final variable position list n. 
##  
##  Creates the transition matrix explicitly.
##
DeclareGlobalFunction( "SumOfProductsPredicaton" );
####################################################################################################
##
#F  TermEqualTermPredicaton( l1, m1, i1, l2, m2, i2, n )
##
##  Returns the Predicaton which recognizes the sum of m1*l1 or the integers i1 equal
##  the sum of m2*l2 or integers i2.
##  Input: l1, l2...variable positions list (double occurences allowed),
##          "int" for integer addition
##     m1, m2...integers of the multiplications (1 for just the variable)
##          "int" for integer addition
##     i1, i2...integer for addition
##     n...resized length as positions
##
DeclareGlobalFunction( "TermEqualTermPredicaton" );
####################################################################################################
##
#F  GreaterEqualNPredicaton(N, l, n)
##
##  Returns the Predicaton which recognizes the language of x >= N.
##  I.e. x >= N <=> E n1: E n2: n1 + n2 = x and n2 = N.
##
DeclareGlobalFunction( "GreaterEqualNPredicaton" );
####################################################################################################
##
#F  GreaterNPredicaton(N, l, n)
##
##  Returns the Predicaton which recognizes the language of x > N.
##
##  Calls GreaterEqualNPredicaton(N+1, l, n).
##
DeclareGlobalFunction( "GreaterNPredicaton" );
####################################################################################################
##
#F  SmallerEqualNPredicaton(N, l, n)
##
##  Returns the Predicaton which recognizes the language of x <= N.
##
DeclareGlobalFunction( "SmallerEqualNPredicaton" );
####################################################################################################
##
#F  SmallerNPredicaton(N, l, n)
##
##  Returns the Predicaton which recognizes the language of x < N.
##
DeclareGlobalFunction( "SmallerNPredicaton" );
####################################################################################################
##
#F  GreaterEqualPredicaton(l, n)
##
##  Returns the Predicaton which recognizes the language of x >= y,
##  I.e. x >= y <=> E n1: y + n1 = x.
##
DeclareGlobalFunction( "GreaterEqualPredicaton" );
####################################################################################################
##
#F  GreaterPredicaton(l, n)
##
##  Returns the Predicaton which recognizes the language of x > y,
##  I.e. x >= y <=> E n1: y + n = x and n >=1.
##
DeclareGlobalFunction( "GreaterPredicaton" );
####################################################################################################
##
#F  SmallerEqualPredicaton(l, n)
##
##  Returns the Predicaton which recognizes the language of x <= y,
##
DeclareGlobalFunction( "SmallerEqualPredicaton" );
####################################################################################################
##
#F  SmallerPredicaton(l, n)
##
##  Returns the Predicaton which recognizes the language of x < y,
##
DeclareGlobalFunction( "SmallerPredicaton" );
####################################################################################################
##
#F  BuchiPredicaton(l, n)
##
##  Returns the Predicaton which gives the Büchi automaton, 
##  i.e. l[2] is the largest power of 2 which divides l[1]. 
##
DeclareGlobalFunction( "BuchiPredicaton" );
####################################################################################################
##
#F  PowerPredicaton(l, n)
##
##  Returns the Predicaton which gives all powers of 2.
##
DeclareGlobalFunction( "PowerPredicaton" );
##
#E
##