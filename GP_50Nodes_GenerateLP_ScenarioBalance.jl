Scenario = "Balance"

#____________________________________________________________________________Problem definition -

#__________________________________________ Arcs set
#
#      [Departure node indice, Arraival node indice, cost]
#
#___________________________________________________
LayersNumber = 50
NodesNumber  =  50
ServiceYears = 10
SkillsNumber =  2

arcs = [[	1	3	1	]
        [	1	4	-1	]
        [	2	5	-1	]
        [	2	6	1	]
        [	3	7	1	]
        [	3	9	-1	]
        [	4	8	-1	]
        [	4	10	1	]
        [	5	11	1	]
        [	5	13	-1	]
        [	6	12	-1	]
        [	6	14	1	]
        [	7	15	1	]
        [	7	17	-1	]
        [	8	16	1	]
        [	8	18	1	]
        [	9	16	-1	]
        [	9	18	1	]
        [	10	16	1	]
        [	10	18	1	]
        [	11	19	1	]
        [	11	21	1	]
        [	12	19	1	]
        [	12	21	-1	]
        [	13	19	1	]
        [	13	21	1	]
        [	14	20	-1	]
        [	14	22	1	]
        [	15	23	1	]
        [	15	25	-1	]
        [	16	24	1	]
        [	16	26	1	]
        [	17	24	-1	]
        [	17	26	1	]
        [	18	24	1	]
        [	18	26	1	]
        [	19	27	1	]
        [	19	29	1	]
        [	20	27	1	]
        [	20	29	-1	]
        [	21	27	1	]
        [	21	29	1	]
        [	22	28	-1	]
        [	22	30	1	]
        [	23	33	1	]
        [	23	31	-1	]
        [	24	34	1	]
        [	24	35	1	]
        [	25	34	-1	]
        [	25	35	1	]
        [	26	34	1	]
        [	26	35	1	]
        [	27	36	1	]
        [	27	37	1	]
        [	28	36	1	]
        [	28	37	-1	]
        [	29	36	1	]
        [	29	37	1	]
        [	30	32	-1	]
        [	30	38	1	]
        [	31	34	-1	]
        [	31	40	-1	]
        [	31	41	1	]
        [	31	35	1	]
        [	32	36	1	]
        [	32	42	1	]
        [	32	43	-1	]
        [	32	37	-1	]
        [	33	33	1	]
        [	33	39	1	]
        [	33	31	-1	]
        [	34	34	1	]
        [	34	40	1	]
        [	34	41	1	]
        [	34	35	1	]
        [	35	35	1	]
        [	35	34	1	]
        [	35	40	1	]
        [	35	41	-1	]
        [	36	36	1	]
        [	36	42	-1	]
        [	36	43	1	]
        [	36	37	1	]
        [	37	37	1	]
        [	37	42	1	]
        [	37	43	1	]
        [	37	36	1	]
        [	38	38	1	]
        [	38	32	-1	]
        [	38	44	1	]
        [	39	45	1	]
        [	40	46	1	]
        [	40	47	-1	]
        [	41	46	-1	]
        [	41	47	1	]
        [	42	48	1	]
        [	42	49	-1	]
        [	43	48	-1	]
        [	43	49	1	]
        [	44	50	1	]
        [	45	45	1	]
        [	46	46	1	]
        [	46	47	-1	]
        [	47	46	-1	]
        [	47	47	1	]
        [	48	48	1	]
        [	48	49	-1	]
        [	49	48	-1	]
        [	49	49	1	]
        [	50	50	1	]]

InitialWorkforce = [20	20	30	15	15	30	30	30	15	25	25	15	30	30	30	30	15	25	25	15	30	30	25	25	15	25	25	15	25	25	15	15	25	25	25	25	25	25	18	17	18	17	18	17	17	18	17	18	17	18]


function ElementOf(n, tab)
  for i = 1:length(tab)
    if n == tab[i]
      return true
    end
  end
  return false
end


RecruitmentE = [1  2]
RecruitmentCost = 2
RecruitmentUpLimit = 200
RecruitmentLowLimit = 0

RecruitmentSkill = [[1]
                    [2]]

#Retirement Nodes Number should be declared in a case of different numbers of retirement node on each skill
RetirmentNodes   =  [[33 34 35 45 46 47]#
                     [36 37 38 48 49 50]]#
