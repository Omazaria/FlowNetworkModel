
if UseIndesirableMVT
        #__________________________________________________________________________________________________ Indesirable movements
        for l = 1:(LayersNumber-1)
            for i = 1:size(arcs, 1)
                if (arcs[i, 3] == -1)
                    ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1)*2 + (l)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + i)] = 1
                end
            end
            ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1)*2 + (l)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 1)] = 1
            ar[(AvailableNbConst + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1)*2 + (l)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2)] =-1
        end
end

if UseRanksLimit
        #__________________________________________________________________________________________________ Ranks limits

        for l = 1:(LayersNumber-1)
                for i = 1:size(Ranks, 1)
                        for j = 1:size(Ranks, 2)
                                if Ranks[i, j] != -1
                                        for k = 1:size(arcs, 1)
                                                if Ranks[i, j] == arcs[k, 2]
                                                        #if (i == 3 & l == 3) println("Ranks[i, j] =  $(Ranks[i, j]), arcs[k, 2] =  $(arcs[k, 2]), k = $k") end
                                                        ar[(NodesNumber + ((LayersNumber-2)*NodesNumber) + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1)*2 + ((UseIndesirableMVT)?(LayersNumber - 1):0) + (l - 1)*size(Ranks, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = 1
                                                end
                                        end
                                end
                        end
                        ar[(NodesNumber + ((LayersNumber-2)*NodesNumber) + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1)*2 + ((UseIndesirableMVT)?(LayersNumber - 1):0) + (l - 1)*size(Ranks, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2 + 2*(i-1) + 1)] = 1
                        ar[(NodesNumber + ((LayersNumber-2)*NodesNumber) + RecruitmentConstnb + (LayersNumber-1)*size(Requirements, 1) + SkillsNumber*(LayersNumber - 1)*2 + ((UseIndesirableMVT)?(LayersNumber - 1):0) + (l - 1)*size(Ranks, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2 + 2*(i-1) + 2)] =-1
                end
        end
end
