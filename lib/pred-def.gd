####################################################################################################
##
##  This file declares the category for the type Predicaton. 
##
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
DeclareRepresentation( "IsPredicatonRep", IsComponentObjectRep, ["aut", "var", "varnames"] );
####################################################################################################
##
#F  Predicaton(Automaton, VariablePositionList)
##
DeclareOperation( "Predicaton", [IsAutomatonObj, IsList]);
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
