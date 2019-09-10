include("DataInit.jl")
IntegerSolution = true
Tolerances_MIPGap = 0.1
#____________________________________________________________________________GP Initiation
VariablesNumberOnLayer = size(arcs,1) +
                         length(RecruitmentE) +
                         RetirementNodesNB +
                         2*size(Requirements, 1) +
                         2*SkillsNumber +
                         2 +
                         2*size(Ranks, 1)
VariablesNumber  =  (VariablesNumberOnLayer)* (LayersNumber-1)

ConstraintNumber =  NodesNumber +
                    NodesNumber*(LayersNumber-2) +
                    (LayersNumber-1)*2 +                    #*length(RecruitmentE)
                    size(Requirements, 1)*(LayersNumber-1) +
                    SkillsNumber*(LayersNumber - 1) +
                    (LayersNumber - 1)+
                    (LayersNumber - 1)*size(Ranks, 1)

println(VariablesNumberOnLayer)

b = zeros(Int64, ConstraintNumber) # b
sense     = Array{Char}(ConstraintNumber) # sense
vartypes = [:Int for i in 1:VariablesNumber]
#____________________________________________________________________________Constraints declaration
TempConstraintNumber = 1
#____________________________________________________________________________Rigid constraints
#__________________________________ ∑_j X_(0 i 1 j) = A_i
for i = 1:NodesNumber
    b[TempConstraintNumber] = InitialWorkforce[i]
    sense[TempConstraintNumber] = '='
    TempConstraintNumber = TempConstraintNumber + 1
end

#__________________________________ ∑_j X_(i-1 jik) -∑_j X_(ik i+1 j) =0
for i = 2:(LayersNumber-1)
  for j = 1:NodesNumber
    b[TempConstraintNumber] = 0
    if ElementOf(j, RecruitmentE)
      sense[TempConstraintNumber] = '='
    else
      sense[TempConstraintNumber] = '='
    end
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ X_(i-1 world i+1 k) ≤MaxRec
for i = 2:(LayersNumber)
    b[TempConstraintNumber] = RecruitmentUpLimit
    sense[TempConstraintNumber] = '<'
    TempConstraintNumber = TempConstraintNumber + 1
end

#__________________________________  X_(i-1 world i+1 k) >= MinRec
for i = 2:(LayersNumber)
    b[TempConstraintNumber] = RecruitmentLowLimit
    sense[TempConstraintNumber] = '>'
    TempConstraintNumber = TempConstraintNumber + 1
end

#____________________________________________________________________________Goals constraints
#__________________________________ ∑_j X_(i-1 jik) +∑_j X_(i-1 jil) +⋯ + d_l_1^-(i) - d_l_1^+(i) =Req(k,l,…)
for i = 2:(LayersNumber)
  for j = 1:size(Requirements, 1)
    b[TempConstraintNumber] = RequiredAmount[i, j]
    sense[TempConstraintNumber] = '='
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ ∑ X_(j-1 i j Retirement) + e_y^-(i) - e_y^+(i)= Ret_y(i)
for i = 1:(ServiceYears)
    for j = 1:size(RetirmentNodes, 1)
        b[TempConstraintNumber] = RetirmentAllowed[i, j]
        sense[TempConstraintNumber] = '='
        TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ ∑ X_y(i, Ret) - ∑_i (X_(y - SY)(W, i)) + e_y^-(i) - e_y^+(i) = 0
for i = (ServiceYears+1):(LayersNumber-1)
  for j = 1:SkillsNumber
    b[TempConstraintNumber] = 0
    sense[TempConstraintNumber] = '='
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ ∑_((i,j)∈Indesirable) X_y(i, j) + f_y^- - f_y^+ = 0
for i = 1:(LayersNumber-1)
    b[TempConstraintNumber] = 0
    sense[TempConstraintNumber] = '='
    TempConstraintNumber = TempConstraintNumber + 1
end

#__________________________________ ∑_{i ∈ L_{y-1}, j ∈ Rank_{y}(r)} X_{y-1}(i, j) Rd_y^-(i) - Rd_y^+(i) = LimRk_y(r)
for i = 1:(LayersNumber-1)
        for j = 1:size(Ranks, 1)
                b[TempConstraintNumber] = LimitRanks[i, j]
                sense[TempConstraintNumber] = '='
                TempConstraintNumber = TempConstraintNumber + 1
        end
end

#____________________________________________________________________________Variables addition
  Cost = zeros(Float64, VariablesNumber)
  TempVariablesNumber = 1
