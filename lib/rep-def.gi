####################################################################################################
##
##  This file installs functions for PredicataRepresentation.
##
####################################################################################################
##
#F  PredicatonRepresentation(Name, Arity, Aut)
##
InstallGlobalFunction( PredicatonRepresentation, function ( Name, Arity, Aut )
  local A, F, n, predrepel;
  # checking if input is: String, PosInt, Automaton with alphabet with 2^Arity letters.
  if not (IsString(Name) and IsInt(Arity) and Arity >= 0 and (IsAutomaton(Aut) or IsPredicaton(Aut)) and AlphabetOfAut(Aut) = 2^Arity and (IsDeterministicAut(Aut) or IsNonDeterministicAut(Aut))) then
    if AlphabetOfAut(Aut) <> 2^Arity then
      Print("The arity doesn't match with size of the alphabet of the automaton (or the size of the variable position list).\n");
    fi;
    Error("PredicatonRepresentation failed, the first argument must be a string, the second a positive integer and the third a Predicata/Automaton.\n");
  fi;
  # checking if input is not an already used string.
  if Length(Name) = 0 then
    Print("PredicatonRepresentation failed, the empty string as name is not allowed.\n");
    return fail;
  elif PredicataIsStringType(Name, "symbol") or PredicataIsStringType(Name, "predicate") then
    Print("PredicatonRepresentation failed, the name is already used by a predefined name.\n");
    return fail;
  elif Length(Positions(Name, ' ')) > 0 then
    Print("PredicatonRepresentation failed, the name must not have whitespaces.\n");
    return fail;
  elif Name{[1]} in ["A", "E"] then
    n:=Name{[2..Length(Name)]};
    if PredicataIsStringType(n, "variable") or PredicataIsStringType(n, "integer") or PredicataIsStringType(n, "boolean") or PredicataIsStringType(n, "symbol") or PredicataIsStringType(n, "predicate") then
      Print("PredicatonRepresentation failed, the following name is not allowed, it might be mistaken as a quantifier with a symbol, variable or integer.\n");
      return fail;
    fi;
  fi;
  if IsPredicaton(Aut) then
    Aut:=AutOfPredicaton(Aut);
  fi;  
  # Defining new family
  F:=NewFamily("PredicatonRepresentation", IsPredicatonRepresentationObj);
  predrepel:=rec(name:=Name, arity:=Arity, aut:=Aut);
  A:=Objectify(NewType(F, IsPredicatonRepresentationRep and IsAttributeStoringRep), predrepel);
  # Return the PredicatonRepresentation.
  return A;
end);
####################################################################################################
##
#F  IsPredicatonRepresentation(p)
##
##  Tests if p is from type PredicatonRepresentation
##
InstallGlobalFunction( IsPredicatonRepresentation, function(p)
    return(IsPredicatonRepresentationObj(p));
end);
####################################################################################################
##
#M  DisplayString(p)
##
InstallMethod ( DisplayString,
  "Returns the PredicataRepresentation nicely formatted.",
  true,
  [IsPredicatonRepresentationRep], 0,
  function( p )
    return Concatenation("Predicaton represented with the name: ", String(p!.name), ", the arity: ", String(p!.arity), " and the following automaton:\n", AutToString(p!.aut));
end);
####################################################################################################
##
#M  ViewString(p)
##
InstallMethod( ViewString,
  "Returns the most important informations about the PredicatonRepresentation.",
  true,
  [IsPredicatonRepresentationRep], 0,
  function( p )
    local S;
    S:=Concatenation("< Predicaton represented with the name \"", String(p!.name), "\", the arity ", String(p!.arity));
    if TypeOfAut(p!.aut) = "det" then
      S:=Concatenation(S, " and the deterministic finite automaton ");
    else
      S:=Concatenation(S, " and the non-deterministic finite automaton ");
    fi;
    S:=Concatenation(S, "on ", String(AlphabetOfAut(p!.aut)), " letters and ", String(NumberStatesOfAut(p!.aut)), " states. >");
    return S;
end);
####################################################################################################
##
#M  String(P)
##
InstallMethod( String,
  "Returns the PredicatonRepresentation as string.",
  true,
  [IsPredicatonRepresentationRep], 0,
  function( p )
    return Concatenation("PredicatonRepresentation(\"", String(p!.name), "\", ", String(p!.arity), ", ", "Automaton(\"", String(p!.aut!.type), "\", ", String(p!.aut!.states), ", ", String(AlphabetOfAutomatonAsList(p!.aut)), ", ", String(p!.aut!.transitions), ", ", String(p!.aut!.initial), ", ", String(p!.aut!.accepting), "))");
end);
####################################################################################################
##
#F  NameOfPredicatonRepresentation(p)
##
##  Returns the name of an predicata representation element.
##
InstallGlobalFunction( NameOfPredicatonRepresentation, function (p) 
  if IsPredicatonRepresentationObj(p) then
    return ShallowCopy(p!.name);
  else
    Error("NameOfPredicatonRepresentation failed, the argument must be a PredicatonRepresentation.\n");
  fi;
end); 
####################################################################################################
##
#F  ArityOfPredicatonRepresentation(p)
##
##  Returns the name of an predicata representation element.
##
InstallGlobalFunction( ArityOfPredicatonRepresentation, function (p) 
  if IsPredicatonRepresentationObj(p) then
    return ShallowCopy(p!.arity);
  else
    Error("ArityOfPredicatonRepresentation failed, the argument must be a PredicatonRepresentation.\n");
  fi;
end);
####################################################################################################
##
#F  AutOfPredicatonRepresentation(p)
##
##  Returns the automaton of an predicata representation element.
##
InstallGlobalFunction( AutOfPredicatonRepresentation, function (p) 
  if IsPredicatonRepresentationObj(p) then
    return CopyAut(p!.aut);
  else
    Error("AutOfPredicatonRepresentation failed, the argument must be a PredicatonRepresentation.\n");
  fi;
end);
####################################################################################################
##
#F  CopyPredicatonRepresentation(p)
##
##  Returns a copy.
##
InstallGlobalFunction( CopyPredicatonRepresentation, function (p) 
  if IsPredicatonRepresentationObj(p) then
    return PredicatonRepresentation(ShallowCopy(p!.name), ShallowCopy(p!.arity), CopyAut(p!.aut));
  else
    Error("CopyOfPredicatonRepresentation failed, the argument must be a PredicatonRepresentation.\n");
  fi;
end);
####################################################################################################
##
#F  PredicataCMPRGR(x, y)
##
##  Compares two elements with >.
##
BindGlobal("PredicataCMPRGR", function ( x, y )
  return x > y;
end);
####################################################################################################
##
#F  PredicataRepresentation(args...)
##
InstallGlobalFunction( PredicataRepresentation, function ( args... )
  local LowercaseNameList, NameList, ArityList, AutList, i, p, A, F, predrep;
  if Length(args) = 0 then
    LowercaseNameList:=[];
    NameList:=[];
    ArityList:=[];
    AutList:=[];
  elif ForAll(args, i-> IsPredicatonRepresentation(i)) then
    LowercaseNameList:=[];
    NameList:=[];
    ArityList:=[];
    AutList:=[];
    for i in [1..Length(args)] do
      if LowercaseString(NameOfPredicatonRepresentation(args[i])) in LowercaseNameList then
        Print("AddPredicataRepresentation failed, predicata name is already used, ignoring upper- and lowercase.\n");
        return fail;
      fi;
      Add(NameList, NameOfPredicatonRepresentation(args[i]));
      Add(LowercaseNameList, LowercaseString(NameOfPredicatonRepresentation(args[i])));
      Add(ArityList, ArityOfPredicatonRepresentation(args[i]));
      Add(AutList, AutOfPredicatonRepresentation(args[i]));
    od;
    p:=Sortex(LowercaseNameList, PredicataCMPRGR);
    NameList:=Permuted(NameList, p);
    ArityList:=Permuted(ArityList, p);
    AutList:=Permuted(AutList, p);
  else
    Error("PredicataRepresentation failed, the optional arguments must be a PredicatonRepresentation.\n");
  fi;
  # Defining new family
  F:=NewFamily("PredicataRepresentation", IsPredicataRepresentationObj);
  predrep:=rec(lowercasenamelist:=LowercaseNameList, namelist:=NameList, aritylist:=ArityList, autlist:=AutList);
  A:=Objectify(NewType(F, IsPredicataRepresentationRep and IsAttributeStoringRep), predrep);
  # Return the PredicataRepresentation.
  return A;
end);
####################################################################################################
##
#M  DisplayString(P)
##
InstallMethod ( DisplayString,
  "Returns the PredicataRepresentation nicely formatted.",
  true,
  [IsPredicataRepresentationRep], 0,
  function( P )
    local i, S;
    S:="Predicata representation containing the following PredicatonRepresentations:\n";
    for i in [1..Length(P!.namelist)] do
      S:=Concatenation(S, DisplayString(ElementOfPredicataRepresentation(StructuralCopy(P), i)));
    od;
    return S;
end);
####################################################################################################
##
#M  ViewString(P)
##
InstallMethod( ViewString,
  "Returns the most important informations about the PredicataRepresentation.",
  true,
  [IsPredicataRepresentationRep], 0,
  function( P )
    return Concatenation("< PredicataRepresentation containing the following predicates: ", String(ShallowCopy(P!.namelist)),". >");
end);
####################################################################################################
##
#M  String(P)
##
InstallMethod( String,
   "Returns the PredicataRepresentation as string.", 
  true,
  [IsPredicataRepresentationRep], 0,
  function( P )
    local e, i, S;
    S:="PredicataRepresentation(";
    i:=1;
    e:=ElementOfPredicataRepresentation(StructuralCopy(P), i);
    while e <> fail do
      S:=Concatenation(S, String(e));
      i:=i+1;
      e:=ElementOfPredicataRepresentation(StructuralCopy(P), i);
      if e <> fail then
        S:=Concatenation(S, ", ");
      fi;
    od;
    S:=Concatenation(S, ")");
    return S;
end);

