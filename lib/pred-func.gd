####################################################################################################
##
##  This file declares functions acting on Predicata.
##
####################################################################################################
##
#F  AutomatonOfPredicaton(A)
##
##  Returns the automaton.
##
DeclareGlobalFunction( "AutomatonOfPredicaton" );
DeclareSynonym( "AutOfPredicaton", AutomatonOfPredicaton);
####################################################################################################
##
#F  VariablePositionListOfPredicaton(A)
##
##  Returns the variable position list.
##
DeclareGlobalFunction( "VariablePositionListOfPredicaton" );
DeclareSynonym( "VarPosListOfPredicaton", VariablePositionListOfPredicaton);
####################################################################################################
##
#F  SetVariablePositionListOfPredicaton(A, v)
##
##  Sets the variable position list.
##
DeclareGlobalFunction( "SetVariablePositionListOfPredicaton" );
DeclareSynonym( "SetVarPosListOfPredicaton", SetVariablePositionListOfPredicaton);
####################################################################################################
##
#F  VariableListOfPredicaton(A)
##
##  Returns the variable names.
##
DeclareGlobalFunction( "VariableListOfPredicaton" );
####################################################################################################
##
#F  SetVariableListOfPredicaton(A)
##
##  Sets the variable names.
##
DeclareGlobalFunction( "SetVariableListOfPredicaton" );
####################################################################################################
##
#F  ProductLZeroPredicaton(A)
##
##  Creates the predicata with the language L*L_0:={xy : x in L and y in L_0}, 
##  where L is the language of the given predicata A and L_0:={w*: w =[0,...,0]}.
##
DeclareGlobalFunction( "ProductLZeroPredicaton" );
####################################################################################################
##
#F  RightQuotientLZeroPredicaton(A)
##
##  Creates the predicata with the language of the right quotient L/L_0:= {x : exists y in L_0 s.t. xy in L },
##  where L is the language of the given predicata A and L_0:={w*: w =[0,...,0]}.
##
DeclareGlobalFunction( "RightQuotientLZeroPredicaton" );
####################################################################################################
##
#F  NormalizedLeadingZeroPredicaton(A)
##
##  Creates the predicata with the language L*L_0 U L/L_0. This language contains the same words as the language of the given predicata, 
##  except either ignoring or adding leading zeros.
##
DeclareGlobalFunction( "NormalizedLeadingZeroPredicaton" );
####################################################################################################
##
#F  SortedAlphabetPredicaton(A)
##
##  Sorts the alphabet to be like the function GetAbc, also sorts the transition matrix.
##
DeclareGlobalFunction( "SortedAlphabetPredicaton" );
DeclareSynonym( "SortedAbcPredicaton", SortedAlphabetPredicaton);
####################################################################################################
##
#F  FormattedPredicaton(A)
##
##  Creates the predicata such that it allows leading zeros and is the minimal a DFA.
##
DeclareGlobalFunction( "FormattedPredicaton" );
####################################################################################################
##
#F  IsValidInput(A, n)
##
##  Checks the input for the following functions.
##
DeclareGlobalFunction( "IsValidInput" );
####################################################################################################
##
#F  ExpandedPredicaton(A, n)
##
##  Expands the alphabet size to 2^|n| regarding comparing the variable
##  position list and copying the transition matrix corresponding to the entries
##
DeclareGlobalFunction( "ExpandedPredicaton" );
####################################################################################################
##
#F  ProjectedPredicaton(A, p)
##
##  Deletes in the alphabet of the predicata the p-th position, i.e.
##  projects it down from {0,1}^n to {0,1}^n-1 
##  The corresponding transition matrix rows are combined (NFA).
##
DeclareGlobalFunction( "ProjectedPredicaton" );
####################################################################################################
##
#F  NegatedProjectedNegatedPredicaton(A, p)
##
##  Negate, project, negate with NormalizedLeadingZeroPred inbetween,
##  due to leading zeros
##
##  Forall quantifier!
## 
DeclareGlobalFunction( "NegatedProjectedNegatedPredicaton" );
####################################################################################################
##
#F  IntersectionPredicata(A, B, n)
##
##  Intersects two predicatas A and B after resizing them to the same
##  variable positions and sorting the alphabet list to be in the same order.
## 
DeclareGlobalFunction( "IntersectionPredicata" );
####################################################################################################
##
#F  UnionPredicata(A, B, n)
##
##  Unites two predicatas A and B after resizing them to the same
##  variable positions and sorting the alphabet list to be in the same order.
## 
DeclareGlobalFunction( "UnionPredicata" );
####################################################################################################
##
#F  PermutedAlphabetPredicaton(A, l)
##
##  Returns the predicata with the permuted alphabet.
##  Relevant for the first call of an specific predicata, especially 
##  for the call of the corresponding automaton, where the variable order
##  matters.
##  E.g.: automaton A is 6*x=y. Then the first position must be the 
##  corresponding to x and the second to y. If the variable position value
##  of x is smaller than y everything is fine, but else one have to swap for
##  each alphabet letter the position of x and y while leaving the transition
##  matrix unchanged.
##
DeclareGlobalFunction( "PermutedAlphabetPredicaton" );
DeclareSynonym( "PermutedAbcPredicaton", PermutedAlphabetPredicaton);
####################################################################################################
##
#F  PredFromAut(A)
##
##  Returns the permuted and expanded predicata A.
##
##  Use this for calling a predicata the first time, where variable position
##  list order matters, see PermutedAlphabetPred.
##
DeclareGlobalFunction( "PredicatonFromAut" );
##
#E
##
