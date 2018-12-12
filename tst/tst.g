Print("\nReading tst.g\n");

LoadPackage( "Predicata" );

## Example 1 ##
# We want a Predicaton accepting the binary representation of the number 4:
DecToBin(4);
A:=Predicaton("x = 4");
# Accepted natural numbers?
IsAcceptedByPredicaton(A, [ 4 ]);
# Accepted binary representation, also with leading zero?
IsAcceptedByPredicaton(A, [ [ 0, 0, 1 ] ]);
IsAcceptedByPredicaton(A, [ [ 0, 0, 1, 0 ] ]);
# Indeed any leading zeros can be added or cancelled:
PredicatonToRatExp(A);
# Now we create the Predicaton recognizing "y = 1" by hand:
# Parameters:  type, states, alphabet, 
Aut:=Automaton("det", 3,     [ [ 0 ], [ 1 ] ],
# transitions from letter (row) and state (column) to state (row, column)
[ [ 3, 2, 3 ], [ 2, 3, 3 ] ],
# inital state, final states
[ 1 ],          [ 2 ]);
# We create the Predicaton from the automaton and the variable position list.
# Here we choose "y" to be at position 2.
B:=Predicaton(Aut, [ 2 ]); 
# We want the Predicaton "x = 4 and y = 1", so we have to set a variable to B.
SetVariableListOfPredicaton(B, [ "y" ]); 
# Then we use AndPredicata to apply "and" according to the variable names.
# Hence the Predicaton C is over the alphabet [[0, 0], [1, 0], [0, 1], [1, 1]],
# where the first coordinate belong to "x" and the second to "y". Note that 
# the parameter [ "x", "y" ] is optional, by default it's sorted alphabetically.
C:=AndPredicata(A, B, [ "x", "y" ]);;
Display(C);
# So C accepts in the first component of the letter the variable x 
# and in the second component the variable y.
IsAcceptedByPredicaton(C, [ 4, 1 ]);
IsAcceptedByPredicaton(C, [ [ 0, 0, 1 ], [ 1 ] ]);
# Alternatively, we could have created this Predicaton simply with
D:=Predicaton("x = 4 and y = 1");
# Furthermore, we can use the following function to see the allowed grammar:
PredicataGrammar();

## Example 2 ##
# We create the Predicaton of the following formula
A:=Predicaton("(E x:(E y:(E z:6*x+9*y+20*z=n)))");
Display(A);
# We ask for the accepted natural numbers.
AcceptedByPredicaton(A, 20);
DisplayAcceptedByPredicaton(A, 99, true);
# We create the Predicaton accepting the greatest non-accepted number
B:=GreatestNonAcceptedNumber(A);
AcceptedByPredicaton(B, 50);
# We look at the regular expression and compute the natural number
PredicatonToRatExp(B);
BinToDec([ 1, 1, 0, 1, 0, 1 ]);
# Compare B with the following Predicaton:
C:=Predicaton("(A m: m>n implies (E x: (E y: (E z: 6*x + 9*y + 20*z = m\
)))) and (not (E x: (E y: (E z: 6*x + 9*y + 20*z = n))))");

## Example 3 ##
# We ask if there exists "y" s.t. 3*y=x.
A:=Predicaton("(E y: 3*y = x)");
# Compare with:
B:=Predicaton("3*y = x");
Display(B);
C:=ExistsPredicaton(B, "y");;
Display(C);

## Example 4 ## 
A:=Predicaton("(E y: 4*x = 7+5*y)");
AcceptedByPredicaton(A, 20);
# We asked for some accepted words and suggest as a solution x = 3+5*k.
B:=Predicaton("(E k: x = 3+5*k)");
# Indeed:
AreEquivalentPredicata(A, B);
# Furthermore, we look at a system of linear congruences.
C:=Predicaton("(E y1: x = 1 + 2*y1) and (E y2: x = 2 + 3*y2)");
AcceptedByPredicaton(C, 20);
# We suggest:
D:=Predicaton("(E k: x = 5 + 6 * k)");
AreEquivalentPredicata(C, D);

## Example 5 ## 
# All multiples of the GCD of 6 and 15. If there exists z such that
# it is a multiple of the GCD(6, 15) after some number y, then also
# z+x is a multiple of the GCD.
A:=Predicaton("(E y: (A z: z>=y implies ((Ea : (Eb: z= 6*a+15*b))\
implies (Ec: (Ed: z+x= 6*c+15*d)))))");
# This Predicaton is already known from Example 2 and we test for the least
# accepted natural number greater 0 (>= 0 with optional parameter false):
B:=LeastAcceptedNumber(A);
AcceptedByPredicaton(B);
# We get the multiples of the LCM(6, 15) straightforwardly.
C:=Predicaton("(E a: 6*a = x) and (E b: 15*b = x)");
D:=LeastAcceptedNumber(C);
AcceptedByPredicaton(D, 100);

## Example 6 ##
# Which of the followings sentences are true?
A1:=Predicaton("(E x:(A y: x = y))");
A2:=Predicaton("(A x:(E y: x = y))");
A3:=Predicaton("(A x:(E y: x = y+1))");
A4:=Predicaton("(A x:(E y: x = 2*y) or (E y: x=2*y+1))");
A5:=Predicaton("(A n:(E n0: n > n0 implies (E x: (E y: 5*x+6*y=n))))");
# Furthermore, we can use "true" and "false" as predicates;
A6:=Predicaton("true and (false implies true) implies true");

Print("\nFinished tst.g\n");