####################################################################################################
##
##  This file declares the functions for displaying and drawing Predicatonicata as well as printing the 
##  recognized states in a nice way.
##
####################################################################################################
##
#F  PredicatonToString ( A )
##
##  Returns an Automaton or a Predicaton nicely formatted as a string.
##
DeclareGlobalFunction( "PredicatonToString" );
####################################################################################################
##
#F  DisplayPredicaton(A)
##
##  Displays an Automaton or a Predicaton. 
##  Note: Display from the "Automata" package will not work properly on alphabet lists.
##
DeclareGlobalFunction( "DisplayPredicaton" );
####################################################################################################
##
#M  RenameAlphabet(Abc)
##
##  Cancels unnesseccary commas and removes empty space to create smaller labels in DrawAut.
##
DeclareGlobalFunction( "RenameAlphabet" );
DeclareSynonym( "RenameAbc", RenameAlphabet );
####################################################################################################
##
#F  DrawPredicaton (A)
##
##  Draws an Automaton or a Predicaton.
##
DeclareGlobalFunction( "DrawPredicaton" );
####################################################################################################
##
#F  IsAcceptedWordByPredicaton(A, L)
##
##  Checks if a list of natural numbers or a list of binary representation is accepted by the 
##  Predicaton. 
##
DeclareGlobalFunction( "IsAcceptedWordByPredicaton" );
DeclareSynonym( "IsAcceptedByPredicaton", IsAcceptedWordByPredicaton );
####################################################################################################
##
#F  AcceptedWordsByPredicaton(A, args...)
##
##  Returns the accepted words up to an upper bound, either one integer or indiviual bound for each 
##  variable.
##
DeclareGlobalFunction( "AcceptedWordsByPredicaton" );
DeclareSynonym( "AcceptedByPredicaton", AcceptedWordsByPredicaton );
####################################################################################################
##
#F  DisplayAcceptedWordsByPredicaton(A, N)
##
##  Prints the recognized natural numbers in a nice way, for one variable as a "list" with YES/no 
##  for two variables as a "matrix" containing YES/no and for three variables as a "matrix"
##  which entries are the third recognized variables.
##
DeclareGlobalFunction( "DisplayAcceptedWordsByPredicaton" );
DeclareSynonym( "DisplayAcceptedByPredicaton", DisplayAcceptedWordsByPredicaton );
####################################################################################################
##
#F  DisplayAcceptedWordsByPredicatonInNxN(A, N)
##
##  Displays the accepted states in N_0 x N_0, i.e. drawing linear equations.
##
DeclareGlobalFunction( "DisplayAcceptedWordsByPredicatonInNxN" );
DeclareSynonym( "DisplayAcceptedByPredicatonInNxN" , DisplayAcceptedWordsByPredicatonInNxN );
####################################################################################################
##
#F  WordsOfRatExp(r, depth)
##
##  Returns all words which can be created from the rational expression by appling the star operator
##  at most depth times as a list with binary letters.
##
DeclareGlobalFunction( "WordsOfRatExp" );
####################################################################################################
##
#F  WordsOfRatExpInterpreted(r, args...)
##
##  Returns all words which can be created from the rational expression by appling the star operator
##  at most depth times (optional argument, default = 1) as a list of natural numbers.
##
DeclareGlobalFunction( "WordsOfRatExpInterpreted" );
##
#E
##