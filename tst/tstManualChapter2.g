Print("\nReading tstManualChapter2.g\n");
A:=Automaton("det", 3,
[ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 0 ],
[ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ], [ 1, 1, 1 ] ],
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ],
[ 3, 1, 3 ], [ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ],
[ 1 ], [ 1 ]);
P:=Predicaton( A, [ 1, 2, 3 ]);
P:=BuildPredicaton("det", 3, [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ],
[ 1, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ], [ 1, 1, 1 ] ],
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ],
[ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ], [ 1, 2, 3 ]);
Display(P);
P:=BuildPredicaton("det", 2, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 2 ], [ 2, 2 ], [ 2, 2 ], [ 1, 2 ] ], [ 1 ], [ 1 ], [ 1, 2 ]);
IsPredicaton(P);
P:=Predicaton(Automaton("det", 3, [ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ],
[ 1, 1, 0 ], [ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ], [ 1, 1, 1 ] ],
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ],
[ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), [ 1, 2, 3 ]);
Display(P);
P:=Predicaton(Automaton("det", 3, [ [ 0 ], [ 1 ] ], [ [ 2, 2, 3 ],
[ 3, 2, 2 ] ], [ 1 ], [ 3 ]), [ 1 ]);;
View(P);
P:=Predicaton(Automaton("det", 3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], 
[ [ 1, 3, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), 
[ 1, 2 ]);;
Print(P);
String(P);
a1:=PredicataAlphabet(3);
P1:=Predicaton(Automaton("det", 3, a1,
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ],
[ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), [ 1, 2, 3 ]);;
Display(P1);
a2:=PredicataAlphabet(0);
P2:=Predicaton(Automaton("det", 1, a2, [ [ 1 ] ], [ 1 ], [ 1 ]), [ ]);;
Display(P2);
A:=Automaton("det", 4, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 3, 2, 2, 4 ], [ 2, 2, 4, 2 ], [ 2, 2, 3, 2 ], [ 3, 2, 2, 4 ] ],
[ 1 ], [ 4 ]);
DisplayPredicaton(A);
A:=Automaton("det", 4, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 3, 2, 2, 4 ], [ 2, 2, 4, 2 ], [ 2, 2, 3, 2 ], [ 3, 2, 2, 4 ] ],
[ 1 ], [ 4 ]);
DisplayPredicaton(A);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ], [ [ 1, 2, 2, 3, 2 ], 
[ 2, 2, 1, 2, 4 ] ], [ 5 ], [ 1 ]), [ 1 ]);
IsDeterministicPredicaton(P);
P:=Predicaton(Automaton("nondet", 2, [ [ 0 ], [ 1 ] ], [ [ 1  ], [  ] ],
[ 1 ], [ 1 ]), [ 1 ]);
Display(P);
IsNonDeterministicPredicaton(P);
P:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], 
[ [ 2, 2, 2, 2, 5 ], [ 2, 2, 5, 2, 2 ], [ 2, 2, 2, 3, 2 ], [ 4, 2, 2, 2, 2 ] ],
[ 1 ], [ 5 ]), [ 1, 2 ]);;
TypeOfPredicaton(P);
P:=Predicaton(Automaton("det", 2, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], 
[ [ 1, 2 ], [ 2, 2 ], [ 2, 2 ], [ 1, 2 ] ], [ 1 ], [ 1 ]), [ 1, 2 ]);;
AlphabetOfPredicaton(P);
AlphabetOfPredicatonAsList(P);
P:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 2, 2, 2, 2, 5 ], [ 4, 2, 5, 3, 2 ], [ 4, 2, 5, 3, 2 ], [ 2, 2, 2, 2, 2 ] ], 
[ 1 ], [ 5 ]), [ 1, 2 ]);;
NumberStatesOfPredicaton(P);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ], [ [ 1, 2, 2, 2, 2 ],
[ 2, 2, 1, 3, 4 ] ], [ 5 ], [ 1 ]), [ 1 ]);;
Display(P);
S:=SortedStatesPredicaton(P);;
Display(S);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ], [ [ 1, 2, 2, 2, 2 ],
[ 2, 2, 1, 3, 4 ] ], [ 5 ], [ 1 ]), [ 1 ]);;
Display(P);
TransitionMatrixOfPredicaton(P);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ], [ [ 2, 2, 2, 3, 5 ], 
[ 4, 2, 5, 2, 2 ] ], [ 1 ], [ 5 ]), [ 1 ]);;
InitialStatesOfPredicaton(P);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ], [ [ 2, 2, 2, 3, 5 ],
[ 4, 2, 5, 2, 2 ] ], [ 1 ], [ 5 ]), [ 1 ]);;
Display(P);
SetInitialStatesOfPredicaton(P, 3);
Display(P);
P:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 2, 2, 2, 4 ],
[ 3, 2, 4, 2 ] ], [ 1 ], [ 4 ]), [ 1 ]);;
Display(P);
FinalStatesOfPredicaton(P);
P:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 2, 2, 2, 4 ],
[ 3, 2, 4, 2 ] ], [ 1 ], [ 4 ]), [ 1 ]);;
Display(P);
SetFinalStatesOfPredicaton(P, [ 1, 2, 3 ]);
Display(P);
P:=Predicaton(Automaton("det", 3, [ [ 0 ], [ 1 ] ], [ [ 2, 2, 3 ],
[ 3, 2, 2 ] ], [ 1 ], [ 3 ]), [ 1 ]);;
Display(P);
SinkStatesOfPredicaton(P);
P:=Predicaton(Automaton("det", 6, [ [ 0 ], [ 1 ] ], [ [ 5, 2, 2, 3, 4, 6 ],
[ 2, 2, 6, 2, 2, 2 ] ], [ 1 ], [ 6 ]), [ 1 ]);;
Display(P);
Q:=PermutedStatesPredicaton(P,[1,6,4,3,2,5]);;
Display(Q);
P:=Predicaton(Automaton("det", 2, [ [ 0 ], [ 1 ] ], [ [ 1, 2 ], [ 2, 2 ] ],
[ 1 ], [ 1 ]), [ 1 ]);;
C:=CopyPredicaton(P);;
SetFinalStatesOfPredicaton(C, 2);
Display(P);
Display(C);
P:=Predicaton(Automaton("det", 9, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 2, 6, 7, 4, 5, 4, 5, 8, 9 ], [ 3, 6, 6, 4, 4, 4, 4, 8, 8 ],
[ 4, 4, 5, 4, 5, 8, 9, 4, 5 ], [ 5, 4, 4, 4, 4, 8, 8, 4, 4 ] ],
[ 1 ], [ 9 ]), [ 1, 2 ]);;
Display(P);
M:=MinimalPredicaton(P);;
Display(M);
P:=Predicaton(Automaton("nondet", 8, [ [ 0 ], [ 1 ] ],
[ [ [ 2 ], [ 2 ], [ 2 ], [ 4 ], [ 7 ], [ 6 ], [ 6 ], [ 8 ] ],
[ [ 3 ], [ 2 ], [ 4 ], [ 2 ], [ 6 ], [ 6 ], [ 8 ], [ 6 ] ] ],
[ 1, 5 ], [ 4, 8 ]), [ 1 ]);;
M:=MinimalPredicaton(P);;
Display(M);
P:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], [ [ 2, 2, 2, 4 ],
[ 3, 2, 4, 2 ] ], [ 1 ], [ 4 ]), [ 1 ]);;
Display(P);
Q:=NegatedPredicaton(P);;
Display(Q);
P1:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 2, 2, 2, 3, 5 ], [ 2, 2, 2, 3, 5 ], [ 4, 2, 5, 2, 2 ], [ 4, 2, 5, 2, 2 ] ],
[ 1 ], [ 5 ]), [ 1, 2 ]);;
P2:=Predicaton(Automaton("det", 2, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 2 ], [ 2, 2 ], [ 2, 2 ], [ 1, 2 ] ], [ 1 ], [ 1 ]), [ 1, 2 ]);;
P3:=IntersectionPredicata(P1, P2);;
Display(P3);
P4:=MinimalPredicaton(P3);;
Display(P4);
P1:=Predicaton(Automaton("det", 2, [ [ 0 ], [ 1 ] ],
[ [ 1, 2 ], [ 2, 2 ] ], [ 1 ], [ 1 ]), [ 1 ]);;
P2:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ],
[ [ 3, 2, 2, 4 ], [ 2, 2, 4, 2 ] ], [ 1 ], [ 4 ]), [ 1 ]);;
P3:=UnionPredicata(P1, P2);;
Display(P3);
M:=MinimalPredicaton(P3);;
Display(M);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ],
[ [ 5, 5, 5, 4, 5 ], [ 2, 3, 4, 5, 5 ] ], [ 1 ], [ 4 ]), [ 1 ]);;
Display(P);
IsRecognizedByPredicaton(P,[[1],[1],[1]]);
IsRecognizedByPredicaton(P,[[1],[1],[1],[0],[0]]);
IsRecognizedByPredicaton(P,[[1],[1],[0]]);
DecToBin(4);
DecToBin(0);
BinToDec([ 0, 0, 1 ]);
BinToDec([ 0, 0, 1, 0, 0, 0, 0 ]);
BinToDec([ ]);
P:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 2, 2, 2, 2, 5 ], [ 4, 2, 2, 3, 2 ], [ 2, 2, 2, 2, 2 ], [ 2, 2, 5, 2, 2 ] ],
[ 1 ], [ 5 ]), [ 1, 2 ]);;
Display(P);
IsAcceptedWordByPredicaton(P, [ 7, 4 ]);
IsAcceptedWordByPredicaton(P, [ DecToBin(7), DecToBin(4) ]);
IsAcceptedWordByPredicaton(P, [ [ 1, 1, 1, 0 ], [ 0, 0, 1, 0, 0, 0 ] ]);
IsRecognizedByPredicaton(P, [ [ 1, 0 ], [ 1, 0 ], [ 1, 1 ] ]);
P:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 2, 2, 2, 2, 5 ], [ 4, 2, 2, 3, 2 ], [ 2, 2, 2, 2, 2 ], [ 2, 2, 5, 2, 2 ] ],
[ 1 ], [ 5 ]), [ 1, 2 ]);;
AcceptedWordsByPredicaton(P, [ 10, 20 ]);
P:=Predicaton(Automaton("det", 3, [ [ 0 ], [ 1 ] ], 
[ [ 1, 3, 2 ], [ 2, 1, 3 ] ], [ 1 ], [ 1 ]), [ 1 ]);;
Display(P);
AcceptedWordsByPredicaton(P, 29);
AcceptedWordsByPredicaton(P, [ [121..144] ]);
P:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], 
[ [ 2, 2, 2, 3, 5 ], [ 4, 2, 2, 3, 2 ], [ 2, 2, 2, 3, 2 ], [ 2, 2, 5, 3, 2 ] ],
[ 1 ], [ 5 ]), [ 1, 2 ]);;
AcceptedWordsByPredicaton(P);
DisplayAcceptedWordsByPredicaton(P, [8,10]);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ], 
[ [ 3, 2, 5, 4, 4 ], [ 3, 2, 4, 2, 4 ] ], 
[ 1 ], [ 3, 4, 5, 1 ]), [ 1 ]);;
Display(P);
AcceptedWordsByPredicaton(P, 19);
DisplayAcceptedWordsByPredicaton(P, 29, true);
P:=Predicaton(Automaton("det", 14, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 6, 2, 2, 3, 4, 2, 2, 3, 7, 2, 10, 12, 12, 14 ], 
[ 2, 2, 12, 2, 9, 11, 7, 7, 2, 13, 2, 2, 7, 2 ], 
[ 2, 2, 12, 2, 7, 8, 14, 14, 2, 14, 2, 2, 14, 2 ], 
[ 5, 2, 2, 12, 3, 2, 2, 12, 7, 2, 13, 2, 2, 14 ] ], 
[ 1 ], [ 12, 13, 14 ]), [ 1, 2 ]);;
Display(P);
DisplayAcceptedWordsByPredicatonInNxN(P, [ 15, 15 ]);
P:=Predicaton(Automaton("det", 4, [ [ 0 ], [ 1 ] ], 
[ [ 4, 2, 3, 3 ], [ 3, 2, 2, 3 ] ], [ 1 ], [ 3, 4, 1 ]), [ 1 ]);
AutomatonOfPredicaton(P);
P:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 2, 2, 3, 2 ], [ 4, 2, 2, 5, 2 ], [ 2, 2, 1, 2, 3 ], [ 2, 2, 4, 2, 5 ] ],
[ 1 ], [ 1 ]), [ 4, 9 ]);;
VariablePositionListOfPredicaton(P);
P:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 2, 2, 3, 2 ], [ 4, 2, 2, 5, 2 ], [ 2, 2, 1, 2, 3 ], [ 2, 2, 4, 2, 5 ] ],
[ 1 ], [ 1 ]), [ 4, 9 ]);;
SetVariablePositionListOfPredicaton(P, [ 1, 2 ]);
VariablePositionListOfPredicaton(P);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ], [ [ 3, 2, 4, 2, 2 ],
[ 2, 2, 2, 5, 2 ] ], [ 1 ], [ 5 ]), [ 1 ]);;
Display(P);
IsAcceptedWordByPredicaton(P, [ [ 0, 0, 1 ] ]);
IsAcceptedWordByPredicaton(P, [ [ 0, 0, 1, 0 ] ]);
PredicatonToRatExp(P);
Q:=ProductLZeroPredicaton(P);;
Display(Q);
IsAcceptedWordByPredicaton(Q, [ [ 0, 0, 1 ] ]);
IsAcceptedWordByPredicaton(Q, [ [ 0, 0, 1, 0 ] ]);
PredicatonToRatExp(Q);
M:=MinimalPredicaton(Q);;
M:=PermutedStatesPredicaton(M, [ 5, 2, 4, 3, 1 ]);;
Display(M);
PredicatonToRatExp(M);
P:=Predicaton(Automaton("det", 6, [ [ 0 ], [ 1 ] ], [ [ 3, 2, 4, 2, 6, 2 ],
[ 2, 2, 2, 5, 2, 2 ] ], [ 1 ], [ 6 ]), [ 1 ]);;
Display(P);
Display(P);
IsAcceptedWordByPredicaton(P, [ 4 ]);
IsAcceptedWordByPredicaton(P, [ [ 0, 0, 1 ] ]);
IsAcceptedWordByPredicaton(P, [ [ 0, 0, 1, 0 ] ]);
PredicatonToRatExp(P);
Q:=RightQuotientLZeroPredicaton(P);;
Display(Q);
IsAcceptedWordByPredicaton(Q, [ 4 ]);
IsAcceptedWordByPredicaton(Q, [ [ 0, 0, 1 ] ]);
IsAcceptedWordByPredicaton(Q, [ [ 0, 0, 1, 0 ] ]);
PredicatonToRatExp(Q);
M:=MinimalPredicaton(Q);;
M:=PermutedStatesPredicaton(M, [ 6, 2, 5, 4, 3, 1 ]);;
Display(M);
IsAcceptedWordByPredicaton(M, [ 4 ]);
PredicatonToRatExp(M);
P:=Predicaton(Automaton("det", 7, [ [ 0 ], [ 1 ] ], [ [ 3, 2, 4, 2, 6, 2, 2], 
[ 2, 2, 7, 5, 2, 2, 2 ] ], [ 1 ], [ 6, 7 ]), [ 1 ]);;
Display(P);
IsAcceptedWordByPredicaton(P, [ [ 0, 1 ] ]);
IsAcceptedWordByPredicaton(P, [ [ 0, 1, 0 ] ]);
IsAcceptedWordByPredicaton(P, [ [ 0, 0, 1 ] ]);
IsAcceptedWordByPredicaton(P, [ [ 0, 0, 1, 0 ] ]);
PredicatonToRatExp(P);
Q:=NormalizedLeadingZeroPredicaton(P);;
Display(Q);
AcceptedWordsByPredicaton(Q, 10);
IsAcceptedWordByPredicaton(Q, [ [ 0, 1 ] ]);
IsAcceptedWordByPredicaton(Q, [ [ 0, 1, 0 ] ]);
IsAcceptedWordByPredicaton(Q, [ [ 0, 0, 1 ] ]);
IsAcceptedWordByPredicaton(Q, [ [ 0, 0, 1, 0 ] ]);
M:=MinimalPredicaton(Q);;
M:=PermutedStatesPredicaton(M, [ 3, 5, 1, 4, 2 ]);;
Display(M);
AcceptedWordsByPredicaton(M, 10);
PredicatonToRatExp(M);
P:=Predicaton(Automaton("det", 3, [ [ 0, 0, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ],
[ 1, 0, 1 ], [ 0, 1, 0 ], [ 0, 1, 1 ], [ 1, 1, 0 ], [ 1, 1, 1 ] ],
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], 
[ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]), [ 1, 2, 3 ]);;
Display(P);
Q:=SortedAlphabetPredicaton(P);;
Display(Q);
P:=Predicaton(Automaton("det", 7, [ [ 0 ], [ 1 ] ], [ [ 3, 2, 4, 2, 6, 2, 2], 
[ 2, 2, 7, 5, 2, 2, 2 ] ], [ 1 ], [ 6, 7 ]), [ 1 ]);;
Display(P);
PredicatonToRatExp(P);
M:=FormattedPredicaton(P);;
Display(M);
PredicatonToRatExp(M);
P:=Predicaton(Automaton("det", 2, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], 
[ [ 1, 2 ], [ 2, 2 ], [ 1, 2 ], [ 2, 2 ] ], [ 1 ], [ 1 ]), [ 2, 4 ]);;
IsValidInput(P, [ 1, 2, 3 ]);
IsValidInput(P, [ 1, 2, 3, 4 ]);
P:=Predicaton(Automaton("det", 3, [ [ 0 ], [ 1 ] ], [ [ 2, 2, 3 ], 
[ 3, 2, 2 ] ], [ 1 ], [ 3 ]), [ 1 ]);
Display(P);
Q:=ExpandedPredicaton(P, [ 1, 2, 3 ]);;
Display(Q);
P:=Predicaton(Automaton("det", 3, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 1, 3, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]),
[ 1, 2 ]);;
Display(P);
Q:=ProjectedPredicaton(P, 1);;
Display(Q);
AcceptedWordsByPredicaton(P, 10);
AcceptedWordsByPredicaton(Q, 10);
PredicatonToRatExp(P);
PredicatonToRatExp(Q);
P:=Predicaton(Automaton("det", 2, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], 
[ [ 1, 2 ], [ 2, 2 ], [ 2, 2 ], [ 1, 2 ] ], [ 1 ], [ 1 ]), [ 1, 2 ]);;
Display(P);
AcceptedWordsByPredicaton(P, 5);
Q1:=ProjectedPredicaton(P, 1);;
Display(Q1);
AcceptedWordsByPredicaton(Q1, 5);
Q2:=NegatedProjectedNegatedPredicaton(Q1, 2);;
Display(Q2);
AcceptedWordsByPredicaton(Q2);
P1:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 4, 2, 2, 2, 5 ], [ 2, 2, 5, 2, 2 ], [ 2, 2, 2, 3, 2 ], [ 4, 2, 2, 2, 2 ] ],
[ 1 ], [ 5 ]), [ 1, 2 ]);;
Display(P1);
AcceptedByPredicaton(P1, 10);
P2:=Predicaton(Automaton("det", 6, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 5, 2, 2, 3, 2, 6 ], [ 2, 2, 6, 2, 2, 2 ], [ 4, 2, 2, 2, 3, 2 ], 
[ 2, 2, 2, 2, 2, 2 ] ], [ 1 ], [ 6 ]), [ 1, 2 ]);;
Display(P2);
AcceptedByPredicaton(P2, 10);
P3:=IntersectionPredicata(P1, P2, [ 1, 2 ]);;
Display(P3);
AcceptedByPredicaton(P3, 10);
P1:=Predicaton(Automaton("det", 5, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 4, 2, 2, 2, 5 ], [ 2, 2, 5, 2, 2 ], [ 2, 2, 2, 3, 2 ], [ 4, 2, 2, 2, 2 ] ],
[ 1 ], [ 5 ]), [ 1, 2 ]);;
Display(P1);
AcceptedByPredicaton(P1, 10);
P2:=Predicaton(Automaton("det", 6, [ [ 0, 0 ], [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ],
[ [ 5, 2, 2, 3, 2, 6 ], [ 2, 2, 6, 2, 2, 2 ], [ 4, 2, 2, 2, 3, 2 ], 
[ 2, 2, 2, 2, 2, 2 ] ], [ 1 ], [ 6 ]), [ 1, 2 ]);;
Display(P2);
AcceptedByPredicaton(P2, 10);
P3:=UnionPredicata(P1, P2, [ 1, 2 ]);;
Display(P3);
AcceptedWordsByPredicaton(P3, 9);
A:=Automaton("det", 3, [ [ 0, 0, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ], [ 1, 0, 1 ],
[ 0, 1, 0 ], [ 0, 1, 1 ], [ 1, 1, 0 ], [ 1, 1, 1 ] ], 
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], [ 1, 3, 3 ],
[ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]);;
DisplayPredicaton(A);
P:=PermutedAlphabetPredicaton(A, [3,2,1]);;
Display(P);
A:=Automaton("det", 3, [ [ 0, 0, 0 ], [ 0, 0, 1 ], [ 1, 0, 0 ], [ 1, 0, 1 ],
[ 0, 1, 0 ], [ 0, 1, 1 ], [ 1, 1, 0 ], [ 1, 1, 1 ] ], 
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ], [ 3, 1, 3 ], [ 1, 3, 3 ],
[ 1, 3, 3 ], [ 3, 2, 3 ] ], [ 1 ], [ 1 ]);;
DisplayPredicaton(A);
P:=PredicatonFromAut(A,[3,2,1],[1,2,3,4]);;
Display(P);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ], 
[ [ 4, 2, 2, 3, 5 ], [ 2, 2, 5, 2, 2 ] ], [ 1 ], [ 5 ]), [ 1 ]);;
AcceptedWordsByPredicaton(P);
FinitelyManyWordsAccepted(P);
P:=Predicaton(Automaton("det", 5, [ [ 0 ], [ 1 ] ],
[ [ 5, 5, 5, 4, 5 ], [ 2, 3, 4, 5, 5 ] ], [ 1 ], [ 4 ]), [ 1 ]);;
PredicatonToRatExp(P);
A:=Automaton("det", 3,
[ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 0 ],
[ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ], [ 1, 1, 1 ] ],
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ],
[ 3, 1, 3 ], [ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ],
[ 1 ], [ 1 ]);
r:=PredicatonToRatExp(A);
WordsOfRatExp(r, 1);
A:=Automaton("det", 3,
[ [ 0, 0, 0 ], [ 1, 0, 0 ], [ 0, 1, 0 ], [ 1, 1, 0 ],
[ 0, 0, 1 ], [ 1, 0, 1 ], [ 0, 1, 1 ], [ 1, 1, 1 ] ],
[ [ 1, 3, 3 ], [ 3, 2, 3 ], [ 3, 2, 3 ], [ 2, 3, 3 ],
[ 3, 1, 3 ], [ 1, 3, 3 ], [ 1, 3, 3 ], [ 3, 2, 3 ] ],
[ 1 ], [ 1 ]);
r:=PredicatonToRatExp(A);
WordsOfRatExpInterpreted(r, 1);
IsValidInputList([1,2,3], [1,2,3,4]);
IsValidInputList([1,1,2,3], [1,2,3,4]);
IsValidInputList([4,3,5], [4,5]);
IsValidInputList([4,3,5], [3,4,5,6]);
P1:=BooleanPredicaton("true",[]);;
Display(P1);
P2:=BooleanPredicaton("false", [ 1, 2 ]);;
Display(P2);
P1:=EqualPredicaton([ 1, 2 ], [ 1, 2 ]);;
Display(P1);
P2:=EqualPredicaton([ 3, 4 ], [ 1, 2, 3, 4 ]);;
Display(P2);
P:=AdditionPredicaton([1,2,3],[1,2,3]);;
Display(P);
DisplayAcceptedByPredicaton(P, [ 15, 15, 30 ]);
P:=SumOfProductsPredicaton([ 1, 2, 3 ], [ 7, 4, -5 ], [ 1, 2, 3 ]);
DisplayAcceptedByPredicaton(P, [ 15, 15, 100 ]);
P:=TermEqualTermPredicaton( [ 1, 1, "int" ], [ 5, 2, "int" ], [ 4 ], 
[ 2, 3 ], [ 6, 1 ], [ ], [ 1, 2, 3 ]);
AcceptedByPredicaton(P);
DisplayAcceptedByPredicaton(P, [10, 15, 100]);
P:=GreaterEqualNPredicaton(15, [ 1 ], [ 1 ]);;
P:=SortedStatesPredicaton(P);;
Display(P);
DisplayAcceptedByPredicaton(P, 29, true);
P:=GreaterNPredicaton(15, [ 1 ], [ 1 ]);;
P:=SortedStatesPredicaton(P);;
Display(P);
DisplayAcceptedByPredicaton(P, 29, true);
P:=SmallerEqualNPredicaton(15, [ 1 ], [ 1 ]);;
P:=SortedStatesPredicaton(P);;
Display(P);
DisplayAcceptedByPredicaton(P, 29, true);
P:=SmallerNPredicaton(15, [ 1 ], [ 1 ]);;
P:=SortedStatesPredicaton(P);;
Display(P);
DisplayAcceptedByPredicaton(P, 29, true);
P:=GreaterEqualPredicaton([1,2],[1,2]);;
Display(P);
DisplayAcceptedByPredicaton(P, 10);
P:=GreaterPredicaton([1,2],[1,2]);;
Display(P);
DisplayAcceptedByPredicaton(P, 10);
P:=SmallerEqualPredicaton([ 1, 2 ], [ 1, 2 ]);;
Display(P);
DisplayAcceptedByPredicaton(P, 15);
P:=SmallerPredicaton([ 1, 2 ], [ 1, 2 ]);;
Display(P);
Print("\nFinished tstManualChapter2.g\n");