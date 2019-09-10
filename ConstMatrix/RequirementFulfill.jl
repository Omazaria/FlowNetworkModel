
#________________________________________________________________________________________ fulfill the requirement conditions
for l = 1:(LayersNumber-1)
    for i = 1:size(Requirements, 1)
        for j = 1:size(Requirements, 2)
            if Requirements[i, j] != -1
                #______________________________ Recruitement
                for k = 1:length(RecruitmentE)
                    if RecruitmentE[k] == Requirements[i, j]
                        ar[(AvailableNbConst + RecruitmentConstnb + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + k)] = 1
                    end #*length(RecruitmentE)
                end
                #______________________________ arcs
                for k = 1:size(arcs, 1)
                    if arcs[k, 2] == Requirements[i, j]
                        ar[(AvailableNbConst + RecruitmentConstnb + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = 1
                    end
                end
            end
        end

        ar[(AvailableNbConst + RecruitmentConstnb + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 1)] = 1

        ar[(AvailableNbConst + RecruitmentConstnb + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 2)] = -1
    end
end