####################################################################################################
##
#F  IsPredicataRepresentation(P)
##
##  Tests if P is from type PredicataRepresentation
##
InstallGlobalFunction( IsPredicataRepresentation, function(P)
    return(IsPredicataRepresentationObj(P));
end);
####################################################################################################
##
#M  Add(P, p)
##
##  Adds a PredicatonRepresentation.
##
InstallOtherMethod ( Add, 
        "Adds a Predicata Representation.",
        true,
        [IsPredicataRepresentationRep, IsPredicatonRepresentationRep], 0,
        function( P, p )
  local Name, name, i;
  Name:=ShallowCopy(p!.name);
  name:=ShallowCopy(LowercaseString(p!.name));
  if name in P!.lowercasenamelist then
    i:=1;
    while name in P!.lowercasenamelist do
      name:=Concatenation(name, String(i));
      Name:=Concatenation(Name, String(i));
      i:=i+1;
    od;
    Print("The name of the Predicata representation element is already used and therefore was changed to ", Name, ".\n");
  fi;
  Add(P!.lowercasenamelist, name);
  Add(P!.namelist, Name);
  Add(P!.aritylist, ShallowCopy(p!.arity));
  Add(P!.autlist, CopyAut(p!.aut));
  # Sorting for proper renaming
  p:=Sortex(P!.lowercasenamelist, PredicataCMPRGR);
  P!.namelist:=Permuted(P!.namelist, p);
  P!.aritylist:=Permuted(P!.aritylist, p);
  P!.autlist:=Permuted(P!.autlist, p);
end);
####################################################################################################
##
#M  Add(P, name, arity, Predicata )
##
##  Adds a PredicatonRepresentation given as the three components name, arity, predicata/automaton.
##
InstallOtherMethod ( Add, 
        "Adds a Predicata Representation.",
        true,
        [IsPredicataRepresentationRep, IsString, IsInt, IsPredicatonObj and IsPredicatonRep], 0,
        function( P, name, arity, Predicata )
  local p;
  p:=PredicatonRepresentation(name, arity, Predicata);
  if p = fail then
    return fail;
  fi;
  Add(P, p);
end);
####################################################################################################
##
#M  Remove(P, i)
##
##  Removes a PredicatonRepresentation.
##
InstallOtherMethod ( Remove, 
        "Removes a Predicata Representation.",
        true,
        [IsPredicataRepresentationRep, IsPosInt], 0,
        function( P, i )
  local n, p;
  if i > Length(P!.namelist) then
    return fail;
  fi;
  n:=Difference([1..Length(P!.namelist)],[i]);
  p:=[];
  p[1]:=ShallowCopy(P!.namelist[i]);
  p[2]:=ShallowCopy(P!.aritylist[i]);
  p[3]:=CopyAut(P!.autlist[i]);
  P!.lowercasenamelist:=P!.lowercasenamelist{n};
  P!.namelist:=P!.namelist{n};
  P!.aritylist:=P!.aritylist{n};
  P!.autlist:=P!.autlist{n};
  return PredicatonRepresentation(p[1], p[2], p[3]);
end);
####################################################################################################
##
#F  ElementOfPredicataRepresentation(P, i)
##
##  Returns the i-th PredicatonRepresentation.
##
InstallGlobalFunction( ElementOfPredicataRepresentation, function ( P, i )
  local p;
  if not IsPredicataRepresentationObj(P) then
    Error("RemovePredicataRepresentation failed, the first argument must be a PredicataRepresentation.\n");
  elif not IsPosInt(i) then
    Error("RemovePredicataRepresentation failed, the second argument must be a PosInt.\n");
  elif i > Length(P!.namelist) then
    return fail;
  else
    return PredicatonRepresentation(StructuralCopy(P!.namelist[i]), StructuralCopy(P!.aritylist[i]), CopyAut(P!.autlist[i]));
  fi;
end);
####################################################################################################
##
#F  NamesOfPredicataRepresentation(p)
##
##  Returns the name list of an predicata representation.
##
InstallGlobalFunction( NamesOfPredicataRepresentation, function (P) 
  if IsPredicataRepresentationObj(P) then
    return ShallowCopy(P!.namelist);
  else
    Error("NamesOfPredicataRepresentation failed, the argument must be a PredicataRepresentation.\n");
  fi;
end); 
####################################################################################################
##
#F  AritiesOfPredicataRepresentation(P)
##
##  Returns the name list of an predicata representation element.
##
InstallGlobalFunction( AritiesOfPredicataRepresentation, function (P) 
  if IsPredicataRepresentationObj(P) then
    return ShallowCopy(P!.aritylist);
  else
    Error("AritiesOfPredicataRepresentation failed, the argument must be a PredicataRepresentation.\n");
  fi;
end);
####################################################################################################
##
#F  AutsOfPredicataRepresentation(P)
##
##  Returns the automaton list of an predicata representation element.
##
InstallGlobalFunction( AutsOfPredicataRepresentation, function (P) 
  if IsPredicataRepresentationObj(P) then
    return StructuralCopy(P!.autlist);
  else
    Error("AutsOfPredicataRepresentation failed, the argument must be a PredicataRepresentation.\n");
  fi;
end);
####################################################################################################
##
#F  CopyPredicataRepresentation(P)
##
##  Returns a copy.
##
InstallGlobalFunction( CopyPredicataRepresentation, function (P)
  local Q;
  if IsPredicataRepresentationObj(P) then
    Q:=PredicataRepresentation();
    Q!.lowercasenamelist:=ShallowCopy(P!.lowercasenamelist);
    Q!.namelist:=ShallowCopy(P!.namelist);
    Q!.aritylist:=ShallowCopy(P!.aritylist);
    Q!.autlist:=StructuralCopy(P!.autlist);
    return Q; 
  else
    Error("CopyPredicataRepresentation failed, the argument must be a PredicatonRepresentation.\n");
  fi;
end);
####################################################################################################
##
#V  PredicataList
##
##  Global variable storing predicates with a name, arity and a Predicata
##
InstallValue( PredicataList, PredicataRepresentation());
####################################################################################################
##
#F  AddToPredicataList(p, args...)
##
##  Adds a PredicatonRepresentation to the global variable PredicataList.
##
InstallGlobalFunction( AddToPredicataList, function ( p, args...) 
  local i;
  if Length(args) = 0 and IsPredicatonRepresentation(p) then
    Add(PredicataList, p);
  elif Length(args) = 0 and IsList(p) and ForAll(p, i->IsPredicatonRepresentation(i)) then
    for i in [1..Length(p)] do
      Add(PredicataList, p[i]);
    od;
  elif Length(args) = 2 and IsString(p) and IsInt(args[1]) and IsPredicaton(args[2]) then
    Add(PredicataList, p, args[1], args[2]);
  else
    Print("AddToPredicataList failed, the argument must either be a PredicatonRepresentation or a name, an arity and a Predicata/Automaton.\n");
  fi;    
end);
####################################################################################################
##
#F  RemoveFromPredicataList(i)
##
##  Adds a PredicatonRepresentation to the global variable PredicataList.
##
InstallGlobalFunction( RemoveFromPredicataList, function (i) 
  if IsPosInt(i) then
    Remove(PredicataList, i);
  else
    Print("RemoveFromPredicataList failed, the argument must be a positive integer.\n");
  fi;    
end);
####################################################################################################
##
#F  ClearPredicataList()
##
##  Clears the global variable PredicataList.
##
InstallGlobalFunction( ClearPredicataList, function () 
  local i;
  for i in PredicataList!.namelist do
    Remove(PredicataList, 1);
  od;
end);
##
#E
##
