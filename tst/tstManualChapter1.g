Print("\nReading tstManualChapter1.g\n");
A:=Predicaton("(E x:(E y:(E z:6*x+9*y+20*z=n)))");
Display(A);
AcceptedWordsByPredicaton(A, 20);
DisplayAcceptedByPredicaton(A, 99);
B:=GreatestNonAcceptedNumber(A);
AcceptedWordsByPredicaton(B, 50);
PredicatonToRatExp(B);
Print("\nFinished tstManualChapter1.g\n");
