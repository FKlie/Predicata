########################################################################
##
##  My predefined context free grammar (CFG).
##
##  Non-Terminals
##
CFG_N:=["Formula", "Term", "Varlist"];
##
##  Terminals
##
CFG_T:=["leftpar", "rightpar", "leftsquare", "rightsquare", "not", "quantifier", "colon",  "logicconnective", "equal", "plus", "minus", "times", "compare", "comma", "predicate", "var", "int", "boolean"];
##
##  Rules
##
CFG_Rules:=[["Formula",[["leftpar","Formula","rightpar"],                             #  1
                        ["not","Formula"],                                            #  2
                        ["leftpar","quantifier","var","colon","Formula","rightpar"],  #  3
                        ["Formula","logicconnective","Formula"],                      #  4
                        ["Term","equal","Term"],                                      #  5
                        ["var","compare","var"],                                      #  6
                        ["var","compare","int"],                                      #  7
                        ["int","compare","var"],                                      #  8
                        ["predicate","leftsquare","Varlist","rightsquare"],           #  9
                        ["boolean"]]],                                                # 10
            ["Term",   [["leftpar","Term","rightpar"],                                # 11
                        ["Term","plus","Term"],                                       # 12
                        ["int","times","var"],                                        # 13
                        ["leftpar", "int", "rightpar", "times","var"],                # 13b
                        ["leftpar", "minus", "int", "rightpar", "times", "var"],      # 14
                        ["var"],                                                      # 15
                        ["int"]]],                                                    # 16
            ["Varlist",[["var","comma","Varlist"],                                    # 17
                        ["var"]]]];                                                   # 18
##
##  Start
##
CFG_S:=["Formula"];
##
##  Grammar
##
CFG_Grammar:=[CFG_N,CFG_T,CFG_Rules,CFG_S];
##
##  CNF_For_CYK(CFG_Grammar);
##
########################################################################
##
#F  CFG_CreateGrammar(start)
##
##  Takes the start symbol, and creates a list with for lists, 
## i.e. Non-Terminals, Terminals, Rules, Start symbol
##
CFG_CreateGrammar := function ( start )
  if IsString(start) then
    return [[start],[],[],[start]];
  else
    Print("CFG_CreateGrammar failed");
    return fail;
  fi;
end;;
########################################################################
##
#F  CFG_AddTerminals(terminals, G)
##
##  Adds to a given grammar either a string or a list to the terminals.
##
CFG_AddTerminals := function ( terminals, G )
  if IsString(terminals) and not terminals in G[1] and not terminals in G[2] then
    Add(G[2],terminals);
  elif IsList(terminals) and not IsString(terminals) and Intersection(terminals, G[1]) = [] and Intersection(terminals, G[2]) = [] then
    Append(G[2],terminals);
  else
    Print("CFG_AddTerminals failed");
  fi;
end;;

########################################################################
##
#F  CFG_AddNonterminals(nonterminals, G)
##
##  Adds to a given grammar either a string or a list to the non-terminals.
##
CFG_AddNonterminals := function ( nonterminals, G )
  if IsString(nonterminals) and not nonterminals in G[1] and not nonterminals in G[2] then
    Add(G[1],nonterminals);
  elif IsList(nonterminals) and not IsString(nonterminals) and Intersection(nonterminals, G[2]) = [] and Intersection(nonterminals, G[1]) = [] then
    Append(G[1],nonterminals);
  else
    Print("CFG_AddNonterminals failed");
  fi;