RetirmentAllowed = [[55 55]
                    [55 55]
                    [55 55]
                    [55 55]
                    [55 55]
                    [55 55]
                    [55 55]
                    [55 55]
                    [55 55]
                    [55 55]]

RetirementNodesNB = size(RetirmentNodes, 1)*size(RetirmentNodes, 2)
RetirementCost = 5

Requirements = [[ 3  7 15  8 16 -1 -1 -1]
                [10 18 26 35 11 19 27 36]
                [ 6 13 14 21 22 -1 -1 -1]
                [23 33 24 34 -1 -1 -1 -1]
                [29 37 30 38 -1 -1 -1 -1]
                [39 45 40 46 -1 -1 -1 -1]
                [41 47 42 48 -1 -1 -1 -1]
                [43 49 44 50 -1 -1 -1 -1]]
RequiredAmount =[[	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]
                [	150	200	150	100	100	70	70	70	]]


Ranks = [[ 3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22]
         [23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 -1 -1 -1 -1]
         [39 40 41 42 43 44 45 46 47 48 49 50 -1 -1 -1 -1 -1 -1 -1 -1]]

LimitRanks = [  [	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]
[	305	400	210	]]

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

ConstraintsRightPart = zeros(Int64, ConstraintNumber)
ConstraintsTypes     = zeros(Int64, ConstraintNumber)

#____________________________________________________________________________Constraints declaration
TempConstraintNumber = 1
#____________________________________________________________________________Rigid constraints
#__________________________________ ∑_j X_(0 i 1 j) = A_i
for i = 1:NodesNumber
    ConstraintsRightPart[TempConstraintNumber] = InitialWorkforce[i]
    ConstraintsTypes[TempConstraintNumber] = 1
    TempConstraintNumber = TempConstraintNumber + 1
end

#__________________________________ ∑_j X_(i-1 jik) -∑_j X_(ik i+1 j) =0
for i = 2:(LayersNumber-1)
  for j = 1:NodesNumber
    ConstraintsRightPart[TempConstraintNumber] = 0
    if ElementOf(j, RecruitmentE)
      ConstraintsTypes[TempConstraintNumber] = 1
    else
      ConstraintsTypes[TempConstraintNumber] = 1
    end
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ X_(i-1 world i+1 k) ≤MaxRec
for i = 2:(LayersNumber)
    ConstraintsRightPart[TempConstraintNumber] = RecruitmentUpLimit
    ConstraintsTypes[TempConstraintNumber] = 2
    TempConstraintNumber = TempConstraintNumber + 1
end

#__________________________________  X_(i-1 world i+1 k) >= MinRec
for i = 2:(LayersNumber)
    ConstraintsRightPart[TempConstraintNumber] = RecruitmentLowLimit
    ConstraintsTypes[TempConstraintNumber] = 3
    TempConstraintNumber = TempConstraintNumber + 1
end

#____________________________________________________________________________Goals constraints
#__________________________________ ∑_j X_(i-1 jik) +∑_j X_(i-1 jil) +⋯ + d_l_1^-(i) - d_l_1^+(i) =Req(k,l,…)
for i = 2:(LayersNumber)
  for j = 1:size(Requirements, 1)
    ConstraintsRightPart[TempConstraintNumber] = RequiredAmount[i, j]
    ConstraintsTypes[TempConstraintNumber] = 1
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ ∑ X_(j-1 i j Retirement) + e_y^-(i) - e_y^+(i)= Ret_y(i)
for i = 1:(ServiceYears)
    for j = 1:size(RetirmentNodes, 1)
        ConstraintsRightPart[TempConstraintNumber] = RetirmentAllowed[i, j]
        ConstraintsTypes[TempConstraintNumber] = 1
        TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ ∑ X_y(i, Ret) - ∑_i (X_(y - SY)(W, i)) + e_y^-(i) - e_y^+(i) = 0
for i = (ServiceYears+1):(LayersNumber-1)
  for j = 1:SkillsNumber
    ConstraintsRightPart[TempConstraintNumber] = 0
    ConstraintsTypes[TempConstraintNumber] = 1
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ ∑_((i,j)∈Indesirable) X_y(i, j) + f_y^- - f_y^+ = 0
for i = 1:(LayersNumber-1)
    ConstraintsRightPart[TempConstraintNumber] = 0
    ConstraintsTypes[TempConstraintNumber] = 1
    TempConstraintNumber = TempConstraintNumber + 1
