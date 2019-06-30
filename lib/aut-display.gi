####################################################################################################
##
##  This file installs the functions for displaying and drawing Predicata as well as printing the 
##  recognized states in a nice way.
##
####################################################################################################
##
#F  AutToString( A )
##
##  Returns an Automaton or a Predicaton nicely formatted as a string.
##
InstallGlobalFunction ( AutToString, function( A, args... )
 local a, t, i, j, k, tl, c, s, m, M, n, S, L, V, intro, mid, outro, alphabet0, alphabet, line0, line, states0, states, pos, pos0;
  # Optional: screen width parameter
  if Length(args) = 0 then
    S:=SizeScreen()[1] - 3; 
  elif Length(args) = 1 and IsPosInt(args[1]) then
    S:=args[1];
  else
    return "AutToString failed, optional parameter must be an positive integer.\n";
  fi;
  if S <= 50 then
    return "AutToString failed, cannot really work with that small size for the table.\n";
  fi;
  # Checking for the type, Automaton or Predicaton
  if IsAutomaton(A) then
    intro:="";
  elif IsPredicaton(A) then
    V:=VariableListOfPredicaton(A);
    A:=SortedAlphabetPredicaton(A);
    intro:="Predicaton: ";
  else
    Error("AutToString failed, input must be an Automaton or a Predicaton");
  fi;
  a:=AlphabetOfAutAsList(A);
  t:=TransitionMatrixOfAut(A);
  tl:=1;
  if IsDeterministicAut(A) then
    intro:=Concatenation(intro, "deterministic finite automaton ");
  else
    c:=StructuralCopy(t); 
    c:=Concatenation(c);
    for i in [1.. Length(c)] do
      tl:=Maximum(tl,Length(String(c[i])));
    od;
    intro:=Concatenation(intro, "nondeterministic finite automaton ");
  fi;
  if AlphabetOfAut(A) = 1 then
    intro:=Concatenation(intro, "on ", String(AlphabetOfAut(A)), " letter ");
  else 
    intro:=Concatenation(intro, "on ", String(AlphabetOfAut(A)), " letters ");
  fi;
  if NumberStatesOfAut(A) = 1 then
    intro:=Concatenation(intro, "with ", String(NumberStatesOfAut(A)), " state");
  else
    intro:=Concatenation(intro, "with ", String(NumberStatesOfAut(A)), " states");
  fi;
  if IsPredicaton(A) then
    intro:=Concatenation(intro, ", the variable position list ", String(A!.var));
  fi;
  intro:=Concatenation(intro, " and the following transitions:\n");
  m:=[];
  M:=1;
  for i in [1..Length(a)] do
    if IsList(a[i]) then
      if Length(a[i]) = 0 then
        m[i]:=3;
      else
        m[i]:=Length(a[i])*3+2;
      fi;
    elif IsString(a[i]) then
      m[i]:=Length(a[i]);
    else 
      m[i]:=1;
    fi;
  od;
  M:=Maximum(m);
  alphabet0:=Concatenation("  ", Flat(ListWithIdenticalEntries(M, " ")), "  |  "); # empty first row above the alphabet
  line0:=Flat(ListWithIdenticalEntries(M+7, "-")); # line above the alphabet
  alphabet:=[];                                    # alphabet
  states0:="";                                     # states in the first row
  states:="";                                      # transition table
  s:=0;
  for i in [1..NumberStatesOfAut(A)] do
    states0:=Concatenation(states0, String(i));
    if IsDeterministicAut(A) then
      if i < 10 then
        states0:=Concatenation(states0, "  ");
      elif i < 100 then
        states0:=Concatenation(states0, " ");
      fi;
      if NumberStatesOfAut(A) > 99 then
        states0:=Concatenation(states0, " ");
        s:=s+1;
      fi;
      s:=s+3;
    else
      if i < 10 then
        states0:=Concatenation(states0, "   ");
      elif i < 100 then
        states0:=Concatenation(states0, "  ");
      else
        states0:=Concatenation(states0, " ");
      fi;
      if NumberStatesOfAut(A) > 99 then
        states0:=Concatenation(states0, " ");
        s:=s+1;
      fi;
      s:=s+4;
      for j in [2..tl-1] do
        states0:=Concatenation(states0, " ");
        s:=s+1;
      od;
    fi;
  od;
  states0:=Concatenation(states0, "#");   # mark the end of the states, will not be printed
  line:=Flat(ListWithIdenticalEntries(s, "-")); # the line
  for i in [1..Length(t)] do
    alphabet[i]:="  ";
    if IsChar(a[i]) then
      alphabet[i]:=Concatenation(alphabet[i], [a[i]]);
    else
      alphabet[i]:=Concatenation(alphabet[i], String(a[i]));
    fi;
    for j in [1..M-m[i]] do
      alphabet[i]:=Concatenation(alphabet[i], " ");
    od;
    alphabet[i]:=Concatenation(alphabet[i], "  |  ");
    states[i]:="";
    for j in [1..Length(t[i])] do
      states[i]:=Concatenation(states[i], String(t[i][j]));
      if IsDeterministicAut(A) then
        if t[i][j] < 10 then
          states[i]:=Concatenation(states[i], "  ");
        elif t[i][j] < 100 then
          states[i]:=Concatenation(states[i], " ");
        fi;
        if NumberStatesOfAut(A) > 99 then
          states[i]:=Concatenation(states[i], " ");
        fi;
      else
        for k in [1..tl-Length(String(t[i][j]))] do
          states[i]:=Concatenation(states[i], " ");
        od;
        states[i]:=Concatenation(states[i], "  ");
        if NumberStatesOfAut(A) > 99 then
          states0:=Concatenation(states0, " ");
        fi;
      fi;
    od;
  od;
  # table
  S:=S-M-7; # 7 is coming from the alphabet spacing "  " ..letter.. "  |  ".
  mid:="";
  m:=1;
  while m < s do
    if s < S then
      L:=[1..s];
      m:=s;
    else
      pos:=PositionsProperty(states0, i -> i <> ' ');
      pos:=pos{PositionsProperty(pos, i -> m <= i and i < S+m)};
      if pos = [] then
        return "Printing the transition table failed, please increase the screen size.\n";
      else
        L:=Maximum(pos);
      fi;
      pos0:=Positions(states0, ' ');
      pos0:=pos0{PositionsProperty(pos0, i -> m <= i and i <= L)};
      if pos0 = [] then
        return "Printing the transition table failed, please increase the screen size.\n";
      else
        L:=Maximum(pos0);
      fi;
      L:=[m..L];
    fi;  
    mid:=Concatenation(mid, alphabet0, states0{L}, "\n", line0, line{L}, "\n");
    for i in [1..Length(t)] do
      mid:=Concatenation(mid, alphabet[i], states[i]{L}, "\n");
    od;
    m:=Maximum(L)+1;
    if m < s then
      mid:=Concatenation(mid, " ...\n");
    fi;
  od;
  i:=InitialStatesOfAut(A);
  Sort(i);
  j:=FinalStatesOfAut(A);
  Sort(j);
  outro:=Concatenation(" Initial states: ", String(i), "\n Final states:   ", String(j), "\n");
  if IsPredicaton(A) and Length(A!.var) > 0 and Length(V) > 0 then
    outro:=Concatenation(outro, "\n The alphabet corresponds to the following variable list: ", String(V), ".\n"); 
  fi;
  return String(Concatenation(intro, mid, outro));
end);
####################################################################################################
##
#F  DisplayAut ( A )
##
##  Displays an Automaton or a Predicaton. 
##  Note: Display from the "automata" package will not work properly on alphabet lists.
##
InstallGlobalFunction ( DisplayAut, function( A, args... )
  Print(AutToString(A));
end);
####################################################################################################
##
#M  RenameAlphabet ( <Abc> )
##
##  Cancels unnesseccary commas and removes empty space to create smaller labels in DrawAut.
##
InstallGlobalFunction ( RenameAlphabet, function ( Abc ) 
  local a, S, s, i;
  S:=[];
  if not (IsList(Abc) and IsList(Abc[1])) then
    Error("RenameAbc failed, input must be a nested list");
  fi;
  for a in Abc do
    s:="(";
    for i in a do
      Append(s, String(i));
    od;
    Append(s,")");
    Add(S,s);
  od;
  return S;
end);
####################################################################################################
##
#F  DrawPredicaton ( A )
##
##  Draws a Automaton or a Predicaton.
##
InstallGlobalFunction ( DrawPredicaton, function (A, name...)
  local a, B;
  if not name = [] and not IsString(name[1]) then 
    Error("DrawPredicaton failed, file name must be a string");
  fi;
  if IsAutomaton(A) then
    B:=A;
  elif IsPredicaton(A) then
    B:=A!.aut;
  else
    Error("DrawPredicaton failed, input must be an Automaton or a Predicaton");
  fi;
  #Drawing with smaller letter lists: DISABLED
  #a:=AlphabetOfAutAsList(B);
  #a:=RenameAlphabet(a);
  #B:=Automaton(B!.type, B!.states, a, B!.transitions,B!.initial,B!.accepting);
  if name = [] then 
    DrawAutomaton(B);
  else
    DrawAutomaton(B,name[1]);
  fi;
end);
####################################################################################################
##
#B  GetListElementElse
##
##  Returns the i-th position of l, otherwise return the optional argument, default 0.
##
BindGlobal( "GetListElementElse", function ( l, i, args... )
  local E;
  if Length(args) = 0 then
    E:=0;
  elif Length(args) = 1 then
    E:=args[1];
  else
    Error("error");  
  fi;
  if 0 < i and i <= Length(l) then
    return l[i];
  else
    return E;
  fi;
end);
####################################################################################################
##
#B  MakePairPredicaton
##
##  Makes a componentwise tuple of several list, where if the list is 
##  empty at a position 0 is added instead.
##
BindGlobal( "MakePairPredicaton",  function ( l )
  local n, m, t, i;
  m:=StructuralCopy(l);
  Apply(m,s->Length(s));
  m:=Maximum(m);
  n:=[];
  for i in [1..m] do
    t:=[1..Length(l)];
    Apply(t,s->GetListElementElse(l[s],i));
    n[i]:=t;
  od;
  return n;
end);
####################################################################################################
##
#F  IsAcceptedWordByPredicaton(A, L)
##
##  Checks if a list of natural numbers or a list of binary representation is accepted by the 
##  Predicaton. 
##
InstallGlobalFunction( IsAcceptedWordByPredicaton, function ( A, L )
  local B, i;
  if IsPredicaton(A) and IsList(L) and ForAll(L, i-> i >= 0 and IsInt(i)) then
    B:=[];
    for i in [1..Length(L)] do
      B[i]:=DecToBin(L[i]);
    od;
    return IsRecognizedByAut(A, MakePairPredicaton(B));
  elif IsPredicaton(A) and IsList(L) and ForAll(L, IsList) then
    for i in [1..Length(L)] do
      if not ForAll(L[i], i -> i >=0 and i <= 1) then
        Error("IsRecognizedByPred failed, the second argument must be a list containing lists which represent a binary number");
      fi;
    od;
    return IsRecognizedByAut(A, MakePairPredicaton(L));
  else
    Error("IsRecognizedByPred failed, the first argument must be a Predicaton, the second argument must be a list containing natural numbers");
  fi;
end);
####################################################################################################
##
#F  AcceptedWordsByPredicaton(A, args...)
##
##  Returns the accepted words up to an upper bound either one integer or indiviual bound for each 
##  variable.
##
InstallGlobalFunction( AcceptedWordsByPredicaton, function ( A, args... )
  local b, C, L, M, N, i, l;
  l:=Length(VariablePositionListOfPredicaton(A));
  if Length(args) = 0 then
    N:=ListWithIdenticalEntries(l, 10);
    b:=true;
  elif Length(args) = 1 and IsInt(args[1]) and args[1] >= 0 then
    N:=ListWithIdenticalEntries(l, args[1]);
    b:=true;
  elif Length(args) = 1 and IsList(args[1]) and Length(args[1]) = l and ForAll(args[1], i -> IsInt(i) and i >= 0) then
    N:=args[1];
    b:=true;
  elif Length(args) = 1 and IsList(args[1]) and Length(args[1]) = l and ForAll(args[1], i -> IsList(i) and ForAll(i, j->IsInt(j) and j >= 0)) then
    N:=args[1];
    b:=false;
  else  
    Error("AcceptedWordsByPred failed, the optional argument must either an positive integer or a list containing integers");
  fi;
  if IsPredicaton(A) and VariablePositionListOfPredicaton(A) = [] and AlphabetOfAut(A) = 1 and NumberStatesOfAut(A) = 1 then
    if Length(FinalStatesOfAut(A)) = 1 then
      return [true];
    else
      return [false];
    fi;
  elif IsPredicaton(A) then
    M:=ShallowCopy(N);
    if b then
      Apply(M, i-> [0..i]);
    fi;
    C:=Cartesian(M);
    L:=[];
    for i in C do
      if IsAcceptedWordByPredicaton(A, i) then
        Add(L, i);
      fi;       
    od;
    return L;
  else  
    Error("AcceptedWordsByPred failed, the argument must be a Predicaton");
  fi;
end);
####################################################################################################
##
#F  DisplayAcceptedWordsByPredicaton(A, args...)
##
##  Prints the recognized natural numbers in a nice way, for one variable as a "list" with YES/no 
##  for two variables as a "matrix" containing YES/no and for three variables as a "matrix"
##  which entries are the third recognized variables.
##
InstallGlobalFunction( DisplayAcceptedWordsByPredicaton, function (A, args...)
  local M, N, B, P, T, i, j, k, l, s, t, len;
  l:=Length(VariablePositionListOfPredicaton(A));
  if Length(args) = 0 then
    t:=false;
    if l = 1 then 
      N:=[99];
    elif l = 2 then
      N:=[50, 30];
    elif l = 3 then
      N:=[40, 20, 80];
    else
      N:=ListWithIdenticalEntries(l, 10);
    fi;
  elif Length(args) >= 1 and IsList(args[1]) and Length(args[1]) = l and ForAll(args[1], i -> IsInt(i) and i >= 0) then
    N:=args[1];
    t:=false;
  elif Length(args) >= 1 and IsInt(args[1]) and args[1] >= 0 then
    N:=ListWithIdenticalEntries(l, args[1]);
    t:=false;
  else  
    Error("DisplayAcceptedWordsByPred failed, the optional argument must either an positive integer or a list containing integers");
  fi; 
  if Length(args) >= 2 then
    if IsBool(args[2]) then
      t:=args[2];
    elif Length(args) > 2 then
      Print("Well, there are only two optional parameters.\n");
    else 
      Error("DisplayAcceptedWordsByPred failed, the second optional argument must be a boolean");
    fi;
  fi;
  if IsPredicaton(A) and VariablePositionListOfPredicaton(A) = [] and AlphabetOfAut(A) = 1 and NumberStatesOfAut(A) = 1 then
    if Length(FinalStatesOfAut(A)) = 1 then
      Print("\n Due to the Automaton the formula is true.\n   true\n");
    else
      Print("\n Due to the Automaton the formula is false.\n   false\n");
    fi;
  elif IsPredicaton(A) and l = 1 then
    B:=[0..N[1]];
    Apply(B, i->DecToBin(i));
    if t then
      Print(" If the following words are accepted by the given Automaton, then: Y, otherwise if not accepted: n.\n ");
    else
      Print(" If the following words are accepted by the given Automaton, then: YES, otherwise if not accepted: no.\n ");
    fi;
    for i in [0..N[1]] do
      if i <10 then 
        Print("  ");
      elif i <100 then
        Print(" ");
      fi;
      Print(i, ": ");
      if IsRecognizedByAut(A, MakePairPredicaton([B[i+1]])) then
        if t then
          Print("Y");
        else
          Print("YES");
        fi;
      else
        if t then
          Print("n");
        else
          Print("no ");
        fi;
      fi;
      if RemInt(i,10) = 9 then
        Print("\n ");
      else
        Print(" ");
      fi;
    od;
    Print("\n");
  elif IsPredicaton(A) and l = 2 then
    Print(" If the following words are accepted by the given Automaton, then: YES, otherwise if not accepted: no.\n\n     | ");
    s:=5;
    for j in [0..N[2]] do
      Print(j);
      if j < 10 then
        Print("   ");
      elif j < 100 then
        Print("  ");
      else 
        Print(" ");
      fi;
      s:=s+4;
    od;
    Print("\n ");
    s:=[1..s];
    Apply(s,i->"-");
    Print(Concatenation(s));
    Print("\n");
    B:=[0..Maximum(N)];
    Apply(B,i->DecToBin(i));
    for i in [0..N[1]] do
      if i < 10 then
        Print("   ");
      elif i < 100 then
        Print("  "); 
      else 
        Print(" ");
      fi;
      Print(i, " | ");
      for j in [0..N[2]] do
        if IsRecognizedByAut(A, MakePairPredicaton([B[i+1],B[j+1]])) then
          Print("YES ");
        else
          Print("no  ");
        fi;
      od;
      Print("\n");
    od;
    Print("\n");
  elif IsPredicaton(A) and l = 3 then
    B:=[0..Maximum(N)];
    Apply(B,i->DecToBin(i));
    T:=[0..N[2]];
    Apply(T,i->[]);
    P:=[0..N[1]];
    Apply(P,i->StructuralCopy(T));
    for i in [0..N[1]] do
      for j in [0..N[2]] do
        for k in [0..N[3]] do
          if IsRecognizedByAut(A, MakePairPredicaton([B[i+1],B[j+1],B[k+1]])) then
            Add(P[i+1][j+1],k);
          fi;
        od;
      od;
    od;
    T:=Concatenation(P);
    Apply(T,i->Length(String(i))-Length(i));
    T:=Maximum(Maximum(T)-3, 2);
    Print("\n     | ");
    s:=5;
    for j in [0..N[2]] do
      Print(j);
      if j < 10 then
        Print("   ");
      elif j < 100 then
        Print("  ");
      else
        Print(" ");
      fi;
      s:=s+4;
      for l in [3..T] do
        Print(" ");
        s:=s+1;
      od;
    od;
    Print("\n ");
    s:=[1..s];
    Apply(s,i->"-");
    Print(Concatenation(s));
    Print("\n");
    for i in [0..N[1]] do
      if i < 10 then
        Print("   ");
      elif i < 100 then
        Print("  "); 
      else 
        Print(" ");
      fi;
      Print(i);
      Print(" | ");
      for j in [0..N[2]] do
        if not P[i+1][j+1] = [] then
          len:=Length(P[i+1][j+1]);
          for l in [1..len-1] do
            Print(P[i+1][j+1][l], ",");
          od;
          Print(P[i+1][j+1][len]);
          for l in [1..T-Length(String(P[i+1][j+1]))+Length(P[i+1][j+1])+3] do
            Print(" ");
          od;
          Print("  ");
        else
          Print("--");
          for l in [1..T] do
            Print(" ");
          od;
        fi;
      od;
      Print("\n");
    od;
    Print("\n");
  elif IsPredicaton(A) and l > 3 then
    B:=AcceptedWordsByPredicaton(A, N);
    Print("The Predicaton accepts the following natural numbers, checked up to ", N, ":\n");
    for i in B do
      Print(" ", i, "\n");
    od;
  else  
    Print("DisplayAcceptedWordsByPred failed, the argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  DisplayAcceptedWordsByPredicatonInNxN(A, args...)
##
##  Displays the accepted states in N_0 x N_0, i.e. drawing linear equations.
##
InstallGlobalFunction(  DisplayAcceptedWordsByPredicatonInNxN, function (A, args...)
  local N, B, i, j, l;
  if IsPredicaton(A) and Length(VariablePositionListOfPredicaton(A)) = 2 then
    if Length(args) = 0 then
      N:=[40, 40];
    elif Length(args) = 1 and IsList(args[1]) and Length(args[1]) = 2 and ForAll(args[1], IsPosInt) then
      N:=args[1];
    else  
      Error("DisplayPredInNxN failed, the optional argument must be list of length two containing positive integer");
    fi;
    Print(" This function draws in N_0 x N_0. Please make sure to add your x-variable as an optional parameter in PredicataFormulaToPredicaton, otherwise it may be flipped.\n\n     | ");
    Print("\n");
    B:=[0..Maximum(N)];
    Apply(B,i->DecToBin(i));
    l:=Reversed([0..N[2]]); 
    for i in l do     # i -> y variable
      if i < 10 then
        Print("   ");
      elif i < 100 then
        Print("  "); 
      else 
        Print(" ");
      fi;
      Print(i, " -");
      for j in [0..N[1]] do   # j -> x variable
        if IsRecognizedByAut(A, MakePairPredicaton([B[j+1],B[i+1]])) then
          Print("  o ");
        else
          Print("    ");
        fi;
      od;
      Print("\n     |\n");
    od;
    Print("   --+");
    for j in [0..N[1]] do
      Print("--|-");
    od;
    Print("--->\n     |");
    for j in [0..N[1]] do
      if j < 10 then
        Print("  ",j ," ");
      elif j < 100 then
        Print(" ", j," ");
      else 
        Print("", j, " ");
      fi;
    od;
    Print("\n");
  elif IsPredicaton(A) and Length(VariablePositionListOfPredicaton(A)) <> 2 then
    Print("Sorry, this function is only for NxN, i.e. a variable position list of length 2.\n");
  else  
    Print("DisplayPredInNxN failed, the argument must be a Predicaton.\n");
  fi;
end);
####################################################################################################
##
#F  WordsOfRatExp(r, depth)
##
##  Returns all words which can be created from the rational expression by appling the star operator
##  at most depth times as a list with binary letters.
##
InstallGlobalFunction( WordsOfRatExp, function (r, depth)
  local B, C, W, l, o, i, j ;
  if not (IsRationalExpression(r) and IsInt(depth) and depth >=0) then
    Error( "WordsOfRatExp failed, the first argument must be a Rational Expression, the second argument a positive integer.\n");
  fi;
  l:=r!.list_exp;
  o:=r!.op;
  if l = "empty_set" then
    return "empty_set";
  fi;
  if o = [ ] then
    #Print("Base case: ", r, r!.list_exp, "returns: ", [FamilyObj(r)!.alphabet2{r!.list_exp}], "\n");
    return [FamilyObj(r)!.alphabet2{r!.list_exp}];
  elif o = "product" then
    B:=[];
    W:=[];
    for i in [1..Length(l)] do
      W[i]:=WordsOfRatExp(l[i], depth);
      #Print("\n Poduct: ", i, "-", W[i], "\n\n");
    od;
    #  Print("List ", W, "\n");
    B:=Cartesian(W);
    #  Print("Product: ", B, "\n");
    Apply(B,i->Concatenation(i));
    #  Print("Concatenation-Product: ", B, "\n");
  elif o = "union" then
    B:=[];
    for i in [1..Length(l)] do
      Append(B, WordsOfRatExp(l[i], depth));
      #  Print("Union: case", i, ", ", WordsOfRatExp (l[i], depth), "\n");
    od;
    #  Print("Union", B, "\n");
  elif o = "star" then
    #B:=[[[]]];
    B:=[];
    if depth > 0 then
      W:=WordsOfRatExp(l, depth);
      #  W:=Concatenation(WordsOfRatExp(l, depth));
      Append(B, W);
      #  Print("star-B: ", B,"\n");
      for i in [3..depth+1] do
        #  Print("star-cart B: ", B, " \nW: ", W); 
        C:=Cartesian([B, W]);
        #  Print("star-cartesian ", C,"\n");
        Apply(C,i->Concatenation(i));
        #  Print("star-cartesian after concatenation ", C,"\n");
        Append(B, C);
      od; 
    fi;
    B:=Unique(B);
    Append(B,[[[]]]);
    #  Print("star: ", B, "\n");
  fi;
  #  Print("B: ", B, "\n");
  return B;
end);
####################################################################################################
##
#F  WordsOfRatExpInterpreted(r, args...)
##
##  Returns all words which can be created from the rational expression by appling the star operator
##  at most depth times (optional argument, default = 1) as a list of natural numbers.
##
InstallGlobalFunction( WordsOfRatExpInterpreted, function (r, args...)
  local B, b, D, d, depth, i, j, k, l;
  D:=[];
  if not IsRationalExpression(r) then
    Error( "WordsOfRatExpInterpreted failed, the first argument must be a Rational Expression.\n");
  fi;
  if IsList(args) and Length(args) = 1 and IsInt(args[1]) and args[1] >= 0 then
    depth:=args[1];
  else
    depth:=1;
  fi;
  l:=LogInt(FamilyObj(r)!.alphabet,2);
  B:=WordsOfRatExp(r, depth);
  #Print("\n\n End B: ", B,"\n");
  for i in [1..Length(B)] do
    b:=[1..l];
    Apply(b,i->[]);
    d:=[];
    for k in [1..l] do
      for j in [1..Length(B[i])] do
        #Print("\n", B[i][j]);
        if B[i][j] <> [] then 
          Add(b[k], B[i][j][k]);
        fi;
      od;
      #Print("b[k]: ", b[k], "\n");
      d[k]:=BinToDec(b[k]);
    od;
    if not d in D then
      Add(D, d);
    fi;
  od;
  Sort(D);
  return D;  
end);
##
#E
##