end;;
########################################################################
##
#F  CFG_AddRule(rule, G)
##
##  Adds a rule of the format [nonterminal, [[terminals or nonterminals]]]
##  to the rules of a given grammar G.
##
CFG_AddRule := function ( rule, G )
  local N, T, R, S, i, B, M;
  N:=G[1];
  T:=G[2];
  R:=G[3];
  S:=G[4];
  B:=true;
  M:=Union(N,T);
  for i in [1..Length(rule[2][1])] do
    if not rule[2][1][i] in M then
      Print("\nCFG_AddRule failed, invalid rule:\n");
      Print(rule);
      return fail;
    fi;
  od;
  for i in [1..Length(R)] do
    if R[i][1] = rule[1] then
      Add(R[i][2], rule[2][1]);
      B:=false;
    fi;
  od;
  if B then 
    Append(R, [rule]);
  fi;
end;;
########################################################################
##
#F  CNF_START(G)
##
##  Is the first step in creating the Chomsky Normal Form. 
##  It creates a new start symbol and duplicates the rules from the 
##  previous start symbol to the new one.
##
CNF_START := function ( G )
  local N, T, R, S, i, s, B;
  N:=G[1];
  T:=G[2];
  R:=G[3];
  S:=G[4];
  i:=0;
  B:=true;
  while B do
    if i=0 then
      s:="Start";
    else 
      s:=Concatenation("Start",String(i));
    fi;
    if not s in N then
      B:=false;
      #Add(N,s);
      G[1]:=Concatenation([s],N);
      Add(R,[s,[[S[1]]]]);
      S[1]:=s;
    fi;
  od;
  return G;
end;;

########################################################################
##
#F  CNF_TERM(G)
##
##  Is the second step in creating the Chomsky Normal Form. 
##  It replaces every terminal symbol in a rule with more than two 
##  elements with a new nonterminal symbol. It also creates a new rule,
##  where the new nonterminal symbol turns in the terminal symbol. 
##
CNF_TERM := function ( G )
  local N, T, R, S, U, N_U, P, u, r, r1, i, i1, p;
  N:=G[1];
  T:=G[2];
  R:=G[3];
  S:=G[4];
  for r in [1..Length(R)] do
    for i in [1..Length(R[r][2])] do
      U:=Intersection(T,R[r][2][i]);
      if Length(R[r][2][i]) > 1 and not U=[] then
        N_U:=StructuralCopy(U);
        Apply(N_U,i->Concatenation("Nonterm_",i));
        CFG_AddNonterminals(N_U,G);
        #Append(N,N_U);
        for u in [1..Length(N_U)] do
          for r1 in [1..Length(R)] do    
            for i1 in [1..Length(R[r1][2])] do
              P:=Positions(R[r1][2][i1],U[u]);
              for p in P do
                R[r1][2][i1][p]:=N_U[u];
              od;
            od;
          od;
          CFG_AddRule([N_U[u],[[U[u]]]],G);
          #Append(R,[[N_U[u],[[U[u]]]]]);
        od;
      fi;
    od;
  od;      
  return [N,T,R,S];
end;;
########################################################################
##
#F  CNF_BIN(G)
##
##  Is the third step in creating the Chomsky Normal Form. 
##  It splits every formula turning into N > 2 nonterminals into N-2
##  new rules.
##
CNF_BIN := function ( G )
  local N, T, R, S, counter, n, r, i, U, TempR, j, newrule1, newrule2;
  N:=G[1];
  T:=G[2];
  R:=G[3];
  S:=G[4];
  for r in [1..Length(R)] do
    counter:=1;
    for i in [1..Length(R[r][2])] do
      # U:=0;
      # for l in [1..Length(R[r][2][i])] do
        # if R[r][2][i][l] in N then
          # U:=U+1;
        # fi;
      # od;
      if Length(R[r][2][i]) > 2 then # U > 2 then
        TempR:=StructuralCopy(R[r][2][i]);
        newrule1:=Concatenation("NR",String(counter),"_",R[r][1]); # numerating new rule
        #Add(N,newrule1);                                               # adding to nonterminals
        CFG_AddNonterminals(newrule1,G);
        R[r][2][i]:=[R[r][2][i][1],newrule1];                           # replace rule
        n:=Length(TempR);
        for j in [2..n-2] do                                            # iteratively
          newrule2:=Concatenation("NR",String(counter+1),"_",R[r][1]);
          CFG_AddNonterminals(newrule2,G);
          #Append(R, [ [ newrule1,[[ TempR[j], newrule2]] ]]);
          CFG_AddRule([newrule1,[[TempR[j],newrule2]]], G);
          counter:=counter+1;
          newrule1:=Concatenation("NR",String(counter),"_",R[r][1]);
          #Add(N,newrule1);
        od;
        #Append(R, [ [ newrule1, [[ TempR[n-1],TempR[n] ]] ] ]);         # last step
        CFG_AddRule([newrule1,[[TempR[n-1],TempR[n]]]], G);
        counter:=counter+1;
      fi;
    od;
  od;
  return [N,T,R,S];