for i = 1:(LayersNumber-1)
  #________________ Recruitment
  for j = 1:length(RecruitmentE)
    Cost[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1
  end
  #________________ Arcs
  for j = 1:size(arcs, 1)
    Cost[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1
  end
  #________________ Retirement
  for j = 1:RetirementNodesNB
    Cost[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1
  end
    #________________ Deviation variables
    #________________ d_y^-(k)  d_y^+(k)
  for j = 1: size(Requirements, 1)
    Cost[TempVariablesNumber] = 30
    TempVariablesNumber = TempVariablesNumber + 1


    Cost[TempVariablesNumber] = 30
    TempVariablesNumber = TempVariablesNumber + 1
  end
    #________________ e_y^-(k)  e_y^+(k)
  for j = 1: SkillsNumber
    Cost[TempVariablesNumber] = 5
    TempVariablesNumber = TempVariablesNumber + 1


    Cost[TempVariablesNumber] = 5
    TempVariablesNumber = TempVariablesNumber + 1
  end


    #________________ f_y^-  f_y^+
    Cost[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1


    Cost[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1

    #________________ Rd_y^-(k)  Rd_y^+(k)
  for j = 1: size(Ranks, 1)
    Cost[TempVariablesNumber] = 30
    TempVariablesNumber = TempVariablesNumber + 1


    Cost[TempVariablesNumber] = 30
    TempVariablesNumber = TempVariablesNumber + 1
  end
end


    ia = repeat([i for i = 1:ConstraintNumber],inner=[VariablesNumber],outer=[1])
    ja = repeat([i for i = 1:VariablesNumber],inner=[1],outer=[ConstraintNumber])

    ar = zeros(Float64, ConstraintNumber, VariablesNumber) #[0.0 for i = 1:(ConstraintNumber*VariablesNumber)]



#______________________________ filling the matrix A

#___________________________________________________________________________________________________________ Rigid constraints
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

#___________________________________________________________________________________________ the transition condition
for l = 1:(LayersNumber-2)
  #______________________________ recruitment
  for i = 1:length(RecruitmentE)
    ar[(NodesNumber+ ((l-1)*NodesNumber) + (RecruitmentE[i])), ((l-1)*VariablesNumberOnLayer + i)] =-1#*(rand(70:80)/100)
  end

  #______________________________ arcs
  for i = 1:size(arcs,1)
    ar[(NodesNumber+ ((l-1)*NodesNumber) + (arcs[i,2])), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + i)] =-1
    ar[(NodesNumber+ ((l-1)*NodesNumber) + (arcs[i,1])), (    l*VariablesNumberOnLayer + length(RecruitmentE) + i)] = 1
  end

  #______________________________ Retirment from nodes
  for i = 1:size(RetirmentNodes,1)
        for j = 1:size(RetirmentNodes,2)
            ar[(NodesNumber+ ((l-1)*NodesNumber) + (RetirmentNodes[i,j])), (l*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs,1) + size(RetirmentNodes, 1)*(j-1)+ i)] = 1
        end
  end

end


#_______________________________________________________________________________________ the recruitment conditions Max
for l = 1:(LayersNumber-1)
  for i = 1:length(RecruitmentE)
        ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (l)), ((l-1)*VariablesNumberOnLayer + i)] = 1
  end
end

#_______________________________________________________________________________________ the recruitment conditions Min
for l = 1:(LayersNumber-1)
  for i = 1:length(RecruitmentE)
    ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1) + (l)), ((l-1)*VariablesNumberOnLayer + i)] = 1
  end
end


#________________________________________________________________________________________ Goal constraints

#________________________________________________________________________________________ fulfill the requirement conditions
for l = 1:(LayersNumber-1)
    for i = 1:size(Requirements, 1)
        for j = 1:size(Requirements, 2)
            if(Requirements[i, j] != -1)
                #______________________________ Recruitement
                for k = 1:length(RecruitmentE)
                    if(RecruitmentE[k] == Requirements[i, j])
                        ar[(NodesNumber + ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + k)] = 1
                    end #*length(RecruitmentE)
                end
                #______________________________ arcs
                for k = 1:size(arcs, 1)
                    if(arcs[k, 2] == Requirements[i, j])
                        ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = 1
                    end
                end
            end
            ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 1)] = 1

            ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 2)] = -1
        end
    end
end


#________________________________________________________________________________ Retirement for the first service years
for l = 1:ServiceYears
    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
            ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + ((i - 1)*size(RetirmentNodes, 2) + j))] = 1
        end

        #Previous deviation
        if l > 1
        ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l-2)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = 0#-1
        end


        ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = 0#1
        ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 2)] = 0#-1
    end
end

#________________________________________________________________________________________ Retirement beyond service years
for l = ServiceYears+1:(LayersNumber-1)
    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
            ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + ((i - 1)*size(RetirmentNodes, 2) + j))] = 1
        end
        for j = 1:size(RecruitmentSkill, 2)
            for k = 1:size(arcs, 1)
              if arcs[k, 1] == RecruitmentE[RecruitmentSkill[i, j]]
                ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l- ServiceYears)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = -1
              end
            end
        end

        #Previous deviation
        ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l-2)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = 0#-1

        ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = 0#1
        ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 2)] = 0#-1
    end
