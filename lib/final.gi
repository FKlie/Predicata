####################################################################################################
##
##  This file installs the functions, which convert a string or a PredicataFormula into Predicaton.
##
####################################################################################################
##
#F  PredicataGrammar()
##
##  Returns the accepted grammar as string.
##
InstallGlobalFunction( PredicataGrammar, function ()
  local S;
  S:=Concatenation(
  "\nThe accepted grammar is defined as follows:\n\n",
  "  <formula>   ::= ( <formula> )\n",
  "                | ( <quantifier> <var> : <formula> )\n",
  "                | <formula> <logicconnective> <formula>\n",
  "                | not <formula>\n",
  "                | <term> = <term>\n",
  "                | <var> <compare> <var>\n",
  "                | <var> <compare> <int>\n",
  "                | <int> <compare> <var>\n",
  "                | <predicate> [ <varlist> ]\n",
  "                | <predicate>\n",
  "                | <boolean>\n\n",
  "  <term>      ::= ( <term> )\n",
  "                | <term> + <term>\n",
  "                | <int> * <var>\n",
  "                | ( - <int> ) * <var>\n",
  "                | <var>\n",
  "                | <int>\n\n",
  "  <varlist>   ::= <var> , <varlist> | <var>\n\n",
  "  <quantifier>::= A | E\n\n",
  "  <logicconnective>::= and | or | implies | equiv \n\n",
  "  <compare>   ::= < | <= | => | > | less | leq | geq | gr\n\n",
  "  <var>       ::= a | b | c | ... | x | y | z | a1 | ... | z1 | ... \n\n",
  "  <int>       ::= 0 | 1 | 2 | 3 | 4 | ... \n\n",
  "  <boolean>   ::= true | false \n\n",
  "  <predicate> ::= P | Predicate1 | ... ; any name that isn't used above\n");
  Print(S);
end);
####################################################################################################
##
#F  PredicataPredefinedPredicates()
##
##  Returns the predefined predicates as string.
##
InstallGlobalFunction( PredicataPredefinedPredicates, function ()
  local S;
  S:=Concatenation(
  "Predefined predicates:\n",
  "  * Buechi[x,y]: V_2(x)=y, where the function V_2(x) returns the highest power of 2 dividing x.\n", 
  "  * Power[x]   : V_2(x)=x\n");
  Print(S);
end);
####################################################################################################
##
#F  PredicataFormulaToPredicaton(f, V)
##
##  Converts a PredicataFormula to a Predicaton
##
##  Calls literally everything.
##
InstallGlobalFunction( PredicataFormulaToPredicaton, function (f, args...)
  local V, F, T, A, B, r;
  if Length(args) = 0 then
    V:=[];
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("PredicataFormulaToPredicaton failed, wrong optional input.\n");
  fi;
  if not IsPredicataFormula(f) then
    Error("PredicataFormulaToPredicaton failed, the first argument must be a PredicataFormula.\n");
  fi;
  F:=PredicataFormulaFormatted(f);
  if F = fail then
    return fail;
  fi;
  T:=PredicataFormulaFormattedToTree(F);
  if T = fail then
    return fail;
  fi;
  A:=PredicataTreeToPredicaton(T, V);
  if A = fail then
    return fail;
  fi;
  if IsList(A) and Length(A) = 2 and A[1] = "Pred" and IsPredicaton(A[2]) then
    B:=SortedStatesAut(FormattedPredicaton(A[2]));
    SetVariableListOfPredicaton(B, VariableListOfPredicaton(A[2]));
    Display(B);
    if NumberStatesOfAut(B) < 20 then
      r:=PredicatonToRatExp(B);
      if Length(String(r)) <= 200 then
        Print("\n Regular expression of the Automaton:\n   ", r, "\n");
      fi;
    fi;
    if VariablePositionListOfPredicaton(B) = [] and AlphabetOfAut(B) = 1 and NumberStatesOfAut(B) = 1 then
      if Length(FinalStatesOfAut(B)) = 1 then
        Print("\n Due to the Automaton/regular expression the formula is true.\n   true\n");
      else
        Print("\n Due to the Automaton/regular expression the formula is false.\n   false\n");
      fi;
    fi;
    return B; 
  else
    Error("\n Evaluate formula failed: the output is of type: ", A," and not of type Predicaton. Please check your input.\n");
  fi;
end);
####################################################################################################
##
#F  StringToPredicaton(F, V)
##
##  Converts a String to a Predicaton, doesn't allow own predicates.
##
##  Calls PredicataFormulaToPredicaton.
##
InstallGlobalFunction( StringToPredicaton, function (f, args...)
  local F, V;
  if Length(args) = 0 then
    V:=[];
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("StringToPredicaton failed, wrong optional input.\n");
  fi;
  if IsString(f) then
    F:=PredicataFormula(f);
    if F = fail then 
      return fail;
    else
      return PredicataFormulaToPredicaton(F, V);
    fi;
  else
    Error("StringToPredicaton failed, the first argument must be a string.\n");
  fi;
end);
####################################################################################################
##
#M  Predicaton(F)
##
##  Overloads the function Predicaton with PredicataFormula.
##
InstallOtherMethod( Predicaton,
               "creates the Predicaton of a PredicataFormula with a variable list", 
                true, 
                [IsPredicataFormulaObj and IsPredicataFormulaRep], 
                0, 
                function( F )
  return PredicataFormulaToPredicaton(F, []);
end);
####################################################################################################
##
#M  Predicaton(F, V)
##
##  Overloads the function Predicaton with PredicataFormula and variable list.
##
InstallOtherMethod( Predicaton,
               "creates the Predicaton of a PredicataFormula", 
                true, 
                [IsPredicataFormulaObj and IsPredicataFormulaRep, IsList], 
                0, 
                function( F, V )
  return PredicataFormulaToPredicaton(F, V);
end);
####################################################################################################
##
#M  Predicaton(S)
##
##  Overloads the function Predicaton with String.
##
InstallOtherMethod( Predicaton,
               "creates the Predicaton of a string", 
                true, 
                [IsString], 
                0, 
                function( S )
  return StringToPredicaton(S, []);
end);
####################################################################################################
##
#M  Predicaton(S, V)
##
##  Overloads the function Predicaton with String and variable list a variable list.
##
InstallOtherMethod( Predicaton,
               "creates the Predicaton of a string and a variable list", 
                true, 
                [IsString, IsList], 
                0, 
                function( S, V )
  return StringToPredicaton(S, V);
end);
####################################################################################################
##
#F  VariableAdjustedPredicaton(P, V)
##
##  Adjusts the Predicaton to match the variables in a different order, sorts the alphabet, 
##  for example for the current VariableListOfPredicaton(P)=["x", "y"] and V:=["y","x"],
##  letters are swapped, and the transition matrix rows are moved accordingly
##  Compare with SetVariablePositionList(P, l) or PermutedPred 
##  Note that SetVariableList(P, V) is just a simple renaming.
##
InstallGlobalFunction( VariableAdjustedPredicaton, function (P, V)
  local Q, i, L, l, n, p, v;
  l:=VariablePositionListOfPredicaton(P);
  v:=VariableListOfPredicaton(P);
  L:=[];
  if Length(l) <> Length(v) then
    Print("Please specify the variable names with SetVariableListOfPred of the Predicaton.\n");
    return fail;
  elif not IsEqualSet(Unique(V), v) then
    Print("Please specify your variable list with all the used variables in the Predicaton.\n");
    return fail;
  elif Length(Unique(V))<> Length(V) then 
    Print("Please specify the variable names uniquely.\n");
    return fail;
  fi;
  n:=[1..Length(V)];
  for i in n do
    p:=Position(v, V[i]);
    if p <> fail then
      L[p]:=i;
    fi;
  od;
  L:=Compacted(L);
  Q:=PredicatonFromAut(AutOfPredicaton(P), L, n);
  SetVariableListOfPredicaton(Q, V);
  return Q;
end);
####################################################################################################
##
#F  VariableAdjustedPredicata(P1, P2, V)
##
##  Adjusts the Predicata to match with the variable names, same as VariableAdjustedPred
##  just with two Predicata at the same time.
##
InstallGlobalFunction( VariableAdjustedPredicata, function (P1, P2, V)
  local P, Q1, Q2, i, L1, L2, l1, l2, n, p, v1, v2;
  l1:=VariablePositionListOfPredicaton(P1);
  v1:=VariableListOfPredicaton(P1);
  L1:=[];
  l2:=VariablePositionListOfPredicaton(P2);
  v2:=VariableListOfPredicaton(P2);
  L2:=[];
  if Length(l1) <> Length(v1) then
    Print("Please specify the variable names with SetVariableListOfPred of the first Predicata.\n");
    return fail;
  elif Length(l2) <> Length(v2) then
    Print("Please specify the variable names with SetVariableListOfPred of the second Predicata.\n");
    return fail;
  elif not IsEqualSet(Unique(V), Union(v1, v2)) then
    Print("Please specify your variable list with all the used variables in the two Predicata.\n");
    return fail;
  elif Length(Unique(V))<> Length(V) then 
    Print("Please specify the variable names uniquely.\n");
    return fail;
  fi;
  n:=[1..Length(V)];
  for i in n do
    p:=Position(v1, V[i]);
    if p <> fail then
      L1[p]:=i;
    fi;
    p:=Position(v2, V[i]);
    if p <> fail then
      L2[p]:=i;
    fi;
  od;
  L1:=Compacted(L1);
  L2:=Compacted(L2);
  Q1:=PredicatonFromAut(AutOfPredicaton(P1), L1, n);
  Q2:=PredicatonFromAut(AutOfPredicaton(P2), L2, n);
  SetVariableListOfPredicaton(Q1, V);
  SetVariableListOfPredicaton(Q2, V);
  return [Q1, Q2, n];
end);
####################################################################################################
##
#F  AndPredicata(P1, P2, V)
##
##  Creates the intersection of two Predicata regarding the variables names!
##
InstallGlobalFunction( AndPredicata, function (P1, P2, args...)
  local P, V;
  if not (IsPredicaton(P1) and IsPredicaton(P2)) then
    Error("AndPredicata failed, the first and the second argument must be Predicata.\n");
  fi;
  if Length(args) = 0 then
    V:=Union(VariableListOfPredicaton(P1), VariableListOfPredicaton(P2));
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("AndPredicata failed, the optional input must be a list with variable strings.\n");
  fi;
  P:=VariableAdjustedPredicata(P1, P2, V);
  if P = fail then 
    return fail;
  fi;
  P:=SortedStatesAut(IntersectionPredicata(P[1], P[2], P[3])); 
  SetVariableListOfPredicaton(P, V);
  return P;
end);
####################################################################################################
##
#F  OrPredicata(P1, P2, V)
##
##  Creates the union of two Predicata regarding the variables names!
##
InstallGlobalFunction( OrPredicata, function (P1, P2, args...)
  local P, V;
  if not (IsPredicaton(P1) and IsPredicaton(P2)) then
    Error("OrPredicata failed, the first and the second argument must be Predicata.\n");
  fi;
  if Length(args) = 0 then
    V:=Union(VariableListOfPredicaton(P1), VariableListOfPredicaton(P2));
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("OrPredicata failed, the optional input must be a list with variable strings.\n");
  fi;
  P:=VariableAdjustedPredicata(P1, P2, V);
  if P = fail then 
    return fail;
  fi;
  P:=SortedStatesAut(UnionPredicata(P[1], P[2], P[3]));
  SetVariableListOfPredicaton(P, V);
  return P;
end);
####################################################################################################
##
#F  NotPredicaton(P1, V)
##
##  Creates the negation of one Predicaton regarding the variables names!
##
InstallGlobalFunction( NotPredicaton, function (P, args...)
  local Q, V;
  if not IsPredicaton(P) then
    Error("NotPredicata failed, the first argument must be a Predicaton.\n");
  fi;
  if Length(args) = 0 then
    V:=VariableListOfPredicaton(P);
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("NotPredicaton failed, the optional input must be a list with variable strings.\n");
  fi;
  Q:=VariableAdjustedPredicaton(P, V);
  if P = fail then 
    return fail;
  fi;
  Q:=SortedStatesAut(NegatedAut(Q));
  SetVariableListOfPredicaton(Q, V);
  return Q;
end);
####################################################################################################
##
#F  ImpliesPredicata(P1, P2, V)
##
##  Creates the implication of two Predicata regarding the variables names!
##
InstallGlobalFunction( ImpliesPredicata, function (P1, P2, args...)
  local P, V;
  if not (IsPredicaton(P1) and IsPredicaton(P2)) then
    Error("ImpliesPredicata failed, the first and the second argument must be Predicata.\n");
  fi;
  if Length(args) = 0 then
    V:=Union(VariableListOfPredicaton(P1), VariableListOfPredicaton(P2));
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("ImpliesPredicata failed, the optional input must be a list with variable strings.\n");
  fi;
  P:=VariableAdjustedPredicata(P1, P2, V);
  if P = fail then 
    return fail;
  fi;
  P:=SortedStatesAut(UnionPredicata(NegatedAut(P[1]), P[2], P[3]));
  SetVariableListOfPredicaton(P, V);
  return P;
end);
####################################################################################################
##
#F  EquivalentPredicata(P1, P2, V)
##
##  Creates the implication of two Predicata regarding the variables names!
##
InstallGlobalFunction( EquivalentPredicata, function (P1, P2, args...)
  local P, V;
  if not (IsPredicaton(P1) and IsPredicaton(P2)) then
    Error("EquivalentPredicata failed, the first and the second argument must be Predicata.\n");
  fi;
  if Length(args) = 0 then
    V:=Union(VariableListOfPredicaton(P1), VariableListOfPredicaton(P2));
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("EquivalentPredicata failed, the optional input must be a list with variable strings.\n");
  fi;
  P:=VariableAdjustedPredicata(P1, P2, V);
  if P = fail then 
    return fail;
  fi;
  P:=SortedStatesAut(UnionPredicata(IntersectionPredicata(NegatedAut(P[1]), NegatedAut(P[2]), P[3]), IntersectionPredicata(P[1], P[2], P[3]), P[3]));
  SetVariableListOfPredicaton(P, V);
  return P;
end);
####################################################################################################
##
#F  ExistsPredicaton(P, v, V)
##
##  Creates the existence quantifier of a Predicaton and a variable regarding the variables names!
##
InstallGlobalFunction( ExistsPredicaton, function (P, v, args...)
  local p, Q, V;
  if not IsPredicaton(P) then
    Error("ExistsPredicaton failed, the first argument must be a Predicaton.\n");
  fi;
  if Length(args) = 0 then
    V:=VariableListOfPredicaton(P);
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("ExistsPredicaton failed, the optional input must be a list with variable strings containing the quantified variable.\n");
  fi;
  if not v in V then
    Print("The quantified variable must exist in the variable list of the Predicaton.\n");
    return fail;
  fi;
  p:=Position(V, v);
  Q:=VariableAdjustedPredicaton(P, V);
  if P = fail then 
    return fail;
  fi;
  Remove(V,p);
  Q:=SortedStatesAut(ProjectedPredicaton(Q, p));
  SetVariableListOfPredicaton(Q, V);
  return Q;
end);
####################################################################################################
##
#F  ForallPredicaton(P, v, V)
##
##  Creates the forall quantifier of a Predicaton and a variable regarding the variables names!
##
InstallGlobalFunction( ForallPredicaton, function (P, v, args...)
  local p, Q, V;
  if not IsPredicaton(P) then
    Error("ForallPredicaton failed, the first argument must be a Predicaton.\n");
  fi;
  if Length(args) = 0 then
    V:=VariableListOfPredicaton(P);
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("ForallPredicaton failed, the optional input must be a list with variable strings containing the quantified variable.\n");
  fi;
  if not v in V then
    Print("The quantified variable must exist in the variable list of the Predicaton.\n");
    return fail;
  fi;
  p:=Position(V, v);
  Q:=VariableAdjustedPredicaton(P, V);
  if P = fail then 
    return fail;
  fi;
  Remove(V,p);
  Q:=SortedStatesAut(NegatedProjectedNegatedPredicaton(Q, p));
  SetVariableListOfPredicaton(Q, V);
  return Q;
end);
####################################################################################################
##
#F  LeastAcceptedNumber(A, args...)
##
##  Returns the least accepted natural number from a given Predicaton with one variable, 
##  optional parameter true asks for the smallest greater zero, otherwise greater equal zero.
##
InstallGlobalFunction( LeastAcceptedNumber, function ( A, args... )
  local b, f, p, P, V, var;
  if not (IsPredicaton(A) and Length(VariablePositionListOfPredicaton(A)) = 1) then
    Print("LeastAcceptedNumber failed, the first argument must be a Predicaton with one variable.\n");
    return fail;
  fi;
  if Length(args) = 0 then
    b:=true;
  elif Length(args) = 1 and IsBool(args[1]) then
    b:=args[1];
  else
    Error("LeastAcceptedNumber failed, the optional argument must be a boolean\n.");
  fi;
  V:=VariableListOfPredicaton(A);
  if Length(V) = 1 and PredicataIsStringType(V[1], "variable") then
    var:=V[1]; 
  else 
    var:="x";
  fi;
  p:=PredicatonRepresentation("P1", 1, AutOfPredicaton(A));
  P:=PredicataRepresentation(p);
  if b then
    f:=PredicataFormula(Concatenation("P1[", var,"] and (A x2:  (0 < x2 and x2 < ", var,") implies not P1[x2]) and 0 < ", var), P); 
  else
    f:=PredicataFormula(Concatenation("P1[", var,"] and (A x2: x2 < ", var," implies not P1[x2])"), P); 
  fi;
  return PredicataFormulaToPredicaton(f);  
end);
####################################################################################################
##
#F  GreatestAcceptedNumber(A, args...)
##
##  Returns the greatest accepted natural number from a given Predicaton with one variable.
##
InstallGlobalFunction( GreatestAcceptedNumber, function ( A )
  local f, p, P, V, var;
  if not (IsPredicaton(A) and Length(VariablePositionListOfPredicaton(A)) = 1) then
    Print("GreatestAcceptedNumber failed, the first argument must be a Predicaton with one variable.\n");
    return fail;
  fi;
  V:=VariableListOfPredicaton(A);
  if Length(V) = 1 and PredicataIsStringType(V[1], "variable") then
    var:=V[1]; 
  else 
    var:="x";
  fi;
  p:=PredicatonRepresentation("P1", 1, AutOfPredicaton(A));
  P:=PredicataRepresentation(p);
  f:=PredicataFormula(Concatenation("P1[", var,"] and (A x2: x2 > ", var," implies not P1[x2])"), P); 
  return PredicataFormulaToPredicaton(f);  
end);
####################################################################################################
##
#F  LeastNonAcceptedNumber(A)
##
##  Returns the smallest nonaccepted natural number from a given Predicaton with one variable.
##
InstallGlobalFunction( LeastNonAcceptedNumber, function ( A )
  local f, p, P, V, var;
  if not (IsPredicaton(A) and Length(VariablePositionListOfPredicaton(A)) = 1) then
    Print("LeastNonAcceptedNumber failed, the first argument must be a Predicaton with one variable.\n");
    return fail;
  fi;
  V:=VariableListOfPredicaton(A);
  if Length(V) = 1 and PredicataIsStringType(V[1], "variable") then
    var:=V[1]; 
  else 
    var:="x";
  fi;
  p:=PredicatonRepresentation("P1", 1, AutOfPredicaton(A));
  P:=PredicataRepresentation(p);
  f:=PredicataFormula(Concatenation("(A x2: x2 < ", var," implies P1[x2]) and not P1[", var,"]"), P); 
  return PredicataFormulaToPredicaton(f);  
end);
####################################################################################################
##
#F  GreatestNonAcceptedNumber(A)
##
##  Returns the greatest nonaccepted natural number from a given Predicaton with one variable.
##
InstallGlobalFunction( GreatestNonAcceptedNumber, function ( A )
  local f, p, P, V, var;
  if not (IsPredicaton(A) and Length(VariablePositionListOfPredicaton(A)) = 1) then
    Print("GreatestNonAcceptedElement failed, the first argument must be a Predicaton with one variable.\n");
    return fail;
  fi;
  V:=VariableListOfPredicaton(A);
  if Length(V) = 1 and PredicataIsStringType(V[1], "variable") then
    var:=V[1]; 
  else 
    var:="x";
  fi;
  p:=PredicatonRepresentation("P1", 1, AutOfPredicaton(A));
  P:=PredicataRepresentation(p);
  f:=PredicataFormula(Concatenation("(A x2: x2 > ", var," implies P1[x2]) and not P1[", var,"]"), P);
  return PredicataFormulaToPredicaton(f);  
end);
####################################################################################################
##
#F  PresentPredicaton(F, V)
##
##  Calls PredicataFormula, PredicataFormulaToPredicaton and DrawPredicaton.
##
InstallGlobalFunction( PresentPredicaton, function (f, args...)
  local A, F, V;
  if Length(args) = 0 then
    V:=[];
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("PresentPredicaton failed, wrong optional input.\n");
  fi;
  if IsString(f) then
    F:=PredicataFormula(f);
    if F = fail then 
      return fail;
    else
      A:=PredicataFormulaToPredicaton(F, V);
      if A = fail then
        return fail;
      else 
        DrawPredicaton(A);
        return A;
      fi;
    fi;
  else
    Error("PresentPredicaton failed, the first argument must be a string.\n");
  fi;
end);
####################################################################################################
##
#F  FindCircleInPredicaton(A, V, t, d)
##
##  Unfolds the Predicaton (Predicaton, Visited final states, state, depth)
##
InstallGlobalFunction( FindCircleInPredicaton, function ( A, V, s, d, loop, final)
  local B, C, F, N, R, S, T, a, c, p0, i, l;
  B:=[];
  c:=1;
  a:=AlphabetOfAutAsList(A);
  l:=AlphabetOfAut(A);
  p0:=Position(a, ListWithIdenticalEntries(Length(a[1]), 0));
  T:=TransitionMatrixOfAut(A);
  F:=FinalStatesOfAut(A);
  S:=SinkStatesOfAut(A);
  N:=NumberStatesOfAut(A);
  if d = 2 * N - 1 then
    #Print("reached max depth\n");
    return false;
  else
    if s in S then
      return false;
    fi;
    R:=[];  # the next states reachable from s.
    for i in [1..l] do        
      R:=Concatenation(R,[T[i][s]]);
    od;
    #Print("s = ", s, " R = ", R, "loop = ", loop, " F = ", F, "\n");
    #Print("s in R: ", s in R, "not s in F: ", not s in F, "\n");
    if s in R and not s in F then   # finding a loop from one state to itself
      loop:=true;                   # set loop to true
      Remove(R, Position(R, s));    # don't go this loop, since loop=true is enough   
    fi;
    #Print("s = ", s, " R = ", R, "loop = ", loop, "\n");
    if s in F then
      if loop then
        return true;
      elif s in R then                    # loop in a final state
        if Length(Positions(R, s)) > 1  then  # at least one non-zero loop in the final state 
          return true;
        elif T[p0][s] <> s then               # non-zero loop in the final state 
          return true;
        elif T[p0][s] = s then                # if zero loop in a final state
          C:=ShallowCopy(R);
          Remove(C, p0);
          if IsEqualSet(C, S) then            # then all others must be sink states, since the Automaton is minimal and normalized with leading zeros.
            return loop;                        # if loop = true, then return true, otherwise false
          else                                  
            loop:=true;                         # else setting loop true, since the is a 0-loop and a non sinkstate transition.
          fi;
        fi;
      else
        final:=true;
      fi;
    fi;
    R:=Unique(R);
    for i in [1..Length(R)] do
      if R[i] in V then 
        #Print("R = ", R, " in V = ", V, "\n");
        if final then                         # found a loop, but already visited on its path a final state, return true;
          return true;
        elif not loop then                    # found a loop for the first time, now find in at most N steps a final state.
          loop:=true;
          d:=1;
          V:=Concatenation(V, [R[i]]);
        else
          V:=Concatenation(V, [R[i]]);
        fi;
      else
        V:=Concatenation(V, [R[i]]);
        #Print("Next call with ", V, " and ", R[i], ", current d+1 = ", d+1, "\n");
        B[c]:=FindCircleInPredicaton(A, V, R[i], d+1, loop, final);     # starting again recursively with all reachable states 
        c:=c+1;                                           # and all already visited final states.
      fi;
    od;
  fi;
  return true in B; 
end); 
####################################################################################################
##
#F  FinitelyManyWordsAccepted(A, args...)
##
##  Checks if the number of solutions is finite, except 0-completion (leading zeros).
##  optional argument = true for an already formatted Predicaton (minimal DFA with 0-completion)
##
InstallGlobalFunction( FinitelyManyWordsAccepted, function ( A , args...)
  local B;
  if not IsPredicaton(A) and not IsDeterministicAut(A) then
    Error("FinitelyManySolutionsPred failed, the argument must be a Predicaton with a deterministic Automaton.\n");
  fi;
  if Length(args) = 0 or Length(args) = 1 and args[1] = false then
    B:=FormattedPredicaton(A);
  elif Length(args) = 1 and args[1] = true then
    B:=A;
  else
    Error("FinitelyManySolutionsPred failed, the optional argument must be a boolean.\n");
  fi;
  return not FindCircleInPredicaton(B, [], InitialStatesOfAut(B)[1], 1, false, false);
end);  
####################################################################################################
##
#F  LinearSolveOverN(A, b, args...)
##
##  Solves the linear equation A * x = b, A in Z^(m x n) and b in Z^m for x in N^n.
##
InstallGlobalFunction( LinearSolveOverN, function ( A, b, args... )
  local V, f, l, r, i, j, len;
  if not (IsList(A) and ForAll(A, IsList) and IsList(b) and Length(A) = Length(b) and Length(A) > 0 ) then
    Error("LinearSolveOverN failed, the first argument must be a list containing list, the second argument must be a list.\n");
  fi;
  if Length(args) = 0 then
    V:=[];
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("LinearSolveOverN failed, wrong optional input.\n");
  fi;
  f:="";
  len:=Length(A[1]);
  for i in [1..Length(A)] do
    if not ForAll(A[i], IsInt) or not Length(A[i]) = len then
      Error("LinearSolveOverN failed, the first argument must contain integers.\n");
    fi;
    l:="";
    r:="";
    for j in [1..Length(A[i])] do
      if A[i][j] > 0 then
        if l = "" then
          l:=Concatenation(String(A[i][j]), " * x" , String(j));
        else
          l:=Concatenation(l, " + ", String(A[i][j]), " * x" , String(j));
        fi;
      elif A[i][j] < 0 then
        if r = "" then
          r:=Concatenation(String(AbsInt(A[i][j])), " * x" , String(j));
        else
          r:=Concatenation(r, " + ", String(AbsInt(A[i][j])), " * x" , String(j));
        fi;
      fi;
    od;
    if b[i] >= 0 then
      if r = "" then
        r:=String(b[i]);
      else 
        r:=Concatenation(r, "+", String(b[i]));
      fi;
    else
      if l = "" then
        l:=String(AbsInt(b[i]));
      else
        l:=Concatenation(l, " + ", String(AbsInt(b[i])));
      fi;
    fi;
    if l = "" then
      l:="0";
    elif r = "" then
      r:="0";
    fi;
    if i < Length(A) then
      f:=Concatenation(f, "(", l, " = ", r, ")", "and");
    else
      f:=Concatenation(f, "(", l, " = ", r, ")");
    fi;
  od;
  #Print(f);
  f:=PredicataFormula(f);
  if f = fail then
    return fail;
  else
    return PredicataFormulaToPredicaton(f, V);
  fi;
end);
####################################################################################################
##
#F  NullSpaceOverN(A, args...)
##
##  Solves the linear equation A * x = 0, A in Z^(m x n) for x in N^n.
##
InstallGlobalFunction( NullSpaceOverN, function ( A, args... )
  local V;
  if not (IsList(A) and ForAll(A, IsList) and Length(A) > 0) then
    Error("NullSpaceOverN failed, the first argument must be a list containing list, the second argument must be a list.\n");
  fi;
  if Length(args) = 0 then
    V:=[];
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i->PredicataIsStringType(i, "variable")) then
    V:=args[1];
  else
    Error("NullSpaceOverN failed, wrong optional input.\n");
  fi;
  return LinearSolveOverN(A, ListWithIdenticalEntries(Length(A), 0), V);
