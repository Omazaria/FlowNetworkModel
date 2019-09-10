if RecruitmentAllowedDeviation >= 0

    LastUsedConst = AvailableNbConst +
                    (LayersNumber-1)*((UseMinRecruitment)?2:1) +                    #*length(RecruitmentE)
                    size(Requirements, 1)*(LayersNumber-1) +
                    SkillsNumber*(LayersNumber - 1)*2 +
                    ((UseIndesirableMVT)?(LayersNumber - 1):0)+
                    (LayersNumber - 1)*size(Ranks, 1)


    for l in 1:(LayersNumber-2)
        for i in 1:length(RecruitmentE)
            ar[LastUsedConst + (l-1)*length(RecruitmentE)*2 +                        i, (l  )*VariablesNumberOnLayer + i] =   1
            ar[LastUsedConst + (l-1)*length(RecruitmentE)*2 +                        i, (l-1)*VariablesNumberOnLayer + i] = -(1 - RecruitmentAllowedDeviation)
            # println(-(1 - RecruitmentAllowedDeviation), " ", -(1 + RecruitmentAllowedDeviation))
            ar[LastUsedConst + (l-1)*length(RecruitmentE)*2 + length(RecruitmentE) + i, (l  )*VariablesNumberOnLayer + i] =   1
            ar[LastUsedConst + (l-1)*length(RecruitmentE)*2 + length(RecruitmentE) + i, (l-1)*VariablesNumberOnLayer + i] = -(1 + RecruitmentAllowedDeviation)
        end
    end
end
