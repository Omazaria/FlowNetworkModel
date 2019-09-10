#_______________________________________________________________________________________ the recruitment conditions Max
for l = 1:(LayersNumber-1)
  for i = 1:length(RecruitmentE)
        ar[(AvailableNbConst + (l)), ((l-1)*VariablesNumberOnLayer + i)] = 1
  end
end
if UseMinRecruitment
        #_______________________________________________________________________________________ the recruitment conditions Min
        for l = 1:(LayersNumber-1)
          for i = 1:length(RecruitmentE)
            ar[(AvailableNbConst + (LayersNumber-1) + (l)), ((l-1)*VariablesNumberOnLayer + i)] = 1
          end
        end
end
