IntegerSolution = true
Tolerances_MIPGap = 0.1

#____________________________________________________________________________GP Initiation
VariablesNumberOnLayer = size(arcs,1) +
                         length(RecruitmentE) +
                         RetirementNodesNB +
                         2*size(Requirements, 1) +
                         ((UseDeviationRetirement)?2*SkillsNumber:0) +
                         ((UseIndesirableMVT)?2:0) +
                         ((UseRanksLimit)?2*size(Ranks, 1):0)
VariablesNumber  =  (VariablesNumberOnLayer)* (LayersNumber-1)

ConstraintNumber =  NodesNumber +
                    NodesNumber*(LayersNumber-2)*2 +
                    (LayersNumber-1)*((UseMinRecruitment)?2:1) +                    #*length(RecruitmentE)
                    size(Requirements, 1)*(LayersNumber-1) +
                    SkillsNumber*(LayersNumber - 1)*2 +
                    ((UseIndesirableMVT)?(LayersNumber - 1):0)+
                    (LayersNumber - 1)*size(Ranks, 1)+
                    ((RecruitmentAllowedDeviation >= 0)? (LayersNumber - 2)*length(RecruitmentE)*2:0)

# println(VariablesNumberOnLayer)

b = zeros(Float64, ConstraintNumber) # b
sense     = Array{Char}(ConstraintNumber) # sense
vartypes = [:Int for i in 1:VariablesNumber]
