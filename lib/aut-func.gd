####################################################################################################
##
##  This file declares new function names for implemented functions of the automata package,
##  in order to call the functions with automatons or Predicaton.
##
####################################################################################################
##
#F  IsDeterministicAut(A)
##
##  Tests if A is a deterministic automaton or Predicaton.
##
DeclareGlobalFunction( "IsDeterministicAut" );
####################################################################################################
##
#F  IsNonDeterministicAut(A)
##
##  Tests if A is a non deterministic automaton or Predicaton.
##
DeclareGlobalFunction( "IsNonDeterministicAut" );
####################################################################################################
##
#F  IsNonDeterministicAut(A)
##
##  Returns the type.
##
DeclareGlobalFunction( "TypeOfAut" );
####################################################################################################
##
#F  AlphabetOfAut(A)
##
##  Gives the number of letters in the alphabet.
##
DeclareGlobalFunction( "AlphabetOfAut" );
####################################################################################################
##
#F  AlphabetOfAutAsList(A)
##
##  Returns the alphabet as list.
##
DeclareGlobalFunction( "AlphabetOfAutAsList" );
####################################################################################################
##
#F  NumberStatesOfAut(A)
##
##  Returns the number of states.
##
DeclareGlobalFunction( "NumberStatesOfAut" );
####################################################################################################
##
#F  SortedStatesAut(A)
##
##  Sorts the states of an automaton or a Predicaton, such that the 
##  intial states have the lowest and the final states the highest number.
##
DeclareGlobalFunction( "SortedStatesAut" );
####################################################################################################
##
#F  TransitionMatrixOfAut(A)
##
##  Returns the transition matrix.
##
DeclareGlobalFunction( "TransitionMatrixOfAut" );
####################################################################################################
##
#F  InitialStatesOfAut(A)
##
##  Returns the initial states.
##
DeclareGlobalFunction( "InitialStatesOfAut" );
####################################################################################################
##
#F  SetInitialStatesOfAut(A)
##
##  Sets the initial states.
##
DeclareGlobalFunction( "SetInitialStatesOfAut" );
####################################################################################################
##
#F  FinalStatesOfAut(A)
##
##  Returns the final states.
##
DeclareGlobalFunction( "FinalStatesOfAut" );
####################################################################################################
##
#F  SetFinalStatesOfAut(A)
##
##  Sets the final states.
##
DeclareGlobalFunction( "SetFinalStatesOfAut" );
####################################################################################################
##
#F  SinkStatesAut(A)
##
##  Returns the sink states.
##
DeclareGlobalFunction( "SinkStatesOfAut" );
####################################################################################################
##
#F  CopyAut(A)
##
##  Returns a copy of the automaton A.
##
DeclareGlobalFunction( "CopyAut" );
DeclareSynonym( "CopyPred", CopyAut );
####################################################################################################
##
#F  PermutedStatesAut(A)
##
##  Returns the permuted states automaton.
##
DeclareGlobalFunction( "PermutedStatesAut" );
####################################################################################################
##
#F  NegateAut(A)
##
##  Negates the automaton swapping the final states to non-final and vice-versa.
##
DeclareGlobalFunction( "NegatedAut" );
####################################################################################################
##
#F  IntersectionAut(A)
##
##  Returns the intersection of two automatons or Predicata.
##
DeclareGlobalFunction( "IntersectionAut" );
####################################################################################################
##
#F  UnionAut(A)
##
##  Returns the union of two automatons or Predicata.
##
DeclareGlobalFunction( "UnionAut" );
####################################################################################################
##
#F  MinimalAut(A)
##
##  Returns the minimal automaton or minimal Predicaton, i.e. the minimal DFA
##
DeclareGlobalFunction( "MinimalAut" );
####################################################################################################
##
#F  IsRecognizedByAut(A, word)
##
##  Tests if a given word is recognized by the given automaton or Predicaton
##
DeclareGlobalFunction( "IsRecognizedByAut" );
####################################################################################################
##
#F  PredToRatExp(A)
##
##  Returns the rational expression for the Predicaton (automatons are also allowed)
##
DeclareGlobalFunction( "PredicatonToRatExp" );
##
#E
##
