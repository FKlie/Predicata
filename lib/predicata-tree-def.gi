####################################################################################################
##
##  This file installs functions for PredicataTrees.
##
####################################################################################################
##
#F  PredicataTree()
##
InstallGlobalFunction( PredicataTree, function (args...)
  local A, F, r, predtree, predcurrent, predstack, treeobj;
  if Length(args) = 0 then
    r:="";
  elif Length(args) = 1 then
    r:=args[1];
  else
    Error("PredicataTree failed, only one optional argument allowed.\n");
  fi;
  # Defining new family
  F:=NewFamily("PredicataTreeFam", IsPredicataTreeObj);
  predtree:=[r];
  predcurrent:=predtree;
  predstack:=PredicataStack();
  PushPredicataStack(predstack, predtree);
  treeobj:=rec(tree:=predtree, currenttree:=predcurrent, stack:=predstack, predrep:=PredicataRepresentation(), bounded:=[], free:=[]);
  A:=Objectify(NewType(F, IsPredicataTreeObj and IsPredicataTreeRep and IsAttributeStoringRep), treeobj);
  # Return the tree.
  return A;
end);
####################################################################################################
##
#F  IsPredicataTree(t)
##
##  Tests if f is from type PredicataTree.
##
InstallGlobalFunction( IsPredicataTree, function( t )
    return(IsPredicataTreeObj(t));
end);
####################################################################################################
##
#M  DisplayString(t)
##
InstallMethod ( DisplayString,
  "Returns the PredicataTree \"nicely\" formatted.",
  true,
  [IsPredicataTreeObj and IsPredicataTreeRep], 0,
  function( t )
    return Concatenation("PredicataTree: ", String(t!.tree), ".\n");
end);
####################################################################################################
##
#M  ViewString(t)
##
InstallMethod( ViewString,
  "Returns the most important informations about the PredicataTree.",
  true,
  [IsPredicataTreeObj and IsPredicataTreeRep], 0,
  function( t )
    return Concatenation("< PredicataTree: " , String(t!.tree), " >");
end);
####################################################################################################
##
#M  String(t)
##
InstallMethod( String,
  "Returns the PredicataTree as string.",
  true,
  [IsPredicataTreeObj and IsPredicataTreeRep], 0,
  function( t )
    return Concatenation("PredicataTree: " , String(t!.tree));
end);
####################################################################################################
##
#F  IsEmptyPredicataTree(t)
##
##  Checks if the tree is empty.
##
InstallGlobalFunction( IsEmptyPredicataTree, function (t) 
  if IsPredicataTreeObj(t) then
    if Length(t!.currenttree) = 0 then
      return true;
    else
      return false;
    fi;
  else
    Error("IsEmptyPredicataTree failed, the argument must be a PredicataTree.\n");
  fi;
end); 
####################################################################################################
##
#F  RootOfPredicataTree(t)
##
##  Returns the root of the tree.
##
InstallGlobalFunction( RootOfPredicataTree, function (t)
  if IsPredicataTreeObj(t) and not IsEmptyPredicataTree(t) then
    return t!.currenttree[1];
  else 
    Error("RootOfPredicataTree failed, the argument must be a PredicataTree.\n");
  fi;
end);
####################################################################################################
##
#F  SetRootOfPredicataTree(t, n)
##
##  Sets the root of the tree t to the input n.
##
InstallGlobalFunction( SetRootOfPredicataTree, function ( t , n )
  if IsPredicataTreeObj(t) then
    t!.currenttree[1]:=n;
  else 
    Error("SetRootOfPredicataTree failed, the argument must be a PredicataTree.\n");
  fi;
end);
####################################################################################################
##
#F  InsertChildToPredicataTree(t)
##
##  Adds to the tree an additional child.
##
InstallGlobalFunction( InsertChildToPredicataTree, function ( t )
  if IsPredicataTreeObj(t) then
    Add(t!.currenttree, []);
  else 
    Error("InsertChildToPredicataTree failed, the argument must be a PredicataTree.\n");
  fi;
end);
####################################################################################################
##
#F  ChildOfPredicataTree(t, i)
##
##  Returns the i-th child of the tree, and remembers its origin
##  by pushing the current tree on the stack.
##
InstallGlobalFunction( ChildOfPredicataTree, function ( t, i )
  if IsPredicataTreeObj(t) and not IsEmptyPredicataTree(t) and IsPosInt(i) and i+1 <= Length(t!.currenttree) then
    PushPredicataStack(t!.stack,t!.currenttree);
    t!.currenttree:=t!.currenttree[i+1];
    return t;
  else 
    Error("ChildOfPredicataTree failed, the first argument must be a PredicataTree and the second a positive integer.\n");
  fi;
end);
####################################################################################################
##
#F  ReturnedChildOfPredicataTree(t, i)
##
##  Returns the i-th child of the tree.
##
InstallGlobalFunction( ReturnedChildOfPredicataTree, function ( t, i )
  local T;
  if IsPredicataTreeObj(t) and not IsEmptyPredicataTree(t) and IsPosInt(i) and i+1 <= Length(t!.currenttree) then
    T:=PredicataTree();
    T!.tree:=StructuralCopy(t!.currenttree[i+1]);
    T!.currenttree:=StructuralCopy(t!.currenttree[i+1]);
    T!.stack:=PredicataStack();
    PushPredicataStack(T!.stack, T!.tree);
    T!.predrep:=CopyPredicataRepresentation(t!.predrep);
    T!.bounded:=StructuralCopy(t!.bounded);
    T!.free:=StructuralCopy(t!.bounded);
    return T;
  else 
    Error("ReturnedChildOfPredicataTree failed, the first argument must be a PredicataTree and the second a positive integer.\n");
  fi;
end);
####################################################################################################
##
#F  NumberOfChildrenOfPredicataTree(t)
##
##  Returns number of children of the current tree root.
##
InstallGlobalFunction( NumberOfChildrenOfPredicataTree, function ( t )
  if IsPredicataTreeObj(t) and not IsEmptyPredicataTree(t) then
    return Length(t!.currenttree)-1;
  else 
    Error("NumberOfChildrenOfPredicataTree failed, the first argument must be a PredicataTree.\n");
  fi;
end);
####################################################################################################
##
#F  ParentOfPredicataTree(t)
##
##  Returns the parent of the tree, if there is one.
##
InstallGlobalFunction( ParentOfPredicataTree, function ( t )
  if IsPredicataTreeObj(t) and not IsEmptyPredicataStack(t!.stack) then
    t!.currenttree:=PopPredicataStack(t!.stack);
    return t;
  else 
    Error("ParentOfPredicataTree failed, the argument must be a PredicataTree with an existing parent.\n");
  fi;
end);
####################################################################################################
##
#F  PredicataRepresentationOfPredicataTree(t)
##
##  Returns the PredicataRepresentation of the PredicataTree.
##
InstallGlobalFunction( PredicataRepresentationOfPredicataTree, function ( t )
  if IsPredicataTreeObj(t) then
    return CopyPredicataRepresentation(t!.predrep);
  else 
    Error("BoundedVariablesOfPredicataTree failed, the argument must be a PredicataTree.\n");
  fi;
end);
####################################################################################################
##
#F  BoundedVariablesOfPredicataTree(t)
##
##  Returns the bounded variables of the tree.
##
InstallGlobalFunction( BoundedVariablesOfPredicataTree, function ( t )
  if IsPredicataTreeObj(t) then
    return ShallowCopy(t!.bounded);
  else 
    Error("BoundedVariablesOfPredicataTree failed, the argument must be a PredicataTree.\n");
  fi;
end);
####################################################################################################
##
#F  FreeVariablesOfPredicataTree(t)
##
##  Returns the free variables of the tree.
##
InstallGlobalFunction( FreeVariablesOfPredicataTree, function ( t )
  if IsPredicataTreeObj(t) then
    return ShallowCopy(t!.free);
  else 
    Error("BoundedVariablesOfPredicataTree failed, the argument must be a PredicataTree.\n");
  fi;
end);
####################################################################################################
##
#F  PredicataFormulaFormattedToTree(F)
##
##  Converts a PredicataFormulaFormatted into a PredicataTree.
##
InstallGlobalFunction( PredicataFormulaFormattedToTree, function ( F )
  local f, P, Pnames, Parities, T, i, counter;
  if not IsPredicataFormulaFormatted(F) then
    Error("PredicataFormulaFormattedToTree failed, the first argument must be a PredicataFormulaFormatted.\n");
  fi;
  f:=F!.stringlist;
  P:=F!.predrep;
  Pnames:=NamesOfPredicataRepresentation(P);
  Parities:=AritiesOfPredicataRepresentation(P);
  T:=PredicataTree();
  T!.predrep:=P;
  T!.bounded:=F!.bounded;
  T!.free:=F!.free;
  i:=1;
  while i <= Length(f) do
    # Case 1: "(" and ("A or "E" or "not"), sets root to the symbol, and inserts and enters first child.
    if i < Length(f) and f[i] = "(" and (PredicataIsStringType(f[i+1], "quantifier") or PredicataIsStringType(f[i+1], "unarysymbol")) then
      SetRootOfPredicataTree(T, f[i+1]);
      InsertChildToPredicataTree(T);
      ChildOfPredicataTree(T, 1);
      i:=i+2;
    # Case 2: "(" and "-" and "int" and ")",  sets the root to a negative integer and enters parent.
    elif i < Length(f) - 2 and f[i] = "(" and f[i+1] = "-" and PredicataIsStringType(f[i+2], "integer") and f[i+3] = ")" then
      SetRootOfPredicataTree(T, Concatenation(f[i+1], f[i+2]));
      ParentOfPredicataTree(T);
      i:=i+4;
    # Case 3: "(" and not a quantifier or not, sets root to empty string, filled up later, and inserts and enters first child.
    elif f[i] = "(" then    
      SetRootOfPredicataTree(T, " ");
      InsertChildToPredicataTree(T);
      ChildOfPredicataTree(T, 1);
      i:=i+1;
    # Case 4: predicate symbol and "[", sets the counter to one, used for the variables the predicate is called with,
    # increased with every "," by one. Sets root to the predicate symbol, and inserts and enters the first child.
    elif i < Length(f) and (PredicataIsStringType(f[i], "predicate") or f[i] in Pnames) and f[i+1] = "[" then  
      counter:=1;
      SetRootOfPredicataTree(T, f[i]);
      InsertChildToPredicataTree(T);
      ChildOfPredicataTree(T, 1);
      i:=i+2;
    # Case 5: variable, integer or boolean, sets the root and enters parent.
    elif PredicataIsStringType(f[i], "variable") or PredicataIsStringType(f[i], "integer") or PredicataIsStringType(f[i], "boolean") or (f[i] in Pnames and Parities{Positions(Pnames, f[i])} = [ 0 ]) then
      SetRootOfPredicataTree(T, f[i]);
      ParentOfPredicataTree(T);
      i:=i+1;
    # Case 6: binary symbol, overwriting the previously empty root " ". Then insert and enter the second child.
    elif PredicataIsStringType(f[i], "binarysymbol") then
      if not RootOfPredicataTree(T) = " " then
        Error("PredicataFormulaFormattedToTree failed, attempting to overwrite the following function symbol: >", RootOfPredicataTree(T), "< with >", f[i], "< at position ", i, ".\n");
      fi;
      SetRootOfPredicataTree(T, f[i]);
      InsertChildToPredicataTree(T);
      ChildOfPredicataTree(T, 2);
      i:=i+1;
    # Case 7: ":" from the quantifers, does not set a root, just inserts and enters a second child
    elif f[i] = ":" then
      InsertChildToPredicataTree(T);
      ChildOfPredicataTree(T, 2);
      i:=i+1;
    # Case 8: "," from predicate, increases the counter by one, inserts and enters the (counter+1)-th child
    elif f[i] = "," then
      counter:=counter+1;
      InsertChildToPredicataTree(T);
      ChildOfPredicataTree(T, counter);
      i:=i+1;
    # Case 9: ")" or "]", enters the parent
    elif ( f[i] = ")" or f[i] = "]" ) then
      ParentOfPredicataTree(T);
      i:=i+1;
    # Case 10: invalid element, error
    else    
      Error("PredicataFormulaFormattedToTree failed, the following list element is invalid or placed at the wrong position: ",f[i],".\n");
    fi;
  od;
  return T;
end);
####################################################################################################
##
#B  FixedVariablePositions(F, V)
##
##  Returns the positions of the first list in the second list.
##
BindGlobal("FixedVariablePositions", function (l1, l2)
  local l;
  l:=ShallowCopy(l1);
  Apply(l, i->Position(l2, i));
  return l;
end);
####################################################################################################
##
#F  PredicataTreeToPredicatonRecursive(T, V)
##
##  Converts a PredicataTree into one Predicaton.
##
InstallGlobalFunction( PredicataTreeToPredicatonRecursive, function (T, V)
  local c, c1, c2, root, l, P, Pnames, p, v, n, i;
  if not IsPredicataTree(T) then
    Error("PredicataTreeToPredicatonRecursive failed, the argument must be a PredicataTree.\n");
  fi;
  c:=[];
  P:=PredicataRepresentationOfPredicataTree(T);
  Pnames:=NamesOfPredicataRepresentation(P);
  # Case: more than two children
  if NumberOfChildrenOfPredicataTree(T) > 2 then                                             
    root:=RootOfPredicataTree(T);
    l:=NumberOfChildrenOfPredicataTree(T);
    for i in [1..l] do 
      c[i]:=PredicataTreeToPredicatonRecursive(ReturnedChildOfPredicataTree(T, i), V);   # call all childrens.
    od;
    if fail in c then 
      return fail;
    fi;
    l:=Length(c);
    if root in Pnames then                                                  # root is a string contained in the names of the predicate represenation.
      p:=ElementOfPredicataRepresentation(P, Position(Pnames, root));       # get the corresponding predicata represenation element
      if ArityOfPredicatonRepresentation(p) <> l then
        Error("PredicataTreeToPredicatonRecursive failed, the predicate arity is ", ArityOfPredicatonRepresentation(p), ", but the predicate is called on ", l , " variables.\n");
      else
        n:=FixedVariablePositions(V[1],V[2]);
        v:=[];
        for i in [1..l] do
          if c[i][1] = "var" then
            v[i]:=c[i][2];
          else
            Error("PredicataTreeToPredicatonRecursive failed, the predicate contains a non-variable.\n");
          fi;
        od;
        return ["Pred", PredicatonFromAut(AutOfPredicatonRepresentation(p), Concatenation(v), n )];               
      fi;
    else 
      Error("PredicataTreeToPredicatonRecursive failed due to the invalid symbol:", root, ".\n");
    fi;
  # Case: two children 
  elif  NumberOfChildrenOfPredicataTree(T) = 2 then
    root:=RootOfPredicataTree(T);
    if root = "E" or root = "A" then                                         # quantifier
      V[1]:=Concatenation(V[1], [RootOfPredicataTree(ReturnedChildOfPredicataTree(T, 1))]);         # add the quantified variable to the variable list
      #Print("Added here a variable:", V, "\n");
    fi;
    c1:=PredicataTreeToPredicatonRecursive(ReturnedChildOfPredicataTree(T, 1), V);    # call the recursive evaluation on the first child
    c2:=PredicataTreeToPredicatonRecursive(ReturnedChildOfPredicataTree(T, 2), V);    # call the recursive evaluation on the second child
    if c1 = fail or c2 = fail then 
      return fail;
    fi;
    if root = "+" then                                                        # Symbol +
      if c1[1] = "var" and c2[1] = "var" then                                 # Var + Var 
        return ["Term", Concatenation(c1[2], c2[2]), [1, 1], []];                  # "Term", Variables, Integer Multiplication, Integer         
        #return ["Term", 2, Concatenation(c1[2], c2[2]), [], [], []];              # "Term", #Summands, Variables, Integer Multiplication, Variable Multiplication, Integer
      elif c1[1] = "int" and c2[1] = "int" then                               # Int + Int         
        return ["Term", ["int", "int"], ["int", "int"], Concatenation(c1[2],c2[2])];
        #return ["Term", 2, Concatenation(["int"], ["int"]), [], [], Concatenation(c1[2],c2[2])];
      elif c1[1] = "int" and c2[1] = "var" then                               # Int + Var
        return ["Term", Concatenation(["int"], c2[2]), ["int",1], c1[2]];
        #return ["Term", 2, Concatenation(["int"], c2[2]), [], [], c1[2]];
      elif c1[1] = "var" and c2[1] = "int" then                               # Var + Int
        return ["Term", Concatenation(c1[2],["int"]), [1,"int"], c2[2]];
        #return ["Term", 2, Concatenation(c1[2],["int"]), [], [], c2[2]];
      elif c1[1] = "Term" and c2[1] = "var" then                              # Term + Var
        return ["Term", Concatenation(c1[2], c2[2]), Concatenation(c1[3], [1]), c1[4]];
        #return ["Term", c1[2]+1, Concatenation(c1[3], c2[2]), c1[4], c1[5], c1[6]];
      elif c1[1] = "var" and c2[1] = "Term" then                              # Var + Term
        return ["Term", Concatenation(c1[2], c2[2]), Concatenation([1], c2[3]), c2[4]];
        #return ["Term", 1+c2[2], Concatenation(c1[2], c2[3]), c2[4], c2[5], c2[6]];
      elif c1[1] = "Term" and c2[1] = "int" then                              # Term + Int
        return ["Term", Concatenation(c1[2], ["int"]), Concatenation(c1[3],["int"]), Concatenation(c1[4], c2[2])];
        #return ["Term", c1[2]+1, Concatenation(c1[3], ["int"]), c1[4], c1[5], Concatenation(c1[6],c2[2])];
      elif c1[1] = "int" and c2[1] = "Term" then                              # Int + Term
        return ["Term", Concatenation(["int"], c2[2]), Concatenation(["int"], c2[3]), Concatenation(c1[2], c2[4])];
        #return ["Term", 1+c2[2], Concatenation(["int"], c2[3]), c2[4], c2[5], Concatenation(c2[6],c1[2])];
      elif c1[1] = "Term" and c1[1] = "Term" then                             # Term + Term
        return ["Term", Concatenation(c1[2], c2[2]), Concatenation(c1[3], c2[3]), Concatenation(c1[4], c2[4])];   
        #return ["Term", c1[2]+c2[2], Concatenation(c1[3],c2[3]), Concatenation(c1[4],c2[4]), Concatenation(c1[5],c2[5]), Concatenation(c1[6],c2[6])];    
      else
        Error("PredicataTreeToPredicatonRecursive failed at Addition: requires two variables.\n");
      fi;
    elif root = "*" then                                                      # Symbol *
      if c1[1] = "int" and c2[1] = "var" then                                 # Int * Var
        return ["Term", c2[2], c1[2], []];                                       # "Term", Variables, Integer Mult, Integer
        #return ["Term", 1, ["mult"], c1[2], c2[2], []];                         # "Term", #Summands, Variables, Integer Mult, Variable Mult, Integer
      elif c1[1] = "var" and c2[1] = "int" then                               # Var * Int
        return ["Term", c1[2], c2[2], []];
        #return ["Term", 1, ["mult"], c2[2], c1[2], []];
      else
        Error("PredicataTreeToPredicatonRecursive failed at Multiplication: requires one variable and one integer.\n");
      fi;
    elif root = "=" then                                                      # Creating Predicaton from formula:
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "var" and c2[1] = "var" then                                 # Var = Var
        return ["Pred", TermEqualTermPredicaton(c1[2], [1], [], c2[2], [1], [], n )];
        #return ["Pred", TermEqualAtomPredicaton(1, Concatenation(c1[2],c2[2]), [], [], [], n )];
      elif c1[1] = "var" and c2[1] = "int" then                               # Var = Int
        return ["Pred", EqualNPredicaton(c2[2][1], c1[2], n )];
      elif c1[1] = "int" and c2[1] = "var" then                               # Int = Var
        return ["Pred", EqualNPredicaton(c1[2][1], c2[2], n )];
      elif c1[1] = "int" and c2[1] = "int" then                               # Int = Int
        return ["Pred", TermEqualTermPredicaton(["int"], ["int"], c1[2], ["int"], ["int"], c2[2], n )];
        #return ["Pred", TermEqualAtomPredicaton(1, ["int","int"], [], [], Concatenation(c1[2],c2[2]), n )];
      elif c1[1] = "Term" and c2[1] = "var" then                              # T*Var + T*Var + ... + T*Var = Var  ( N summands)
        return ["Pred", TermEqualTermPredicaton(c1[2], c1[3], c1[4], c2[2], [1], [], n)]; 
        #return ["Pred", TermEqualAtomPredicaton(c1[2], Concatenation(c1[3],c2[2]), c1[4], c1[5], c1[6], n)]; 
      elif c1[1] = "var" and c2[1] = "Term" then                              # Var = T*Var + T*Var + ... + T*Var  ( N summands)
        return ["Pred", TermEqualTermPredicaton(c1[2], [1], [], c2[2], c2[3], c2[4], n)]; 
        #return ["Pred", TermEqualAtomPredicaton(c2[2], Concatenation(c2[3],c1[2]), c2[4], c2[5], c2[6], n)]; 
      elif c1[1] = "Term" and c2[1] = "int" then                              # T*Var + T*Var + ... + T*Var = Int  ( N summands)
        return ["Pred", TermEqualTermPredicaton(c1[2], c1[3], c1[4], ["int"], ["int"], c2[2], n)];
        #return ["Pred", TermEqualAtomPredicaton(c1[2], Concatenation(c1[3], ["int"]), c1[4], c1[5], Concatenation(c1[6], c2[2]), n)];
      elif c1[1] = "int" and c2[1] = "Term" then                              # Int = T*Var + T*Var + ... + T*Var  ( N summands)
        return ["Pred", TermEqualTermPredicaton(["int"], ["int"], c1[2], c2[2], c2[3], c2[4], n)];
        #return ["Pred", TermEqualAtomPredicaton(c2[2], Concatenation(c2[3], ["int"]), c2[4], c2[5], Concatenation(c2[6], c1[2]), n)];
      elif c1[1] = "Term" and c2[1] = "Term" then                             # T*Var + T*Var + ... + T*Var = T*Var + T*Var + ... + T*Var
        return ["Pred", TermEqualTermPredicaton(c1[2], c1[3], c1[4], c2[2], c2[3], c2[4], n)];
        #return ["Pred", TermEqualTermPredicaton([c1[2], c1[3], c1[4], c1[5], c1[6]], [c2[2], c2[3], c2[4], c2[5], c2[6]], n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at creating predicata from a formula.\n");
      fi;
    elif root = "geq" then                                                    # greater equal
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "var" and c2[1] = "int" then                                 # var >= int
        return["Pred", GreaterEqualNPredicaton(c2[2][1], c1[2],n)];
      elif c1[1] = "int" and c2[1] = "var" then                               # int >= var <-> not int < var
        return["Pred", NegatedAut(GreaterNPredicaton(c1[2][1], c2[2],n))];
      elif c1[1] = "var" and c2[1] = "var" then                               # var >= var
        return["Pred", GreaterEqualPredicaton(Concatenation(c1[2], c2[2]),n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at greater equal, input must be Var >= Var, Var >= Int or Int >= Var.\n");
      fi;
    elif root = "gr" then                                                     # greater
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "var" and c2[1] = "int" then                                 # var > int
        return["Pred", GreaterNPredicaton(c2[2][1], c1[2],n)];
      elif c1[1] = "int" and c2[1] = "var" then                               # int > var <-> not int <= var
        return["Pred", NegatedAut(GreaterEqualNPredicaton(c1[2][1], c2[2],n))];
      elif c1[1] = "var" and c2[1] = "var" then                               # var > var
        return["Pred", GreaterPredicaton(Concatenation(c1[2], c2[2]),n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at greater, input must be Var > Var, Var > Int or Int > Var.\n");
      fi;
    elif root = "leq" then                                                    # less equal
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "int" and c2[1] = "var" then                                 # int <= var
        return["Pred", GreaterEqualNPredicaton(c1[2][1], c2[2],n)];
      elif c1[1] = "var" and c2[1] = "int" then                               # var <= int <-> not var > int
        return["Pred", NegatedAut(GreaterNPredicaton(c2[2][1], c1[2],n))];
      elif c1[1] = "var" and c2[1] = "var" then                               # var <= var
        return["Pred", GreaterEqualPredicaton(Concatenation(c2[2], c1[2]),n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at less equal, input must be Var <= Var, Var <= Int or Int <= Var.\n");
      fi;
    elif root = "less" then                                                   # less
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "int" and c2[1] = "var" then                                 # int < var
        return["Pred", GreaterNPredicaton(c1[2][1], c2[2],n)];
      elif c1[1] = "var" and c2[1] = "int" then                               # var < int <-> not var >= int
        return["Pred", NegatedAut(GreaterEqualNPredicaton(c2[2][1], c1[2],n))];
      elif c1[1] = "var" and c2[1] = "var" then                               # var < var
        return["Pred", GreaterPredicaton(Concatenation(c2[2], c1[2]),n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at less, input must be Var < Var, Var < Int or Int < Var.\n");
      fi;
    elif root = "and" then                                                    # and
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "Pred" and c2[1] = "Pred" then
        return ["Pred", IntersectionPredicata(c1[2], c2[2], n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at the intersection of predicatas.\n");
      fi;
    elif root = "or" then                                                     # or
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "Pred" and c2[1] = "Pred" then
        return ["Pred", UnionPredicata( c1[2], c2[2], n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at the union of predicatas.\n");
      fi;
    elif root = "equiv" then                                                  # equiv
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "Pred" and c2[1] = "Pred" then
        return ["Pred", UnionPredicata( IntersectionPredicata(NegatedAut(c1[2]), NegatedAut(c2[2]), n), IntersectionPredicata(c1[2], c2[2], n), n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at the equivalence of predicatas.\n");
      fi;
    elif root = "implies" then                                                # implies  
      n:=FixedVariablePositions(V[1], V[2]);
      if c1[1] = "Pred" and c2[1] = "Pred" then
        return ["Pred", UnionPredicata( NegatedAut(c1[2]), c2[2], n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at the implication of predicatas.\n");
      fi;
    elif root = "E" then                                                      # exists
      if c1[1] = "var" and c2[1] = "Pred" then
        Remove(V[1],Position(V[1],V[2][c1[2][1]]));                           # removes the variable, since it gets quanfitied here (projected)
        return ["Pred", ProjectedPredicaton(c2[2], c1[2][1])];
      else 
        Error("PredicataTreeToPredicatonRecursive failed at reducing an predicatas (i.e. solving an existence quantifier).\n");
      fi;  
    elif root = "A" then                                                      # for all
      if c1[1] = "var" and c2[1] = "Pred" then
        Remove(V[1],Position(V[1],V[2][c1[2][1]]));                           # removes the variable, since it gets quanfitied here (projected)
        return ["Pred", NegatedProjectedNegatedPredicaton(c2[2], c1[2][1])];
      else 
        Error("PredicataTreeToPredicatonRecursive failed at reducing an pradiacatas (i.e. solving an for all quantifier).\n");
      fi;
    elif root in Pnames then                                                  # root is a string contained in the names of the predicate represenation.
      p:=ElementOfPredicataRepresentation(P, Position(Pnames, root));         # get the position and then the predicate represenation, p_name, p_arity, p_automata
      if ArityOfPredicatonRepresentation(p) <> 2 then
        Error("PredicataTreeToPredicatonRecursive failed, the predicate arity is ", ArityOfPredicatonRepresentation(p), ", but the predicate is called on 2 variables.\n");
      else
        n:=FixedVariablePositions(V[1], V[2]);
        v:=[];
        if c1[1] = "var" and c2[1] = "var" then
          v[1]:=c1[2];
          v[2]:=c2[2];
        else
          Error("PredicataTreeToPredicatonRecursive failed, the predicate contains a non-variable.\n");
        fi;
        return ["Pred", PredicatonFromAut(AutOfPredicatonRepresentation(p), Concatenation(v), n )];               
      fi;
    elif root = "Buchi" or root = "Büchi" or root = "Buechi" then
      if c1[1] = "var" and c2[1] = "var" then                                 # Buchi[Var, Var]
        n:=FixedVariablePositions(V[1], V[2]);
        return["Pred", BuchiPredicaton(Concatenation(c1[2], c2[2]), n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at Buchi-automaton: requires two variables.\n");
      fi;
    else 
      Error("PredicataTreeToPredicatonRecursive failed due to the invalid symbol:", root, ".\n");
    fi;
  # Case: one child
  elif  NumberOfChildrenOfPredicataTree(T) = 1 then
    root:=RootOfPredicataTree(T);
    #Print(" Current root: ", root, ".\n");
    c:=PredicataTreeToPredicatonRecursive(ReturnedChildOfPredicataTree(T, 1), V);
    if c = fail then 
      return fail;
    fi;
    if root = " " then                                                        # empty node due to unneccessary brackets
      return c;
    elif root = "not" then                                                    # not
      if c[1] = "Pred" then
        return ["Pred", NegatedAut(NormalizedLeadingZeroPredicaton(c[2]))];
      else
        Error("PredicataTreeToPredicatonRecursive failed at negating an Predicata.\n");
      fi;
    elif root in Pnames then                                                  # root is a string contained in the names of the predicate represenation.
      p:=ElementOfPredicataRepresentation(P, Position(Pnames, root));         # get the position and then the predicate represenation, p_name, p_arity, p_automata
      if ArityOfPredicatonRepresentation(p) <> 1 then
        Error("PredicataTreeToPredicatonRecursive failed, the predicate arity is ", ArityOfPredicatonRepresentation(p), ", but the predicate is called on 1 variable.\n");
      else
        n:=FixedVariablePositions(V[1], V[2]);
        v:=[];
        if c[1] = "var" then
          v[1]:=c[2];
        else
          Error("PredicataTreeToPredicatonRecursive failed, the predicate contains a non-variable.\n");
        fi;
        return ["Pred", PredicatonFromAut(AutOfPredicatonRepresentation(p), Concatenation(v), n )];               
      fi;
    elif root = "Power" then                                                  # Power[var]
      if c[1] = "var" then                                 
        n:=FixedVariablePositions(V[1], V[2]);
        return["Pred", PowerPredicaton(c[2], n)];
      else
        Error("PredicataTreeToPredicatonRecursive failed at (Power of 2) - 1 - automaton: requires one variables.\n");
      fi;        
    else 
      Error("PredicataTreeToPredicatonRecursive failed due to the invalid symbol:", root, ".\n");
    fi;
  # Case: leaf
  elif NumberOfChildrenOfPredicataTree(T) = 0 then
    root:=RootOfPredicataTree(T);
    #Print(" Current leaf: ", root, ".\n");
    if PredicataIsStringType(root, "integer") or PredicataIsStringType(root, "negativeinteger") then # positive integer (greater equal 0) or negative with -
      return ["int", [Int(root)]];
    elif PredicataIsStringType(root, "variable") then                         # variable
      if root in V[1] then                                                    # lying in current variable list.
        return ["var", FixedVariablePositions([root],V[2])];
      else
        Error("PredicataTreeToPredicatonRecursive failed, the variable ", root, " cannot be called as leaf.\n");
      fi;
    elif PredicataIsStringType(root, "boolean") then                          # boolean
      n:=FixedVariablePositions(V[1],V[2]);
      return ["Pred", BooleanPredicaton(root, n)];
    elif root in Pnames then                                                  # root is a string contained in the names of the predicate represenation.
      p:=ElementOfPredicataRepresentation(P, Position(Pnames, root));         # get the position and then the predicate represenation, p_name, p_arity, p_automata
      if ArityOfPredicatonRepresentation(p) <> 0 then
        Error("PredicataTreeToPredicatonRecursive failed, the predicate arity is ", ArityOfPredicatonRepresentation(p), ", but the predicate is called on 0 variables.\n");
      else
        n:=FixedVariablePositions(V[1], V[2]);
        return ["Pred", PredicatonFromAut(AutOfPredicatonRepresentation(p), [], n )];               
      fi;
    else 
      Error("PredicataTreeToPredicatonRecursive failed at the leaf level: ", String(root), ".\n");
    fi;
  else
    Error("PredicataTreeToPredicatonRecursive failed, something went completely wrong, no tree case for having children greater equal to 0 was executed.\n");
  fi;
end);
####################################################################################################
##
#F  PredicataTreeToPredicaton(T, args...)
##
##  Converts a tree into one predicata.
##
##  Calls PredicataTreeToPredicatonRecursive.
##
InstallGlobalFunction( PredicataTreeToPredicaton, function (T, args...)
  local A, F, V, bounded, free;
  if Length(args) = 0 then
    F:=[];
  elif Length(args) = 1 and IsList(args[1]) and ForAll(args[1], i -> PredicataIsStringType(i, "variable")) then
    F:=StructuralCopy(args[1]);
  else
    Error("PredicataTreeToPredicaton failed, wrong optional input, the argument must be a string containing \"variables\".\n");  
  fi;
  if not IsPredicataTreeObj(T) then
    Error("PredicataTreeToPredicaton failed, the argument must be a PredicataTree.\n");
  fi;
  bounded:=BoundedVariablesOfPredicataTree(T);
  free:=FreeVariablesOfPredicataTree(T);
  # Comment1: this will force to set order only to existing variables.
  #if not IsSubsetSet(free, F) then
  #  Print("PredicataTreeToPredicaton failed, the optional variable order must be a subset of the free variables.\n");
  #  return fail;
  #else
  #  Append(F, free);       # set an order to the free variables, by entering some of the through V
  #  F:=Unique(F);
  #fi;
  # Comment2: this will allow to add any variables to be free
  if Intersection(F, bounded) <> [] then
    Print("PredicataTreeToPredicaton failed, the optional variable order must not contain bounded variables.\n");
    return fail;
  fi;
  Append(F, free);          # set an order to the free variables, by entering some of the through V
  F:=Unique(F);
  V:=ShallowCopy(F);
  Append(V, bounded);       # append the bounded variables, this will be the order for the whole recursive computation.
  A:=PredicataTreeToPredicatonRecursive(T, [F, V]);   # tree, [free variables, all variables]
  if not (IsList(A) and Length(A) = 2 and A[1] = "Pred" and IsPredicaton(A[2])) then
    Error("PredicataTreeToPredicaton failed, something went wrong.\n");
  fi;
  SetVariableListOfPredicaton(A[2], F);
  return A;
end);
##
#E
##