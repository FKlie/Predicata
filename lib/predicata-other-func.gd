####################################################################################################
##
##  This file declares some auxiliary functions.
##
####################################################################################################
##
#F  InsertAt(l, e, p )
##
##  Inserts into a list l the element e at position p, 
##  where the position p can be 0 <= p <= Length(l)+1.
##
DeclareGlobalFunction( "InsertAt", [IsList, , IsPosInt] );
####################################################################################################
##
#F  GetAlphabet(N)
##
##  Returns the alphabet of length N, i.e. ({0,1})^N.
##
DeclareGlobalFunction( "GetAlphabet", [IsInt] );
DeclareSynonym( "GetAbc", GetAlphabet);
####################################################################################################
##
#F  DecToBin(D)
##
##  Converts a decimal number into a binary number. 
##  Note: The binary representation list is reversed, i.e.
##        D = B[1] * 2^0 + B[2] * 2^1 + ...
##
DeclareGlobalFunction( "DecToBin" );
####################################################################################################
##
#F  BinToDec(B)
##
##  Converts a binary number list into a decimal number 
##  Note: The binary representation list is reversed, i.e.
##        B[1] * 2^0 + B[2] * 2^1 +... = D
##
DeclareGlobalFunction( "BinToDec" );
####################################################################################################
##
#C IsStackObj
##
DeclareCategory( "IsPredicataStackObj", IsObject );
DeclareCategoryCollections( "IsPredicataStackObj" );
####################################################################################################
##
#R  IsPredicataStackRep
##
DeclareRepresentation( "IsPredicataStackRep", IsComponentObjectRep, ["list"] );
####################################################################################################
##
#F  PredicataStack()
##
DeclareGlobalFunction( "PredicataStack" );
####################################################################################################
##
#F  IsEmptyPredicataStack(Stack)
##
DeclareGlobalFunction( "IsEmptyPredicataStack" );
####################################################################################################
##
#F  PushPredicataStack(Stack, element)
##
DeclareGlobalFunction( "PushPredicataStack" );
####################################################################################################
##
#F  PopPredicataStack(Stack)
##
DeclareGlobalFunction( "PopPredicataStack" );
####################################################################################################
##
#F  TopPredicataStack(Stack)
##
DeclareGlobalFunction( "TopPredicataStack" );
##
#E
##
