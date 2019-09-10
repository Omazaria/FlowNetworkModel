UseMinRecruitment = false
UseDeviationRetirement = false
UseRanksLimit = false
UseIndesirableMVT = false
UseTimeDependentCosts = true
RecruitmentAllowedDeviation = -1

include("DataInit5Skill.jl")
include("GP_Init.jl")
include("ConstDeclaration.jl")
include("VariableDeclaration.jl")
include("ConstMatrix/ConstMatrix.jl")



#_______________________________________________________________________________
# MIP resolution
print("Solving LP...")
using MathProgBase, CPLEX
stattoendStart = now()
IntegerSolution = false
if IntegerSolution
    println(" IntegerSolution")
    sol = mixintprog(Cost, ar, sense, b, vartypes, 0, Inf16, CplexSolver(CPXPARAM_MIP_Tolerances_MIPGap=0.05))#CbcSolver(allowableGap=0.8)) #GurobiSolver(Presolve=0)CPXPARAM_MIP_Tolerances_MIPGap=Tolerances_MIPGap
else
    println(" Non IntegerSolution")
    sol = linprog(Cost, ar, sense, b, 0, Inf, CplexSolver(CPX_PARAM_EPINT = 0.5))
end
stattoendEnd = now()
println( "ended with: $(sol.status). Elapsed time: $(Dates.canonicalize(Dates.CompoundPeriod(Dates.Millisecond(stattoendEnd - stattoendStart))))." )
fpA = 0
try
    fpA = open("C:/Users/Administrator/Dropbox/Flow cost/SolOrganized.txt", "w")
catch
    fpA = open("C:/Users/MediaMonster/Dropbox/Flow cost/SolOrganized.txt", "w")
end
for y in 1:LayersNumber-1
  for i in 1:VariablesNumberOnLayer
    write(fpA, "$(Int(round(sol.sol[(y-1)*VariablesNumberOnLayer + i])))\t")
  end
  write(fpA, "\n")
end
close(fpA)

RequirementFulfillment = zeros(Float64, LayersNumber, size(Requirements, 1))
for l = 1:(LayersNumber-1)
    for i = 1:size(Requirements, 1)
        for j = 1:size(Requirements, 2)
            if Requirements[i, j] != -1
                #______________________________ Recruitement
                for k = 1:length(RecruitmentE)
                    if RecruitmentE[k] == Requirements[i, j]
                        RequirementFulfillment[l, i] += sol.sol[((l-1)*VariablesNumberOnLayer + k)]
                    end
                end
                #______________________________ arcs
                for k = 1:size(arcs, 1)
                    if arcs[k, 2] == Requirements[i, j]
                        RequirementFulfillment[l, i] += sol.sol[((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + k)]
                    end
                end
            end
        end

        #RequirementFulfillment[l, i] += sol.sol[((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 1)]
        #RequirementFulfillment[l, i] -= sol.sol[ ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 2)]
    end
end


try
    writedlm("C:/Users/Administrator/Dropbox/Flow cost/RequirementFulfillment.txt", Int.(round(RequirementFulfillment)))
    # writedlm("C:/Users/Administrator/Dropbox/Flow cost/ar.txt", ar)
    # writedlm("C:/Users/Administrator/Dropbox/Flow cost/b.txt", b)
    # writedlm("C:/Users/Administrator/Dropbox/Flow cost/sense.txt", sense)

catch
    writedlm("C:/Users/MediaMonster/Dropbox/Flow cost/RequirementFulfillment.txt", Int.(round(RequirementFulfillment)))
    # writedlm("C:/Users/MediaMonster/Dropbox/Flow cost/ar.txt", ar)
    # writedlm("C:/Users/MediaMonster/Dropbox/Flow cost/b.txt", b)
    # writedlm("C:/Users/MediaMonster/Dropbox/Flow cost/sense.txt", sense)
end
