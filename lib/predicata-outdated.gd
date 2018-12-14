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