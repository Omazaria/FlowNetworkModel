
#____________________________________________________________________________Constraints declaration
TempConstraintNumber = 1
#____________________________________________________________________________Rigid constraints
#__________________________________ ∑_j X_(0 i 1 j) = A_i
for i = 1:NodesNumber
    b[TempConstraintNumber] = InitialWorkforce[i]
    sense[TempConstraintNumber] = '='
    TempConstraintNumber = TempConstraintNumber + 1
end
# println(TempConstraintNumber)
#__________________________________ Alph * ∑_j X_(i-1 jik) -∑_j X_(ik i+1 j) < 1
for i = 2:(LayersNumber-1)
  for j = 1:NodesNumber
    b[TempConstraintNumber] = 0
    if ElementOf(j, RecruitmentE)
      sense[TempConstraintNumber] = '<'
    else
      sense[TempConstraintNumber] = '<'
    end
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ Alph * ∑_j X_(i-1 jik) -∑_j X_(ik i+1 j) > 0
for i = 2:(LayersNumber-1)
  for j = 1:NodesNumber
    b[TempConstraintNumber] = 0
    if ElementOf(j, RecruitmentE)
      sense[TempConstraintNumber] = '>'
    else
      sense[TempConstraintNumber] = '>'
    end
    TempConstraintNumber = TempConstraintNumber + 1
  end
end
# println(TempConstraintNumber)
#__________________________________ X_(i-1 world i+1 k) ≤MaxRec
for i = 2:(LayersNumber)
    b[TempConstraintNumber] = RecruitmentUpLimit
    sense[TempConstraintNumber] = '<'
    TempConstraintNumber = TempConstraintNumber + 1
end
# println(TempConstraintNumber)
if UseMinRecruitment #___________________________________________________________________Min Recruitement
        #__________________________________  X_(i-1 world i+1 k) >= MinRec
        for i = 2:(LayersNumber)
            b[TempConstraintNumber] = RecruitmentLowLimit
            sense[TempConstraintNumber] = '>'
            TempConstraintNumber = TempConstraintNumber + 1
        end
        # println(TempConstraintNumber)
end
#____________________________________________________________________________Goals constraints
#__________________________________ ∑_j X_(i-1 jik) +∑_j X_(i-1 jil) +⋯ + d_l_1^-(i) - d_l_1^+(i) =Req(k,l,…)
for i = 2:(LayersNumber)
  for j = 1:size(Requirements, 1)
    b[TempConstraintNumber] = RequiredAmount[i][j]
    sense[TempConstraintNumber] = '='
    TempConstraintNumber = TempConstraintNumber + 1
  end
end
# println(TempConstraintNumber)
#__________________________________ ∑ X_(j-1 i j Retirement) + e_y^-(i) - e_y^+(i) < Ret_y(i) +1
for i = 1:(ServiceYears)
    for j = 1:size(RetirmentNodes, 1)
        b[TempConstraintNumber] = (((1-AnnualAttritionRate)^(i-1))*RetirmentAllowed[i, j])
        sense[TempConstraintNumber] = '<'
        TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ ∑ X_y(i, Ret) - ∑_i (X_(y - SY)(W, i)) + e_y^-(i) - e_y^+(i) < 1
for i = (ServiceYears+1):(LayersNumber-1)
  for j = 1:SkillsNumber
    b[TempConstraintNumber] = 0
    sense[TempConstraintNumber] = '<'
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

#__________________________________ ∑ X_(j-1 i j Retirement) + e_y^-(i) - e_y^+(i) > Ret_y(i)
for i = 1:(ServiceYears)
    for j = 1:size(RetirmentNodes, 1)
        b[TempConstraintNumber] = (((1-AnnualAttritionRate)^(i-1))*RetirmentAllowed[i, j])
        sense[TempConstraintNumber] = '>'
        TempConstraintNumber = TempConstraintNumber + 1
  end
end

# println(TempConstraintNumber)
#__________________________________ ∑ X_y(i, Ret) - ∑_i (X_(y - SY)(W, i)) + e_y^-(i) - e_y^+(i) > 0
for i = (ServiceYears+1):(LayersNumber-1)
  for j = 1:SkillsNumber
    b[TempConstraintNumber] = 0
    sense[TempConstraintNumber] = '>'
    TempConstraintNumber = TempConstraintNumber + 1
  end
end

# println(TempConstraintNumber)
if UseIndesirableMVT
        #__________________________________ ∑_((i,j)∈Indesirable) X_y(i, j) + f_y^- - f_y^+ = 0
        for i = 1:(LayersNumber-1)
            b[TempConstraintNumber] = 0
            sense[TempConstraintNumber] = '='
            TempConstraintNumber = TempConstraintNumber + 1
        end
        # println(TempConstraintNumber)
end
if UseRanksLimit
    #__________________________________ ∑_{i ∈ L_{y-1}, j ∈ Rank_{y}(r)} X_{y-1}(i, j) Rd_y^-(i) - Rd_y^+(i) = LimRk_y(r)
    for i = 1:(LayersNumber-1)
            for j = 1:size(Ranks, 1)
                    b[TempConstraintNumber] = LimitRanks[i, j]
                    sense[TempConstraintNumber] = '='
                    TempConstraintNumber = TempConstraintNumber + 1
            end
    end
    # println(TempConstraintNumber)
end

if RecruitmentAllowedDeviation >= 0
    for i = 1:(LayersNumber - 2)
        for j in 1:length(RecruitmentE)
            b[TempConstraintNumber] = 0
            sense[TempConstraintNumber] = '>'
            TempConstraintNumber = TempConstraintNumber + 1
        end

        for j in 1:length(RecruitmentE)
            b[TempConstraintNumber] = 0
            sense[TempConstraintNumber] = '<'
            TempConstraintNumber = TempConstraintNumber + 1
        end
    end
    # println(TempConstraintNumber)
end
