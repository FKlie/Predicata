gap> START_TEST("Predicata package: introduction.tst");

gap> SizeScreen([100]);
[ 100, 40 ]
gap> A:=Predicaton("(E x:(E y:(E z:6*x+9*y+20*z=n)))");
Predicaton: deterministic finite automaton on 2 letters with 17 states, the variable position list\
 [ 1 ] and the following transitions:
         |  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 
---------------------------------------------------------------
  [ 0 ]  |  17 12 6  3  5  5  6  4  7  6  5  10 13 13 14 15 16 
  [ 1 ]  |  2  9  13 5  13 5  3  15 10 14 14 4  13 5  5  11 8  
 Initial states: [ 1 ]
 Final states:   [ 1, 13, 14, 15, 16, 17 ]

 The alphabet corresponds to the following variable list: [ "n" ].
< Predicaton: deterministic finite automaton on 2 letters with 17 states and the variable position\
 list [ 1 ]. >
gap> Display(A);
Predicaton: deterministic finite automaton on 2 letters with 17 states, the variable position list\
 [ 1 ] and the following transitions:
         |  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 
---------------------------------------------------------------
  [ 0 ]  |  17 12 6  3  5  5  6  4  7  6  5  10 13 13 14 15 16 
  [ 1 ]  |  2  9  13 5  13 5  3  15 10 14 14 4  13 5  5  11 8  
 Initial states: [ 1 ]
 Final states:   [ 1, 13, 14, 15, 16, 17 ]

 The alphabet corresponds to the following variable list: [ "n" ].
gap> AcceptedByPredicaton(A, 20);
[ [ 0 ], [ 6 ], [ 9 ], [ 12 ], [ 15 ], [ 18 ], [ 20 ] ]
gap> DisplayAcceptedByPredicaton(A, 99);
 If the following words are accepted by the given Automaton, then: YES, otherwise if not accepted:\
 no.
   0: YES   1: no    2: no    3: no    4: no    5: no    6: YES   7: no    8: no    9: YES
  10: no   11: no   12: YES  13: no   14: no   15: YES  16: no   17: no   18: YES  19: no 
  20: YES  21: YES  22: no   23: no   24: YES  25: no   26: YES  27: YES  28: no   29: YES
  30: YES  31: no   32: YES  33: YES  34: no   35: YES  36: YES  37: no   38: YES  39: YES
  40: YES  41: YES  42: YES  43: no   44: YES  45: YES  46: YES  47: YES  48: YES  49: YES
  50: YES  51: YES  52: YES  53: YES  54: YES  55: YES  56: YES  57: YES  58: YES  59: YES
  60: YES  61: YES  62: YES  63: YES  64: YES  65: YES  66: YES  67: YES  68: YES  69: YES
  70: YES  71: YES  72: YES  73: YES  74: YES  75: YES  76: YES  77: YES  78: YES  79: YES
  80: YES  81: YES  82: YES  83: YES  84: YES  85: YES  86: YES  87: YES  88: YES  89: YES
  90: YES  91: YES  92: YES  93: YES  94: YES  95: YES  96: YES  97: YES  98: YES  99: YES
 
gap> B:=GreatestNonAcceptedNumber(A);
Predicaton: deterministic finite automaton on 2 letters with 8 states, the variable position list \
[ 1 ] and the following transitions:
         |  1  2  3  4  5  6  7  8  
------------------------------------
  [ 0 ]  |  2  2  2  3  2  5  2  8  
  [ 1 ]  |  7  2  8  2  4  2  6  2  
 Initial states: [ 1 ]
 Final states:   [ 8 ]

 The alphabet corresponds to the following variable list: [ "n" ].

 Regular expression of the Automaton:
   [ 1 ][ 1 ][ 0 ][ 1 ][ 0 ][ 1 ][ 0 ]*
< Predicaton: deterministic finite automaton on 2 letters with 8 states and the variable position \
list [ 1 ]. >
gap> AcceptedWordsByPredicaton(B, 50);
[ [ 43 ] ]
gap> PredicatonToRatExp(B);
[ 1 ][ 1 ][ 0 ][ 1 ][ 0 ][ 1 ][ 0 ]*

gap> STOP_TEST( "introduction.tst", 10000 );