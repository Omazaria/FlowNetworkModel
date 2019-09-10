#___________________________________________________________________________________________________________ the available workforce condition
#______________________________ incidance from layer 0
for i = 1:size(arcs,1)
  ar[(arcs[i,1]), (length(RecruitmentE) + i)] = 1
end
#______________________________ retirment from layer 0
for i = 1:size(RetirmentNodes, 1)
    for j = 1:size(RetirmentNodes, 2)
        ar[(RetirmentNodes[i, j]), (length(RecruitmentE) + size(arcs,1) + size(RetirmentNodes, 1)*(j-1)+ i )] = 1
    end
end

#___________________________________________________________________________________________ the transition condition  < 1
for l = 1:(LayersNumber-2)
  #______________________________ recruitment
  for i = 1:length(RecruitmentE)
    ar[(NodesNumber+ ((l-1)*NodesNumber) + (RecruitmentE[i])), ((l-1)*VariablesNumberOnLayer + i)] =-(1 - AnnualAttritionRate)
  end

  #______________________________ arcs
  for i = 1:size(arcs,1)
    ar[(NodesNumber+ ((l-1)*NodesNumber) + (arcs[i,2])), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + i)] =-(1 - AnnualAttritionRate)
    ar[(NodesNumber+ ((l-1)*NodesNumber) + (arcs[i,1])), (    l*VariablesNumberOnLayer + length(RecruitmentE) + i)] = 1
  end

  #______________________________ Retirment from nodes
  for i = 1:size(RetirmentNodes,1)
        for j = 1:size(RetirmentNodes,2)
            ar[(NodesNumber+ ((l-1)*NodesNumber) + (RetirmentNodes[i,j])), (l*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs,1) + size(RetirmentNodes, 1)*(j-1)+ i)] = 1
        end
  end

end

#___________________________________________________________________________________________ the transition condition > 0
for l = 1:(LayersNumber-2)
  #______________________________ recruitment
  for i = 1:length(RecruitmentE)
    ar[(NodesNumber + NodesNumber*(LayersNumber-2) + ((l-1)*NodesNumber) + (RecruitmentE[i])), ((l-1)*VariablesNumberOnLayer + i)] =-(1 - AnnualAttritionRate)
  end

  #______________________________ arcs
  for i = 1:size(arcs,1)
    ar[(NodesNumber + NodesNumber*(LayersNumber-2) + ((l-1)*NodesNumber) + (arcs[i,2])), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + i)] =-(1 - AnnualAttritionRate)
    ar[(NodesNumber + NodesNumber*(LayersNumber-2) + ((l-1)*NodesNumber) + (arcs[i,1])), (    l*VariablesNumberOnLayer + length(RecruitmentE) + i)] = 1
  end

  #______________________________ Retirment from nodes
  for i = 1:size(RetirmentNodes,1)
        for j = 1:size(RetirmentNodes,2)
            ar[(NodesNumber + NodesNumber*(LayersNumber-2) + ((l-1)*NodesNumber) + (RetirmentNodes[i,j])), (l*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs,1) + size(RetirmentNodes, 1)*(j-1)+ i)] = 1
        end
  end

end
