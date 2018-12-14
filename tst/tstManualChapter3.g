Print("\nReading tstManualChapter3.g\n");
PredicataFormulaSymbols;
PredicataIsStringType("x1", "variable");
PredicataIsStringType("1", "integer");
PredicataIsStringType("-1", "negativeinteger");
PredicataIsStringType("true", "boolean");
PredicataIsStringType("A", "quantifier");
PredicataIsStringType("+", "symbol");
PredicataGrammarVerification("4+x=2*y");
PredicataGrammarVerification("(E x:3+x=2*y)");
PredicataGrammarVerification("= , 2 + <= x 4");
PredicataFormula("(E y: x + y = z)");
f:=PredicataFormula("(E y: x + y = z)");
IsPredicataFormula(f);
f:=PredicataFormula("(A x: (E y: x = y))");
Display(f);
f:=PredicataFormula("x + y = z");;
View(f);
f:=PredicataFormula("x = 4 and not x = 5");
Print(f);
String(f);
f:=PredicataFormula("(E n: 3*n = x) or (E m: 4*m = x)");
FreeVariablesOfPredicataFormula(f);
f:=PredicataFormula("(E n: 3*n = x) or (E m: 4*m = x)");
BoundedVariablesOfPredicataFormula(f);
f:=PredicataFormula("(E y: x + y = z)");
F:=PredicataFormulaFormatted(f);
f:=PredicataFormula("(E y: x + y = z)");
F:=PredicataFormulaFormatted(f);
IsPredicataFormulaFormatted(F);
F:=PredicataFormulaFormatted(PredicataFormula("(E y: x + y = z)"));
Display(F);
f:=PredicataFormula("x + y = z");;
F:=PredicataFormulaFormatted(f);;
View(F);
F:=PredicataFormulaFormatted(PredicataFormula("x = 4 and not x = 5"));
Print(F);
String(F);
PredicataTree("root");
PredicataTree();
f:=PredicataFormula("(E y: x + y = z)");
IsPredicataFormula(f);
t:=PredicataTree("only one element");
Display(t);
t:=PredicataTree("root");;
View(t);
t:=PredicataTree("root");;
Print(t);
t:=PredicataTree("root");
IsEmptyPredicataTree(t);
t:=PredicataTree("current root");
RootOfPredicataTree(t);
SetRootOfPredicataTree(t, "element #2");
t:=PredicataTree("element #1");
SetRootOfPredicataTree(t, "element #2");
Display(t);
t:=PredicataTree("root");
InsertChildToPredicataTree(t);
Display(t);
InsertChildToPredicataTree(t);
Display(t);
t:=PredicataTree("root");
InsertChildToPredicataTree(t);
ChildOfPredicataTree(t, 1);
SetRootOfPredicataTree(t, "child 1");
Display(t);
t:=PredicataTree("root");
NumberOfChildrenOfPredicataTree(t);
InsertChildToPredicataTree(t);
InsertChildToPredicataTree(t);
NumberOfChildrenOfPredicataTree(t);
ChildOfPredicataTree(t, 1);
SetRootOfPredicataTree(t, "child 1");
Display(t);
NumberOfChildrenOfPredicataTree(t);
InsertChildToPredicataTree(t);
InsertChildToPredicataTree(t);
NumberOfChildrenOfPredicataTree(t);
Display(t);
t:=PredicataTree("root");
InsertChildToPredicataTree(t);
InsertChildToPredicataTree(t);
Display(t);
ChildOfPredicataTree(t, 1);
SetRootOfPredicataTree(t, "child 1");     
ParentOfPredicataTree(t);
ChildOfPredicataTree(t, 2);
SetRootOfPredicataTree(t, "child 2");
Display(t);
t:=PredicataTree("root");
InsertChildToPredicataTree(t);
ChildOfPredicataTree(t, 1);
SetRootOfPredicataTree(t, "child 1");     
ParentOfPredicataTree(t);
r:=ReturnedChildOfPredicataTree(t, 1);
f:=PredicataFormula("(E y: x+y=z and y = x)");
F:=PredicataFormulaFormatted(f);
t:=PredicataFormulaFormattedToTree(F);
f:=PredicataFormula("(E y: x+y=z and y = x)");
F:=PredicataFormulaFormatted(f);
t:=PredicataFormulaFormattedToTree(F);
FreeVariablesOfPredicataTree(t);
f:=PredicataFormula("(E y: x+y=z and y = x)"); 
F:=PredicataFormulaFormatted(f);
t:=PredicataFormulaFormattedToTree(F);
BoundedVariablesOfPredicataTree(t);
f:=PredicataFormula("(E y: x+y=z and y = x)");   
F:=PredicataFormulaFormatted(f);
t:=PredicataFormulaFormattedToTree(F);
P:=PredicataTreeToPredicaton(t);
Display(P[2]);
F:=PredicataFormulaFormatted(PredicataFormula("(E y: x+y=z and y = x)"));;
t:=PredicataFormulaFormattedToTree(F);;
P:=PredicataTreeToPredicatonRecursive(t, [[ "x", "z" ], [ "x", "y", "z" ]]);;
Display(P[2]);
t:=PredicataTree("root");;
A:=Predicaton(Automaton("det", 3, [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], 
[ 1, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ], [ 1, 1, 1 ] ], 
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], 
[ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), [ 1, 2, 3 ]);;
p:=PredicatonRepresentation("MyAdd", 3, A);
A:=Predicaton(Automaton("det", 2, [ [ 0 ], [ 1 ] ], [ [ 1, 2 ], [ 2, 2 ] ],
[ 1 ], [ 1 ]), [ 1 ]);;
p:=PredicatonRepresentation("EqualZero", 1, A);
IsPredicatonRepresentation(p);
A:=Predicaton(Automaton("det", 2, [ [ 0 ], [ 1 ] ], [ [ 1, 2 ], [ 2, 2 ] ], 
[ 1 ], [ 1 ]), [ 1 ]);;
p:=PredicatonRepresentation("EqualZero", 1, A);;
Display(p);
A:=Predicaton(Automaton("det", 4, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 2, 2, 3 ], [ 2, 2, 4, 2 ], [ 2, 2, 1, 2 ], [ 3, 2, 2, 4 ] ],
[ 1 ], [ 1 ]), [ 1, 2 ]);;
p:=PredicatonRepresentation("MultipleOfThree", 2, A);;
View(p);
A:=Predicaton(Automaton("det", 2, [ [ 0 ], [ 1 ] ], [ [ 1, 2 ], [ 2, 2 ] ],
[ 1 ], [ 2 ]), [ 1 ]);;
p:=PredicatonRepresentation("GreaterZero", 1, A);;
Print(p);
String(p);
A:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 4, 2, 3, 3 ],
[ 3, 3, 3, 2 ] ], [ 1 ], [ 3, 4, 1 ]), [ 1 ]);;
p:=PredicatonRepresentation("NotTwo", 1, A);;
NameOfPredicatonRepresentation(p);
A:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 4, 2, 3, 3 ],
[ 3, 3, 3, 2 ] ], [ 1 ], [ 3, 4, 1 ]), [ 1 ]);;
p:=PredicatonRepresentation("NotTwo", 1, A);;
ArityOfPredicatonRepresentation(p);
A:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 4, 2, 3, 3 ],
[ 3, 3, 3, 2 ] ], [ 1 ], [ 3, 4, 1 ]), [ 1 ]);;
p:=PredicatonRepresentation("NotTwo", 1, A);;
PredicatonOfPredicatonRepresentation(p);
A:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 4, 2, 3, 3 ],
[ 3, 3, 3, 2 ] ], [ 1 ], [ 3, 4, 1 ]), [ 1 ]);;
p:=PredicatonRepresentation("NotTwo", 1, A);;
BaseOfPredicatonRepresentation(p);
A:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 4, 2, 3, 3 ],
[ 3, 3, 3, 2 ] ], [ 1 ], [ 3, 4, 1 ]), [ 1 ]);;
p:=PredicatonRepresentation("NotTwo", 1, A);;
AutOfPredicatonRepresentation(p);
A:=Predicaton(Automaton("det", 3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 3, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), [ 1, 2 ] );;
p:=PredicatonRepresentation("CopyPred", 2, A);;
q:=CopyPredicatonRepresentation(p);
A1:=Predicaton(Automaton("det", 3, [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], 
[ 1, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ], [ 1, 1, 1 ] ], 
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], 
[ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), [ 1, 2, 3 ]);;
p1:=PredicatonRepresentation("MyAdd", 3, A1);
A2:=Predicaton(Automaton("det", 2, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 2 ], [ 2, 2 ], [ 2, 2 ], [ 1, 2 ] ], [ 1 ], [ 1 ]), [ 1, 2 ]);;
p2:=PredicatonRepresentation("MyEqual", 2, A2);;
P:=PredicataRepresentation(p1, p2);
f:=PredicataFormula("MyAdd[x,y,z] and MyEqual[x,y]", P);
# Continued example: PredicataRepresentation
IsPredicataRepresentation(P);
# Continued example: PredicataRepresentation
Display(P);
P:=PredicataRepresentation();;
View(P);
# Continued example: PredicataRepresentation
Print(P);
String(P);
# Continued example: PredicataRepresentation
NamesOfPredicataRepresentation(P);
# Continued example: PredicataRepresentation
AritiesOfPredicataRepresentation(P);
# Continued example: PredicataRepresentation
PredicataOfPredicataRepresentation(P);
# Continued example: PredicataRepresentation
ElementOfPredicataRepresentation(P, 1);
# Continued example: PredicataRepresentation
A3:=Predicaton(Automaton("det", 2, [ [ 0 ], [ 1 ] ], [ [ 1, 2 ], [ 2, 2 ] ], 
[ 1 ], [ 2 ]), [ 1 ]);;
p3:=PredicatonRepresentation("GreaterZero", 1, A3);;
Add(P, p3);
P;
# Continued example: PredicataRepresentation
A4:=Predicaton(Automaton("det", 2, [ [ 0 ], [ 1 ] ], [ [ 1, 2 ], [ 2, 2 ] ], 
[ 1 ], [ 1 ]), [ 1 ]);;
Add(P, "EqualZero", 1, A4);
P;
A5:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 4, 2, 3, 3 ],
[ 3, 3, 3, 2 ] ], [ 1 ], [ 3, 4, 1 ]), [ 1 ]);;
p5:=PredicatonRepresentation("NotTwo", 1, A5);;
Add(P, p5);
P;
Remove(P, 1);
P;
A:=Predicaton(Automaton("det", 3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 3, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), [ 1, 2 ]);;
p:=PredicatonRepresentation("CopyPred", 2, A);;
P:=PredicataRepresentation(p);
Q:=CopyPredicataRepresentation(P);
PredicataList;
A1:=Predicaton(Automaton("det", 3, [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], 
[ 1, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ], [ 1, 1, 1 ] ], 
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], 
[ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), [ 1, 2, 3 ]);;
p1:=PredicatonRepresentation("MyAdd", 3, A1);;
Add(PredicataList, p1);
PredicataList;
f:=PredicataFormula("MyAdd[x,y,z]");
# Continued example: PredicataList
A2:=Predicaton(Automaton("det", 2, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 2 ], [ 2, 2 ], [ 2, 2 ], [ 1, 2 ] ], [ 1 ], [ 1 ]), [ 1, 2 ]);;
p2:=PredicatonRepresentation("MyEqual", 2, A2);;
AddToPredicataList(p2);
A3:=Predicaton(Automaton("det", 2, [ [ 0 ], [ 1 ] ], [ [ 1, 2 ], [ 2, 2 ] ], 
[ 1 ], [ 2 ]), [ 1 ]);;
AddToPredicataList("GreaterZero", 1, A3);
PredicataList;
f:=PredicataFormula("MyAdd[x,y,z] and MyEqual[x,y]");
# Continued example: PredicataList
ClearPredicataList();
PredicataList;
A:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 4, 2, 3, 3 ],
[ 3, 3, 3, 2 ] ], [ 1 ], [ 3, 4, 1 ]), [ 1 ]);;
AddToPredicataList("NotTwo", 1, A);
PredicataList;
RemoveFromPredicataList(1);
PredicataList;
f:=PredicataFormula("x = 4");
A:=PredicataFormulaToPredicaton(f);
A:=StringToPredicaton("x+y = z");
Print("\nFinished tstManualChapter3.g\n");