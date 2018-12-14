####################################################################################################
##
##  This file installs functions acting on Predicata.
##
####################################################################################################
##
#F  AutomatonOfPredicaton(A)
##
##  Returns the Automaton.
##
InstallGlobalFunction(AutomatonOfPredicaton, function ( A ) 
  if IsPredicatonObj(A) then
    return CopyPredicaton(A!.aut);
  else
    Error("AutomatonOfPredicaton failed, the argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  VariablePositionListOfPredicaton(A)
##
##  Returns the variable position list.
##
InstallGlobalFunction(VariablePositionListOfPredicaton, function ( A ) 
  if IsPredicatonObj(A) then
    return ShallowCopy(A!.var);
  else
    Error("VariablePositionListOfPredicaton failed, the argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SetVariablePositionListOfPredicaton(A, V)
##
##  Sets the variable position list.
##
InstallGlobalFunction( SetVariablePositionListOfPredicaton, function ( A, l ) 
  local B, p, l1;
  if IsPredicatonObj(A) then
    if IsList(l) and ForAll(l, IsPosInt) and Length(A!.var) = Length(l) and Length(Unique(l)) = Length(l) then
      l1:=ShallowCopy(l);
      p:=SortingPerm(ShallowCopy(l));
      B:=AutOfPredicaton(A);
      B:=PermutedAlphabetPredicaton(B, l1);
      A!.aut:=AutOfPredicaton(B);
      A!.var:=VariablePositionListOfPredicaton(B);
      A!.varnames:=Permuted(ShallowCopy(A!.varnames), p);
    else
      Error("SetVariablePositionListOfPredicaton failed, the second argument must be a positive integer list of the same length as the variable position list.\n");
    fi;
  else
    Error("SetVariablePositionListOfPredicaton failed, the first argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  BaseOfPredicaton(A)
##
##  Returns the base of the Predicaton.
##
InstallGlobalFunction(BaseOfPredicaton, function ( A ) 
  if IsPredicatonObj(A) then
    return ShallowCopy(A!.base);
  else
    Error("BaseOfPredicaton failed, the argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  VariableListOfPredicaton(A)
##
##  Returns the variable names.
##
InstallGlobalFunction(VariableListOfPredicaton, function ( A ) 
  if IsPredicatonObj(A) then
    return ShallowCopy(A!.varnames);
  else
    Error("VariableListOfPredicaton failed, the argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SetVariableListOfPredicaton(A)
##
##  Sets the variable names.
##
InstallGlobalFunction( SetVariableListOfPredicaton, function ( A, V ) 
  if IsPredicatonObj(A) then
    if IsList(V) and ForAll(V, i->PredicataIsStringType(i, "variable")) and Length(A!.var) = Length(V) and Length(Unique(V)) = Length(V) then
      A!.varnames:=ShallowCopy(V);
    else
      Error("SetVariableListOfPredicaton failed, the second argument must be a string of the same length as the variable position list.\n");
    fi;
  else
    Error("SetVariableListOfPredicaton failed, the first argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  ProductLZeroPredicaton(A)
##
##  Creates the Predicaton with the language L*L_0:={xy : x in L and y in L_0}, 
##  where L is the language of the given Predicaton A and L_0:={w*: w =[0,...,0]}.
##
InstallGlobalFunction( ProductLZeroPredicaton, function ( A )
  local a, S, T, I, F, p, i;
  if not IsPredicaton(A) then
    Error("ProductLZeroPredicaton failed, the argument must be a Predicaton.\n");
  fi;
  S:=NumberStatesOfPredicaton(A)+1;
  a:=AlphabetOfPredicatonAsList(A);
  T:=TransitionMatrixOfPredicaton(A);
  I:=InitialStatesOfPredicaton(A);
  F:=FinalStatesOfPredicaton(A);
  p:=Position(a, ListWithIdenticalEntries(Length(a[1]), 0));
  if IsDeterministicPredicaton(A) then
    for i in [1..Length(T)] do
      Apply(T[i], s->[s]);
    od;
  fi;
  for i in F do
    Add(T[p][i], S);  # Adding in the row related to [0,...,0] the new state S for each final state.
  od;
  Add(T[p], [S]); # Adding the zero loop in the new state S
  Add(F, S);
  return Predicaton(Automaton("nondet", S, a, T, I, F), VariablePositionListOfPredicaton(A), BaseOfPredicaton(A));
end);
####################################################################################################
##
#F  RightQuotientLZeroPredicaton(A)
##
##  Creates the Predicaton with the language of the right quotient L/L_0:= {x : exists y in L_0 s.t. xy in L },
##  where L is the language of the given Predicaton A and L_0:={w*: w =[0,...,0]}.
##
InstallGlobalFunction( RightQuotientLZeroPredicaton, function ( A )
  local a, S, T, I, F, G, p, i;
  if not IsPredicaton(A) then
    Error("RightQuotientLZeroPredicaton failed, the argument must be a Predicaton.\n");
  fi;
  S:=NumberStatesOfPredicaton(A);
  a:=AlphabetOfPredicatonAsList(A);
  T:=TransitionMatrixOfPredicaton(A);
  I:=InitialStatesOfPredicaton(A);
  F:=FinalStatesOfPredicaton(A);
  p:=Position(a, ListWithIdenticalEntries(Length(a[1]),0));
  if IsDeterministicPredicaton(A) then
    for i in [1..Length(T)] do
      Apply(T[i],s->[s]);
    od;
  fi;
  G:=[];
  while not IsEqualSet(F,G) do
    G:=ShallowCopy(F);
    for i in [1..Length(T[p])] do
      if not Intersection(T[p][i],F) = [] and not i in F then # Checking if there is a zero transition from the non-final state i to any final state.
        Add(F,i);                                             # If yes, then add it to the final states
      fi;
    od;
  od;
  return Predicaton(Automaton("nondet", S, a, T, I, F), VariablePositionListOfPredicaton(A), BaseOfPredicaton(A));
end);
####################################################################################################
##
#F  NormalizedLeadingZeroPredicaton(A)
##
##  Creates the Predicaton with the language L*L_0 U L/L_0. This language contains the same words as the language of the given Predicaton, 
##  except either ignoring or adding leading zeros.
##
InstallGlobalFunction( NormalizedLeadingZeroPredicaton, function ( A )
  if IsPredicaton(A) then
    return UnionPredicata(ProductLZeroPredicaton(A), RightQuotientLZeroPredicaton(A));
  else
    Error("NormalizedLeadingZeroPredicaton failed, the argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  SortedAlphabetPredicaton(A)
##
##  Sorts the alphabet to be like the function PredicataAlphabet, also sorts the transition matrix.
##
InstallGlobalFunction( SortedAlphabetPredicaton, function ( A )
  local B, a, newa, T, newT, i;
  if not IsPredicaton(A) then
    Error("SortedAlphabetPredicaton failed, the argument must be a Predicaton.\n"); 
  fi;
  a:=AlphabetOfPredicatonAsList(A);
  newa:=PredicataAlphabet(Length(VariablePositionListOfPredicaton(A)),BaseOfPredicaton(A));
  if a = newa then
    return A;
  else
    T:=TransitionMatrixOfPredicaton(A);
    newT:=[];
    for i in [1..Length(newa)] do
      newT[i]:=T[Position(a, newa[i])];
    od;
    B:=Predicaton(Automaton(TypeOfPredicaton(A), NumberStatesOfPredicaton(A), newa, newT, InitialStatesOfPredicaton(A), FinalStatesOfPredicaton(A)), VariablePositionListOfPredicaton(A), BaseOfPredicaton(A));
    B!.varnames:=A!.varnames;
    return B;
  fi;
end);
####################################################################################################
##
#F  FormattedPredicaton(A)
##
##  Creates the Predicaton such that it allows leading zeros and is the minimal a DFA.
##
InstallGlobalFunction( FormattedPredicaton, function ( A )
  if IsPredicaton(A) then
    return MinimalPredicaton(NormalizedLeadingZeroPredicaton(A));
    #return SortedAlphabetPredicaton(MinimalPredicaton(NormalizedLeadingZeroPredicaton(A)));   #check how much slower
  else
    Error("FormattedPredicaton failed, the argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  IsValidInput( A, n)
##
##  Checks the input for the following functions.
##
InstallGlobalFunction( IsValidInput, function ( A, n )
  if not IsPredicaton(A) then
    Print("The first argument is not a Predicaton.\n");
    return false;
  elif not IsList(n) then
    Print("The new variable position list is not a list.\n");
    return false;
  elif Length(VariablePositionListOfPredicaton(A)) > Length(n) then
    Print("The new variable position list is smaller than the old one of the Predicaton. Compare ", VariablePositionListOfPredicaton(A), " with ", n, ".\n");
    return false;
  elif not IsSubsetSet(n, VariablePositionListOfPredicaton(A)) then
    Print("The new variable position list must contain the old one of the Predicaton. Compare ", VariablePositionListOfPredicaton(A), " with ", n, ".\n");
    return false;
  else
    return true;
  fi;
end);
####################################################################################################
## 
##  Auxilary function for ExpandPred
##  Expands the alphabet of the Predicaton A at the position p, i.e. 
##  it doubles the alphabet by adding 0 at position p (regarding it's
##  position to the variable position list) at the first half and 1 at
##  position p to the second half. The transition matrix is doubled.
##
BindGlobal( "ExpandPredOneStep", function ( A, p ) 
  local T, a, b, i, j, k, l, pos;
  if not IsPredicaton(A) or not IsInt(p) then
    Error("ExpandPredOneStep failed, the arguments must be a Predicaton and a positive integer.\n");
  elif p in VariablePositionListOfPredicaton(A) then
    return A;
  else
    k:=BaseOfPredicaton(A);
    b:=List([1..k],i->AlphabetOfPredicatonAsList(A));
    l:=VariablePositionListOfPredicaton(A);
    Add(l,p);  # add p to variable position list
    Sort(l);
    pos:=Position(l,p);
    for i in [1..AlphabetOfPredicaton(A)] do
      for j in [0..k-1] do
        Add(b[j+1][i], j, pos);  # adding j corresponding to the position of pos
      od;
    od;
    a:=Concatenation(b); # Concatenating b.
    T:=Concatenation(List([1..k],i->TransitionMatrixOfPredicaton(A)));  # duplicate the transition matrix k-times
    return Predicaton(Automaton(TypeOfPredicaton(A), NumberStatesOfPredicaton(A), a, T, InitialStatesOfPredicaton(A), FinalStatesOfPredicaton(A)), l, k);
  fi;
end);
BindGlobal( "ExpandPredOneStepOLD", function ( A, p ) 
  local T, a, b, l, i, pos;
  if not IsPredicaton(A) or not IsInt(p) then
    Error("ExpandPredOneStep failed, the arguments must be a Predicaton and a positive integer.\n");
  elif p in VariablePositionListOfPredicaton(A) then
    return A;
  else
    a:=AlphabetOfPredicatonAsList(A);
    b:=AlphabetOfPredicatonAsList(A);
    l:=VariablePositionListOfPredicaton(A);
    Add(l,p);  # add p to variable position list
    Sort(l);
    pos:=Position(l,p);
    for i in [1..AlphabetOfPredicaton(A)] do
      Add(a[i], 0, pos);  # add 0 corresponding to the position of p
      Add(b[i], 1, pos);  # add 1 corresponding to the position of p
    od;
    Append(a, b);
    T:=Concatenation(TransitionMatrixOfPredicaton(A), TransitionMatrixOfPredicaton(A));  # duplicate the transition matrix
    return Predicaton(Automaton(TypeOfPredicaton(A), NumberStatesOfPredicaton(A), a, T, InitialStatesOfPredicaton(A), FinalStatesOfPredicaton(A)), l);
  fi;
end);
####################################################################################################
##
#F  ExpandedPredicaton(A, n)
##
##  Expands the alphabet size to base k^|n| regarding comparing the variable
##  position list and copying the transition matrix corresponding to the entries
##
##  For calling a Predicaton the first time, use PredicatonFromAut, where the variable
##  position list order matters.
##
InstallGlobalFunction( ExpandedPredicaton, function ( A, n )
  local B, l, i;
  if not IsPredicaton(A) or not IsValidInput(A, n) then
    Error("ExpandedPredicaton failed, the arguments must be a Predicaton and a new variable position list.\n");
  fi;
  l:=VariablePositionListOfPredicaton(A);
  B:=CopyPredicaton(A);
  Sort(n);
  for i in n do
    B:=ExpandPredOneStep(B, i);
  od;
  return B;
  # return FormattedPredicaton(B); # check if so much slower with it.
end);
####################################################################################################
##
#F  ProjectedPredicaton(A, p)
##
##  Deletes in the alphabet of the Predicaton the p-th position, i.e.
##  projects it down from {0,...,k-1}^n to {0,...,k-1}^n-1 
##  The corresponding transition matrix rows are combined (NFA).
##
##  Existence quantifier!
##
InstallGlobalFunction( ProjectedPredicaton, function ( A, p )
  local B, T, a, l, i, length, pos, q;
  if not IsPredicaton(A) or not p in VariablePositionListOfPredicaton(A) then
    Error("ProjectedPredicaton failed, the arguments must be a Predicaton and positive integer in the variable position list.\n");
  fi;
  l:=VariablePositionListOfPredicaton(A);
  Sort(l);
  length:=AlphabetOfPredicaton(A);
  a:=AlphabetOfPredicatonAsList(A);
  q:=NumberStatesOfPredicaton(A);
  pos:=Position(l, p);
  for i in [1..length] do
    Remove(a[i],pos);   # remove p-th position of the alphabet.
  od;
  T:=TransitionMatrixOfPredicaton(A);
  i:=1;
  while i <= length do
    pos:= Positions(a,a[i]);  # checks for the same letter, which occurce more than once due to removal of the p-th position
    if Length(pos) > 1 then
      a:=a{Difference([1..Length(a)],pos{[2..Length(pos)]})}; #removing duplicate letters, keep the first of pos.
      T[pos[1]]:=List([1..q],r->List([1..Length(pos)],s->T[pos[s]][r])); # s runs through all positions, r runs through all states, collecting entries for the NFA.
      T:=T{Difference([1..Length(T)],pos{[2..Length(pos)]})}; #removing transitions that have been added into the NFA transitions at pos[1].
    fi;
    i:=i+1;
    length:=Length(a);
  od;
  Remove(l, Position(l, p));  # removes the variable position p from the variable position list.
  Sort(l);
  Print("a:", a,"\n");
  Print("T:", T,"\n");
  return FormattedPredicaton(Predicaton(Automaton("nondet", NumberStatesOfPredicaton(A), a, T, InitialStatesOfPredicaton(A), FinalStatesOfPredicaton(A)), l, BaseOfPredicaton(A)));
end);



BindGlobal( "ProjectedPredCombinedList", function ( l1, l2 )
  local l, m, i;
  if not IsList(l1) or not IsList(l2) then
    Error("CombineList failed, the arguments must be both a list.\n");
  fi;
  m:= Length(l1);
  l:=[];
  for i in [1..m] do
    l[i]:=Flat([l1[i], l2[i]]);
  od;
  return l;
end);
BindGlobal( "ProjectedPredicaton2", function ( A, p )
  local B, T, a, l, i, length, pos;
  if not IsPredicaton(A) or not p in VariablePositionListOfPredicaton(A) then
    Error("ProjectedPredicaton failed, the arguments must be a Predicaton and positive integer in the variable position list.\n");
  fi;
  l:=VariablePositionListOfPredicaton(A);
  Sort(l);
  length:=AlphabetOfPredicaton(A);
  a:=AlphabetOfPredicatonAsList(A);
  pos:=Position(l, p);
  for i in [1..length] do
    Remove(a[i],pos);   # remove p-th position of the alphabet.
  od;
  T:=TransitionMatrixOfPredicaton(A);
  i:=1;
  while i <= length do
    pos:= Positions(a,a[i]);  # checks for the same letter, which occurce twice due to removal of the p-th position
    if Length(pos) > 1 then
      Remove(a, pos[2]);  # removes duplicate letter
      T[i]:=ProjectedPredCombinedList(T[pos[1]], T[pos[2]]); # combines the transition matrix entries of the same letter
      Remove(T, pos[2]);  # removes the transition matrix row which was added to the first one.
    fi;
    i:=i+1;
    length:=Length(a);
  od;
  Remove(l, Position(l, p));  # removes the variable position p from the variable position list.
  Sort(l);
  return FormattedPredicaton(Predicaton(Automaton("nondet", NumberStatesOfPredicaton(A), a, T, InitialStatesOfPredicaton(A), FinalStatesOfPredicaton(A)),l));
end);
####################################################################################################
##
#F  NegatedProjectedNegatedPredicaton(A, p)
##
##  Negate, project, negate with NormalizedLeadingZeroPredicaton inbetween,
##  due to leading zeros
##
##  Forall quantifier!
## 
InstallGlobalFunction( NegatedProjectedNegatedPredicaton, function ( A, p )
  if IsPredicaton(A) and p in VariablePositionListOfPredicaton(A) then
    return FormattedPredicaton(NegatedPredicaton(FormattedPredicaton(ProjectedPredicaton(NegatedPredicaton(FormattedPredicaton(A)),p))));
  else
    Error("NegatedProjectedNegatedPredicaton failed, the arguments must be a Predicaton and positive integer in the variable position list.\n");
  fi;
end);
####################################################################################################
##
#F  PermutedAlphabetPredicaton(A, l[, base])
##
##  Returns the Predicaton with the permuted alphabet.
##  Relevant for the first call of an specific Predicaton, especially 
##  for the call of the corresponding Automaton, where the variable order
##  matters.
##  E.g.: Automaton A is 6*x=y. Then the first position must be the 
##  corresponding to x and the second to y. If the variable position value
##  of x is smaller than y everything is fine, but else one have to swap for
##  each alphabet letter the position of x and y while leaving the transition
##  matrix unchanged.
##
InstallGlobalFunction( PermutedAlphabetPredicaton, function ( A, l, args... )
  local a, newa, p, i, k;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  if not IsAutomaton(A) or not IsList(l) or not ForAll(l, i->IsPosInt(i)) then
    Error("PermutedAlphabetPredicaton failed, the first argument must be a Automaton and the second argument must be a list containing positive integers.\n");
  fi;
  p:=SortingPerm(l);              # Sorts the list and returns a list that can be applied to a permutation
  if p = () then
    return Predicaton(A, l, k);       # nothing to do here, everything in correct order.
  else
    a:=AlphabetOfPredicatonAsList(A);
    newa:=StructuralCopy(a);
    for i in [1..Length(a)] do
      newa[i]:=Permuted(a[i], p); # permute the positions in the list of the i-th letter according to SortingPerm(l)
    od;
    Sort(l);
    return Predicaton(Automaton(TypeOfPredicaton(A), NumberStatesOfPredicaton(A), newa, TransitionMatrixOfPredicaton(A), InitialStatesOfPredicaton(A), FinalStatesOfPredicaton(A)), l, k);
  fi;
end);
####################################################################################################
##
#F  PredicatonFromAut(A, l, n[, base])
##
##  Returns the permuted and expanded Predicaton A.
##
##  Use this for calling a Predicaton the first time, where variable position
##  list order matters, see PermutedAlphabetPred.
##
InstallGlobalFunction( PredicatonFromAut, function ( A, l, n, args...)
  local B, k;
  if not IsAutomaton(A) or not ForAll(n, i -> IsPosInt(i)) or not IsSubsetSet(n, l) then
    Error("PredicatonFromAut failed, the first argument must be a Automaton and the second and third argument must be a list containing positive integers.\n");
  fi;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  B:=PermutedAlphabetPredicaton(A, l, k);
  return ExpandedPredicaton(B, n);
end);
##
#E
##