end

#__________________________________ ∑_{i ∈ L_{y-1}, j ∈ Rank_{y}(r)} X_{y-1}(i, j) Rd_y^-(i) - Rd_y^+(i) = LimRk_y(r)
for i = 1:(LayersNumber-1)
        for j = 1:size(Ranks, 1)
                ConstraintsRightPart[TempConstraintNumber] = LimitRanks[i, j]
                ConstraintsTypes[TempConstraintNumber] = 1
                TempConstraintNumber = TempConstraintNumber + 1
        end
end

#____________________________________________________________________________Variables addition
  CoeficientGoal = zeros(Int64, VariablesNumber)
  TempVariablesNumber = 1
for i = 1:(LayersNumber-1)
  #________________ Recruitment
  for j = 1:length(RecruitmentE)
    CoeficientGoal[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1
  end
  #________________ Arcs
  for j = 1:size(arcs, 1)
    CoeficientGoal[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1
  end
  #________________ Retirement
  for j = 1:RetirementNodesNB
    CoeficientGoal[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1
  end
    #________________ Deviation variables
    #________________ d_y^-(k)  d_y^+(k)
  for j = 1: size(Requirements, 1)
    CoeficientGoal[TempVariablesNumber] = 30
    TempVariablesNumber = TempVariablesNumber + 1


    CoeficientGoal[TempVariablesNumber] = 30
    TempVariablesNumber = TempVariablesNumber + 1
  end
    #________________ e_y^-(k)  e_y^+(k)
  for j = 1: SkillsNumber
    CoeficientGoal[TempVariablesNumber] = 5
    TempVariablesNumber = TempVariablesNumber + 1


    CoeficientGoal[TempVariablesNumber] = 5
    TempVariablesNumber = TempVariablesNumber + 1
  end


    #________________ f_y^-  f_y^+
    CoeficientGoal[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1


    CoeficientGoal[TempVariablesNumber] = 0
    TempVariablesNumber = TempVariablesNumber + 1

    #________________ Rd_y^-(k)  Rd_y^+(k)
  for j = 1: size(Ranks, 1)
    CoeficientGoal[TempVariablesNumber] = 30
    TempVariablesNumber = TempVariablesNumber + 1


    CoeficientGoal[TempVariablesNumber] = 30
    TempVariablesNumber = TempVariablesNumber + 1
  end
end


    ia = repeat([i for i = 1:ConstraintNumber],inner=[VariablesNumber],outer=[1])
    ja = repeat([i for i = 1:VariablesNumber],inner=[1],outer=[ConstraintNumber])

    ar = zeros(Float64, ConstraintNumber*VariablesNumber) #[0.0 for i = 1:(ConstraintNumber*VariablesNumber)]



#______________________________ filling the matrix A

#___________________________________________________________________________________________________________ Rigid constraints
#___________________________________________________________________________________________________________ the available workforce condition
#______________________________ incidance from layer 0
for i = 1:size(arcs,1)
  ar[((arcs[i,1]-1)*VariablesNumber) + (length(RecruitmentE) + i)] = 1
end
#______________________________ retirment from layer 0
for i = 1:size(RetirmentNodes, 1)
    for j = 1:size(RetirmentNodes, 2)
        ar[((RetirmentNodes[i, j]-1)*VariablesNumber) + (length(RecruitmentE) + size(arcs,1) + size(RetirmentNodes, 1)*(j-1)+ i )] = 1

    end
end

#___________________________________________________________________________________________ the transition condition
for l = 1:(LayersNumber-2)
  #______________________________ recruitment
  for i = 1:length(RecruitmentE)
    ar[((NodesNumber+ ((l-1)*NodesNumber) + (RecruitmentE[i]-1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + i)] =-1#*(rand(70:80)/100)
  end

  #______________________________ arcs
  for i = 1:size(arcs,1)
    ar[((NodesNumber+ ((l-1)*NodesNumber) + (arcs[i,2]-1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + i)] =-1
    ar[((NodesNumber+ ((l-1)*NodesNumber) + (arcs[i,1]-1))*VariablesNumber) + (    l*VariablesNumberOnLayer + length(RecruitmentE) + i)] = 1
  end

  #______________________________ Retirment from nodes
  for i = 1:size(RetirmentNodes,1)
        for j = 1:size(RetirmentNodes,2)
            ar[((NodesNumber+ ((l-1)*NodesNumber) + (RetirmentNodes[i,j] - 1))*VariablesNumber) + (l*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs,1) + size(RetirmentNodes, 1)*(j-1)+ i)] = 1
        end
  end

end


#_______________________________________________________________________________________ the recruitment conditions Max
for l = 1:(LayersNumber-1)
  for i = 1:length(RecruitmentE)
        ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (l-1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + i)] = 1
  end
end

#_______________________________________________________________________________________ the recruitment conditions Min
for l = 1:(LayersNumber-1)
  for i = 1:length(RecruitmentE)
    ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1) + (l-1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + i)] = 1
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
                        ar[((NodesNumber + ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i-1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + k)] = 1
                    end #*length(RecruitmentE)
                end
                #______________________________ arcs
                for k = 1:size(arcs, 1)
                    if(arcs[k, 2] == Requirements[i, j])
                        ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i-1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = 1
                    end
                end
            end
            ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i-1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 1)] = 1

            ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (l-1)*size(Requirements, 1) + (i-1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*(i-1) + 2)] = -1
        end
    end
end


#________________________________________________________________________________ Retirement for the first service years
for l = 1:ServiceYears
    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
            ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + ((i - 1)*size(RetirmentNodes, 2) + j))] = 1
        end

        #Previous deviation
        if l > 1
        ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l-2)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = 0#-1
        end


        ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = 0#1
        ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 2)] = 0#-1
    end
