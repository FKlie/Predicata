####################################################################################################
##
##  This file installs some auxiliary functions.
##
####################################################################################################
##
#F  MaximumOrZero(l)
##
##  Returns the maximum or 0 if l is empty.
##
BindGlobal( "MaximumOrZero", function ( l )
  if l = [] then
    return 0;
  else
    return Maximum(l);
  fi;
end);
####################################################################################################
##
#F  PredicataAlphabet(N[,base])
##
##  Returns the alphabet of length N, i.e. ({0,1})^N.
##
InstallGlobalFunction( PredicataAlphabet, function ( N, args...)
  local a, b, n, i, j, k;
  if not IsInt(N) or N < 0 then
    Error("PredicataAlphabet failed, input must be an integer greater equal 0.\n");
  fi;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  a:=[[]];
  for n in [1..N] do
    for i in [1..Length(a)] do
      b:=[];
      for j in [0..k-1] do
        b[j+1]:=List([1..Length(a)],l->Concatenation(ShallowCopy(a[l]),[j]));
      od;
    od;
    a:=Concatenation(b);
  od;
  return a;
end);
BindGlobal( "PredicataAlphabet2", function ( N, args...)
 local a0, a1, n, i, p;
  if not IsInt(N) or N < 0 then
    Error("PredicataAlphabet failed, input must be an integer greater equal 0.\n");
  fi;
  a0:=[[]];
  a1:=[[]];
  p:=1;
  for n in [1..N] do
    for i in [1..Length(a0)] do
      Add(a0[i], 0, p);
      Add(a1[i], 1, p);
    od;
    Append(a0, a1);
    a1:=StructuralCopy(a0);
    p:=p+1;
  od;
  return a0;
end);
####################################################################################################
##
#F  DecToBaseRep(D[,base])
##
##  Converts a decimal number into a base k=PredicataBase representation. 
##  Note: The binary representation list is reversed, i.e.
##        D = B[1] * k^0 + B[2] * k^1 + ...
##
InstallGlobalFunction( DecToBaseRep, function ( D, args... )
  local i, k, B;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  if not IsInt(D) or D < 0 then
    Error("DecToBaseRep failed, the argument must be an integer greater equal than 0.\n");
  fi;
  B:=[];
  if D = 0 then
    return [0];
  fi;
  while D > 0 do
    Add(B,RemInt(D,k));
    D:=QuoInt(D,k);
  od;
  return B;
end);
####################################################################################################
##
#F  BaseRepToDec(B[,base])
##
##  Converts a base k=PredicataBase representation list into a decimal number 
##  Note: The base k representation list is reversed, i.e.
##        B[1] * k^0 + B[2] * k^1 +... = D
##
InstallGlobalFunction( BaseRepToDec, function ( B, args... )
  local i, k, D;
  if Length(args) = 0 then
    k:=ReturnPredicataBase();
  elif Length(args) = 1 and IsInt(args[1]) and args[1]>1 then
    k:=args[1];
  fi;
  if not IsList(B) or (not B=[] and (Maximum(B) >= k or Minimum(B) < 0)) then
    Error("BaseRepToDec failed, the argument must be a list containing 0,..,k-1.\n");
  fi;
  D:=0;
  for i in [1..Length(B)] do
    D:=D+B[i]*k^(i-1);
  od;
  return D;
end);
####################################################################################################
##
#F  DecToBin(D)
##
##  Converts a decimal number into a binary number. 
##  Note: The binary representation list is reversed, i.e.
##        D = B[1] * 2^0 + B[2] * 2^1 + ...
##
InstallGlobalFunction( DecToBin, function ( D )
  if not IsInt(D) or D < 0 then
    Error("DecToBin failed, the argument must be an integer greater equal than 0.\n");
  fi;
  return DecToBaseRep(D, 2);
end);
####################################################################################################
##
#F  BinToDec(B)
##
##  Converts a binary number list into a decimal number 
##  Note: The binary representation list is reversed, i.e.
##        B[1] * 2^0 + B[2] * 2^1 +... = D
##
InstallGlobalFunction( BinToDec, function ( B )
  local i, D;
  if not IsList(B) or (not B=[] and (Maximum(B) > 1 or Minimum(B) < 0)) then
    Error("BinToDec failed, the argument must be a list containing 0s and 1s.\n");
  fi;
  return BaseRepToDec(B, 2);
end);
####################################################################################################
##
#F  PredicataStack()
##
InstallGlobalFunction( PredicataStack, function ()
  local A, F, stack;
  # Defining new family
  F:=NewFamily("predicataStackFam", IsPredicataStackObj);
  stack:=rec(list:=[]);
  A:=Objectify(NewType(F, IsPredicataStackObj and IsPredicataStackRep and IsAttributeStoringRep), stack);
  # Return the stack.
  return A;
end);
####################################################################################################
##
#M  ViewObj(Stack)
##
InstallMethod( ViewString,
        "Displays a stack.",
        true,
        [IsPredicataStackObj and IsPredicataStackRep], 0,
        function( Stack )
  return "< Stack >";
end);
####################################################################################################
##
#M  DisplayString(Stack)
##
InstallMethod ( DisplayString,
        "Displays a stack",
        true,
        [IsPredicataStackObj and IsPredicataStackRep], 0,
        function( Stack )
  local l, len, i, S;
  l:=StructuralCopy(Stack!.list);
  len:=Length(l);
  S:=" Stack:\n  Top\n";
  for i in [1..Length(l)] do
    S:=Concatenation("  ", String(l[len-i+1]), "\n");
  od;
  return S;
end);
####################################################################################################
##
#F  IsEmptyPredicataStack(Stack)
##
InstallGlobalFunction( IsEmptyPredicataStack, function ( Stack )
  if IsPredicataStackObj(Stack) then
    if Stack!.list=[] then
      return true;
    else
      return false;
    fi;
  else 
    Error("predicataIsEmpty failed, the argument must be of type stack.\n");
  fi;
end);
####################################################################################################
##
#F  PushPredicataStack(Stack, element)
##
InstallGlobalFunction( PushPredicataStack,  function ( Stack, element )
  if IsPredicataStackObj(Stack) then
    Add(Stack!.list, element);
  else
    Error("predicataPush failed, the first argument must be of type stack.\n");
  fi;
end);
####################################################################################################
##
#F  PopPredicataStack(Stack)
##
InstallGlobalFunction( PopPredicataStack, function ( Stack )
  if IsPredicataStackObj(Stack) and not IsEmptyPredicataStack(Stack) then
    return Remove(Stack!.list,Length(Stack!.list));
  else
    Error("predicataPop failed, the argument must be of type stack.\n");
  fi;
end);
####################################################################################################
##
#F  TopPredicataStack(Stack)
##
InstallGlobalFunction( TopPredicataStack, function ( Stack )
  if IsPredicataStackObj(Stack) then
    return Stack!.list[Length(Stack!.list)];
  else 
    Error("predicataTop failed, the argument must be of type stack.\n");
  fi;
end);
####################################################################################################
##
#M  String(A)
##
InstallMethod( String,
               "Stack", 
               true, 
               [IsPredicataStackObj and IsPredicataStackRep], 0, 
               function( Stack )
  local S, i;
  S:=String("MyStack:=predicataStack();");
  for i in Stack!.list do
    S:=Concatenation(S,"predicataPush(MyStack,", String(i), ");");
  od;
  return S;
end); 
##
#E
##
