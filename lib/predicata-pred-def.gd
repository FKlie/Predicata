####################################################################################################
##
##  This file declares the category for the type Predicaton. 
##
####################################################################################################
##
#V  PredicataBase
##
##  Global variable storing the number of base represenation.
##
DeclareGlobalVariable( "PredicataBase", "Global variable defining the base representation");
####################################################################################################
##
#F  SetPredicataBase
##
##  Setting the base for the base represenation.
##
DeclareGlobalFunction( "SetPredicataBase" );
####################################################################################################
##
#F  ReturnPredicataBase
##
##  Returning the base for the base represenation.
##
DeclareGlobalFunction( "ReturnPredicataBase" );
####################################################################################################
##
#C IsPredicatonObj
##
DeclareCategory( "IsPredicatonObj", IsObject );
DeclareCategoryCollections( "IsPredicatonObj" );
####################################################################################################
##
#R  IsPredicatonRep
##
DeclareRepresentation( "IsPredicatonRep", IsComponentObjectRep, ["aut", "var", "varnames", "base"] );
####################################################################################################
##
#F  Predicaton(Automaton, VariablePositionList)
##
DeclareOperation( "Predicaton", [IsAutomatonObj, IsList, IsInt]);
####################################################################################################
##
#F  IsPredicaton(A)
##
DeclareGlobalFunction( "IsPredicaton" );
####################################################################################################
##
#F  BuildPredicaton(Type, Size, Alphabet, TransitionTable, Initial, Final, VariablePositionList)
##
##  Creates the Predicaton without the need of defining an automaton first. 
##
DeclareGlobalFunction( "BuildPredicaton" );
##
#E
##
