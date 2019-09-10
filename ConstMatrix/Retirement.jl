#________________________________________________________________________________ Retirement for the first service years < Allowed +1
for l = 1:ServiceYears
    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
            ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + ((i - 1)*size(RetirmentNodes, 2) + j))] = 1
        end
    end
end

#________________________________________________________________________________________ Retirement beyond service years < 1
for l = ServiceYears+1:(LayersNumber-1)
    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
            ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + ((i - 1)*size(RetirmentNodes, 2) + j))] = 1
        end
        for j = 1:size(RecruitmentSkill, 2)
            for k = 1:size(arcs, 1)
              if arcs[k, 1] == RecruitmentE[RecruitmentSkill[i, j]]
                ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l- ServiceYears)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = -((1-AnnualAttritionRate)^(ServiceYears))
              end
            end
        end

        #Previous deviation
        if UseDeviationRetirement
            ar[(AvailableNbConst + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-2)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = -1

            ar[(AvailableNbConst + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] =  1
            ar[(AvailableNbConst + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 2)] = -1
        end
    end
end



#________________________________________________________________________________ Retirement for the first service years > Allowed
for l = 1:ServiceYears
    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
            ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + ((i - 1)*size(RetirmentNodes, 2) + j))] = 1
        end
    end
end

#________________________________________________________________________________________ Retirement beyond service years > 0
for l = ServiceYears+1:(LayersNumber-1)
    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
            ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + ((i - 1)*size(RetirmentNodes, 2) + j))] = 1
        end
        for j = 1:size(RecruitmentSkill, 2)
            for k = 1:size(arcs, 1)
              if arcs[k, 1] == RecruitmentE[RecruitmentSkill[i, j]]
                ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l- ServiceYears)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = -((1-AnnualAttritionRate)^(ServiceYears))
              end
            end
        end

        #Previous deviation
        if UseDeviationRetirement
            ar[(AvailableNbConst + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-2)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = -1

            ar[(AvailableNbConst + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] =  1
            ar[(AvailableNbConst + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1) + (l-1)*size(RetirmentNodes, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 2)] = -1
        end
    end
end
