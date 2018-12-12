####################################################################################################
##
##  This file installs new function names for implemented functions of the automata package,
##  in order to call the functions with Automata or Predicata.
##
####################################################################################################
##
#F  IsDeterministicAut(A)
##
##  Tests if A is a deterministic Automaton or Predicaton.
##
InstallGlobalFunction( IsDeterministicAut, function ( A )
  if IsAutomatonObj(A) then
    return IsDeterministicAutomaton(A);
  elif IsPredicatonObj(A) then
    return IsDeterministicAutomaton(A!.aut);
  else 
    return false;
  fi;
end);
####################################################################################################
##
#F  IsNonDeterministicAut(A)
##
##  Tests if A is a non deterministic Automaton or Predicaton.
##
InstallGlobalFunction( IsNonDeterministicAut, function ( A )
  if IsAutomatonObj(A) then
    return IsNonDeterministicAutomaton(A);
  elif IsPredicatonObj(A) then
    return IsNonDeterministicAutomaton(A!.aut);
  else 
    return false;
  fi;
end);
####################################################################################################
##
#F  TypeOfAut(A)
##
##  Returns the type.
##
InstallGlobalFunction( TypeOfAut, function ( A )
  if IsAutomatonObj(A) then
    return ShallowCopy(A!.type);
  elif IsPredicatonObj(A) then
    return ShallowCopy(A!.aut!.type);
  else 
    Error("TypeOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  AlphabetOfAut(A)
##
##  Returns the number of letters in the alphabet.
##
InstallGlobalFunction( AlphabetOfAut, function( A )
  if IsAutomatonObj(A) then
    return StructuralCopy(A!.alphabet);
  elif IsPredicatonObj(A) then
    return StructuralCopy(A!.aut!.alphabet); 
  else 
    Error("AlphabetOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  AlphabetOfAutAsList(A)
##
##  Returns the alphabet as list.
##
InstallGlobalFunction( AlphabetOfAutAsList, function( A )
  if IsAutomatonObj(A) then
    return StructuralCopy(FamilyObj(A)!.alphabet);
  elif IsPredicatonObj(A) then
    return StructuralCopy(FamilyObj(A!.aut)!.alphabet); 
  else 
    Error("AlphabetOfAutAsList failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  NumberStatesOfAut(A)
##
##  Returns the number of states.
##
InstallGlobalFunction( NumberStatesOfAut, function( A )
  if IsAutomatonObj(A) then
    return A!.states ;
  elif IsPredicatonObj(A) then
    return A!.aut!.states ;
  else
    Error("NumberStatesOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SortedStatesAut(A)
##
##  Returns the Automaton or the Predicaton with sorted states,
##  such that the intial states have the lowest and the final states the highest number.
##
InstallGlobalFunction( SortedStatesAut, function( A )
  local B; 
  if IsAutomatonObj(A) then
    return NormalizedAutomaton(A);
  elif IsPredicatonObj(A) then
    B:=Predicaton(NormalizedAutomaton(A!.aut), A!.var);
    B!.varnames:=A!.varnames;
    return B;
  else
    Error("SortedStatesAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  TransitionMatrixOfAut(A)
##
##  Returns the transition matrix.
##
InstallGlobalFunction( TransitionMatrixOfAut, function( A )
  if IsAutomatonObj(A) then
    return StructuralCopy(A!.transitions);
  elif IsPredicatonObj(A) then
    return StructuralCopy(A!.aut!.transitions); 
  else 
    Error("TransitionMatrixOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  InitialStatesOfAut(A)
##
##  Returns the initial states.
##
InstallGlobalFunction( InitialStatesOfAut, function( A )
  if IsAutomatonObj(A) then
    return ShallowCopy(A!.initial);
  elif IsPredicatonObj(A) then
    return ShallowCopy(A!.aut!.initial); 
  else 
    Error("InitialStatesOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SetInitialStatesOfAut(A)
##
##  Sets the initial states.
##
InstallGlobalFunction( SetInitialStatesOfAut, function( A, I )
  if IsAutomatonObj(A) then
    SetInitialStatesOfAutomaton(A, I);
  elif IsPredicatonObj(A) then
    SetInitialStatesOfAutomaton(A!.aut, I);
  else
    Error("SetInitialStatesOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  FinalStatesOfAut(A)
##
##  Returns the final states.
##
InstallGlobalFunction(FinalStatesOfAut, function( A )
  if IsAutomatonObj(A) then
    return ShallowCopy(A!.accepting);
  elif IsPredicatonObj(A) then
    return ShallowCopy(A!.aut!.accepting); 
  else 
    Error("FinalStatesOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SetFinalStatesOfAut(A)
##
##  Sets the final states.
##
InstallGlobalFunction( SetFinalStatesOfAut, function( A, F )
  if IsAutomatonObj(A) then
    SetFinalStatesOfAutomaton(A, F);
  elif IsPredicatonObj(A) then
    SetFinalStatesOfAutomaton(A!.aut, F);
  else
    Error("SetFinalStatesOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SinkStatesOfAut(A)
##
##  Returns the sink states.
##
InstallGlobalFunction(SinkStatesOfAut, function( A )
  if IsAutomatonObj(A) then
    return ShallowCopy(ListSinkStatesAut(A));
  elif IsPredicatonObj(A) then
    return ShallowCopy(ListSinkStatesAut(A!.aut)); 
  else 
    Error("FinalStatesOfAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  CopyAut(A)
##
##  Returns a copy.
##
InstallGlobalFunction( CopyAut, function ( A )
  local B;
  if IsAutomaton(A) then
    return Automaton(TypeOfAut(A), NumberStatesOfAut(A), AlphabetOfAutAsList(A), TransitionMatrixOfAut(A), 
                      InitialStatesOfAut(A), FinalStatesOfAut(A));
  elif IsPredicatonObj(A) then
    B:=Predicaton(Automaton(TypeOfAut(A!.aut), NumberStatesOfAut(A!.aut), AlphabetOfAutAsList(A!.aut), TransitionMatrixOfAut(A!.aut), 
                         InitialStatesOfAut(A!.aut), FinalStatesOfAut(A!.aut)),A!.var);
    B!.varnames:=A!.varnames;
    return B;
  else
    Error("CopyAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  PermutedStatesAut(A)
##
##  Returns the permuted states Automaton.
##
InstallGlobalFunction( PermutedStatesAut, function ( A, p )
  local B;
  if IsAutomaton(A) and IsEqualSet([1..NumberStatesOfAut(A)], p) then
    return PermutedAutomaton(A, p);
  elif IsPredicatonObj(A) and IsEqualSet([1..NumberStatesOfAut(A)], p) then
    B:=Predicaton(PermutedAutomaton(A!.aut, p), A!.var);
    B!.varnames:=A!.varnames;
    return B;
  else
    Error("PermutedStatesAut failed, the first argument must be an Automaton or a Predicaton, the second must be a list which is equal to the set containing all states.\n");
  fi;
end);
####################################################################################################
##
#F  NegatedAut(A)
##
##  Negates the Automaton swapping the final states to non-final and vice-versa.
##
InstallGlobalFunction( NegatedAut , function ( A )
  local B, S;
  if IsAutomaton(A) or IsPredicaton(A) then
    B:=CopyAut(A);
    S:=[1..NumberStatesOfAut(B)];
    SubtractSet(S,FinalStatesOfAut(B));
    Sort(S);
    SetFinalStatesOfAut(B, S);
    return B;
  else
    Error("NegatedAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  IntersectionAut(A)
##
##  Returns the intersection of two Automata or Predicata.
##
InstallGlobalFunction( IntersectionAut, function ( A, B )
  if IsAutomaton(A) and IsAutomaton(B) then
    return IntersectionAutomaton(A,B);
  elif IsPredicatonObj(A) and IsPredicatonObj(B) then
    if IsEqualSet(A!.var, B!.var) and AlphabetOfAutAsList(A!.aut) = AlphabetOfAutAsList(B!.aut) then
      return Predicaton(IntersectionAutomaton(A!.aut,B!.aut), A!.var);
    else
      Print("Compare the variable position lists: ", A!.var , " and ", B!.var, "\nCompare the two Automata:\n");
      Display(A);
      Display(B);
      Error("IntersectionAut failed, please use IntersectionPred for the intersection of two Predicata with different variable lists.\n");
    fi;
  else 
    Error("IntersectionAut failed, the arguments must be both of type Automaton or Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  UnionAut(A)
##
##  Returns the union of two Automata or Predicata.
##
InstallGlobalFunction( UnionAut, function ( A, B )
  if IsAutomaton(A) and IsAutomaton(B) then
    return UnionAutomata(A,B);
  elif IsPredicatonObj(A) and IsPredicatonObj(B) then
    if IsEqualSet(A!.var, B!.var) and AlphabetOfAutAsList(A!.aut) = AlphabetOfAutAsList(B!.aut) then
      return Predicaton(UnionAutomata(A!.aut,B!.aut), A!.var);
    else 
      Error("UnionAut failed, please use UnionPred for the union of two Predicata with different variable lists.\n");
    fi;
  else 
    Error("UnionAut failed, the arguments must be both of type Automaton or Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F   MinimalAut(A)
##
##  Returns the minimal Automaton or minimal Predicaton, i.e. the minimal DFA.
##
InstallGlobalFunction( MinimalAut, function ( A )
  local B;
  if IsAutomaton(A) then
    return MinimalizedAut(A);
  elif IsPredicatonObj(A) then
    B:=Predicaton(MinimalAut(A!.aut), A!.var);
    B!.varnames:=A!.varnames;
    return B;
  else 
    Error("MinimalAut failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  IsRecognizedByAut(A, word)
##
##  Tests if a given word is recognized by the given Automaton or Predicaton.
##
InstallGlobalFunction( IsRecognizedByAut, function( A , word )
  if IsAutomatonObj(A) then
    return IsRecognizedByAutomaton( A, word );
  elif IsPredicatonObj(A) then
    return IsRecognizedByAutomaton( A!.aut, word );
  else
    Error("IsRecognizedByAut failed, the first argument must be an Automaton or a Predicaton and the second must be a word over the language\n");
  fi;
end);
####################################################################################################
##
#F  PredToRatExp
##
##  Returns the rational expression for the Predicaton (Automatons are also allowed)
##
InstallGlobalFunction( PredicatonToRatExp, function ( A )
  if IsAutomaton(A) then
    return AutToRatExp(A);
  elif IsPredicatonObj(A) then
    return AutToRatExp(A!.aut);
  else
    Error("PredToRatExp failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
##
#E
##