end;;
########################################################################
##
#F  CNF_UNIT(G)
##
##  Is the fourth step in creating the Chomsky Normal Form. 
##  It removes unit rules, i.e. for every rule where a nontermial turns
##  into exactly one nonterminal, which turns into more than one
##  nonterminal, it deletes the middle nonterminal.
##
CNF_UNIT := function ( G )
  local N, T, R, S, B, r, r1, i, i1;
  N:=G[1];
  T:=G[2];
  R:=G[3];
  S:=G[4];
  for r in [1..Length(R)] do
    i:=1;
    while i <= Length(R[r][2]) do
      if Length(R[r][2][i])=1 and R[r][2][i][1] in N then     # Case: nonterminal -> nonterminal
        B:=R[r][2][i];
        Remove(R[r][2],i);
        # Print("\nremoving\n");
        # Print(R[r][1]);
        # Print("->");
        # Print(B);
        for r1 in [1..Length(R)] do
          if R[r1][1] = B[1] then
            for i1 in [1..Length(R[r1][2])] do
              if not ( Length(R[r1][2][i1])=1 and R[r1][2][i1][1] in N ) then
                # Print("\nadding\n");
                # Print(R[r][1]);
                # Print("->");
                # Print(R[r1][2][i1]);
                # Print("\n\n");
                Add(R[r][2],R[r1][2][i1]);
              fi;
            od;
          fi;
        od;
      else  
        i:=i+1;
      fi;
    od;
  od;  
  return [N,T,R,S];    
end;;
        
########################################################################
##
#F  CNF_ChomskyNormalForm(G)
##
##  Computes the Chomsky Normal Form. It executes 
##    * CNF_START(C);
##    * CNF_TERM(C);
##    * CNF_BIN(C);
##    * CNF_UNIT(C);
##
CNF_ChomskyNormalForm := function ( G )
  local C;
  C:=[];
  C:=StructuralCopy(G);
  C:=CNF_START(C);
  C:=CNF_TERM(C);
  C:=CNF_BIN(C);
  C:=CNF_UNIT(C);
  return C;
end;;         
########################################################################
##
#F  CNF_FormatRules(Rules)
##
##  Splits rules given in Chomsky Normal Form into rules turning into 
##  one terminal and rules turning into two nonterminals.
##
CNF_FormatRules := function ( Rules )
  local UnitRules, ProductRules, r, i;
  UnitRules:=[];
  ProductRules:=[];
  for r in [1..Length(Rules)] do
    for i in [1..Length(Rules[r][2])] do
      if Length(Rules[r][2][i])=1 then
        Add(UnitRules,[Rules[r][1],Rules[r][2][i]]);
      elif Length(Rules[r][2][i])=2 then
        Add(ProductRules,[Rules[r][1],Rules[r][2][i]]);
      fi;
    od;
  od;
  return [UnitRules, ProductRules];
end;;
########################################################################
##
#F  CNF_For_CYK(G)
##
CNF_For_CYK := function (G)
  local C, R;
  C:=CNF_ChomskyNormalForm(G);
  R:=CNF_FormatRules(C[3]);
  return [C[1], C[2], R[1], R[2], C[4]];
