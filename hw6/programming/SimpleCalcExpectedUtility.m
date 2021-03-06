function EU = SimpleCalculateExpectedUtility(I)

  % Inputs: An influence diagram, I (as described in the writeup).
  %         I.RandomFactors = list of factors for each random variable.  These are CPDs, with
  %              the child variable = D.var(1)
  %         I.DecisionFactors = factor for the decision node.
  %         I.UtilityFactors = list of factors representing conditional utilities.
  % Return Value: the expected utility of I
  % Given a fully instantiated influence diagram with a single utility node and decision node,
  % calculate and return the expected utility.  Note - assumes that the decision rule for the 
  % decision node is fully assigned.

  % In this function, we assume there is only one utility node.
  F = [I.RandomFactors I.DecisionFactors];
  U = I.UtilityFactors(1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Quiz Q1
  %    SimpleCalcExpectedUtility(FullI) = -685.9531
  % Quiz Q2
  %    FullII = FullI;
  %    FullII.RandomFactors = ObserveEvidence(FullII.RandomFactors,[3,2],'normalize')
  %    SimpleCalcExpectedUtility(FullII) = -729.2367
    F_indx = unique([F(:).var]);
    F_indx(ismember(F_indx,U.var))=[];
    F_new_list =  VariableElimination(F, F_indx, []);
    Fnew = struct('var', [], 'card', [], 'val', []);
    for i=1:length(F_new_list)
          Fnew = FactorProduct(Fnew,F_new_list(i));
    end
    Fnew = FactorProduct(Fnew,U);
    EU = sum(Fnew.val);
end