end

#________________________________________________________________________________________ Retirement beyond service years
for l = ServiceYears+1:(LayersNumber-1)
    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
            ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + ((i - 1)*size(RetirmentNodes, 2) + j))] = 1
        end
        for j = 1:size(RecruitmentSkill, 2)
            for k = 1:size(arcs, 1)
              if arcs[k, 1] == RecruitmentE[RecruitmentSkill[i, j]]
                ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l- ServiceYears)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = -1
              end
            end
        end

        #Previous deviation
        ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l-2)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = 0#-1

        ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 1)] = 0#1
        ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (l-1)*size(RetirmentAllowed, 2) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + (i-1)*2 + 2)] = 0#-1
    end
end

println(6)

#__________________________________________________________________________________________________ Indesirable movements
for l = 1:(LayersNumber-1)
    for i = 1:size(arcs, 1)
        if (arcs[i, 3] == -1)
            ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (l - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + i)] = 1
        end
    end
    ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (l - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 1)] = 1
    ar[((NodesNumber+ ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (l - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2)] =-1
end

#__________________________________________________________________________________________________ Ranks limits

for l = 1:(LayersNumber-1)
        for i = 1:size(Ranks, 1)
                for j = 1:size(Ranks, 2)
                        if Ranks[i, j] != -1
                                for k = 1:size(arcs, 1)
                                        if Ranks[i, j] == arcs[k, 2]
                                                #if (i == 3 & l == 3) println("Ranks[i, j] =  $(Ranks[i, j]), arcs[k, 2] =  $(arcs[k, 2]), k = $k") end
                                                ar[((NodesNumber + ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (LayersNumber - 1) + (l - 1)*size(Ranks, 1) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + k)] = 1
                                        end
                                end
                        end
                end
                ar[((NodesNumber + ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (LayersNumber - 1) + (l - 1)*size(Ranks, 1) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2 + 2*(i-1) + 1)] = 1
                ar[((NodesNumber + ((LayersNumber-2)*NodesNumber) + (LayersNumber-1)*2 + (LayersNumber-1)*size(Requirements, 1) + (LayersNumber-1)*size(RetirmentAllowed, 2) + (LayersNumber - 1) + (l - 1)*size(Ranks, 1) + (i - 1))*VariablesNumber) + ((l-1)*VariablesNumberOnLayer + length(RecruitmentE) + size(arcs, 1) + RetirementNodesNB + 2*size(Requirements, 1) + 2*SkillsNumber + 2 + 2*(i-1) + 2)] =-1
        end
end

#________________________________________________________________________ LP file generation
function WriteEquationUseTable(fp, Coeficient, start_Index = -1)
  if start_Index == -1
    count = 1
    WriteAll = 1
  else
    count = start_Index
    WriteAll = 0
  end
  for l = 1:LayersNumber-1
    for i = 1:length(RecruitmentE)
      if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) X$(l)_W_$(RecruitmentE[i]) ")
      end

      count += 1
    end
    for i = 1:size(arcs, 1)
        if(Coeficient[count] != 0 || WriteAll == 1)
          if Coeficient[count]>0
            write(fp, "+ ")
          else
            write(fp, "- ")
          end
          write(fp, "$(abs(Coeficient[count])) X$(l)_$(arcs[i, 1])_$(arcs[i, 2]) ")
        end

        count += 1
    end

    for i = 1:size(RetirmentNodes, 1)
        for j = 1:size(RetirmentNodes, 2)
          if(Coeficient[count] != 0 || WriteAll == 1)
              if Coeficient[count]>0
                write(fp, "+ ")
              else
                write(fp, "- ")
              end
              write(fp, "$(abs(Coeficient[count])) X$(l)_$(RetirmentNodes[i, j])_Ret ")
          end

          count += 1
        end
    end

      #________________ d_y^-(k)  d_y^+(k)
  for j = 1: size(Requirements, 1)
    if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) d_$(l)M_$(j) ")
    end
    count += 1

    if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) d_$(l)P_$(j) ")
    end
    count += 1
  end
    #________________ e_y^-(k)  e_y^+(k)
  for j = 1: SkillsNumber
    if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) e_$(l)M_$(j) ")
    end
    count += 1

    if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) e_$(l)P_$(j) ")
    end
    count += 1
  end


    #________________ f_y^-  f_y^+
    if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) f_$(l)M ")
    end
    count += 1

    if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) f_$(l)P ")
    end
    count += 1

    #________________ Rd_y^-(k)  Rd_y^+(k)
  for j = 1: size(Ranks, 1)
    if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) Rd_$(l)M_$(j) ")
    end
    count += 1

    if(Coeficient[count] != 0 || WriteAll == 1)
        if Coeficient[count]>0
          write(fp, "+ ")
        else
          write(fp, "- ")
        end
        write(fp, "$(abs(Coeficient[count])) Rd_$(l)P_$(j) ")
    end
    count += 1
  end

  end
