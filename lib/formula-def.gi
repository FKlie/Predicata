####################################################################################################
##
##  This file installs functions for PredicataFormulas and PredicataFormulaFormatted and their 
##  conversion.
##
####################################################################################################
##
#V  PredicataFormulaSymbols
##
##  Allowed symbols in PredicataFormula.
##
InstallValue( PredicataFormulaSymbols, 
              ["*", "+", "-", "=", "gr", "geq","less", "leq", "and", "or", "equiv", "equivalent", "implies", "not", "(", ")", "[", "]", ",", ":", "A", "E"]);
####################################################################################################
##
#F  PredicataIsStringType(S, T)
##
##  Checks if a string S represents one of the following string types T:
##  "variable", "integer" (greater equal 0), "negativeinteger", "boolean", "predicate",
##  "internalpredicate", "quantifier", "symbol", "binarysymbol", "unarysymbol".
##
InstallGlobalFunction( PredicataIsStringType, function ( S, T )
  local i;
  if not IsString(S) or Length(S) = 0 then
    return false;
  elif T = "variable" then
    if S[1] in ['a','b','c','d','e','f', 'g', 'h', 'i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'] then
      i:=Int(S{[2..Length(S)]});
      if IsInt(i) and i >= 0 then
        return true;
      else
        return false;
      fi;
    else
      return false;
    fi;
  elif T = "integer" then
    i:=Int(S);
    if IsInt(i) and i>=0 then
      return true;
    else
      return false;
    fi;
  elif T = "negativeinteger" then
    i:=Int(S);
    if IsInt(i) and i < 0 then
      return true;
    else
      return false;
    fi;
  elif T = "boolean" then
    if S in ["true","false"] then 
      return true;
    else
      return false;
    fi;
  elif T = "predicate" then
    if S in ["true", "false", "Buchi", "Buechi", "Büchi", "Power"] then
      return true;
    else
      return false;
    fi;
  elif T = "internalpredicate" then
    if Length(S) < 2 then 
      return false;
    elif S[1]='P' and S[2]='_' then
      i:=Int(S{[3..Length(S)]});
      if IsInt(i) and i>=0 then
        return true;
      else
        return false;
      fi;
    else
      return false;
    fi;
  elif T = "quantifier" then
    if S in ["A","E"] then
      return true;
    else
      return false;
    fi; 
  elif T = "symbol" then
    if S in PredicataFormulaSymbols then
      return true;
    else
      return false;
    fi;  
  elif T = "binarysymbol" then
    if S in ["+", "*", "=", "geq", "gr", "leq", "less", "and", "or", "equiv", "implies"] then
      return true;
    else
      return false;
    fi;
  elif T = "unarysymbol" then
    if S in ["not"] then
      return true;
    else
      return false;
    fi;
  else
    Print("PredicataIsStringType failed, wrong type T.\n");
    return fail;
  fi;
end);
####################################################################################################
##
#F  PredicataNormalizedString
##
##  Normalizes a string, addind whitespaces, converting, etc..
##
InstallGlobalFunction( PredicataNormalizedString, function ( f , args...) 
  local B1, B2, B3, P, Pnames, i, s;
  if not IsString(f) then
    Error("PredicataNormalizedString failed, the first argument must be a string.\n");
  fi;  
  if Length(args) = 0 then
    P:=PredicataRepresentation();
    B1:=true;   # Renaming predicates back to their orignal name from P_xyz
    B2:=true;   # Splitting string
    B3:=true;   # Renaming predicates to P_xyz
  elif Length(args) = 1 and IsPredicataRepresentation(args[1]) then
    P:=args[1];
    B1:=true;
    B2:=true;
    B3:=true;
  elif Length(args) = 2 and IsPredicataRepresentation(args[1]) and IsBool(args[2]) then
    P:=args[1];
    B1:=args[2];
    B2:=true;
    B3:=true;
  elif Length(args) = 3 and IsPredicataRepresentation(args[1]) and IsBool(args[2]) and IsBool(args[3]) then
    P:=args[1];
    B1:=args[2];
    B2:=args[3];
    B3:=true;
  elif Length(args) = 4 and IsPredicataRepresentation(args[1]) and IsBool(args[2]) and IsBool(args[3]) and IsBool(args[4]) then
    P:=args[1];
    B1:=args[2];
    B2:=args[3];
    B3:=args[4];
  else
    Error("SplitStringIntoList failed, wrong optional input.\n");
  fi;
  Pnames:=NamesOfPredicataRepresentation(P);
  if B3 then
    for i in [1..Length(Pnames)] do  # replacing new define predicate names with P_.
      if i < 10 then
        s:=Concatenation("00", String(i));
      elif i < 100 then
        s:=Concatenation("0", String(i));
      else
        s:=String(i);
      fi;
      f:=ReplacedString(f, Pnames[i], Concatenation("P_", s)); #???
    od;
  fi;
  f:=ReplacedString(f,">="," geq ");
  f:=ReplacedString(f,"<="," leq ");
  f:=ReplacedString(f,">"," gr ");
  f:=ReplacedString(f,"<"," less ");
  f:=ReplacedString(f,"equivalent"," equiv ");
  for i in [1..Length(PredicataFormulaSymbols)] do   # adding whitespaces around all symbols
    f:=ReplacedString(f, PredicataFormulaSymbols[i], Concatenation(" ", PredicataFormulaSymbols[i], " ") );
  od;
  if B1 then                  # if true (on default) revert back to predicate names.
    for i in [1..Length(Pnames)] do
      if i < 10 then
        s:=Concatenation("00", String(i));
      elif i < 100 then
        s:=Concatenation("0", String(i));
      else
        s:=String(i);
      fi;
      f:=ReplacedString(f, Concatenation("P_", s), Concatenation(" ", Pnames[i], " "));
    od;
  fi;
  f:=NormalizedWhitespace(f);                    # normalize whitespaces 
  if B2 then
    f:=SplitString(f, " ");
  fi;
  return f;
end);
####################################################################################################
##
#F  PredicataGrammarVerification
##
##  Checks if a string is accepted by the predefined grammar.
##
InstallGlobalFunction( PredicataGrammarVerification, function ( f, args... )
  local B, G, S, I, P, Q, R, Pname, NonTerm, Term, UnitRules, ProductRules, Start, a, b, c, i, j, k, l, n, p, r, s, t, V, v;
  if not IsString(f) then
    Error("PredicataGrammarVerification failed, the first argument must be a string.\n");
  fi;  
  if Length(args) = 0 then
    P:=PredicataRepresentation();
  elif Length(args) = 1 and IsPredicataRepresentation(args[1]) then
    P:=args[1];
  else
    Error("PredicataGrammarVerification failed, wrong optional input.\n");
  fi;
  # splitting string in a list of strings, while adding whitespace and renaming some symbols.
  S:=PredicataNormalizedString(f, P, false);
  # lexical analysis, renaming the string list to lexcial syntax.
  I:=[];
  for i in [1..Length(S)] do
    if S[i] = "(" then 
      Add(I, "leftpar");
    elif S[i] = ")" then 
      Add(I, "rightpar");
    elif S[i] = "[" then 
      Add(I, "leftsquare");
    elif S[i] = "]" then 
      Add(I, "rightsquare");
    elif S[i] = "not" then 
      Add(I, "not");
    elif S[i] = "A" or S[i] = "E" then 
      Add(I, "quantifier");
    elif S[i] = ":" then 
      Add(I, "colon");
    elif S[i] = "and" or S[i] = "or" or S[i] = "implies" or S[i] = "equiv" then
      Add(I, "logicconnective");
    elif S[i] = "=" then 
      Add(I, "equal");
    elif S[i] = "+" then 
      Add(I, "plus");
    elif S[i] = "-" then 
      Add(I, "minus");
    elif S[i] = "*" then 
      Add(I, "times");
    elif S[i] = "gr" or S[i] = "less" or S[i] = "geq" or S[i] = "leq" then 
      Add(I, "compare");
    elif S[i] = "," then 
      Add(I, "comma");
    elif (PredicataIsStringType(S[i], "internalpredicate") or PredicataIsStringType(S[i], "predicate")) and i < Length(S) and S[i+1] = "[" then 
      Add(I, "predicate");
    elif PredicataIsStringType(S[i], "variable") then 
      Add(I, "var");
    elif PredicataIsStringType(S[i], "integer") then 
      Add(I, "int");
    elif PredicataIsStringType(S[i], "boolean") or PredicataIsStringType(S[i], "internalpredicate") then
      Add(I, "boolean");
    else 
      Add(I, "invalid");
    fi;
  od;
  # false if invalid symbol
  if "invalid" in I then
    Print("Invalid symbol at positions ", Positions(I, "invalid"), ", where the following symbols aren't recognized " , S{Positions(I, "invalid")}, ".\n");
    return false;
  fi;
  # Chomsky Normal Form of my grammar, see .g files.
  G:=[ [ "Start", "Formula", "Term", "Varlist", "Nonterm_leftpar", "Nonterm_rightpar", "Nonterm_not", "Nonterm_colon", "Nonterm_quantifier", 
      "Nonterm_var", "Nonterm_logicconnective", "Nonterm_equal", "Nonterm_compare", "Nonterm_int", "Nonterm_leftsquare", "Nonterm_predicate", 
      "Nonterm_rightsquare", "Nonterm_plus", "Nonterm_times", "Nonterm_minus", "Nonterm_comma", "NR1_Formula", "NR2_Formula", "NR3_Formula", 
      "NR4_Formula", "NR5_Formula", "NR6_Formula", "NR7_Formula", "NR8_Formula", "NR9_Formula", "NR10_Formula", "NR11_Formula", 
      "NR12_Formula", "NR1_Term", "NR2_Term", "NR3_Term", "NR4_Term", "NR5_Term", "NR6_Term", "NR7_Term", "NR8_Term", "NR9_Term", 
      "NR10_Term", "NR1_Varlist" ], [ "leftpar", "rightpar", "leftsquare", "rightsquare", "not", "quantifier", "colon", "logicconnective", 
      "equal", "plus", "minus", "times", "compare", "comma", "predicate", "var", "int", "boolean" ], 
  [ [ "Formula", [ "boolean" ] ], [ "Term", [ "var" ] ], [ "Term", [ "int" ] ], [ "Varlist", [ "var" ] ], [ "Start", [ "boolean" ] ], 
      [ "Nonterm_leftpar", [ "leftpar" ] ], [ "Nonterm_rightpar", [ "rightpar" ] ], [ "Nonterm_not", [ "not" ] ], 
      [ "Nonterm_colon", [ "colon" ] ], [ "Nonterm_quantifier", [ "quantifier" ] ], [ "Nonterm_var", [ "var" ] ], 
      [ "Nonterm_logicconnective", [ "logicconnective" ] ], [ "Nonterm_equal", [ "equal" ] ], [ "Nonterm_compare", [ "compare" ] ], 
      [ "Nonterm_int", [ "int" ] ], [ "Nonterm_leftsquare", [ "leftsquare" ] ], [ "Nonterm_predicate", [ "predicate" ] ], 
      [ "Nonterm_rightsquare", [ "rightsquare" ] ], [ "Nonterm_plus", [ "plus" ] ], [ "Nonterm_times", [ "times" ] ], 
      [ "Nonterm_minus", [ "minus" ] ], [ "Nonterm_comma", [ "comma" ] ] ], 
  [ [ "Formula", [ "Nonterm_leftpar", "NR1_Formula" ] ], [ "Formula", [ "Nonterm_not", "Formula" ] ], 
      [ "Formula", [ "Nonterm_leftpar", "NR2_Formula" ] ], [ "Formula", [ "Formula", "NR6_Formula" ] ], 
      [ "Formula", [ "Term", "NR7_Formula" ] ], [ "Formula", [ "Nonterm_var", "NR8_Formula" ] ], 
      [ "Formula", [ "Nonterm_var", "NR9_Formula" ] ], [ "Formula", [ "Nonterm_int", "NR10_Formula" ] ], 
      [ "Formula", [ "Nonterm_predicate", "NR11_Formula" ] ], [ "Term", [ "Nonterm_leftpar", "NR1_Term" ] ], 
      [ "Term", [ "Term", "NR2_Term" ] ], [ "Term", [ "Nonterm_int", "NR3_Term" ] ], [ "Term", [ "Nonterm_leftpar", "NR4_Term" ] ], 
      [ "Term", [ "Nonterm_leftpar", "NR7_Term" ] ], [ "Varlist", [ "Nonterm_var", "NR1_Varlist" ] ], 
      [ "Start", [ "Nonterm_leftpar", "NR1_Formula" ] ], [ "Start", [ "Nonterm_not", "Formula" ] ], 
      [ "Start", [ "Nonterm_leftpar", "NR2_Formula" ] ], [ "Start", [ "Formula", "NR6_Formula" ] ], [ "Start", [ "Term", "NR7_Formula" ] ], 
      [ "Start", [ "Nonterm_var", "NR8_Formula" ] ], [ "Start", [ "Nonterm_var", "NR9_Formula" ] ], 
      [ "Start", [ "Nonterm_int", "NR10_Formula" ] ], [ "Start", [ "Nonterm_predicate", "NR11_Formula" ] ], 
      [ "NR1_Formula", [ "Formula", "Nonterm_rightpar" ] ], [ "NR2_Formula", [ "Nonterm_quantifier", "NR3_Formula" ] ], 
      [ "NR3_Formula", [ "Nonterm_var", "NR4_Formula" ] ], [ "NR4_Formula", [ "Nonterm_colon", "NR5_Formula" ] ], 
      [ "NR5_Formula", [ "Formula", "Nonterm_rightpar" ] ], [ "NR6_Formula", [ "Nonterm_logicconnective", "Formula" ] ], 
      [ "NR7_Formula", [ "Nonterm_equal", "Term" ] ], [ "NR8_Formula", [ "Nonterm_compare", "Nonterm_var" ] ], 
      [ "NR9_Formula", [ "Nonterm_compare", "Nonterm_int" ] ], [ "NR10_Formula", [ "Nonterm_compare", "Nonterm_var" ] ], 
      [ "NR11_Formula", [ "Nonterm_leftsquare", "NR12_Formula" ] ], [ "NR12_Formula", [ "Varlist", "Nonterm_rightsquare" ] ], 
      [ "NR1_Term", [ "Term", "Nonterm_rightpar" ] ], [ "NR2_Term", [ "Nonterm_plus", "Term" ] ], 
      [ "NR3_Term", [ "Nonterm_times", "Nonterm_var" ] ], [ "NR4_Term", [ "Nonterm_int", "NR5_Term" ] ], 
      [ "NR5_Term", [ "Nonterm_rightpar", "NR6_Term" ] ], [ "NR6_Term", [ "Nonterm_times", "Nonterm_var" ] ], 
      [ "NR7_Term", [ "Nonterm_minus", "NR8_Term" ] ], [ "NR8_Term", [ "Nonterm_int", "NR9_Term" ] ], 
      [ "NR9_Term", [ "Nonterm_rightpar", "NR10_Term" ] ], [ "NR10_Term", [ "Nonterm_times", "Nonterm_var" ] ], 
      [ "NR1_Varlist", [ "Nonterm_comma", "Varlist" ] ] ], [ "Start" ] ];
  NonTerm:=StructuralCopy(G[1]);
  Term:=StructuralCopy(G[2]);
  UnitRules:=StructuralCopy(G[3]);
  ProductRules:=StructuralCopy(G[4]);              
  Start:=StructuralCopy(G[5]);
  # Cocke–Younger–Kasami algorithm
  n:=Length(S);
  r:=Length(NonTerm);
  R:=[];
  Q:=[];
  P:=[];
  for k in [1..r] do
    Add(R, false);
  od;
  for j in [1..n] do
    Add(Q, StructuralCopy(R));
  od;
  for i in [1..n] do
    Add(P, StructuralCopy(Q));
  od;
  for i in [1..n] do
    for j in [1..Length(UnitRules)] do
      if UnitRules[j][2][1] = I[i] then
        P[1][i][Position(NonTerm,UnitRules[j][1])]:=true;     # unit production Rv -> as
      fi;
    od;
  od;
  for l in [2..n] do          # Length of span
    for s in [1..n-l+1] do    # Start of span
      for p in [1..l-1] do    # Partition of span
        for i in [1..Length(ProductRules)] do
          a:=Position(NonTerm, ProductRules[i][1]);
          b:=Position(NonTerm, ProductRules[i][2][1]);
          c:=Position(NonTerm, ProductRules[i][2][2]);
          if P[p][s][b] and P[l-p][s+p][c] then 
            P[l][s][a]:=true;
          fi;
        od;
      od;
    od;
  od;
  # if the the symbol is true, string is accepted by the grammar.
  if not P[n][1][1] then
    if Length(Positions(S,"(")) <> Length(Positions(S,")")) then                 
      Print("Please check your input, there is a different amount of opening and closing parenthesis. Compare # left parenthesis: ", Length(Positions(S,"(")), " and # right parenthesis: ", Length(Positions(S,")")), ".\n");
    fi;
    Print("The input cannot be generated by the predefined grammar, for an overview please use PredicataGrammar().\n");
    return false;
  fi;
  # here: accepted by grammar, but: check for correctly quantification, no variables quantified more than once within one proper subformula.
  Q:=PositionsProperty(S, i-> PredicataIsStringType(i, "quantifier"))+1;  # quantified variables positions
  P:=S{Q};                                # quantified variables
  for v in Unique(P) do                   # run through all variables.
    p:=Intersection(Positions(S, v), Q);  # bounded variable occurences
    R:=[];                                # variable range collection
    for i in [1..Length(p)] do            # run through all variables    
      b:=1;
      j:=p[i];  
      B:=true;
      while j <= Length(S) and B do
        if S[j] = "(" then
          b:=b+1;                         # counting "("
        elif S[j] = ")" then
          b:=b-1;                         # counting ")"
        fi;
        if b = 0 then                     # check if there have been already enough closing parenthesis
          R[i]:=[p[i]-2..j];              # set B[i] to the "range" of the bounded variable v at the p[i]-th position.
          B:=false;
        fi;
        j:=j+1;
      od;
    od;
    # checking the intersection of the ranges, if it's not empty then false (for the case of a variable being bounded more than once.)
    if Length(p) > 1 and not Intersection(R) = [] then    
      Print("Please check the formula, the variable ", S[p[i]], " is quantifed more than once.\n");
      return false;
    # checking if a bounded variable occures also as a unbounded one, i.e. the positions of the variable v must be in one of the ranges of the bounded variable.
    elif not IsSubsetSet(Union(R), Positions(S, v)) then
      Print("Please check the formula, the variable ", S[p[i]], " is a quantified variable but also occures as a free variable.\n");
      return false;
    fi;    
  od;
  # Passed all tests, therefore true!
  return true;
end);
####################################################################################################
##
#F  PredicataFormula(f)
##
InstallGlobalFunction( PredicataFormula, function (f, args...)
  local A, F, P, S, predstr, var, boundedvar, freevar;
  if Length(args) = 0 then
    P:=PredicataList;
    #P:=PredicataRepresentation();
  elif Length(args) = 1 and IsPredicataRepresentation(args[1]) then
    P:=args[1];
  else
    Error("PredicataFormula failed, wrong optional input");
  fi;
  # checking if input is string
  if not IsString(f) then
    Error("PredicataFormula failed, the argument is not a string");
  fi;
  # checking if input is accepted by my predefined grammar.
  if not PredicataGrammarVerification(f, P) then
    Print("PredicataFormula failed, the string is not accepted by the grammar.\n");
    return fail;
  fi;
  # bounded and free variables
  S:=PredicataNormalizedString(f, P); 
  boundedvar:=Unique(S{Intersection(PositionsProperty(S, i->PredicataIsStringType(i, "quantifier"))+1, PositionsProperty(S, i->PredicataIsStringType(i, "variable")))});
  var:=Unique(S{PositionsProperty(S, i->PredicataIsStringType(i, "variable"))});
  freevar:=Difference(var, boundedvar);
  # Defining new family
  F:=NewFamily("PredicataFormulaFam", IsPredicataFormulaObj);
  predstr:=rec(string:=f, predrep:=P, bounded:=boundedvar, free:=freevar);
  A:=Objectify(NewType(F, IsPredicataFormulaObj and IsPredicataFormulaRep and IsAttributeStoringRep), predstr);
  # Return the PredicataFormula.
  return A;
end);
####################################################################################################
##
#F  BoundedVariablesOfPredicataFormula(t)
##
##  Returns the bounded variables of the string.
##
InstallGlobalFunction( BoundedVariablesOfPredicataFormula, function ( f )
  if IsPredicataFormulaObj(f) then
    return ShallowCopy(f!.bounded);
  else 
    Error("BoundedVariablesOfPredicataFormula failed, the argument must be a PredicataFormula.\n");
  fi;
end);
####################################################################################################
##
#F  FreeVariablesOfPredicataFormula(t)
##
##  Returns the free variables of the string.
##
InstallGlobalFunction( FreeVariablesOfPredicataFormula, function ( f )
  if IsPredicataFormulaObj(f) then
    return ShallowCopy(f!.free);
  else 
    Error("FreeVariablesOfPredicataFormula failed, the argument must be a PredicataFormula.\n");
  fi;
end);
####################################################################################################
##
#F  IsPredicataFormula(f)
##
##  Tests if f is from type PredicataFormula.
##
InstallGlobalFunction( IsPredicataFormula, function(f)
    return(IsPredicataFormulaObj(f));
end);
####################################################################################################
##
#M  DisplayString(f)
##
InstallMethod ( DisplayString,
  "Returns the PredicataFormula nicely formatted.",
  true,
  [IsPredicataFormulaObj and IsPredicataFormulaRep], 0,
  function( f )
    return Concatenation("PredicataFormula: ", String(PredicataNormalizedString(f!.string, f!.predrep, true, false)), ".\n");
end);
####################################################################################################
##
#M  ViewString(f)
##
InstallMethod( ViewString,       
  "Returns the most important informations about the PredicataFormula.",
  true,
  [IsPredicataFormulaObj and IsPredicataFormulaRep], 0,
  function( f )
    return Concatenation("< PredicataFormula: ", String(PredicataNormalizedString(f!.string, f!.predrep, true, false)), " >");
end);
####################################################################################################
##
#M  String(f)
##
InstallMethod( String,
 "Returns the string of a PredicataFormulaFormatted",
  true, 
  [IsPredicataFormulaObj and IsPredicataFormulaRep], 0, 
  function( f )
    local P;
    if f!.predrep!.namelist = [] then
      return Concatenation("PredicataFormula(\"",f!.string, "\");");
    else
      return Concatenation("PredicataFormula(\"",f!.string, "\", ",  String(f!.predrep), ");");
    fi;
end);
####################################################################################################
##
#B  PredicataCheckForAt
##
##  CHECKS if in a list l FOR an element e AT position p 
##
BindGlobal( "PredicataCheckForAt", function ( l, e, p )
  if not IsList(l) or p < 0 or p > Length(l) + 1 then
    Error("PredicataCheckForAt failed.\n");
  elif p = 0 or p = Length(l) + 1 then
    return false;
  elif l[p] = e then
    return true;
  else
    return false;
  fi;
end);
####################################################################################################
##
#B  PredicataFormulaFormattedAddedParentheses
##
##  Adds parentheses and calls recursively for the case "not":
##
InstallGlobalFunction( PredicataFormulaFormattedAddedParentheses, function (f)
  local Symbols, B, F, S, c, count, g, p, i, j;
  Symbols:=["*", "+", "=", "geq", "gr", "leq", "less", "not", "and", "or", "equiv", "implies"]; # here matters the order of the symbols!
  F:=[];
  while f <> F do
    F:=StructuralCopy(f);
    for S in Symbols do     # run through all symbols in the correct way
      p:=Positions(f, S);
      count:=1;
      while not p = [] do
        i:=p[1];
        if S = "not" and (not PredicataCheckForAt(f, "(", i-1) or not PredicataCheckForAt(f, ")", i+2)) and not PredicataIsStringType(f[i+1], "symbol") then
          g:=Concatenation("(", Concatenation(f{[i..i+1]}), ")");
          f:=f{Concatenation([1..i-1], [i], [i+2..Length(f)])};
          f[i]:=g;
        elif S = "not" and PredicataCheckForAt(f, "(", i-1) and PredicataCheckForAt(f, ")", i+2) then
          g:=Concatenation((f{[i-1..i+2]}));
          f:=f{Concatenation([1..i-2], [i], [i+3..Length(f)])};
          f[i-1]:=g;
        elif S = "not" and PredicataCheckForAt(f, "(", i+1) then # case: "not" "(" .... ")" where the substring must be formatted before.
          c:=1;                                         # find correct parentheses, begin and ending.
          j:=i+2;
          B:=true;
          while j < Length(f) and B do
            if PredicataCheckForAt(f, "(", j) then
              c:=c+1;
            elif PredicataCheckForAt(f, ")", j) then
              c:=c-1;
            fi;
            if c = 0 then
              B:=false;                                 # at the j-th position is the closing parethesis.
            else
              j:=j+1;
            fi;
          od;
          g:=PredicataFormulaFormattedAddedParentheses(f{[i+1..j]});  # format the substring.
          # f:=f{Concatenation([1..i],[j+1..Length(f)])};
          # if not PredicataCheckForAt(f, "(", i-1) then # add parentheses if needed.
            # f[i]:=Concatenation(Concatenation(["("], f{[i]}, g, [")"]));
          # else                                # otherwise don't.
            # f[i]:=Concatenation(Concatenation(f{[i]}, g));
          # fi;
          f:=f{Concatenation([1..i],[i+1],[j+1..Length(f)])};
          f[i+1]:=Concatenation(g);
        elif S <> "not" and (not PredicataCheckForAt(f,"(",i-2) or not PredicataCheckForAt(f,")",i+2)) and (not PredicataIsStringType(f[i-1], "symbol") and not PredicataIsStringType(f[i+1], "symbol")) then
          g:=Concatenation("(",Concatenation(f{[i-1..i+1]}),")");
          f:=f{Concatenation([1..i-2],[i],[i+2..Length(f)])};
          f[i-1]:=g;
        elif S <> "not" and PredicataCheckForAt(f,"(",i-2) and PredicataCheckForAt(f,")",i+2) then
          g:=Concatenation((f{[i-2..i+2]}));
          f:=f{Concatenation([1..i-3],[i],[i+3..Length(f)])};
          f[i-2]:=g;
        else
          count:= count + 1;              # Increase counter by one in order to move to the next symbol
        fi;
        p:=Positions(f,S);                # update the position list of the binary symbol and
        p:=p{[count..Length(p)]};         # look at the remaining positions.
      od;
    od;
    for S in ["A","E"] do # run through all quantifier symbols
      p:=Positions(f,S);
      count:=1;
      while not p = [] do
        i:=p[1];
        if i > Length(f)-3 then
          Error("PredicataFormulaFormatted failed, invalid formula, quantifier symbol at wrong position.\n");
        #elif (not PredicataCheckForAt(f,"(",i-1) or not PredicataCheckForAt(f,")",i+4)) and not PredicataIsStringType(f[i+1], "symbol") and f[i+2] = ":" and not PredicataIsStringType(f[i+3], "symbol") then
        #  g:=Concatenation("(",Concatenation(f{[i..i+3]}),")");
        #  f:=f{Concatenation([1..i-1],[i],[i+4..Length(f)])};
        #  f[i]:=g;
        elif PredicataCheckForAt(f,"(",i-1) and f[i+2] = ":" and PredicataCheckForAt(f,")",i+4) then
          g:=Concatenation((f{[i-1..i+4]}));
          f:=f{Concatenation([1..i-2],[i],[i+5..Length(f)])};
          f[i-1]:=g;
        else
          count:= count + 1;
        fi;
        p:=Positions(f, S);
        p:=p{[count..Length(p)]};  
      od;
    od;
  od;
  return f;
end);
####################################################################################################
##
#F  PredicataFormulaFormatted(f)
##
##  Formats a predicata string.
##
InstallGlobalFunction( PredicataFormulaFormatted, function ( f )
  local P, F, F2, g, p, i, left, right, S, Symbols, count, A, Fam, formattedpredstr, boundedvar, freevar;
  if IsPredicataFormulaObj(f) then
    P:=f!.predrep;
    boundedvar:=f!.bounded;
    freevar:=f!.free;
    f:=f!.string;
  else  
    Error("PredicataFormulaFormatted failed, the argument must be a PredicataFormula.\n");
  fi;
  # splits the string into a list of strings, after adding whitespaces and renaming compare symbols and own defined predicates.
  f:=PredicataNormalizedString(f, P, false, true);
  # combine the occurence of predicates to one string, i.e. [..., "P", "[", "x", ",", "y", "]",...] to [...,"P[x,y]",...];
  left:=Positions(f,"[")-1;
  right:=Positions(f,"]");
  if not Length(left) = Length(right) then
    Error("PredicataFormulaFormatted failed, different amount of square brackets.\n");
  else
    while Length(left) > 0 do
      if left[1] > 0 and right[1] <= Length(f) then
      g:=Concatenation(f{[left[1]..right[1]]});
      f:=Concatenation(f{[1..left[1]-1]},[left[1]],f{[right[1]+1..Length(f)]});
      f[left[1]]:=g;
      left:=Positions(f,"[")-1;
      right:=Positions(f,"]");
      else 
        Error("PredicataFormulaFormatted failed, wrong placements of square brackets.\n");
      fi;
    od;
  fi;
  # combine negative multiplication
  i:=2;
  while i < Length(f)-1 do
    if f[i-1]="(" and f[i]="-" and f[i+2]=")" and PredicataIsStringType(f[i+1], "integer") then
      g:=Concatenation(f[i-1], f[i], f[i+1], f[i+2]);
      f:=f{Concatenation([1..i-2], [i], [i+3..Length(f)])};
      f[i-1]:=g;
    fi;
    i:=i+1;
  od;
  # remove unneccessary brackets around variables, positive integers and booleans
  i:=2;
  while i < Length(f) do
    if f[i-1]="(" and f[i+1]=")" and (PredicataIsStringType(f[i], "variable") or PredicataIsStringType(f[i], "integer") or PredicataIsStringType(f[i], "boolean")) then
      f:=f{Concatenation([1..i-2],[i],[i+2..Length(f)])};
    fi;
    i:=i+1;
  od;
  # combine terms which have the correct brackets
  F:=[];
  while not f = F do
    F:=StructuralCopy(f);
    i:=2;
    while i < Length(f)-1 do
      # checking for binary symbol occurences with brackets around
      if 2 < i and i < Length(f)-1 and f[i-2]="(" and not PredicataIsStringType(f[i-1], "symbol") and PredicataIsStringType(f[i], "binarysymbol")
          and not PredicataIsStringType(f[i+1], "symbol") and f[i+2]=")" then
        g:=Concatenation(f{[i-2..i+2]});
        f:=f{Concatenation([1..i-3],[i],[i+3..Length(f)])};
        f[i-2]:=g;
      # checking for binary symbol occurences with brackets around
      elif f[i-1]="(" and PredicataIsStringType(f[i], "unarysymbol") and not PredicataIsStringType(f[i+1], "symbol") and f[i+2]=")" then 
        g:=Concatenation(f{[i-1..i+2]});
        f:=f{Concatenation([1..i-2],[i],[i+3..Length(f)])};
        f[i-1]:=g;
      # checking for unneccessary brackets, delete them.
      elif f[i-1]="(" and not PredicataIsStringType(f[i], "symbol") and f[i+1]=")" then
        f:=f{Concatenation([1..i-2],[i],[i+2..Length(f)])};
      # checking for quantifiers
      elif i < Length(f)-3 and f[i-1]="(" and PredicataIsStringType(f[i], "quantifier") and not PredicataIsStringType(f[i+1], "symbol") and f[i+2]=":" 
          and not PredicataIsStringType(f[i+3], "symbol") and f[i+4]=")" then
        g:=Concatenation(f{[i-1..i+4]});
        f:=f{Concatenation([1..i-2],[i],[i+5..Length(f)])};
        f[i-1]:=g;
      fi;
      i:=i+1;
    od;
  od;
  # adding missing brackets.
  f:=PredicataFormulaFormattedAddedParentheses(f);
  F:=[];
  for i in [1..Length(f)] do        # run through all sub-strings
    f[i]:=PredicataNormalizedString(f[i], P, true, true, false);
    Append(F,f[i]);
  od;
  Fam:=NewFamily("PredicataFormulaFormattedFam", IsPredicataFormulaFormattedObj);
  formattedpredstr:=rec(stringlist:=F, predrep:=P, bounded:=boundedvar, free:=freevar);
  A:=Objectify(NewType(Fam, IsPredicataFormulaFormattedObj and IsPredicataFormulaFormattedRep and IsAttributeStoringRep), formattedpredstr);
  # Return the formatted formula.
  return A;
end);
####################################################################################################
##
#F  IsPredicataFormulaFormatted(f)
##
##  Tests if f is from type PredicataFormula.
##
InstallGlobalFunction( IsPredicataFormulaFormatted, function(f)
    return(IsPredicataFormulaFormattedObj(f));
end);
####################################################################################################
##
#M  DisplayString(f)
##
InstallMethod ( DisplayString,
  "Returns the PredicataFormulaFormatted nicely formatted.",
  true,
  [IsPredicataFormulaFormattedObj and IsPredicataFormulaFormattedRep], 0,
  function( f )
    return Concatenation("PredicataFormulaFormatted: ", String(f!.stringlist), ".\nConcatenation: ", String(Concatenation(f!.stringlist)),".\n");
end);
####################################################################################################
##
#M  ViewString(f)
##
InstallMethod( ViewString,
  "Returns the most important informations about the PredicataFormulaFormatted.",
  true,
  [IsPredicataFormulaFormattedObj and IsPredicataFormulaFormattedRep], 0,
  function( f )
    return Concatenation("< PredicataFormulaFormatted: ", String(PredicataNormalizedString(Concatenation(f!.stringlist), f!.predrep, true, false)), " >");
end);
####################################################################################################
##
#M  String(f)
##
InstallMethod( String,
  "Returns the string of a PredicataFormulaFormatted", 
  true, 
  [IsPredicataFormulaFormattedObj and IsPredicataFormulaFormattedRep], 0, 
  function( f )
  local P;
    if f!.predrep!.namelist = [] then
      return Concatenation("PredicataFormulaFormatted(PredicataFormula(\"",Concatenation(f!.stringlist), "\"));");
    else
      return Concatenation("PredicataFormulaFormatted(PredicataFormula(\"",Concatenation(f!.stringlist), "\", ",  String(P), "));");
    fi;
end);
##
#E
##