end);
####################################################################################################
##
#F  InterpretedPredicaton(A)
##
##  Returns true if the Predicaton A can be interpreted as true, otherwise false.
##
InstallGlobalFunction( InterpretedPredicaton, function ( A )
  local B, states, final;
  states:=NumberStatesOfAut(A);
  final:=FinalStatesOfAut(A);
  if states > 1 then
    B:=FormattedPredicaton(A);
    states:=NumberStatesOfAut(B);
    final:=FinalStatesOfAut(B);
  fi;
  if states = 1 and Length(final) = 1 then
    if Length(VariablePositionListOfPredicaton(A)) > 0 then
      Print("The Predicaton holds for all natural numbers and is interpreted as True.\n");
    else
      Print("The Predicaton is interpreted as True.\n");
    fi;
    return true;
  else
    if Length(VariablePositionListOfPredicaton(A)) > 0 then
      Print("The Predicaton doesn't hold for all natural numbers and is interpreted as False.\n");
    else
      Print("The Predicaton is interpreted as False.\n");
    fi;
    return false;
  fi;
end);
####################################################################################################
##
#F  AreEquivalentPredicata(A, B)
##
##  Checks if two Predicata are equivalent, the optional parameter = true computes w.r.t. to the 
##  variable list, otherwise w.r.t. variable POSITION list
##
InstallGlobalFunction( AreEquivalentPredicata, function ( A, B, args... )
  local b;
  if Length(args) = 0 then
    b:=true;
  elif Length(args) = 1 and IsBool(args[1]) then
    b:=args[1];
  else
    Error("AreEquivalentPredicata failed, the optional argument must be a boolean.\n");
  fi;
  if b then
    return InterpretedPredicaton(EquivalentPredicata(A, B));
  else
    return InterpretedPredicaton(UnionPredicata(IntersectionPredicata(NegatedAut(A), NegatedAut(B)), IntersectionPredicata(A, B)));
  fi;
end);
##
#E
##
