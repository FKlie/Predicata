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
#V  PredicataEqualAut
##
##  The automaton PredicataEqualAut recognizes the language of 
##  two binary s.t.:
##  
##  PredicataEqualAut(x,y) :<=> x = y        
##
DeclareGlobalVariable( "PredicataEqualAut", "PredicataEqualAut(x,y) :<=> x = y." );
####################################################################################################
##
#F  EqualPredicaton(l, n)
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
#V  PredicataAdditionAut
##
##  The automaton >AdditionAut< recognizes the language of
##  three binary strings s.t.:
##
##  PredicataAdditionAut( x, y, z ) :<=> x + y = z  
##
DeclareGlobalVariable( "PredicataAdditionAut", "PredicataAdditionAut( x, y, z ) :<=> x + y = z." );
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
#F  AdditionPredicaton3Summands(l, n)
##
##  Returns the Predicaton that recognizes x1 + x2 + x3 = z.
##
DeclareGlobalFunction( "AdditionPredicaton3Summands" );
####################################################################################################
##
#F  AdditionPredicaton4Summands(l, n)
##
##  Returns the Predicaton that recognizes x1 + ... + x4 = z.
##
DeclareGlobalFunction( "AdditionPredicaton4Summands" );
####################################################################################################
##
#F  AdditionPredicaton5Summands(l, n)
##
##  Returns the Predicaton that recognizes x1 + ... + x5 = z.
##
DeclareGlobalFunction( "AdditionPredicaton5Summands" );
####################################################################################################
##
#F  AdditionPredicatonNSummandsIterative(N, l, n)
##
##  Returns the Predicaton that recognizes x_1 + ... + x_n = z, 
##  with inital variable position list l, where the order still matters
##  and final variable position list n. 
##  
##  The summands are evaluated iteratively, i.e. 
##    x_1 + x_2 = t_1 and t_1 + x_3 = t_2, ...
##
DeclareGlobalFunction( "AdditionPredicatonNSummandsIterative" );
####################################################################################################
##
#F  AdditionPredicatonNSummandsRecursive(N, l, n)
##
##  Returns the Predicaton that recognizes x_1 + ... + x_n = z, 
##  with inital variable position list l, where the order still matters
##  and final variable position list n. 
##  
##  The summands are evaluated recursively, i.e. 
##    x_1 + x_2 + x_N/2= t_1 and t_1 + x_N/2 + ... + x_N = z, 
##    with proper N even/odd handling.
##
DeclareGlobalFunction( "AdditionPredicatonNSummandsRecursive" );
####################################################################################################
##
#F  AdditionPredicatonNSummandsExplicit(N, l, n)
##
##  Returns the Predicaton that recognizes x_1 + ... + x_n = z, 
##  with inital variable position list l, where the order still matters
##  and final variable position list n. 
##  
##  Creates the transition matrix explicitly.
##
DeclareGlobalFunction( "AdditionPredicatonNSummandsExplicit" );
####################################################################################################
##
#F  AdditionPredicatonNSummands(N, l, n)
##
##  Returns the Predicaton that recognizes x_1 + ... + x_n = z, 
##  with inital variable position list l, where the order still matters
##  and final variable position list n. 
##  
##  Calls the faster AdditionPredNSummandsRecursive, maybe for small N iterative is faster.
##
DeclareGlobalFunction( "AdditionPredicatonNSummands" );
####################################################################################################
##
#F  Times2Predicaton(l, n)
##
##  Returns Predicaton A recognizing 2*x=y. 
##  Predefined to speed up the following functions.
##
DeclareGlobalFunction( "Times2Predicaton" );
####################################################################################################
##
#F  Times3Predicaton(l, n)
##
##  Returns Predicaton A recognizing 3*x=y. 
##  Predefined to speed up the following functions.
##
DeclareGlobalFunction( "Times3Predicaton" );
####################################################################################################
##
#F  Times4Predicaton(l, n)
##
##  Returns Predicaton A recognizing 4*x=y. 
##  Predefined to speed up the following functions.
##
DeclareGlobalFunction( "Times4Predicaton" );
####################################################################################################
##
#F  Times5Predicaton(l, n)
##
##  Returns Predicaton A recognizing 5*x=y. 
##  Predefined to speed up the following functions.
##
DeclareGlobalFunction( "Times5Predicaton" );
####################################################################################################
##
#F  Times6Predicaton(l, n)
##
##  Returns Predicaton A recognizing 6*x=y. 
##  Predefined to speed up the following functions.
##
DeclareGlobalFunction( "Times6Predicaton" );
####################################################################################################
##
#F  Times7Predicaton(l, n)
##
##  Returns Predicaton A recognizing 7*x=y. 
##  Predefined to speed up the following functions.
##
DeclareGlobalFunction( "Times7Predicaton" );
####################################################################################################
##
#F  Times8Predicaton(l, n)
##
##  Returns Predicaton A recognizing 8*x=y. 
##  Predefined to speed up the following functions.
##
DeclareGlobalFunction( "Times8Predicaton" );
####################################################################################################
##
#F  Times9Predicaton(l, n)
##
##  Returns Predicaton A recognizing 9*x=y. 
##  Predefined to speed up the following functions.
##
DeclareGlobalFunction( "Times9Predicaton" );
####################################################################################################
##
#F  TimesNPredRecursive(l, n)
##
##  Returns Predicaton A recognizing N*x=y, for N > 0. 
##  Uses the predefined times Predicatas.
##
DeclareGlobalFunction( "TimesNPredicatonRecursive" );
####################################################################################################
##
#F  TimesNPredExplicit(N, l, n)
##
##  Returns Predicaton A recognizing N*x=y, for N > 0. 
##  
##  Creates the transition matrix explicitly.
##
DeclareGlobalFunction( "TimesNPredicatonExplicit" );
####################################################################################################
##
#F  TimesNPredicaton(l, n)
##
##  Returns Predicaton A recognizing N*x=y, for N > 0.
## 
##  Calls TimesNPredRecursive with the relevant variable positions,
##  expands it afterwards.
##
DeclareGlobalFunction( "TimesNPredicaton" );
####################################################################################################
##
#F  NSummandsPredicaton(N, l, t, m, i, n)
##
##  Returns the Predicaton which recognizes the sum of N either variables
##  integers or multiplication equal a variable, integer or multiplication.
##  Input: N... number of summands
##     l...variable positions list of length N, 
##          either integer for variable position (double occurences allowed),
##          "int" for integer or
##          "mult" for multiplication
##     t...integers of the multiplications
##     m...variable positions of multiplications
##     i...integer of the additions,
##     n...resized length as positions
##
DeclareGlobalFunction( "NSummandsPredicaton" );
####################################################################################################
##
#F  NSummandsPredicatonFast(N, l, t, m, i, n)
##
DeclareGlobalFunction( "NSummandsPredicatonFast" );
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
#F  TermEqualAtomPredicaton(N, l, t, m, i, n)
##
##  Returns the Predicaton which recognizes the sum of N either variables
##  integers or multiplication equal a variable, integer or multiplication.
##  Input: N... number of summands
##     l...variable positions list of length N, 
##          either integer for variable position (double occurences allowed),
##          "int" for integer or
##          "mult" for multiplication
##     t...integers of the multiplications
##     m...variable positions of multiplications
##     i...integer of the additions,
##     n...resized length as positions
##
##  Calls NSummandsPredicaton with the relevant variable positions,
##  expands it afterwards.
##
DeclareGlobalFunction( "TermEqualAtomPredicaton" );
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