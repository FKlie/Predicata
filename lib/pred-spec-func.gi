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
#F  BooleanPredicaton(B, n)
##
##  Returns the Predicaton which consists of one state. This state is a 
##  final state for B = "true" and a non-final state for B = "false".
##
InstallGlobalFunction( BooleanPredicaton, function ( B, n )
  local F; 
  if B = "true" and IsList(n) and ForAll(n, i->IsPosInt(i)) then
    F:=[1];
  elif B = "false" and IsList(n) and ForAll(n, i->IsPosInt(i)) then
    F:=[];
  else
    Error("BooleanPredicaton failed, the first argument must be a string (\"true\" or \"false\"), the second argument must be a list containing positive integers.\n");
  fi;
  return Predicaton(Automaton("det", 1, GetAbc(Length(n)), ListWithIdenticalEntries(2^Length(n), [1]), [1], F), n);
end);
####################################################################################################
##
#V  PredicataEqualAut
##
##  The automaton PredicataEqualAut recognizes the language of 
##  two binary s.t.:
##  
##  PredicataEqualAut(x,y) :<=> x = y        
##
InstallValue( PredicataEqualAut, Automaton("det", 2, [[0,0],[1,0],[0,1],[1,1]], [[1,2],[2,2],[2,2],[1,2]], [1], [1]));
####################################################################################################
##
#F  EqualPredicaton(l, n)
##
##  Returns the Predicaton that recognizes x = y 
##  with final variable position list n and inital variable position list l
##  where the order still matters, see also PredicatonFromAut and PermutedAlphabetPred.
##
InstallGlobalFunction( EqualPredicaton, function ( l, n )
  if IsValidInputList(l, n) and Length(l) = 2 then
    return PredicatonFromAut(PredicataEqualAut, l, n);
  else
    Error("EqualPredicaton failed, the arguments must be a list containing positive integers, the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  EqualNPredicaton(N, l, n)
##
##  Returns the Predicaton that recognizes x = N for N >= 0.
##
InstallGlobalFunction( EqualNPredicaton, function ( N, l, n )
  local A, B;
  if IsInt(N) and N >= 0 and Length(l) = 1 and IsValidInputList(l, n) then
    B:=DecToBin(N);
    Apply(B, i->[i]);
    A:=FormattedPredicaton(PredicatonFromAut(ListOfWordsToAutomaton(GetAbc(1),[B]), l, l));
    return ExpandedPredicaton(A, n);
  else
    Error("EqualNPredicaton failed, the first argument must be an integer greater equal 0, the second and third arguments must be a list containing positive integers, the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#V  PredicataAdditionAut
##
##  The automaton >AdditionAut< recognizes the language of
##  three binary strings s.t.:
##
##  PredicataAdditionAut( x, y, z ) :<=> x + y = z  
##
InstallValue( PredicataAdditionAut, 
              Automaton("det", 
                        3, 
                        [ [0,0,0],[1,0,0],[0,1,0],[1,1,0],[0,0,1],[1,0,1],[0,1,1],[1,1,1] ],
                        [ [1,3,3],[3,2,3],[3,2,3],[2,3,3],[3,1,3],[1,3,3],[1,3,3],[3,2,3] ],
                        [1],
                        [1]));
####################################################################################################
##
#F  AdditionPredicaton(l, n)
##
##  Returns the Predicaton that recognizes x + y = z 
##  with final variable position list n and inital variable position list l
##  where the order still matters, see also PredicatonFromAut and PermutedAlphabetPred.
##
InstallGlobalFunction( AdditionPredicaton, function ( l, n )
  if IsValidInputList(l, n) and Length(l) = 3 then
    return PredicatonFromAut(PredicataAdditionAut, l, n);
  else
    Error("AdditionPredicaton failed, the arguments must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  AdditionPredicaton3Summands(l, n)
##
##  Returns the Predicaton that recognizes x1 + x2 + x3 = z.
##
InstallGlobalFunction( AdditionPredicaton3Summands, function ( l, n )
  if IsValidInputList(l, n) and Length(l) = 4 then
    return PredicatonFromAut(Automaton("det", 4, GetAlphabet(4), 
                                 [[1,4,2,4],[4,2,4,4],[4,2,4,4],[2,4,3,4],[4,2,4,4],[2,4,3,4],[2,4,3,4],[4,3,4,4],
                                  [4,1,4,4],[1,4,2,4],[1,4,2,4],[4,2,4,4],[1,4,2,4],[4,2,4,4],[4,2,4,4],[2,4,3,4]], [1], [1]), l, n);
  else
    Error("AdditionPredicaton3Summands failed, the arguments must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  AdditionPredicaton4Summands(l, n)
##
##  Returns the Predicaton that recognizes x1 + ... + x4 = z.
##
InstallGlobalFunction( AdditionPredicaton4Summands, function ( l, n )
  if IsValidInputList(l, n) and Length(l) = 5 then
    return PredicatonFromAut(Automaton("det", 5, GetAlphabet(5), 
                                 [[1,3,5,5,5],[5,5,3,2,5],[5,5,3,2,5],[3,2,5,5,5],[5,5,3,2,5],[3,2,5,5,5],[3,2,5,5,5],[5,5,2,4,5],
                                  [5,5,3,2,5],[3,2,5,5,5],[3,2,5,5,5],[5,5,2,4,5],[3,2,5,5,5],[5,5,2,4,5],[5,5,2,4,5],[2,4,5,5,5],
                                  [5,5,1,3,5],[1,3,5,5,5],[1,3,5,5,5],[5,5,3,2,5],[1,3,5,5,5],[5,5,3,2,5],[5,5,3,2,5],[3,2,5,5,5],
                                  [1,3,5,5,5],[5,5,3,2,5],[5,5,3,2,5],[3,2,5,5,5],[5,5,3,2,5],[3,2,5,5,5],[3,2,5,5,5],[5,5,2,4,5]], [1], [1]), l, n);
  else
    Error("AdditionPredicaton4Summands failed, the arguments must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  AdditionPredicaton5Summands(l, n)
##
##  Returns the Predicaton that recognizes x1 +. .. + x5 = z.
##
InstallGlobalFunction( AdditionPredicaton5Summands, function ( l, n )
  if IsValidInputList(l, n) and Length(l) = 6 then
    return PredicatonFromAut(Automaton("det", 6, GetAlphabet(6),
                                 [[1,6,6,3,4,6],[6,4,3,6,6,6],[6,4,3,6,6,6],[3,6,6,4,2,6],[6,4,3,6,6,6],[3,6,6,4,2,6],
                                  [3,6,6,4,2,6],[6,2,4,6,6,6],[6,4,3,6,6,6],[3,6,6,4,2,6],[3,6,6,4,2,6],[6,2,4,6,6,6],
                                  [3,6,6,4,2,6],[6,2,4,6,6,6],[6,2,4,6,6,6],[4,6,6,2,5,6],[6,4,3,6,6,6],[3,6,6,4,2,6],
                                  [3,6,6,4,2,6],[6,2,4,6,6,6],[3,6,6,4,2,6],[6,2,4,6,6,6],[6,2,4,6,6,6],[4,6,6,2,5,6],
                                  [3,6,6,4,2,6],[6,2,4,6,6,6],[6,2,4,6,6,6],[4,6,6,2,5,6],[6,2,4,6,6,6],[4,6,6,2,5,6],
                                  [4,6,6,2,5,6],[6,5,2,6,6,6],[6,3,1,6,6,6],[1,6,6,3,4,6],[1,6,6,3,4,6],[6,4,3,6,6,6],
                                  [1,6,6,3,4,6],[6,4,3,6,6,6],[6,4,3,6,6,6],[3,6,6,4,2,6],[1,6,6,3,4,6],[6,4,3,6,6,6],
                                  [6,4,3,6,6,6],[3,6,6,4,2,6],[6,4,3,6,6,6],[3,6,6,4,2,6],[3,6,6,4,2,6],[6,2,4,6,6,6],
                                  [1,6,6,3,4,6],[6,4,3,6,6,6],[6,4,3,6,6,6],[3,6,6,4,2,6],[6,4,3,6,6,6],[3,6,6,4,2,6],
                                  [3,6,6,4,2,6],[6,2,4,6,6,6],[6,4,3,6,6,6],[3,6,6,4,2,6],[3,6,6,4,2,6],[6,2,4,6,6,6],
                                  [3,6,6,4,2,6],[6,2,4,6,6,6],[6,2,4,6,6,6],[4,6,6,2,5,6]], [1], [1]), l, n);
  else
    Error("AdditionPredicaton5Summands failed, the arguments must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
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
InstallGlobalFunction( AdditionPredicatonNSummandsIterative, function ( N, l, n )
  local A, I, i, m, n1;
  if not IsPosInt(N) or not Length(l) = N+1 or not IsValidInputList(l, n) then
    Error("AdditionPredicatonNSummandsIterative failed, the first argument must be a positive integer, the second and third parameter must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
  if N = 1 then                      # case N = 1: x = y
    return EqualPredicaton(l, n);
  elif N = 2 then
    return AdditionPredicaton(l, n);       # case N = 2: x_1 + x_2 = z
  elif N = 3 then
    return AdditionPredicaton3Summands(l, n);
  elif N = 4 then
    return AdditionPredicaton4Summands(l, n);
  elif N = 5 then
    return AdditionPredicaton5Summands(l, n);
  elif N > 5 then
    A:=[];
    m:=[1..N-2]+Maximum(n);            # N-2 intermediate variable needed
    n1:=Union(l, m);
    I:=AdditionPredicaton([l[1], l[2], m[1]], n1);  # x_1 + x_2 = t_1 
    for i in [2..N-2] do
      A:=AdditionPredicaton([m[i-1], l[i+1], m[i]], n1);
      I:=IntersectionPredicata(I, A, n1);
      I:=ProjectedPredicaton(I, m[i-1]);          # Eliminating the N-2 intermediate variables
      n1:=VariablePositionListOfPredicaton(I);
    od;
    A:=AdditionPredicaton([m[N-2], l[N], l[N+1]], n1);
    I:=IntersectionPredicata(I, A, n1);
    I:=ProjectedPredicaton(I, m[N-2]);
    return ExpandedPredicaton(I, n);
  else
    Error("AdditionPredicatonNSummandsIterative, wrong argument for N.\n");
  fi;
end);
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
InstallGlobalFunction( AdditionPredicatonNSummandsRecursive, function ( N, l, n )
  local A1, A2, N1, N2, l1, l2, m, n1;
  if not IsValidInputList(l, n) or not IsPosInt(N) or not Length(l) = N+1 then
    Error("AdditionPredicatonNSummandsRecursive failed, the first argument must be a positive integer, the second and third parameter must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
  if N = 1 then                      # case N = 1: only 1 variable left of the =
    return EqualPredicaton(l, n);
  elif N = 2 then
    return AdditionPredicaton(l, n);        # case N = 2: only 2 variable left of the =
  elif N > 2 then
    N1:=BestQuoInt(N, 2);
    if IsOddInt(N) then 
      N1:=N1+1;
    fi;
    N2:=N-N1+1;
    m:=[1+Maximum(n)];
    n:=Concatenation(n, m);
    l1:=Concatenation(l{[1..N1]}, m);
    l2:=Concatenation(m, l{[N1+1..N+1]});
    A1:=AdditionPredicatonNSummandsRecursive(N1, l1, l1);
    A2:=AdditionPredicatonNSummandsRecursive(N2, l2, l2);
    A1:=IntersectionPredicata(A1, A2, n);
    A1:=ProjectedPredicaton(A1, m[1]);
    return A1;
  else
    Error("AdditionPredicatonNSummandsRecursive, wrong argument for N.\n");
  fi;
end);
####################################################################################################
##
#F  AdditionPredicatonNSummandsExplicit(N, l, n)
##
##  Returns the Predicaton that recognizes x_1 + ... + x_n = z, 
##  with inital variable position list l, where the order still matters
##  and final variable position list n. 
##  
##  Creates the transition matrix explicitly with the property, where state i (state from 0..N)
##  denotes having carry i: 
##    Sum(a_1,...a_N-1) =  a_N + (i-1) + 2 * ( j - i )
##
InstallGlobalFunction( AdditionPredicatonNSummandsExplicit, function ( N, l, n )
  local A, Aut, T, i, j, k, s;
  if not IsValidInputList(l, n) or not IsPosInt(N) or not Length(l) = N+1 then
    Error("AdditionPredicatonNSummandsExplicit failed, the first argument must be a positive integer, the second and third parameter must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
  A:=GetAbc(N+1);
  if N = 1 then
    T:=[[1,2],[2,2],[2,2],[1,2]];
  elif N = 2 then
    T:=[[1,3,3],[3,2,3],[3,2,3],[2,3,3],[3,1,3],[1,3,3],[1,3,3],[3,2,3]];
  elif N = 3 then
    T:=[[1,4,2,4],[4,2,4,4],[4,2,4,4],[2,4,3,4],[4,2,4,4],[2,4,3,4],[2,4,3,4],[4,3,4,4],
        [4,1,4,4],[1,4,2,4],[1,4,2,4],[4,2,4,4],[1,4,2,4],[4,2,4,4],[4,2,4,4],[2,4,3,4]];
  elif N = 4 then
    T:=[[1,5,2,5,5],[5,2,5,3,5],[5,2,5,3,5],[2,5,3,5,5],[5,2,5,3,5],[2,5,3,5,5],[2,5,3,5,5],[5,3,5,4,5],
        [5,2,5,3,5],[2,5,3,5,5],[2,5,3,5,5],[5,3,5,4,5],[2,5,3,5,5],[5,3,5,4,5],[5,3,5,4,5],[3,5,4,5,5],
        [5,1,5,2,5],[1,5,2,5,5],[1,5,2,5,5],[5,2,5,3,5],[1,5,2,5,5],[5,2,5,3,5],[5,2,5,3,5],[2,5,3,5,5],
        [1,5,2,5,5],[5,2,5,3,5],[5,2,5,3,5],[2,5,3,5,5],[5,2,5,3,5],[2,5,3,5,5],[2,5,3,5,5],[5,3,5,4,5]];
  elif N = 5 then
    T:=[[1,6,2,6,3,6],[6,2,6,3,6,6],[6,2,6,3,6,6],[2,6,3,6,4,6],[6,2,6,3,6,6],[2,6,3,6,4,6],[2,6,3,6,4,6],[6,3,6,4,6,6],
        [6,2,6,3,6,6],[2,6,3,6,4,6],[2,6,3,6,4,6],[6,3,6,4,6,6],[2,6,3,6,4,6],[6,3,6,4,6,6],[6,3,6,4,6,6],[3,6,4,6,5,6],
        [6,2,6,3,6,6],[2,6,3,6,4,6],[2,6,3,6,4,6],[6,3,6,4,6,6],[2,6,3,6,4,6],[6,3,6,4,6,6],[6,3,6,4,6,6],[3,6,4,6,5,6],
        [2,6,3,6,4,6],[6,3,6,4,6,6],[6,3,6,4,6,6],[3,6,4,6,5,6],[6,3,6,4,6,6],[3,6,4,6,5,6],[3,6,4,6,5,6],[6,4,6,5,6,6],
        [6,1,6,2,6,6],[1,6,2,6,3,6],[1,6,2,6,3,6],[6,2,6,3,6,6],[1,6,2,6,3,6],[6,2,6,3,6,6],[6,2,6,3,6,6],[2,6,3,6,4,6],
        [1,6,2,6,3,6],[6,2,6,3,6,6],[6,2,6,3,6,6],[2,6,3,6,4,6],[6,2,6,3,6,6],[2,6,3,6,4,6],[2,6,3,6,4,6],[6,3,6,4,6,6],
        [1,6,2,6,3,6],[6,2,6,3,6,6],[6,2,6,3,6,6],[2,6,3,6,4,6],[6,2,6,3,6,6],[2,6,3,6,4,6],[2,6,3,6,4,6],[6,3,6,4,6,6],
        [6,2,6,3,6,6],[2,6,3,6,4,6],[2,6,3,6,4,6],[6,3,6,4,6,6],[2,6,3,6,4,6],[6,3,6,4,6,6],[6,3,6,4,6,6],[3,6,4,6,5,6]];
  else 
    T:=[1..2^(N+1)];
    Apply(T, i->[]);
    s:=Length(A[1]);
    for i in [1..N+1] do
      for k in [1..Length(A)] do
        j:=( Sum( A[k]{[1..s-1]} ) - A[k][s] + i + 1 ) / 2;
        if IsInt(j) and i < s then
          Add(T[k], j);
        else 
          Add(T[k], s);
        fi;
      od;
    od;
  fi;
  Aut:=Automaton("det", N+1, A, T, [1], [1]);
  return PredicatonFromAut(Aut, l, n);  
end);
####################################################################################################
##
#F  AdditionPredicatonNSummands(N, l, n)
##
##  Returns the Predicaton that recognizes x_1 + ... + x_n = z, 
##  with inital variable position list l, where the order still matters
##  and final variable position list n.
##
##  Calls AdditionPredicatonNSummandsExplicit.
##
InstallGlobalFunction( AdditionPredicatonNSummands, function ( N, l, n )
  return AdditionPredicatonNSummandsExplicit(N, l, n);
end);
####################################################################################################
##
#F  Times2Predicaton(l, n)
##
##  Returns Predicaton A recognizing 2*x=y. 
##  Predefined to speed up the following functions.
##
InstallGlobalFunction( Times2Predicaton, function ( l , n )
  if IsValidInputList(l,n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 3, GetAlphabet(2), [[1,3,3],[2,3,3],[3,1,3],[3,2,3]], [1], [1]), l, n );
  else
    Error("Times2Predicaton failed, the first and second argument must be a list containing postive integers.\n");
  fi;
end);
####################################################################################################
##
#F  Times3Predicaton(l, n)
##
##  Returns Predicaton A recognizing 3*x=y. 
##  Predefined to speed up the following functions.
##
InstallGlobalFunction( Times3Predicaton, function ( l , n )
  if IsValidInputList(l,n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 4, GetAlphabet(2), [[1,4,2,4],[4,3,4,4],[4,1,4,4],[2,4,3,4]] ,[1] ,[1]), l, n );
  else
    Error("Times3Predicaton failed, the first and second argument must be a list containing postive integers.\n");
  fi;
end);
####################################################################################################
##
#F  Times4Predicaton(l, n)
##
##  Returns Predicaton A recognizing 4*x=y. 
##  Predefined to speed up the following functions.
##
InstallGlobalFunction( Times4Predicaton, function ( l , n )
  if IsValidInputList(l,n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 5, GetAlphabet(2), [[1,2,2,3,2],[4,2,2,5,2],[2,2,1,2,3],[2,2,4,2,5]], [1], [1]), l, n);
  else
    Error("Times4Predicaton failed, the first and second argument must be a list containing postive integers.\n");
  fi;
end);
####################################################################################################
##
#F  Times5Predicaton(l, n)
##
##  Returns Predicaton A recognizing 5*x=y. 
##  Predefined to speed up the following functions.
##
InstallGlobalFunction( Times5Predicaton, function ( l , n )
  if IsValidInputList(l,n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 6, GetAlphabet(2), [[1,6,6,3,4,6], [6,5,2,6,6,6], [6,3,1,6,6,6], [4,6,6,2,5,6]], [1], [1]), l, n );
  else
    Error("Times5Predicaton failed, the first and second argument must be a list containing postive integers.\n");
  fi;
end);
####################################################################################################
##
#F  Times6Predicaton(l, n)
##
##  Returns Predicaton A recognizing 6*x=y. 
##  Predefined to speed up the following functions.
##
InstallGlobalFunction( Times6Predicaton, function ( l , n )
  if IsValidInputList(l,n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 7, GetAlphabet(2), [[1,7,7,3,4,7,7], [2,7,7,5,6,7,7], [7,3,1,7,7,4,7], [7,5,2,7,7,6,7]], [1], [1]), l, n );
  else
    Error("Times6Predicaton failed, the first and second argument must be a list containing postive integers.\n");
  fi;
end);
####################################################################################################
##
#F  Times7Predicaton(l, n)
##
##  Returns Predicaton A recognizing 7*x=y. 
##  Predefined to speed up the following functions.
##
InstallGlobalFunction( Times7Predicaton, function ( l , n )
  if IsValidInputList(l,n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 8, GetAlphabet(2), [[1,8,8,3,4,8,2,8], [8,6,5,8,8,7,8,8], [8,3,1,8,8,4,8,8], [2,8,8,5,6,8,7,8]], [1], [1]), l, n );
  else
    Error("Times7Predicaton failed, the first and second argument must be a list containing postive integers.\n");
  fi;
end);
####################################################################################################
##
#F  Times8Predicaton(l, n)
##
##  Returns Predicaton A recognizing 8*x=y. 
##  Predefined to speed up the following functions.
##
InstallGlobalFunction( Times8Predicaton, function ( l , n )
  if IsValidInputList(l,n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 9, GetAlphabet(2), [[1,2,2,3,4,2,2,7,2], [5,2,2,6,8,2,2,9,2], [2,2,1,2,2,4,3,2,7], [2,2,5,2,2,8,6,2,9]], [1], [1]), l, n );
  else
    Error("Times8Predicaton failed, the first and second argument must be a list containing postive integers.\n");
  fi;
end);
####################################################################################################
##
#F  Times9Predicaton(l, n)
##
##  Returns Predicaton A recognizing 9*x=y. 
##  Predefined to speed up the following functions.
##
InstallGlobalFunction( Times9Predicaton, function ( l , n )
  if IsValidInputList(l,n) and Length(l) = 2 then
    return PredicatonFromAut(Automaton("det", 10, GetAlphabet(2), [[1,2,2,3,4,5,2,2,2,9],[2,2,8,2,2,2,6,7,10,2],[2,2,1,2,2,2,9,4,3,2],[5,2,2,8,10,6,2,2,2,7]], [1], [1]), l, n );
  else
    Error("Times9Predicaton failed, the first and second argument must be a list containing postive integers.\n");
  fi;
end);
####################################################################################################
##
#F  TimesNPredicatonRecursive(l, n)
##
##  Returns Predicaton A recognizing N*x=y, for N > 0. 
##  Uses the predefined times Predicatons.
##
InstallGlobalFunction( TimesNPredicatonRecursive, function ( N, l, n )
  local A, T, I, T1, T2, N1, N2, m, r, d;
  if not IsPosInt(N) or not IsValidInputList(l, n) then
    Error("TimesNPredicatonRecursive failed, the first argument must be a positive integer, the second and third parameter must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
  if N = 1 then
    return EqualPredicaton(l, n );
  elif N = 2 then
    #Print(" Multiplication by t = ", N, " base case.\n");
    return Times2Predicaton(l, n);
  elif N = 3 then
    #Print(" Multiplication by t = ", N, " base case.\n");
    return Times3Predicaton(l, n);
  elif N = 4 then
    #Print(" Multiplication by t = ", N, " base case.\n");
    return Times4Predicaton(l, n);
  elif N = 5 then
    #Print(" Multiplication by t = ", N, " base case.\n");
    return Times5Predicaton(l, n);
  elif N = 6 then
    #Print(" Multiplication by t = ", N, " base case.\n");
    return Times6Predicaton(l, n);
  elif N = 7 then
    #Print(" Multiplication by t = ", N, " base case.\n");
    return Times7Predicaton(l, n);
  elif IsPrime(N) then   # If prime, just conclude with N-1, i.e. (N-1) x + x = z.
    #Print(" Multiplication by t = ", N, " is prime. Multiplication with t = ", N-1, " in the next step.\n");
    m:=Maximum(n)+1;
    n:=Concatenation(n, [m]);  # new variable position           
    A:=AdditionPredicaton([l[1], m, l[2]], n);         # x + newVar = z 
    T:=TimesNPredicatonRecursive(N-1, [l[1], m], n);  # (N-1) * x = newVar 
    I:=IntersectionPredicata(A, T, n);               # intersect both
    I:=ProjectedPredicaton(I, m);                     # existence quantifier on newVar.
    return I;
  else
    r:=RootInt(N);                              # floor of squareroot(N)
    d:=DivisorsInt(N);                          # all divisors    
    N1:=d{PositionsProperty(d,i -> i >= r)};    # take all divisors greater than floor of sqrt(N)
    N1:=N1[1];                                  # take the first one = N1
    N2:=N/N1;                                   # divide N by N1 = N2
    #Print(" Multiplication by t = ", N, ", t = t1 * t2 with t1 = ", N1, " and t2 = ", N2, ".\n");
    m:=Maximum(n)+1;
    n:=Union(n, [m]);                           # For N * x = z compute instead           
    T1:=TimesNPredicatonRecursive(N1, [l[1], m], n);  # N1 * x = newVar
    T2:=TimesNPredicatonRecursive(N2, [m, l[2]], n);  # N2 * newVar = z
    I:=IntersectionPredicata(T1, T2, n);        # intersect
    I:=ProjectedPredicaton(I, m);                         # eliminate newVar
    return I;
  fi;
end);
####################################################################################################
##
#F  TimesNPredicatonExplicit(N, l, n)
##
##  Returns Predicaton A recognizing N*x=y, for N > 0. 
##  
##  Creates the transition matrix explicitly.
##
InstallGlobalFunction( TimesNPredicatonExplicit, function ( N, l, n )
  local A, Aut, B, T, i, j, k;
  if not IsPosInt(N) or not IsValidInputList(l, n) then
    Error("TimesNPredicatonExplicit failed, the first argument must be a positive integer, the second and third parameter must be a list,   containing positive integers and the first list must be contained in the second list.\n");
  fi;
  A:=GetAbc(2);
  T:=[1..4];
  Apply(T, i->[]); 
  for i in [1..N+1] do
    for k in [1..Length(A)] do
      j:=(N * A[k][1] - A[k][2] + i + 1) / 2;
      if IsInt(j) and i < N+1 then
         Add(T[k], j);
      else 
         Add(T[k], N+1);
      fi;
    od;
  od;
  Aut:=Automaton("det", N+1, A, T, [1], [1]);
  return PredicatonFromAut(Aut, l, n);  
end);
####################################################################################################
##
#F  TimesNPredicaton(N, l, n)
##
##  Returns Predicaton A recognizing N*x=y, for N > 0.
## 
##  NOT: Calls TimesNPredRecursive with the relevant variable positions,
##  expands it afterwards.
##
##  Calls TimesNPredExplicit.
##
InstallGlobalFunction( TimesNPredicaton, function ( N, l, n )
  local A;
  if IsPosInt(N) and IsValidInputList(l, n) then
    return TimesNPredicatonExplicit(N, l, n);
  else
    Error("TimesNPredicaton failed, the first argument must be a positive integer, the second and third parameter must be a list, containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  SumOfProductsPredicaton(l, m, n)
##
##  Returns the Predicaton that recognizes t_1*x_1 + ... + t_2*x_N = 0, for integers t_i,
##  with inital variable position list l, where the order still matters
##  and final variable position list n. 
##  
##  Creates the transition matrix explicitly.
##
InstallGlobalFunction( "SumOfProductsPredicaton", function ( l, t, n )
local A, Aut, N, L, S, Sp, Sn, T, i, j, k, p, p0, q;
  if not (IsValidInputList(l, n) and IsList(t) and Length(l) = Length(t)) then
    Error("SumOfProductsPredicaton failed, the first and third argument must be a list, containing positive integers and the first list must be contained in the second list, the second argument must be a list, containing positive integers.\n");
  fi;
  p0:=Positions(t, 0);                # Looking at the different from zero multiplications.
  p:=Difference([1..Length(t)], p0);
  l:=l{p};
  t:=t{p};
  N:=Length(l);  
  #Print("l: ", l, " t: ", t, " n: ", n, " N: ", N, "\n");
  if N > 1 then
    A:=GetAbc(N);
    S:=ShallowCopy(t);
    Apply(S, i -> AbsInt(i));
    S:=Sum(S);
    Sp:=Sum(t{PositionsProperty(t, i -> i > 0)});
    Sn:=Sum(t{PositionsProperty(t, i -> i < 0)});
    #Print("S: ", S, " Sn: ", Sn, " Sp: ", Sp, "\n");
    if Sn = 0 or Sp = 0 then # if there are only positive or only negative multiplications then [0,...,0] is the only solution
      T:=[1..2^N];
      Apply(T, i -> [ 2, 2 ]);
      T[1][1]:=1;
      Aut:=Automaton("det", 2, GetAbc(N), T, [ 1 ], [ 1 ]);
    else 
      T:=[1..2^N];
      Apply(T, i->[]);
      L:=Reversed([ Sn+1..-1 ]);
      L:=Concatenation([ 0..Sp-1 ], L, [ S ]); # states from 0 to Sp-1, then from -1 to Sn+1, where each state q has carry q; 
      for i in L do                            # state S is the sink state.
        for k in [1..Length(A)] do
          if i < S then
            j:=( t * A[k] + i) / 2;  # transition rule
            #Print("a: ", A[k], " i = ", i, " -> j = " , j, "\n");
            if IsInt(j) and Sn < i and i < Sp and Sn < j and j < Sp then
              if j >= 0 then 
                Add(T[k], j+1);  # this maps the j-th state (if positive) to (j+1)-th states.
              else
                Add(T[k], Sp-j); # this maps the j-th state (if negative) to (Sp-j)-th states
              fi;
            else 
              Add(T[k], S);      # sink state
            fi;
          else
            Add(T[k], S);       # sink state
          fi;
        od;
      od;
      Aut:=Automaton("det", S, A, T, [ 1 ], [ 1 ]);
    fi;
  elif N = 1 then
    Aut:=Automaton("det", 2, GetAbc(1), [ [ 1, 2 ], [ 2, 2 ] ], [ 1 ], [ 1 ]); # accepts [0]*
  else
    Aut:=Automaton("det", 1, GetAbc(0), [ [ 1 ] ], [ 1 ], [ 1 ]); # accepts []*
  fi;
  return PredicatonFromAut(Aut, l, n); 
end);
####################################################################################################
##
#F  TermEqualTermPredicaton( l1, m1, i1, l2, m2, i2, n )
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
InstallGlobalFunction( TermEqualTermPredicaton, function ( l1, m1, i1, l2, m2, i2, n )
  local A, I, l, m, c, p, len, ls1, ls2, s1, s2, lu, u, w, i, j, k;
  #Print("l1: ", l1, " m1: ", m1, " i1: ", i1, "l2: ", l2, " m2: ", m2, " i2: ", i2, " n: ", n, "\n");
  if not (IsList(l1) and IsList(m1) and IsList(i1) and IsList(l1) and IsList(m1) and IsList(i1) and IsList(n) and ForAll(n, IsPosInt)) then
    Error("TermEqualTermPredicaton failed, the arguments must be lists.\n");
  elif not (Length(l1) = Length(m1) and Length(Positions(l1, "int")) = Length(i1) and Length(Positions(m1, "int")) = Length(i1) and ForAll(i1, i -> IsInt(i) and i >= 0) and IsSubsetSet(n, l1{PositionsProperty(l1, IsPosInt)})) then
    Error("TermEqualTermPredicaton failed, the first argument must be a list containing either variable positions or \"int\", the second argument must contain the multiplication integer or \"int\", and the third argument must contain positive integers.\n");   
  elif not (Length(l2) = Length(m2) and Length(Positions(l2, "int")) = Length(i2) and Length(Positions(m2, "int")) = Length(i2) and ForAll(i2,  i -> IsInt(i) and i >= 0) and IsSubsetSet(n, l2{PositionsProperty(l2, IsPosInt)})) then
    Error("TermEqualTermPredicaton failed, the fourth argument must be a list containing either variable positions or \"int\", the fifth argument must contain the multiplication integer or \"int\", and the sixth argument must contain positive integers.\n");   
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
        for k in [2..Length(p)] do
          Add(w, [l[p[k]], u[c]]);
          l[p[k]]:=u[c];
          c:=c+1;
        od;   
      fi;
    od;
    n:=Union(n, u);
  fi;
  #Print("l: ", l, " u: ", u, " w: ", w, "\n"); 
  lu:=len-lu; 
  # Sum of products
  A:=SumOfProductsPredicaton(l, m, n);
  # Left side: intersection with var = int
  for j in [1..ls1] do   
    I:=EqualNPredicaton(i1[j], [s1[j]], n);
    A:=IntersectionPredicata(A, I, n);
    A:=ProjectedPredicaton(A, s1[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  # Right side: intersection with var = int
  for j in [1..ls2] do   
    I:=EqualNPredicaton(i2[j], [s2[j]], n);
    A:=IntersectionPredicata(A, I, n);
    A:=ProjectedPredicaton(A, s2[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  # Both sides: intersection with var (double occurence) = var (new var)
  for j in [1..lu] do   
    I:=EqualPredicaton(w[j], n);
    A:=IntersectionPredicata(A, I, n);
    A:=ProjectedPredicaton(A, u[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  return SortedStatesAut(A);
end);
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
InstallGlobalFunction( NSummandsPredicaton, function ( N, l, t, m, i, n )
  local A, I, j, k, len, M, c, s, u, v, w, p, ls, lu, lv;
  if not IsList(l) or not IsList(t) or not IsList(m) or not IsList(m) or not IsList(i) or not IsList(n) or not IsPosInt(N) or not N+1=Length(l) or not Length(Positions(l,"int")) = Length(i) or not Length(Positions(l,"mult")) = Length(t) or not Length(t) = Length(m) then
    Error("NSummandsPredicaton failed, the first argument must be an integer, the others must be lists.\n The first integer gives the amount of summands, the second argument contains the variable position, if it's an integer it contains \"int\" or \"mult\" for multiplication.\n The third and fourth argument contain the information about the mutliplication in the N summands, the third argument at position i states the multiplication integer and the fourth argument at position i states the multiplication variable position of the i-th multiplication.\n The fifth argument states the integers for the integer addition.\n The last argument is the wanted resized variable position list.");
  fi;
  len:=Length(l);
  # replacing every non-multiplication integer with an variable and intersect with x = i.
  if n = [] then
    M:=0;
  else
    M:=Maximum(n);
  fi;
  ls:=Length(i);
  s:=[1..ls]+M;
  c:=1;
  for j in [1..len] do
    if l[j]="int" then
      l[j]:=s[c];
      c:=c+1;
    fi;
  od;
  n:=Union(n,s);
  # replacing the multiplication t*x with y and then intersecting with the aut t*x=y.
  if n = [] then
    M:=0;
  else
    M:=Maximum(n);
  fi;
  lv:=Length(t);          
  v:=[1..lv]+M; 
  c:=1;
  for j in [1..len] do
    if l[j]="mult" then
      l[j]:=v[c];
      c:=c+1;
    fi;
  od;
  n:=Union(n,v);
  # replacing every multiple occurence of variables with another variable and intersect with x = y
  if n = [] then
    M:=0;
  else
    M:=Maximum(n);
  fi;
  c:=1;
  lu:=Length(Unique(l));
  u:=[1..len-lu]+M;
  w:=[];
  if lu < len then  
    for j in [1..len] do 
      p:=Positions(l,l[j]);
      if Length(p) > 1 then
        for k in [2..Length(p)] do
          Add(w, [l[p[k]], u[c]]);
          l[p[k]]:=u[c];
          c:=c+1;
        od;   
      fi;
    od;
    n:=Union(n,u);
  fi;
  lu:=len-lu; 
  # AdditionAut containing of N summands = var, where each summand is a unique variable
  A:=AdditionPredicatonNSummands(N, l, n);
  # intersection with var = int
  for j in [1..ls] do   
    I:=EqualNPredicaton(i[j], [s[j]], n);
    A:=IntersectionPredicata(A, I, n);
    A:=ProjectedPredicaton(A,s[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  # intersection with var (double occurence) = var (new var)
  for j in [1..lu] do   
    I:=EqualPredicaton(w[j], n);
    A:=IntersectionPredicata(A,I,n);
    A:=ProjectedPredicaton(A,u[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  # intersection with times * var = var
  for j in [1..lv] do   
    I:=TimesNPredicaton(t[j], [m[j],v[j]], n);
    A:=IntersectionPredicata(A,I,n);
    A:=ProjectedPredicaton(A,v[j]);
    n:=VariablePositionListOfPredicaton(A);
  od;
  return A;
end);
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
InstallGlobalFunction( TermEqualAtomPredicaton, function ( N, l, t, m, i, n )
  local A, j, n1, c;
  if not IsList(l) or not IsList(t) or not IsList(m) or not IsList(m) or not IsList(i) or not IsList(n) or not IsPosInt(N) or not N+1=Length(l) or not Length(Positions(l,"int")) = Length(i) or not Length(Positions(l,"mult")) = Length(t) or not Length(t) = Length(m) then
    Error("TermEqualAtomPredicaton failed, the first argument must be an integer, the others must be lists.\n The first integer gives the amount of summands, the second argument contains the variable position, if it's an integer it contains \"int\" or \"mult\" for multiplication.\n The third and fourth argument contain the information about the mutliplication in the N summands, the third argument at position i states the multiplication integer and the fourth argument at position i states the multiplication variable position of the i-th multiplication.\n The fifth argument states the integers for the integer addition.\n The last argument is the wanted resized variable position list.");
  fi;
  n1:=[];                       # temporary neccessary resized variable position list
  c:=1;
  for j in [1..Length(l)] do
    if l[j]="mult" then         # add all "mult" occurences to n1
      Add(n1,m[c]);
      c:=c+1;
    elif not l[j]="int" then
      Add(n1,l[j]);             # add all non "int" occurences to n1
    fi;
  od;
  A:=NSummandsPredicaton(N, l, t, m, i, n1); # call it with n1 instead n
  return ExpandedPredicaton(A, n);       # expand it to n.
end);
####################################################################################################
##
#F  GreaterEqualNPredicaton(N, l, n)
##
##  Returns the Predicaton which recognizes the language of x >= N.
##  I.e. x >= N <=> E n1: E n2: n1 + n2 = x and n2 = N.
##
InstallGlobalFunction( GreaterEqualNPredicaton, function (N, l, n)
  local A, EN, i, m, n1;
  if not IsInt(N) or N < 0 or not Length(l) = 1 or not IsValidInputList(l, n) then
    Error("GreaterEqualNPredicaton failed, the first argument must be an integer greater equal 0, the second and third arguments must be a list containing positive integers, the first list must be contained in the second list.\n");
  fi;
  m:=[1,2]+Maximum(n);
  n1:=Union(l, m);
  A:=AdditionPredicaton([m[1], m[2], l[1]], n1);
  EN:=EqualNPredicaton(N, [m[2]], n1);
  A:=IntersectionPredicata(A, EN, n1);
  for i in m do
    A:=ProjectedPredicaton(A, i);
  od;
  A:=ExpandedPredicaton(A, n);
  return A;
end);
####################################################################################################
##
#F  GreaterNPredicaton(N, l, n)
##
##  Returns the Predicaton which recognizes the language of x > N.
##
InstallGlobalFunction( GreaterNPredicaton, function (N , l, n)
  return GreaterEqualNPredicaton(N+1, l, n);
end);
####################################################################################################
##
#F  SmallerEqualNPredicaton(N, l, n)
##
##  Returns the Predicaton which recognizes the language of x <= N.
##
InstallGlobalFunction( SmallerEqualNPredicaton, function (N , l, n)
  return NegatedAut(GreaterEqualNPredicaton(N+1, l, n));
end);
####################################################################################################
##
#F  SmallerNPredicaton(N, l, n)
##
##  Returns the Predicaton which recognizes the language of x < N.
##
InstallGlobalFunction( SmallerNPredicaton, function (N , l, n)
  return NegatedAut(GreaterEqualNPredicaton(N, l, n));
end);
####################################################################################################
##
#F  GreaterEqualPredicaton(l, n)
##
##  Returns the Predicaton which recognizes the language of x >= y,
##  I.e. x >= y <=> E m: y + m = x.
##
InstallGlobalFunction( GreaterEqualPredicaton, function(l, n) 
  local A, m, n1;
  if not IsValidInputList(l, n) or not Length(l) = 2 then
    Error("GreaterEqualPredicaton failed, the arguments must be a list containing positive integers and the first list must be contained in the second list.\n");
  fi;
  m:=[1]+Maximum(n);
  n1:=Union(l, m);
  A:=AdditionPredicaton([l[2], m[1], l[1]], n1);
  A:=ProjectedPredicaton(A, m[1]);
  return ExpandedPredicaton(A, n);
end);
####################################################################################################
##
#F  GreaterPredicaton(l, n)
##
##  Returns the Predicaton which recognizes the language of x > y,
##  I.e. x >= y <=> E m: y + m = x and m >=1.
##
InstallGlobalFunction( GreaterPredicaton, function(l, n) 
  local A, G, m, n1;
  if not IsValidInputList(l, n) or not Length(l) = 2 then
    Error("GreaterPredicaton failed, the arguments must be a list containing positive integers and the first list must be contained in the second list.\n");
  fi;
  m:=[1]+Maximum(n);
  n1:=Union(n, m);
  Sort(n1);
  A:=AdditionPredicaton([l[2], m[1], l[1]], n1);
  G:=GreaterEqualNPredicaton(1, m, n1);
  A:=IntersectionPredicata(A, G, n1);
  A:=ProjectedPredicaton(A, m[1]);  
  return ExpandedPredicaton(A, n);
end);
####################################################################################################
##
#F  SmallerEqualPredicaton(l, n)
##
##  Returns the Predicaton which recognizes the language of x <= y.
##
InstallGlobalFunction( SmallerEqualPredicaton, function(l, n) 
  if IsValidInputList(l, n) and Length(l) = 2 then
    return NegatedAut(GreaterPredicaton(l, n));
  else
    Error("GreaterEqualPredicaton failed, the arguments must be a list containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  SmallerPredicaton(l, n)
##
##  Returns the Predicaton which recognizes the language of x < y.
##
InstallGlobalFunction( SmallerPredicaton, function(l, n) 
  if IsValidInputList(l, n) and Length(l) = 2 then
    return NegatedAut(GreaterEqualPredicaton(l, n));
  else
    Error("SmallerPredicaton failed, the arguments must be a list containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  BuchiPredicaton(l, n)
##
##  Returns the Predicaton which gives the Büchi automaton, 
##  i.e. l[2] is the largest power of 2 which divides l[1]. 
##
InstallGlobalFunction( BuchiPredicaton, function(l, n)
  local A;
  if IsValidInputList(l, n) and Length(l) = 2 then
    A:=Automaton("det", 3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], [ [ 1, 2, 3 ], [ 3, 2, 3 ], [ 3, 3, 3], [ 2, 3, 3 ] ], [ 1 ], [ 2 ]);
    return PredicatonFromAut(A, l, n);
  else
    Error("BuchiPredicaton failed, the arguments must be lists containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
####################################################################################################
##
#F  PowerPredicaton(l, n)
##
##  Returns the Predicata which gives all powers of 2.
##
InstallGlobalFunction( PowerPredicaton, function(l, n)
  local A;
  if IsValidInputList(l, n) and Length(l) = 1 then
    A:=Automaton("det", 3, [ [ 0 ], [ 1 ] ], [ [ 1, 2, 3 ], [ 2, 3, 3 ] ], [ 1 ], [ 2 ]);
    return PredicatonFromAut(A, l, n);
  else
    Error("PowerPredicaton failed, the arguments must be lists containing positive integers and the first list must be contained in the second list.\n");
  fi;
end);
##
#E
##