end

println(6)

#__________________________________________________________________________________________________ Indesirable movements
for l = 1:(LayersNumber-1)
    for i = 1:size(arcs, 1)
        if (arcs[i, 3] == -1)
            ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (l)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + i)] = 1
        end
    end
    ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (l)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 1)] = 1
    ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (l)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2)] =-1
end

#__________________________________________________________________________________________________ Ranks limits

for l = 1:(LayersNumber-1)
        for i = 1:size(Ranks, 1)
                for j = 1:size(Ranks, 2)
                        if Ranks[i, j] != -1
                                for k = 1:size(arcs, 1)
                                        if Ranks[i, j] == arcs[k, 2]
                                                #if (i == 3 & l == 3) println("Ranks[i, j] =  $(Ranks[i, j]), arcs[k, 2] =  $(arcs[k, 2]), k = $k") end
                                                ar[(NodesNumber + ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (LayersNumber - 1) + (l - 1)*size(Ranks, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = 1
                                        end
                                end
                        end
                end
                ar[(NodesNumber + ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (LayersNumber - 1) + (l - 1)*size(Ranks, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2 + 2*(i-1) + 1)] = 1
                ar[(NodesNumber + ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (LayersNumber - 1) + (l - 1)*size(Ranks, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2 + 2*(i-1) + 2)] =-1
        end
end


#writedlm("matrix.txt", A)

#_______________________________________________________________________________
# MIP resolution
print("Solving LP...")
using MathProgBase, CPLEX#, Gurobi
stattoendStart = now()
if IntegerSolution
    println(" IntegerSolution")
    sol = mixintprog(Cost, ar, sense, b, vartypes, 0, Inf16, CplexSolver(CPXPARAM_MIP_Tolerances_MIPGap=Tolerances_MIPGap))#CbcSolver(allowableGap=0.8)) #GurobiSolver(Presolve=0)
else
    println(" Non IntegerSolution")
    sol = linprog(Cost, ar, sense, b, 0, Inf, CplexSolver(CPX_PARAM_EPINT = 0.5))
end
stattoendEnd = now()
println( "ended with: $(sol.status). Elapsed time: $(Dates.canonicalize(Dates.CompoundPeriod(Dates.Millisecond(stattoendEnd - stattoendStart))))." )
writedlm("C:/Users/MediaMonster/Dropbox/Flow cost/solution.txt", sol.sol)

#fpA = open("C:/Users/MediaMonster/Dropbox/Flow cost/SolOrganized.txt", "w")

RequirementFulfillment = zeros(Float64, LayersNumber, size(Requirements, 1))
for l = 1:(LayersNumber-1)
    for i = 1:size(Requirements, 1)
        for j = 1:size(Requirements, 2)
            if(Requirements[i, j] != -1)
                #______________________________ Recruitement
                for k = 1:length(RecruitmentE)
                    if(RecruitmentE[k] == Requirements[i, j])
                        RequirementFulfillment[l, i] += sol.sol[((l-1)*VariablesNumberOnLayer + k)]
                    end #*length(RecruitmentE)
                end
                #______________________________ arcs
                for k = 1:size(arcs, 1)
                    if(arcs[k, 2] == Requirements[i, j])
                        RequirementFulfillment[l, i] += sol.sol[((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + k)]
                    end
                end
            end
            #ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 1)] = 1

            #ar[(NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i)), ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 2)] = -1
        end
    end
end

# for y in 1:LayersNumber-1
#   for i in 1:VariablesNumberOnLayer
#     write(fpA, "$(Int(sol.sol[(y-1)*VariablesNumberOnLayer + i]))\t")
#   end
#   write(fpA, "\n")
# end
#close(fpA)
# RequirementFulfillment = zeros(Float64, LayersNumber, size(Requirements, 1))
# sumi = 0
# for i in 1:LayersNumber
#     for j in 1:size(Requirements, 1)
#         for k in 1:(size(arcs,1) + length(RecruitmentE) + RetirementNodesNB)
#             if ar[size(arcs,1) + length(RecruitmentE) + RetirementNodesNB + (i - 1)*size(Requirements, 1) + j, k] != 0
#                 RequirementFulfillment[i, j] +=  sol.sol[k]*ar[InitConst + RecruitmentConst + (i - 1)*size(Requirements, 1) + j, k]#round(Int,)
#             end
#         end
#     end
# end

# YearlyRecruitment = zeros(Float64, NBYears)
#
# for i in 1:NBYears
#     for j in 1:length(GuyCareerPaths)
#         YearlyRecruitment[i] += sol.sol[InitMPDivisionNb + (i - 1)*length(GuyCareerPaths) + j]
#     end
# end


writedlm("C:/Users/MediaMonster/Dropbox/Flow cost/RequirementFulfillment.txt", RequirementFulfillment)
