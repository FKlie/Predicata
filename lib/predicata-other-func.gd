####################################################################################################
##
##  This file declares some auxiliary functions.
##
####################################################################################################
##
#F  PredicataAlphabet(N[,base])
##
##  Returns the alphabet of length N, i.e. ({0,1})^N.
##
DeclareGlobalFunction( "PredicataAlphabet", [IsInt] );
####################################################################################################
##
#F  DecToBaseRep(D[,base])
##
##  Converts a decimal number into a base k=PredicataBase representation. 
##  Note: The binary representation list is reversed, i.e.
##        D = B[1] * k^0 + B[2] * k^1 + ...
##
DeclareGlobalFunction( "DecToBaseRep" );
####################################################################################################
##
#F  BaseRepToDec(B[,base])
##
##  Converts a base k=PredicataBase representation list into a decimal number 
##  Note: The base k representation list is reversed, i.e.
##        B[1] * k^0 + B[2] * k^1 +... = D
##
DeclareGlobalFunction( "BaseRepToDec" );
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