end;;
########################################################################
##
#F  IsVariableString(v)
##
IsVariableString := function ( v )
  local A,i;
  A:=['a','b','c','d','e','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
  if not IsString(v) or Length(v)=0 then 
    return false;
  elif v[1] in A then
    i:=Int(v{[2..Length(v)]});
    if IsInt(i) and i>=0 then
      return true;
    else
      return false;
    fi;
  else
    return false;
  fi;
end;;
########################################################################
##
#F  IsPositiveIntegerString(i)
##
IsPositiveIntegerString := function ( i )
  local j;
  if not IsString(i) or Length(i)=0 then 
    return false;
  else
    j:=Int(i);
    if IsInt(j) and j>=0 then
      return true;
    else
      return false;
    fi;
  fi;
end;;
########################################################################
##
#F  IsBooleanString(b)
##
IsBooleanString := function ( b )
  if IsString(b) and b in ["true","false"] then 
    return true;
  else
    return false;
  fi;
end;;
########################################################################
##
#F  IsPredicateString(p)
##
IsPredicateString := function ( p )
  local P,i;
  P:=['P','Q','S','T'];
  if not IsString(p) or Length(p)=0 then 
    return false;
  elif p[1] in P then
    i:=Int(p{[2..Length(p)]});
    if IsInt(i) and i>=0 then
      return true;
    else
      return false;
    fi;
  else
    return false;
  fi;
end;;
########################################################################
##
#F  CFG_LexicalAnalysis(l, P)
##
##  Converts a given string into the symbols used by my context-free grammar.
##
CFG_LexicalAnalysis := function( l)
  local t, i;
  t:=[];
  for i in [1..Length(l)] do
    if   l[i]="(" then 
      Add(t,"leftpar");
    elif l[i]=")" then 
      Add(t,"rightpar");
    elif l[i]="[" then 
      Add(t,"leftsquare");
    elif l[i]="]" then 
      Add(t,"rightsquare");
    elif l[i]="not" then 
      Add(t,"not");
    elif l[i]="A" or l[i]="E" then 
      Add(t,"quantifier");
    elif l[i]=":" then 
      Add(t,"colon");
    elif l[i]="and" or l[i]="or" or l[i]="implies" then
      Add(t,"logicconnective");
    elif l[i]="=" then 
      Add(t,"equal");
    elif l[i]="+" then 
      Add(t,"plus");
    elif l[i]="*" then 
      Add(t,"times");
    elif l[i]="gr" or l[i]="less" or l[i]="geq" or l[i]="leq" then 
      Add(t,"compare");
    elif l[i]="," then 
      Add(t,"comma");
    elif IsPredicateString(l[i]) then 
      Add(t,"predicate");
    elif IsVariableString(l[i]) then 
      Add(t,"var");
    elif IsPositiveIntegerString(l[i]) then 
      Add(t,"int");
    elif IsBooleanString(l[i]) then
      Add(t,"boolean");
    else 
      Add(t,"invalid");
    fi;
  od;
  return t;
end;;
########################################################################
##
#F  CYK_Algorithm
##
##  Computes Cocke–Younger– Kasami algorithm for an given input I
##
CYK_Algorithm := function ( I, NonTerm, Term, UnitRules, ProductRules, Start ) 
  local R, Q, P, S, V, n, r, i, j, k, l, s, v, p, a, b, c;
  n:=Length(I);
  r:=Length(NonTerm);
  R:=[];
  Q:=[];
  P:=[];
  for k in [1..r] do
    Add(R,false);
  od;
  for j in [1..n] do
    Add(Q,StructuralCopy(R));
  od;
  for i in [1..n] do
    Add(P,StructuralCopy(Q));
  od;
  for i in [1..n] do
    for j in [1..Length(UnitRules)] do
      if UnitRules[j][2][1] = I[i] then
        P[1][i][Position(NonTerm,UnitRules[j][1])]:=true;     # unit production Rv -> as
        #Print("\n1,");
        #Print(i);
        #Print(",");
        #Print(Position(NonTerm,UnitRules[j][1]));
      fi;
    od;
  od;
  for l in [2..n] do          # Length of span
    for s in [1..n-l+1] do    # Start of span
      for p in [1..l-1] do    # Partition of span
        for i in [1..Length(ProductRules)] do
          if not Length(ProductRules[i][2])=2 then
            Print("CYK_Algorithm failed, wrong product rules length");
            return fail;
          fi;   
          a:=Position(NonTerm,ProductRules[i][1]);
          b:=Position(NonTerm,ProductRules[i][2][1]);
          c:=Position(NonTerm,ProductRules[i][2][2]);
          if P[p][s][b] and P[l-p][s+p][c] then 
            P[l][s][a]:=true;
          fi;
        od;
      od;
    od;
  od;
  if P[n][1][1] then
    return P[n][1][1];
  else
    return false;
  fi;  
end;;
########################################################################
##
#F  SplitStringIntoList
##
##  Splits string into a list
##
SplitStringIntoList := function ( f ) 
  local Symbols, i;
  Symbols:=["*", "+", "=", "gr", "geq","less", "leq", "and", "or", "implies", "not", "(", ")", "[", "]", ",", ":", "A", "E"];#"
  f:=ReplacedString(f,">="," geq ");
  f:=ReplacedString(f,"<="," leq ");
  f:=ReplacedString(f,">"," gr ");
  f:=ReplacedString(f,"<"," less ");
  for i in [1..Length(Symbols)] do               # adding whitespaces around all symbols
    f:=ReplacedString(f, Symbols[i], Concatenation(" ", Symbols[i], " ") );
  od;
  f:=NormalizedWhitespace(f);                    # normalize whitespaces 
  f:=SplitString(f, " ");
  return f;
end;;
########################################################################
##
#F  InputVerification
##
##  Checks with the help of the CYK-algorithm if a given formula is
##  in a given grammar
##
InputVerification := function ( f, G )
  local S, I, C, B, NonTerm, Term, UnitRules, ProductRules, Start;
  Print(" Input verification");
  if not IsString(f) then
    Print("\n Input must be a string.\n   ");
    return fail;
  fi;
  Print("\n Given formula: \n   ");
  Print(f);
  S:=SplitStringIntoList(f);
  Print("\n Splits into:\n   ");
  Print(S);
  I:=CFG_LexicalAnalysis(S);        # format formula to the input form.
  Print("\n Converts to: \n   ");
  Print(I);
  if "invalid" in I then
    Print("\n Lexical analysis failed, invalid symbols at ");
    Print(Positions(I,"invalid")); 
    Print(", these symbols aren't accepted:");
    Print(S{Positions(I,"invalid")});
    Print(".\n   ");
    return false;
  else
    Print("\n");
    Print(" Lexical analysis succeeded:\n   ");
    Print("true\n");
  fi;
  C:=CNF_ChomskyNormalForm(G);  # transform into chomsky normal form
  NonTerm:= C[1];
  Term:= C[2];
  UnitRules:=CNF_FormatRules(C[3])[1];
  ProductRules:=CNF_FormatRules(C[3])[2]; 
  Start:=C[4];
  B:=CYK_Algorithm( I, NonTerm, Term, UnitRules, ProductRules, Start );
  if B = fail then
    Print(" Syntactical Analysis: Something went wrong.\n   ");
    return B;
  elif B then
    Print(" Syntactical Analysis: Accepted! Input can be generated by grammar.\n   ");
    return B;
  else
    Print(" Syntactical Analysis: Not accepted! Input cannot be generated by grammar.\n   ");
    return B;
  fi;
end;;
##
#E
##
