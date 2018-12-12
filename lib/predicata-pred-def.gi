####################################################################################################
##
##  This file contains some generic methods for Predicaton. 
##
####################################################################################################
##
#F  Predicaton(Automaton, VariablePositionList)
##
InstallMethod( 
  Predicaton, 
  "default method",
	true,
	[IsAutomatonObj, IsList],
	0,
  function( Automaton, VariablePositionList )
  local A, F, a, predicaton;
  # Testing for correct input 
  # Testing for Automaton from the package "automata" and variable position list being a list.
    if not IsAutomaton(Automaton) or not IsList(VariablePositionList) then
      Error("Input failed, the first argument must be an Automaton and the second argument must be a list.\n");
    fi;
  # Testing the variable position list, it must contain positive integers only.
    a:=StructuralCopy(VariablePositionList);
    if not ForAll(a,i->IsPosInt(i)) then
      Error("Input failed, variable position list contains a non positive integer.\n");
    fi;
  # Testing uniqueness of the variable position list.
    a:=StructuralCopy(VariablePositionList);
    if Length(a) <> Length(Unique(a)) then
      Error("Input failed, variable position list must contain unique positive integer only.\n");
    fi;
  # Testing the alphabet, each letter must be a list.
    a:=AlphabetOfAutomatonAsList(Automaton);
    if not ForAll(a,i->IsList(i)) then
      Error("Input failed, alphabet must be a list.\n");
    fi;
  # Each letter must be of the same length.
    a:=AlphabetOfAutomatonAsList(Automaton);
    Apply(a,i->Length(i));
    if Length(Unique(a)) <> 1 then 
      Error("Input failed, each letter in the alphabet must be the same length.\n");
    fi;
    if Length(VariablePositionList) <> a[1] then
      Error("Input failed, variable list must be of the same length as each letter.\n");
    fi;
  # The alphabet must be all combinations of ({0,1})^n, where n is the size of the variable position list.
    a:=AlphabetOfAutomatonAsList(Automaton);
    if Length(Unique(a)) <> 2^Length(a[1]) then
      Error("Input failed, alphabet must be unique letters and the length must be equal 2^length of the letters.\n");
    fi;
    if Length(a) > 1 then
      a:=AlphabetOfAutomatonAsList(Automaton);
      Apply(a,i->Maximum(i));
      if Maximum(a) > 1 then
        Error(" Input failed, alphabet must be over {0,1}^n.\n");
      fi;
      a:=AlphabetOfAutomatonAsList(Automaton);
      Apply(a,i->Minimum(i));
      if Minimum(a) < 0 then
        Error(" Input failed, alphabet must be over {0,1}^n.\n");
      fi;
    elif Length(a) = 1 and not a[1] = [] then
      Error(" Input failed, alphabet must be over {0,1}^0, i.e. the only letter is [].\n");
    fi; 
  # Defining new family
    F:=NewFamily("PredicataFam", IsPredicatonObj);
    predicaton:=rec(aut:=Automaton, var:=VariablePositionList, varnames:=[]);
    A:=Objectify(NewType(F, IsPredicatonObj and IsPredicatonRep and IsAttributeStoringRep), predicaton);
  # Return the predicata.
    return A;
end);   
####################################################################################################
##
#F  IsPredicaton(A)
##
##  Tests if A is from type Predicaton.
##
InstallGlobalFunction( IsPredicaton, function(A)
    return(IsPredicatonObj(A));
end);
####################################################################################################
##
#M  DisplayString( A )
##
InstallMethod ( DisplayString,
  "Returns the Predicaton nicely formatted.",
  true,
  [IsPredicatonObj and IsPredicatonRep], 0,
  function( A )
    return AutToString(A);
end);
####################################################################################################
##
#M  ViewString(A)
##
InstallMethod( ViewString,
  "Returns the most important informations about the Predicaton.",
  true,
  [IsPredicatonObj and IsPredicatonRep], 0,
  function( A )
    if IsDeterministicAutomaton(A!.aut) then
      if AlphabetOfAutomaton(A!.aut) = 1 and NumberStatesOfAutomaton(A!.aut) = 1 then
        return Concatenation("< Predicaton: deterministic finite automaton on ", String(AlphabetOfAutomaton(A!.aut)), " letter with ", String(NumberStatesOfAutomaton(A!.aut)), " state ", "and the variable position list ", String(A!.var), ". >" );
      elif AlphabetOfAutomaton(A!.aut) = 1 and NumberStatesOfAutomaton(A!.aut) > 1 then
        return Concatenation("< Predicaton: deterministic finite automaton on ", String(AlphabetOfAutomaton(A!.aut)), " letter with ", String(NumberStatesOfAutomaton(A!.aut)), " states ", "and the variable position list ", String(A!.var), ". >" );
      elif AlphabetOfAutomaton(A!.aut) > 1 and NumberStatesOfAutomaton(A!.aut) = 1 then
        return Concatenation("< Predicaton: deterministic finite automaton on ", String(AlphabetOfAutomaton(A!.aut)), " letters with ", String(NumberStatesOfAutomaton(A!.aut)), " state ", "and the variable position list ", String(A!.var), ". >" );
      else
        return Concatenation("< Predicaton: deterministic finite automaton on ", String(AlphabetOfAutomaton(A!.aut)), " letters with ", String(NumberStatesOfAutomaton(A!.aut)), " states ", "and the variable position list ", String(A!.var), ". >" );
      fi;
    elif IsNonDeterministicAutomaton(A!.aut) then
      if AlphabetOfAutomaton(A!.aut) = 1 and NumberStatesOfAutomaton(A!.aut) = 1 then
        return Concatenation("< Predicaton: nondeterministic finite automaton on ", String(AlphabetOfAutomaton(A!.aut)), " letter with ", String(NumberStatesOfAutomaton(A!.aut)), " state ", "and the variable position list ", String(A!.var), ". >" );
      elif AlphabetOfAutomaton(A!.aut) = 1 and NumberStatesOfAutomaton(A!.aut) > 1 then
        return Concatenation("< Predicaton: nondeterministic finite automaton on ", String(AlphabetOfAutomaton(A!.aut)), " letter with ", String(NumberStatesOfAutomaton(A!.aut)), " states ", "and the variable position list ", String(A!.var), ". >" );
      elif AlphabetOfAutomaton(A!.aut) > 1 and NumberStatesOfAutomaton(A!.aut) = 1 then
        return Concatenation("< Predicaton: nondeterministic finite automaton on ", String(AlphabetOfAutomaton(A!.aut)), " letters with ", String(NumberStatesOfAutomaton(A!.aut)), " state ", "and the variable position list ", String(A!.var), ". >" );
      else
        return Concatenation("< Predicaton: nondeterministic finite automaton on ", String(AlphabetOfAutomaton(A!.aut)), " letters with ", String(NumberStatesOfAutomaton(A!.aut)), " states ", "and the variable position list ", String(A!.var), ". >" );
      fi;
    else 
      return Concatenation("< Predicaton: Strange object, please check input, this shouldn't happened at all >");
    fi;
end);
####################################################################################################
##
#M  String(A)
##
InstallMethod( String,
 "Returns the Predicaton as string.", 
  true, 
  [IsPredicatonObj and IsPredicatonRep], 0, 
  function( A )
    return Concatenation("Predicaton(Automaton(\"", String(A!.aut!.type), "\", ", String(A!.aut!.states), ", ", String(AlphabetOfAutomatonAsList(A!.aut)), ", ", String(A!.aut!.transitions), ", ", String(A!.aut!.initial), ", ", String(A!.aut!.accepting), "), ", String(A!.var), ");;");
end);
####################################################################################################
##
#M  BuildPredicaton(Type, Size, Alphabet, TransitionTable, Initial, Final, VariablePositionList)
##
##  Creates first the Automaton as well as then Predicaton.
##
InstallGlobalFunction( BuildPredicaton, function( Type, Size, Alphabet, TransitionTable, Initial, Final, VariablePositionList )
  return Predicaton(Automaton(Type, Size, Alphabet, TransitionTable, Initial, Final), VariablePositionList);
end);
##
#E
##
