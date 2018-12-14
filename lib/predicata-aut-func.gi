####################################################################################################
##
##  This file installs new function names for implemented functions of the automata package,
##  in order to call the functions with Automata or Predicata.
##
####################################################################################################
##
#F  IsDeterministicPredicaton(A)
##
##  Tests if A is a deterministic Automaton or Predicaton.
##
InstallGlobalFunction( IsDeterministicPredicaton, function ( A )
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
#F  IsNonDeterministicPredicaton(A)
##
##  Tests if A is a non deterministic Automaton or Predicaton.
##
InstallGlobalFunction( IsNonDeterministicPredicaton, function ( A )
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
#F  TypeOfPredicaton(A)
##
##  Returns the type.
##
InstallGlobalFunction( TypeOfPredicaton, function ( A )
  if IsAutomatonObj(A) then
    return ShallowCopy(A!.type);
  elif IsPredicatonObj(A) then
    return ShallowCopy(A!.aut!.type);
  else 
    Error("TypeOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  AlphabetOfPredicaton(A)
##
##  Returns the number of letters in the alphabet.
##
InstallGlobalFunction( AlphabetOfPredicaton, function( A )
  if IsAutomatonObj(A) then
    return StructuralCopy(A!.alphabet);
  elif IsPredicatonObj(A) then
    return StructuralCopy(A!.aut!.alphabet); 
  else 
    Error("AlphabetOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  AlphabetOfPredicatonAsList(A)
##
##  Returns the alphabet as list.
##
InstallGlobalFunction( AlphabetOfPredicatonAsList, function( A )
  if IsAutomatonObj(A) then
    return StructuralCopy(FamilyObj(A)!.alphabet);
  elif IsPredicatonObj(A) then
    return StructuralCopy(FamilyObj(A!.aut)!.alphabet); 
  else 
    Error("AlphabetOfPredicatonAsList failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  NumberStatesOfPredicaton(A)
##
##  Returns the number of states.
##
InstallGlobalFunction( NumberStatesOfPredicaton, function( A )
  if IsAutomatonObj(A) then
    return A!.states ;
  elif IsPredicatonObj(A) then
    return A!.aut!.states ;
  else
    Error("NumberStatesOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SortedStatesPredicaton(A)
##
##  Returns the Automaton or the Predicaton with sorted states,
##  such that the intial states have the lowest and the final states the highest number.
##
InstallGlobalFunction( SortedStatesPredicaton, function( A )
  local B; 
  if IsAutomatonObj(A) then
    return NormalizedAutomaton(A);
  elif IsPredicatonObj(A) then
    B:=Predicaton(NormalizedAutomaton(A!.aut), A!.var, BaseOfPredicaton(A));
    B!.varnames:=A!.varnames;
    return B;
  else
    Error("SortedStatesPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  TransitionMatrixOfPredicaton(A)
##
##  Returns the transition matrix.
##
InstallGlobalFunction( TransitionMatrixOfPredicaton, function( A )
  if IsAutomatonObj(A) then
    return StructuralCopy(A!.transitions);
  elif IsPredicatonObj(A) then
    return StructuralCopy(A!.aut!.transitions); 
  else 
    Error("TransitionMatrixOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  InitialStatesOfPredicaton(A)
##
##  Returns the initial states.
##
InstallGlobalFunction( InitialStatesOfPredicaton, function( A )
  if IsAutomatonObj(A) then
    return ShallowCopy(A!.initial);
  elif IsPredicatonObj(A) then
    return ShallowCopy(A!.aut!.initial); 
  else 
    Error("InitialStatesOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SetInitialStatesOfPredicaton(A)
##
##  Sets the initial states.
##
InstallGlobalFunction( SetInitialStatesOfPredicaton, function( A, I )
  if IsAutomatonObj(A) then
    SetInitialStatesOfAutomaton(A, I);
  elif IsPredicatonObj(A) then
    SetInitialStatesOfAutomaton(A!.aut, I);
  else
    Error("SetInitialStatesOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  FinalStatesOfPredicaton(A)
##
##  Returns the final states.
##
InstallGlobalFunction(FinalStatesOfPredicaton, function( A )
  if IsAutomatonObj(A) then
    return ShallowCopy(A!.accepting);
  elif IsPredicatonObj(A) then
    return ShallowCopy(A!.aut!.accepting); 
  else 
    Error("FinalStatesOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SetFinalStatesOfPredicaton(A)
##
##  Sets the final states.
##
InstallGlobalFunction( SetFinalStatesOfPredicaton, function( A, F )
  if IsAutomatonObj(A) then
    SetFinalStatesOfAutomaton(A, F);
  elif IsPredicatonObj(A) then
    SetFinalStatesOfAutomaton(A!.aut, F);
  else
    Error("SetFinalStatesOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SinkStatesOfPredicaton(A)
##
##  Returns the sink states.
##
InstallGlobalFunction(SinkStatesOfPredicaton, function( A )
  if IsAutomatonObj(A) then
    return ShallowCopy(ListSinkStatesAut(A));
  elif IsPredicatonObj(A) then
    return ShallowCopy(ListSinkStatesAut(A!.aut)); 
  else 
    Error("FinalStatesOfPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  CopyPredicaton(A)
##
##  Returns a copy.
##
InstallGlobalFunction( CopyPredicaton, function ( A )
  local B;
  if IsAutomaton(A) then
    return Automaton(TypeOfPredicaton(A), NumberStatesOfPredicaton(A), AlphabetOfPredicatonAsList(A), TransitionMatrixOfPredicaton(A), 
                      InitialStatesOfPredicaton(A), FinalStatesOfPredicaton(A));
  elif IsPredicatonObj(A) then
    B:=Predicaton(Automaton(TypeOfPredicaton(A!.aut), NumberStatesOfPredicaton(A!.aut), AlphabetOfPredicatonAsList(A!.aut), TransitionMatrixOfPredicaton(A!.aut), 
                         InitialStatesOfPredicaton(A!.aut), FinalStatesOfPredicaton(A!.aut)), ShallowCopy(A!.var), ShallowCopy(A!.base));
    B!.varnames:=ShallowCopy(A!.varnames);
    return B;
  else
    Error("CopyPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  PermutedStatesPredicaton(A)
##
##  Returns the permuted states Automaton.
##
InstallGlobalFunction( PermutedStatesPredicaton, function ( A, p )
  local B;
  if IsAutomaton(A) and IsEqualSet([1..NumberStatesOfPredicaton(A)], p) then
    return PermutedAutomaton(A, p);
  elif IsPredicatonObj(A) and IsEqualSet([1..NumberStatesOfPredicaton(A)], p) then
    B:=Predicaton(PermutedAutomaton(A!.aut, p), A!.var, BaseOfPredicaton(A));
    B!.varnames:=A!.varnames;
    return B;
  else
    Error("PermutedStatesPredicaton failed, the first argument must be an Automaton or a Predicaton, the second must be a list which is equal to the set containing all states.\n");
  fi;
end);
####################################################################################################
##
#F  NegatedPredicaton(A)
##
##  Negates the Automaton swapping the final states to non-final and vice-versa.
##
InstallGlobalFunction( NegatedPredicaton , function ( A )
  local B, S;
  if IsAutomaton(A) or IsPredicaton(A) then
    B:=CopyPredicaton(A);
    S:=[1..NumberStatesOfPredicaton(B)];
    SubtractSet(S,FinalStatesOfPredicaton(B));
    Sort(S);
    SetFinalStatesOfPredicaton(B, S);
    return B;
  else
    Error("NegatedPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  IntersectionPredicaton(A, B,[ n])
##
##  Returns the intersection of two Automata or Predicata.
##  Intersects two Predicatons A and B after resizing them to the same
##  variable positions and sorting the alphabet list to be in the same order.
## 
InstallGlobalFunction( IntersectionPredicata, function ( A, B, args... )
  local A1, B1, C, n, n1;
  if IsAutomaton(A) and IsAutomaton(B) then
    return IntersectionAutomaton(A,B);
  elif IsPredicatonObj(A) and IsPredicatonObj(B) then
    if BaseOfPredicaton(A) <> BaseOfPredicaton(B) then
      Error("IntersectionPredicata failed, please do not intersect two Predicata with a different base.\n");
    fi;
    n1:=Union(VariablePositionListOfPredicaton(A), VariablePositionListOfPredicaton(B)); # working only with the neccessary variable positions
    if Length(args) = 0 then
      n:=n1;
    elif Length(args) = 1 and IsList(args[1]) and IsValidInput(A, args[1]) and IsValidInput(B, args[1]) then
      n:=args[1];
    else
      Error("IntersectionPredicata failed, the optional argument must be a list of integers.\n");
    fi;
    A1:=ExpandedPredicaton(A, n1);                  # expands to the equal variable position list
    B1:=ExpandedPredicaton(B, n1);                  # sorting the alphabet list should happen in ExpandedPred
    if AlphabetOfPredicatonAsList(A1) <> AlphabetOfPredicatonAsList(B1) then
      A1:=SortedAlphabetPredicaton(A1);             # if not do it here.
      B1:=SortedAlphabetPredicaton(B1);             # and here
    fi;
    C:=IntersectionAutomaton(A1!.aut, B1!.aut);     # Calls IntersectionAutomaton on the automatons of the Predicata
    return ExpandedPredicaton(MinimalPredicaton(Predicaton(C, A1!.var, BaseOfPredicaton(A))),n);    # format it and expand it
  else 
    Error("IntersectionPredicata failed, the arguments must be both either Automaton or Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  UnionPredicata(A, B,[ n])
##
##  Returns the union of two Automata or Predicata.
##  Unites two Predicata A and B after resizing them to the same
##  variable positions and sorting the alphabet list to be in the same order.
## 
InstallGlobalFunction( UnionPredicata, function ( A, B, args... )
  local A1, B1, C, n, n1;
  if IsAutomaton(A) and IsAutomaton(B) then
    return UnionAutomata(A,B);
  elif IsPredicatonObj(A) and IsPredicatonObj(B) then
    if BaseOfPredicaton(A) <> BaseOfPredicaton(B) then
      Error("IntersectionPredicata failed, please do not unite two Predicata with a different base.\n");
    fi;
    n1:=Union(VariablePositionListOfPredicaton(A), VariablePositionListOfPredicaton(B)); # working only with the neccessary variable positions
    if Length(args) = 0 then
      n:=n1;
    elif Length(args) = 1 and IsList(args[1]) and IsValidInput(A, args[1]) and IsValidInput(B, args[1]) then
      n:=args[1];
    else
      Error("UnionPredicata failed, the optional argument must be a list of integers.\n");
    fi;
    A1:=ExpandedPredicaton(A, n1);                  # expands to the equal variable position list
    B1:=ExpandedPredicaton(B, n1);                  # sorting the alphabet list should happen in ExpandedPred
    if AlphabetOfPredicatonAsList(A1) <> AlphabetOfPredicatonAsList(B1) then
      A1:=SortedAlphabetPredicaton(A1);             # if not do it here.
      B1:=SortedAlphabetPredicaton(B1);             #
    fi;
    C:=UnionAutomata(A1!.aut, B1!.aut);             # Calls UnionAutomata on the automatons of the Predicata
    return ExpandedPredicaton(MinimalPredicaton(Predicaton(C, A1!.var, BaseOfPredicaton(A))),n);    # format it and expand it
  else 
    Error("UnionPredicata failed, the arguments must be both either Automaton or Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F   MinimalPredicaton(A)
##
##  Returns the minimal Automaton or minimal Predicaton, i.e. the minimal DFA.
##
InstallGlobalFunction( MinimalPredicaton, function ( A )
  local B;
  if IsAutomaton(A) then
    return MinimalizedAut(A);
  elif IsPredicatonObj(A) then
    B:=Predicaton(MinimalizedAut(A!.aut), A!.var,BaseOfPredicaton(A));
    B!.varnames:=A!.varnames;
    return B;
  else 
    Error("MinimalPredicaton failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  IsRecognizedByPredicaton(A, word)
##
##  Tests if a given word is recognized by the given Automaton or Predicaton.
##
InstallGlobalFunction( IsRecognizedByPredicaton, function( A , word )
  if IsAutomatonObj(A) then
    return IsRecognizedByAutomaton( A, word );
  elif IsPredicatonObj(A) then
    return IsRecognizedByAutomaton( A!.aut, word );
  else
    Error("IsRecognizedByPredicaton failed, the first argument must be an Automaton or a Predicaton and the second must be a word over the language\n");
  fi;
end);
####################################################################################################
##
#F  PredicatonToRatExp
##
##  Returns the rational expression for the Predicaton (Automatons are also allowed)
##
InstallGlobalFunction( PredicatonToRatExp, function ( A )
  if IsAutomaton(A) then
    return AutToRatExp(A);
  elif IsPredicatonObj(A) then
    return AutToRatExp(A!.aut);
  else
    Error("PredicatonToRatExp failed, the argument must be an Automaton or a Predicaton.\n");
  fi;
end);
##
#E
##
