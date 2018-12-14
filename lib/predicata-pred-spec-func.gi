####################################################################################################
##
##  This file declares special functions on Predicata, it precalls also some Predicata.
##
####################################################################################################
##
#F  IsValidInputList(l, n)
##
##  Checks the input for the following functions.
##
InstallGlobalFunction( IsValidInputList, function ( l, n )
  if not IsList(l) and not ForAll(l, i -> IsPosInt(i)) then
    Print("Variable position list is not a list containing positive integers.\n");
    return false;
  elif not IsList(n) and not ForAll(n, i -> IsPosInt(i)) then
    Print("Requested size list is not a list containing positive integers.\n");
    return false;
  elif Length(Unique(l)) <> Length(l) then
    Print("Variable position list must contain unique positive integers.\n");
    return false; 
  elif not IsSubsetSet(n, l) then
    Print("Variable position list must be a subset of requested size list. Compare: ", l, " with ", n, "\n");
    return false;
  else
    return true;
  fi;
end);
####################################################################################################
##
#F  BooleanPredicaton(B, n[, base])
##
##  Returns the Predicaton which consists of one state. This state is a 
##  final state for B = "true" and a non-final state for B = "false".
##
InstallGlobalFunction( BooleanPredicaton, function ( B, n, args... )
  local F, k; 
  if B = "true" and IsList(n) and ForAll(n, i->IsPosInt(i)) then
    F:=[1];
  elif B = "false" and IsList(n) and ForAll(n, i->IsPosInt(i)) then
    F:=[];
  else
    Error("BooleanPredicaton failed, the first argument must be a string (\"true\" or \"false\"), the second argument must be a list containing positive integers.\n");
  fi;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  return Predicaton(Automaton("det", 1, PredicataAlphabet(Length(n),k), List([1..k^Length(n)], i->[1]), [1], F), n, k);
end);
####################################################################################################
##
#F  EqualPredicaton(l, n[, base] )
##
##  Returns the Predicaton that recognizes x = y 
##  with final variable position list n and inital variable position list l
##  where the order still matters, see also PredicatonFromAut and PermutedAlphabetPred.
##
BindGlobal( "PredicataEqualPredicatonHelper", function ( l )
  if l[1]-l[2] = 0 then
    return [ 1, 2 ];
  else  
    return [ 2, 2 ];
  fi;
end);
InstallGlobalFunction( EqualPredicaton, function ( l, n, args... )
  local k;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  if IsValidInputList(l, n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 2, PredicataAlphabet(2,k), List(PredicataAlphabet(2,k), i->PredicataEqualPredicatonHelper(i)), [1], [1]), l, n, k);
  else
    Error("EqualPredicaton failed, the arguments must be a list containing positive integers, the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  AdditionPredicaton(l, n[, base])
##
##  Returns the Predicaton that recognizes x + y = z 
##  with final variable position list n and inital variable position list l
##  where the order still matters, see also PredicatonFromAut and PermutedAlphabetPred.
##
InstallGlobalFunction( AdditionPredicaton, function ( l, n, args...  )
  local A, T, S, a, i, j, k;
  if IsValidInputList(l, n) and Length(l) = 3 then
    if Length(args) = 0 then
      k:=ReturnPredicataBase();
    elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
      k:=args[1];
    fi;
    A:=PredicataAlphabet(3, k);
    T:=List([1..k^3], i->[]);
    S:=3;
    for i in [0,1,3] do                            # state S is the sink state.
      for a in [1..Length(A)] do
        if i < S then
          j:=( [1,1,-1] * A[a] + i) / k;  # transition rule
          #Print("a: ", A[a], " i = ", i, " -> j = " , j, "\n");
          if IsInt(j) and 0 <= i and i <= 1 and 0 <= j and j <=1 then
            Add(T[a], j+1);  # this maps the j-th state (if positive) to (j+1)-th states.
          else 
            Add(T[a], S);      # sink state
          fi;
        else
          Add(T[a], S);        # sink state
        fi;
      od;
    od;
    return PredicatonFromAut(Automaton("det", 3, A, T, [1], [1]), l, n, k);
  else
    Error("AdditionPredicaton failed, the arguments must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  EqualNPredicaton(N, l, n[, base])
##
##  Returns the Predicaton that recognizes x = N for N >= 0.
##
InstallGlobalFunction( EqualNPredicaton, function ( N, l, n, args... )
  local A, B, k;
  if IsInt(N) and N >= 0 and Length(l) = 1 and IsValidInputList(l, n) then
    if Length(args) = 0 then
      k:=ReturnPredicataBase();
    elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
      k:=args[1];
    fi;
    B:=List(DecToBaseRep(N, k), i->[i]);
    A:=FormattedPredicaton(PredicatonFromAut(ListOfWordsToAutomaton(PredicataAlphabet(1, k), [B]), l, l, k));
    #A:=PredicatonFromAut(ListOfWordsToAutomaton(PredicataAlphabet(1, k), [B]), l, l, k);
    return ExpandedPredicaton(A, n);
  else
    Error("EqualNPredicaton failed, the first argument must be an integer greater equal 0, the second and third arguments must be a list containing positive integers, the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  SumOfProductsPredicaton(l, m, n[, base])
##
##  Returns the Predicaton that recognizes t_1*x_1 + ... + t_2*x_N = 0, for integers t_i,
##  with inital variable position list l, where the order still matters
##  and final variable position list n. 
##  
##  Creates the transition matrix explicitly.
##
InstallGlobalFunction( "SumOfProductsPredicaton", function ( l, t, n, args... )
local A, Aut, N, L, S, Sp, Sn, T, a, i, j, k, p, p0, q;
  if not (IsValidInputList(l, n) and IsList(t) and Length(l) = Length(t)) then
    Error("SumOfProductsPredicaton failed, the first and third argument must be a list, containing positive integers and the first list must be contained in the second list, the second argument must be a list, containing positive integers.\n");
  fi;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  p0:=Positions(t, 0);                # Looking at the different from zero multiplications.
  p:=Difference([1..Length(t)], p0);
  l:=l{p};
  t:=t{p};
  N:=Length(l);  
  #Print("l: ", l, " t: ", t, " n: ", n, " N: ", N, "\n");
  if N > 1 then
    A:=PredicataAlphabet(N, k);
    S:=ShallowCopy(t);
    Apply(S, i -> AbsInt(i));
    S:=Sum(S);
    Sp:=Sum(t{PositionsProperty(t, i -> i > 0)});
    Sn:=Sum(t{PositionsProperty(t, i -> i < 0)});
    #Print("S: ", S, " Sn: ", Sn, " Sp: ", Sp, "\n");
    if Sn = 0 or Sp = 0 then # if there are only positive or only negative multiplications then [0,...,0] is the only solution
      T:=List([1..k^N], i -> [ 2, 2 ]);
      T[1][1]:=1;
      Aut:=Automaton("det", 2, PredicataAlphabet(N, k), T, [ 1 ], [ 1 ]);
    else 
      T:=List([1..k^N], i -> []);
      L:=Reversed([ Sn+1..-1 ]);
      L:=Concatenation([ 0..Sp-1 ], L, [ S ]); # states from 0 to Sp-1, then from -1 to Sn+1, where each state q has carry q; 
      for i in L do                            # state S is the sink state.
        for a in [1..Length(A)] do
          if i < S then
            j:=( t * A[a] + i) / k;  # transition rule
            #Print("a: ", A[a], " i = ", i, " -> j = " , j, "\n");
            if IsInt(j) and Sn < i and i < Sp and Sn < j and j < Sp then
              if j >= 0 then 
                Add(T[a], j+1);  # this maps the j-th state (if positive) to (j+1)-th states.
              else
                Add(T[a], Sp-j); # this maps the j-th state (if negative) to (Sp-j)-th states
              fi;
            else 
              Add(T[a], S);      # sink state
            fi;
          else
            Add(T[a], S);        # sink state
          fi;
        od;
      od;
      Aut:=Automaton("det", S, A, T, [ 1 ], [ 1 ]);
    fi;
  elif N = 1 then
    T:=List([1..k], i -> [ 2, 2 ]);
    T[1][1]:=1;
    Aut:=Automaton("det", 2, PredicataAlphabet(1, k), T, [ 1 ], [ 1 ]); # accepts [0]*
  else
    Aut:=Automaton("det", 1, PredicataAlphabet(0, k), [ [ 1 ] ], [ 1 ], [ 1 ]); # accepts []*
  fi;
  return PredicatonFromAut(Aut, l, n, k); 
end);
####################################################################################################
##
#F  TermEqualTermPredicaton( l1, m1, i1, l2, m2, i2, n[, base] )
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
InstallGlobalFunction( TermEqualTermPredicaton, function ( l1, m1, i1, l2, m2, i2, n, args... )
  local A, I, l, m, c, p, len, ls1, ls2, s1, s2, lu, u, w, h, i, j, k;
  #Print("l1: ", l1, " m1: ", m1, " i1: ", i1, "l2: ", l2, " m2: ", m2, " i2: ", i2, " n: ", n, "\n");
  if not (IsList(l1) and IsList(m1) and IsList(i1) and IsList(l1) and IsList(m1) and IsList(i1) and IsList(n) and ForAll(n, IsPosInt)) then
    Error("TermEqualTermPredicaton failed, the arguments must be lists.\n");
  elif not (Length(l1) = Length(m1) and Length(Positions(l1, "int")) = Length(i1) and Length(Positions(m1, "int")) = Length(i1) and ForAll(i1, i -> IsInt(i) and i >= 0) and IsSubsetSet(n, l1{PositionsProperty(l1, IsPosInt)})) then
    Error("TermEqualTermPredicaton failed, the first argument must be a list containing either variable positions or \"int\", the second argument must contain the multiplication integer or \"int\", and the third argument must contain positive integers.\n");   
  elif not (Length(l2) = Length(m2) and Length(Positions(l2, "int")) = Length(i2) and Length(Positions(m2, "int")) = Length(i2) and ForAll(i2,  i -> IsInt(i) and i >= 0) and IsSubsetSet(n, l2{PositionsProperty(l2, IsPosInt)})) then
    Error("TermEqualTermPredicaton failed, the fourth argument must be a list containing either variable positions or \"int\", the fifth argument must contain the multiplication integer or \"int\", and the sixth argument must contain positive integers.\n");   
  fi;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  # Left side: replace every integer addition with an variable and later intersect with x = i.
  ls1:=Length(i1);
  s1:=[1..ls1] + MaximumOrZero(n);
  c:=1;
  for j in [1..Length(l1)] do
    if l1[j]="int" then
      l1[j]:=s1[c];
      m1[j]:=1;
      c:=c+1;
    fi;
  od;
  n:=Union(n, s1);
  # Right side: replace every integer addition with an variable and later intersect with x = i.
  ls2:=Length(i2);
  s2:=[1..ls2] + MaximumOrZero(n);
  c:=1;
  for j in [1..Length(l2)] do
    if l2[j]="int" then
      l2[j]:=s2[c];
      m2[j]:=1;
      c:=c+1;
    fi;
  od;
  n:=Union(n, s2);
  #Print(" l1: ", l1, " m1: ", m1, " i1: ", i1, " s1: ", s1, "\n");
  #Print(" l2: ", l2, " m2: ", m2, " i2: ", i2, " s2: ", s2, "\n");
  # move the right side to the left
  l:=Concatenation(l1, l2);
  m:=Concatenation(m1, -1*m2);
  # Both sides: replace every multiple occurence of variables with another variable and later intersect with x = y
  len:=Length(l);
  c:=1;
  lu:=Length(Unique(l));
  u:=[1..len-lu] + MaximumOrZero(n);
  w:=[];
  #Print("l: ", l, " u: ", u, "\n"); 
  if lu < len then  
    for j in [1..len] do 
      p:=Positions(l, l[j]);
      if Length(p) > 1 then
        for h in [2..Length(p)] do
          Add(w, [l[p[h]], u[c]]);
          l[p[h]]:=u[c];
          c:=c+1;
        od;   
      fi;
    od;
    n:=Union(n, u);
  fi;
  #Print("l: ", l, " u: ", u, " w: ", w, "\n"); 
  lu:=len-lu; 
  # Sum of products
  A:=SumOfProductsPredicaton(l, m, n, k);
  # Left side: intersection with var = int
  for j in [1..ls1] do   
    I:=EqualNPredicaton(i1[j], [s1[j]], n, k);
    A:=IntersectionPredicata(A, I, n);
    A:=ProjectedPredicaton(A, s1[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  # Right side: intersection with var = int
  for j in [1..ls2] do   
    I:=EqualNPredicaton(i2[j], [s2[j]], n, k);
    A:=IntersectionPredicata(A, I, n);
    A:=ProjectedPredicaton(A, s2[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  # Both sides: intersection with var (double occurence) = var (new var)
  for j in [1..lu] do   
    I:=EqualPredicaton(w[j], n, k);
    A:=IntersectionPredicata(A, I, n);
    A:=ProjectedPredicaton(A, u[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  return SortedStatesPredicaton(A);
end);
####################################################################################################
##
#F  GreaterEqualNPredicaton(N, l, n[,base])
##
##  Returns the Predicaton which recognizes the language of x >= N.
##  I.e. x >= N <=> E n1: E n2: n1 + n2 = x and n2 = N.
##
InstallGlobalFunction( GreaterEqualNPredicaton, function (N, l, n, args...)
  local A, EN, i, m, n1, k;
  if not IsInt(N) or N < 0 or not Length(l) = 1 or not IsValidInputList(l, n) then
    Error("GreaterEqualNPredicaton failed, the first argument must be an integer greater equal 0, the second and third arguments must be a list containing positive integers, the first list must be contained in the second list.\n");
  fi;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  m:=[1,2]+Maximum(n);
  n1:=Union(l, m);
  A:=AdditionPredicaton([m[1], m[2], l[1]], n1, k);
  EN:=EqualNPredicaton(N, [m[2]], n1, k);
  A:=IntersectionPredicata(A, EN, n1);
  for i in m do
    A:=ProjectedPredicaton(A, i);
  od;
  A:=ExpandedPredicaton(A, n);
  return A;
end);
####################################################################################################
##
#F  GreaterNPredicaton(N, l, n[,base])
##
##  Returns the Predicaton which recognizes the language of x > N.
##
InstallGlobalFunction( GreaterNPredicaton, function ( N , l, n, args... )
  local k;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  return GreaterEqualNPredicaton(N+1, l, n, k);
end);
####################################################################################################
##
#F  SmallerEqualNPredicaton(N, l, n[,base])
##
##  Returns the Predicaton which recognizes the language of x <= N.
##
InstallGlobalFunction( SmallerEqualNPredicaton, function ( N , l, n, args... )
  local k;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  return NegatedPredicaton(GreaterEqualNPredicaton(N+1, l, n, k));
end);
####################################################################################################
##
#F  SmallerNPredicaton(N, l, n[,base])
##
##  Returns the Predicaton which recognizes the language of x < N.
##
InstallGlobalFunction( SmallerNPredicaton, function ( N , l, n, args... )
  local k;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  return NegatedPredicaton(GreaterEqualNPredicaton(N, l, n, k));
end);
####################################################################################################
##
#F  GreaterEqualPredicaton(l, n[,base])
##
##  Returns the Predicaton which recognizes the language of x >= y,
##  I.e. x >= y <=> E m: y + m = x.
##
InstallGlobalFunction( GreaterEqualPredicaton, function( l, n, args... ) 
  local A, m, n1, k;
  if not IsValidInputList(l, n) or not Length(l) = 2 then
    Error("GreaterEqualPredicaton failed, the arguments must be a list containing positive integers and the first list must be contained in the second list.\n");
  fi;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  m:=[1]+Maximum(n);
  n1:=Union(l, m);
  A:=AdditionPredicaton([l[2], m[1], l[1]], n1, k);
  A:=ProjectedPredicaton(A, m[1]);
  return ExpandedPredicaton(A, n);
end);
####################################################################################################
##
#F  GreaterPredicaton(l, n[,base])
##
##  Returns the Predicaton which recognizes the language of x > y,
##  I.e. x >= y <=> E m: y + m = x and m >=1.
##
InstallGlobalFunction( GreaterPredicaton, function( l, n, args... ) 
  local A, G, m, n1, k;
  if not IsValidInputList(l, n) or not Length(l) = 2 then
    Error("GreaterPredicaton failed, the arguments must be a list containing positive integers and the first list must be contained in the second list.\n");
  fi;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  m:=[1]+Maximum(n);
  n1:=Union(n, m);
  Sort(n1);
  A:=AdditionPredicaton([l[2], m[1], l[1]], n1, k);
  G:=GreaterEqualNPredicaton(1, m, n1, k);
  A:=IntersectionPredicata(A, G, n1);
  A:=ProjectedPredicaton(A, m[1]);  
  return ExpandedPredicaton(A, n);
end);
####################################################################################################
##
#F  SmallerEqualPredicaton(l, n[,base])
##
##  Returns the Predicaton which recognizes the language of x <= y.
##
InstallGlobalFunction( SmallerEqualPredicaton, function( l, n, args... ) 
  local k;
  if IsValidInputList(l, n) and Length(l) = 2 then
    if Length(args) = 0 then
      k:=ReturnPredicataBase();
    elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
      k:=args[1];
    fi;
    return NegatedPredicaton(GreaterPredicaton(l, n, k));
  else
    Error("GreaterEqualPredicaton failed, the arguments must be a list containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  SmallerPredicaton(l, n[,base])
##
##  Returns the Predicaton which recognizes the language of x < y.
##
InstallGlobalFunction( SmallerPredicaton, function( l, n, args... ) 
  local k;
  if IsValidInputList(l, n) and Length(l) = 2 then
    if Length(args) = 0 then
      k:=ReturnPredicataBase();
    elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
      k:=args[1];
    fi;
    return NegatedPredicaton(GreaterEqualPredicaton(l, n, k));
  else
    Error("SmallerPredicaton failed, the arguments must be a list containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  BuchiPredicaton(l, n[,base])
##
##  Returns the Predicaton which gives the Büchi automaton, 
##  i.e. l[2] is the largest power of base=k which divides l[1]. 
##
InstallGlobalFunction( BuchiPredicaton, function(l, n, args...)
  local A, T, i, k;
  if IsValidInputList(l, n) and Length(l) = 2 then
    if Length(args) = 0 then
      k:=ReturnPredicataBase();
    elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
      k:=args[1];
    fi;
    A:=PredicataAlphabet(2, k);
    T:=List([1..k^2], i -> [ 3, 3, 3 ]);
    T[1]:=[ 1, 2, 3 ]; # letter [ 0, 0, 0 ] loops always.
    for i in [1..k-1] do
      Print(Position(A,[i,1]),Position(A,[i,0]));
      T[Position(A,[i,1])][1]:=2;  # Transition from state 1 to state 2: [1,1], ... [k,1] the base represenation of 0*1,... 0*k is divisible by 0*k,
                                   #                                     with the same amount of zeros.
      T[Position(A,[i,0])][2]:=2;   # Transition from state 2 to state 2: the highest power of k dividing is already chosen above. now just loop
    od; 
    # OLD: automaton for k=2.
    # Automaton("det", 3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], [ [ 1, 2, 3 ], [ 3, 2, 3 ], [ 3, 3, 3], [ 2, 3, 3 ] ], [ 1 ], [ 2 ]);
    return PredicatonFromAut(Automaton("det", 3, A, T, [ 1 ], [ 2 ]), l, n, k);
  else
    Error("BuchiPredicaton failed, the arguments must be lists containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  PowerPredicaton(l, n[,base])
##
##  Returns the Predicata which gives all powers of base=k.
##
InstallGlobalFunction( PowerPredicaton, function(l, n, args...)
  local A, T, k;
  if IsValidInputList(l, n) and Length(l) = 1 then
    if Length(args) = 0 then
      k:=ReturnPredicataBase();
    elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
      k:=args[1];
    fi;
    A:=PredicataAlphabet(1, k);
    T:=List([1..k], i -> [ 3, 3, 3 ]);
    T[1]:=[ 1, 2, 3 ]; # letter [ 0, 0, 0 ] loops always.
    T[2]:=[ 2, 3, 3 ]; # transition from state 1 to state 2 with 1, i.e. accepted words are: 0*10*
    return PredicatonFromAut(Automaton("det", 3, A, T, [ 1 ], [ 2 ]), l, n, k);
  else
    Error("PowerPredicaton failed, the arguments must be lists containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
##
#E
##