end


function WriteVariables(fp)
        for l = 1:LayersNumber-1
                for i = 1:length(RecruitmentE)
                        write(fp, "X$(l)_W_$(RecruitmentE[i]) ")
                end
                for i = 1:size(arcs, 1)
                        write(fp, "X$(l)_$(arcs[i, 1])_$(arcs[i, 2]) ")
                end

                for i = 1:size(RetirmentNodes, 1)
                        for j = 1:size(RetirmentNodes, 2)
                                write(fp, "X$(l)_$(RetirmentNodes[i, j])_Ret ")
                        end
                end

                for j = 1: size(Requirements, 1) #________________ d_y^-(k)  d_y^+(k)
                        write(fp, "d_$(l)M_$(j) d_$(l)P_$(j) ")
                end

                for j = 1: SkillsNumber #________________ e_y^-(k)  e_y^+(k)
                        write(fp, "e_$(l)M_$(j) e_$(l)P_$(j) ")
                end

                write(fp, "f_$(l)M f_$(l)P ") #________________ f_y^-  f_y^+


                for i = 1:size(Ranks, 1) #________________ Rd_y^-(i) - Rd_y^+(i)
                        write(fp, "Rd_$(l)M_$(i) Rd_$(l)P_$(i) ")
                end

                write(fp, "\n")
        end
end

#______________________ Generate LP file
fpA = open("C:/Users/Administrator/Dropbox/GP_50Nodes_Scenario$(Scenario).lp", "w")

  #___ Objectif Function
write(fpA, "minimize\n")
WriteEquationUseTable(fpA, CoeficientGoal)
#println(" ")
write(fpA, "\n")
  #___ Constraints
write(fpA, "subject to\n")
for i = 0:ConstraintNumber-1
    WriteEquationUseTable(fpA, ar, VariablesNumber*(i)+1)

    if ConstraintsTypes[i+1] == 1
    write(fpA, "= $(ConstraintsRightPart[i+1])")
    elseif ConstraintsTypes[i+1] == 2
    write(fpA, "<= $(ConstraintsRightPart[i+1])")
    elseif ConstraintsTypes[i+1] == 3
    write(fpA, ">= $(ConstraintsRightPart[i+1])")
    end
    write(fpA, "\n")
end

  #___ Bounds
#write(fpA, "bounds\n")


  #___ Types
write(fpA, "general\n")
    WriteVariables(fpA)

write(fpA, "\nend")

close(fpA)
