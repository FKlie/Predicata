####################################################################################################
##
##  This file declares the category for PredicataRepresentation and associated functions.
##
####################################################################################################
##
#C IsPredicatonRepresentationObj
##
DeclareCategory( "IsPredicatonRepresentationObj", IsObject );
DeclareCategoryCollections( "IsPredicatonRepresentationObj" );
####################################################################################################
##
#R  IsPredicatonRepresentationRep
##
DeclareRepresentation( "IsPredicatonRepresentationRep", IsComponentObjectRep, ["name", "arity", "predicaton"] );
####################################################################################################
##
#F  PredicatonRepresentation(Name, Arity, Predicaton)
##
DeclareGlobalFunction( "PredicatonRepresentation" );
####################################################################################################
##
#F  IsPredicatonRepresentation(p)
##
##  Tests if p is from type PredicatonRepresentation.
##
DeclareGlobalFunction( "IsPredicatonRepresentation" );
####################################################################################################
##
#F  NameOfPredicatonRepresentation(p)
##
##  Returns the name of an Predicaton representation element.
##
DeclareGlobalFunction( "NameOfPredicatonRepresentation" ); 
####################################################################################################
##
#F  ArityOfPredicatonRepresentation(p)
##
##  Returns the name of an Predicaton representation element.
##
DeclareGlobalFunction( "ArityOfPredicatonRepresentation" );
####################################################################################################
##
#F  PredicatonOfPredicatonRepresentation(p)
##
##  Returns the Predicaton of an Predicaton representation element.
##
DeclareGlobalFunction( "PredicatonOfPredicatonRepresentation" );
####################################################################################################
##
#F  AutOfPredicatonRepresentation(p)
##
##  Returns the Automaton of an Predicaton representation element.
##
DeclareGlobalFunction( "AutOfPredicatonRepresentation" );
####################################################################################################
##
#F  BaseOfPredicatonRepresentation(p)
##
##  Returns the base of the Predicaton of an Predicaton representation element.
##
DeclareGlobalFunction( "BaseOfPredicatonRepresentation" );
####################################################################################################
##
#F  CopyPredicatonRepresentation(p)
##
##  Returns a copy.
##
DeclareGlobalFunction( "CopyPredicatonRepresentation" );
####################################################################################################
##
#C IsPredicataRepresentationObj
##
DeclareCategory( "IsPredicataRepresentationObj", IsObject );
DeclareCategoryCollections( "IsPredicataRepresentationObj" );
####################################################################################################
##
#R  IsPredicataRepresentationRep
##
DeclareRepresentation( "IsPredicataRepresentationRep", IsComponentObjectRep, ["lowercasenamelist", "namelist", "aritylist", "predicatonlist"] );
####################################################################################################
##
#F  PredicataRepresentation(args...)
##
DeclareGlobalFunction( "PredicataRepresentation" );
####################################################################################################
##
#F  IsPredicataRepresentation(P)
##
##  Tests if p is from type PredicatonRepresentation.
##
DeclareGlobalFunction( "IsPredicataRepresentation" );
####################################################################################################
##
#F  ElementOfPredicataRepresentation(P, i)
##
##  Returns the i-th PredicatonRepresentation.
##
DeclareGlobalFunction( "ElementOfPredicataRepresentation");
####################################################################################################
##
#F  NamesOfPredicataRepresentation(p)
##
##  Returns the name list of an Predicata representation .
##
DeclareGlobalFunction( "NamesOfPredicataRepresentation" ); 
####################################################################################################
##
#F  AritiesOfPredicataRepresentation(P)
##
##  Returns the name list of an Predicata representation element.
##
DeclareGlobalFunction( "AritiesOfPredicataRepresentation" );
####################################################################################################
##
#F  PredicataOfPredicataRepresentation(P)
##
##  Returns the Predicata list of an Predicata representation element.
##
DeclareGlobalFunction( "PredicataOfPredicataRepresentation" );
####################################################################################################
##
#F  CopyPredicataRepresentation(P)
##
##  Returns a copy.
##
DeclareGlobalFunction( "CopyPredicataRepresentation" );
####################################################################################################
##
#V  PredicataList
##
##  Global variable storing predicates with a name, arity and a Predicata
##
DeclareGlobalVariable( "PredicataList", "Global variable using as default PredicataRepresentation");
####################################################################################################
##
#F  AddToPredicataList(p, args...)
##
##  Adds a PredicatonRepresentation to the global variable PredicataList.
##
DeclareGlobalFunction( "AddToPredicataList" );
####################################################################################################
##
#F  RemoveFromPredicataList(i)
##
##  Adds a PredicatonRepresentation to the global variable PredicataList.
##
DeclareGlobalFunction( "RemoveFromPredicataList" );
####################################################################################################
##
#F  ClearPredicataList()
##
##  Clears the global variable PredicataList.
##
DeclareGlobalFunction( "ClearPredicataList" );
##
#E
##
