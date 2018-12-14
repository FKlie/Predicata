####################################################################################################
##
##  This file declares new function names for implemented functions of the automata package,
##  in order to call the functions with automatons or Predicaton.
##
####################################################################################################
##
#F  IsDeterministicPredicaton(A)
##
##  Tests if A is a deterministic automaton or Predicaton.
##
DeclareGlobalFunction( "IsDeterministicPredicaton" );
####################################################################################################
##
#F  IsNonDeterministicPredicaton(A)
##
##  Tests if A is a non deterministic automaton or Predicaton.
##
DeclareGlobalFunction( "IsNonDeterministicPredicaton" );
####################################################################################################
##
#F  TypeOfPredicaton(A)
##
##  Returns the type.
##
DeclareGlobalFunction( "TypeOfPredicaton" );
####################################################################################################
##
#F  AlphabetOfPredicaton(A)
##
##  Gives the number of letters in the alphabet.
##
DeclareGlobalFunction( "AlphabetOfPredicaton" );
####################################################################################################
##
#F  AlphabetOfPredicatonAsList(A)
##
##  Returns the alphabet as list.
##
DeclareGlobalFunction( "AlphabetOfPredicatonAsList" );
####################################################################################################
##
#F  NumberStatesOfPredicaton(A)
##
##  Returns the number of states.
##
DeclareGlobalFunction( "NumberStatesOfPredicaton" );
####################################################################################################
##
#F  SortedStatesPredicaton(A)
##
##  Sorts the states of an automaton or a Predicaton, such that the 
##  intial states have the lowest and the final states the highest number.
##
DeclareGlobalFunction( "SortedStatesPredicaton" );
####################################################################################################
##
#F  TransitionMatrixOfPredicaton(A)
##
##  Returns the transition matrix.
##
DeclareGlobalFunction( "TransitionMatrixOfPredicaton" );
####################################################################################################
##
#F  InitialStatesOfPredicaton(A)
##
##  Returns the initial states.
##
DeclareGlobalFunction( "InitialStatesOfPredicaton" );
####################################################################################################
##
#F  SetInitialStatesOfPredicaton(A)
##
##  Sets the initial states.
##
DeclareGlobalFunction( "SetInitialStatesOfPredicaton" );
####################################################################################################
##
#F  FinalStatesOfPredicaton(A)
##
##  Returns the final states.
##
DeclareGlobalFunction( "FinalStatesOfPredicaton" );
####################################################################################################
##
#F  SetFinalStatesOfPredicaton(A)
##
##  Sets the final states.
##
DeclareGlobalFunction( "SetFinalStatesOfPredicaton" );
####################################################################################################
##
#F  SinkStatesPredicaton(A)
##
##  Returns the sink states.
##
DeclareGlobalFunction( "SinkStatesOfPredicaton" );
####################################################################################################
##
#F  CopyPredicaton(A)
##
##  Returns a copy of the automaton A.
##
DeclareGlobalFunction( "CopyPredicaton" );
####################################################################################################
##
#F  PermutedStatesPredicaton(A)
##
##  Returns the permuted states automaton.
##
DeclareGlobalFunction( "PermutedStatesPredicaton" );
####################################################################################################
##
#F  NegatePredicaton(A)
##
##  Negates the automaton swapping the final states to non-final and vice-versa.
##
DeclareGlobalFunction( "NegatedPredicaton" );
####################################################################################################
##
#F  IntersectionPredicata(A, B, n)
##
##  Returns the intersection of two Automata or Predicata.
##  Intersects two predicatas A and B after resizing them to the same
##  variable positions and sorting the alphabet list to be in the same order.
## 
DeclareGlobalFunction( "IntersectionPredicata" );
####################################################################################################
##
#F  UnionPredicata(A, B, n)
##
##  Returns the union of two Automata or Predicata.
##  Unites two predicatas A and B after resizing them to the same
##  variable positions and sorting the alphabet list to be in the same order.
## 
DeclareGlobalFunction( "UnionPredicata" );
####################################################################################################
##
#F  MinimalPredicaton(A)
##
##  Returns the minimal automaton or minimal Predicaton, i.e. the minimal DFA
##
DeclareGlobalFunction( "MinimalPredicaton" );
####################################################################################################
##
#F  IsRecognizedByPredicaton(A, word)
##
##  Tests if a given word is recognized by the given automaton or Predicaton
##
DeclareGlobalFunction( "IsRecognizedByPredicaton" );
####################################################################################################
##
#F  PredicatonToRatExp(A)
##
##  Returns the rational expression for the Predicaton (automatons are also allowed)
##
DeclareGlobalFunction( "PredicatonToRatExp" );
##
#E
##
