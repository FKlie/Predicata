####################################################################################################
##
##  This file declares the category for PredicataFormula and PredicataFormulaFormatted.
##
####################################################################################################
##
#V  PredicataFormulaSymbols
##
##  Allowed symbols in PredicataFormula.
##
DeclareGlobalVariable( "PredicataFormulaSymbols" );
####################################################################################################
##
#F  PredicataIsStringType(S, T)
##
##  Checks if a string S represents one of the following string types T:
##  "variable", "integer" (greater equal 0), "negativeinteger", "boolean", "predicate",
##  "internalpredicate", "quantifier", "symbol", "binarysymbol", "unarysymbol".
##
DeclareGlobalFunction( "PredicataIsStringType" );
####################################################################################################
##
#F  PredicataNormalizedString
##
##  Normalizes a string, addind whitespaces, converting, etc..
##
DeclareGlobalFunction( "PredicataNormalizedString" );
####################################################################################################
##
#F  GrammarVerificationPredicataFormula
##
##  Checks if a string is accepted by the predefined grammar.
##
DeclareGlobalFunction( "PredicataGrammarVerification" );
####################################################################################################
##
#C IsPredicataFormulaObj
##
DeclareCategory( "IsPredicataFormulaObj", IsObject );
DeclareCategoryCollections( "IsPredicataFormulaObj" );
####################################################################################################
##
#R  IsPredicataFormulaRep
##
DeclareRepresentation( "IsPredicataFormulaRep", IsComponentObjectRep, ["string", "predrep", "bounded", "free"] );
####################################################################################################
##
#F  PredicataFormula(f, args...)
##
DeclareGlobalFunction( "PredicataFormula" );
####################################################################################################
##
#F  IsPredicataFormula(f)
##
##  Tests if f is from type PredicataFormula.
##
DeclareGlobalFunction( "IsPredicataFormula" );
####################################################################################################
##
#F  BoundedVariablesOfPredicataFormula(t)
##
##  Returns the bounded variables of the string.
##
DeclareGlobalFunction( "BoundedVariablesOfPredicataFormula" );
####################################################################################################
##
#F  FreeVariablesOfPredicataFormula(t)
##
##  Returns the free variables of the string.
##
DeclareGlobalFunction( "FreeVariablesOfPredicataFormula" );
####################################################################################################
##
#C IsPredicataFormulaFormattedObj
##
DeclareCategory( "IsPredicataFormulaFormattedObj", IsObject );
DeclareCategoryCollections( "IsPredicataFormulaFormattedObj" );
####################################################################################################
##
#R  IsPredicataFormulaFormattedRep
##
DeclareRepresentation( "IsPredicataFormulaFormattedRep", IsComponentObjectRep, ["stringlist", "predrep", "bounded", "free"] );
####################################################################################################
##
#B  PredicataFormulaFormattedAddedParentheses
##
##  Adds parentheses and calls recursively for the case "not":
##
DeclareGlobalFunction( "PredicataFormulaFormattedAddedParentheses" );
####################################################################################################
##
#F  PredicataFormula(f)
##
##  Formats a predicata string.
##
DeclareGlobalFunction( "PredicataFormulaFormatted" );
####################################################################################################
##
#F  IsPredicataFormula(f)
##
##  Tests if f is from type PredicataFormula.
##
DeclareGlobalFunction( "IsPredicataFormulaFormatted" );
##
#E
##
