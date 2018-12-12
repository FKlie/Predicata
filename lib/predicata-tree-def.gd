####################################################################################################
##
##  This file declares the category for PredicataTree.
##
####################################################################################################
##
#C IsPredicataTreeObj
##
DeclareCategory( "IsPredicataTreeObj", IsObject );
DeclareCategoryCollections( "IsPredicataTreeObj" );
####################################################################################################
##
#R  IsPredicataTreeRep
##
DeclareRepresentation( "IsPredicataTreeRep", IsComponentObjectRep, ["tree", "currenttree", "stack", "predrep", "bounded", "free"] );
####################################################################################################
##
#F  PredicataTree()
##
DeclareGlobalFunction( "PredicataTree" );
####################################################################################################
##
#F  IsPredicataTree(t)
##
##  Tests if t is from type Tree.
##
DeclareGlobalFunction( "IsPredicataTree" );
####################################################################################################
##
#F  IsEmptyPredicataTree(t)
##
##  Checks if the tree is empty.
##
DeclareGlobalFunction( "IsEmptyPredicataTree");
####################################################################################################
##
#F  RootOfPredicataTree(t)
##
##  Returns the root of the tree.
##
DeclareGlobalFunction( "RootOfPredicataTree" );
####################################################################################################
##
#F  SetRootOfPredicataTree(t, n)
##
##  Sets the root of the tree t to the input n.
##
DeclareGlobalFunction( "SetRootOfPredicataTree" );
####################################################################################################
##
#F  InsertChildToPredicataTree(t)
##
##  Adds to the tree an additional child.
##
DeclareGlobalFunction( "InsertChildToPredicataTree" );
####################################################################################################
##
#F  ChildOfPredicataTree(t, i)
##
##  Returns the i-th child of the tree, and remembers its origin
##  by pushing the current tree on the stack.
##
DeclareGlobalFunction( "ChildOfPredicataTree" );
####################################################################################################
##
#F  ReturnedChildOfPredicataTree(t, i)
##
##  Returns the i-th child of the tree.
##
DeclareGlobalFunction( "ReturnedChildOfPredicataTree" );
####################################################################################################
##
#F  NumberOfChildrenOfPredicataTree(t)
##
##  Returns number of children of the current tree root.
##
DeclareGlobalFunction( "NumberOfChildrenOfPredicataTree" );
####################################################################################################
##
#F  ParentOfPredicataTree(t)
##
##  Returns the parent of the tree, if there is one.
##
DeclareGlobalFunction( "ParentOfPredicataTree" );
####################################################################################################
##
#F  PredicataRepresentationOfPredicataTree(t)
##
##  Returns the PredicataRepresentation of the tree.
##
DeclareGlobalFunction( "PredicataRepresentationOfPredicataTree" );
####################################################################################################
##
#F  BoundedVariablesOfPredicataTree(t)
##
##  Returns the bounded variables of the tree.
##
DeclareGlobalFunction( "BoundedVariablesOfPredicataTree" );
####################################################################################################
##
#F  FreeVariablesOfPredicataTree(t)
##
##  Returns the free variables of the tree.
##
DeclareGlobalFunction( "FreeVariablesOfPredicataTree" );
####################################################################################################
##
#F  PredicataFormulaFormattedToTree(F)
##
##  Converts a PredicataFormulaFormatted into a PredicataTree.
##
DeclareGlobalFunction( "PredicataFormulaFormattedToTree" );
DeclareSynonym( "PredFormToTree", PredicataFormulaFormattedToTree );
####################################################################################################
##
#F  PredicataTreeToPredicatonRecursive(T, V)
##
##  Converts a tree into a Predicaton.
##
DeclareGlobalFunction( "PredicataTreeToPredicatonRecursive" );
####################################################################################################
##
#F  PredicataTreeToPredicaton(T, args...)
##
##  Converts a tree into one Predicata.
##
##  Calls PredicataTreeToPredicatonRecursive.
##
DeclareGlobalFunction( "PredicataTreeToPredicaton" );
DeclareSynonym( "PredTreeToPredicaton", PredicataTreeToPredicaton );
##
#E
##
