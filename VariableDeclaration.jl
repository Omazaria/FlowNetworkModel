
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
    Cost[TempVariablesNumber] = ((i<10)?0:1)#((UseTimeDependentCosts)?i:1)
    TempVariablesNumber = TempVariablesNumber + 1


    Cost[TempVariablesNumber] = ((i<10)?0:1)#1*((UseTimeDependentCosts)?i:1)
    TempVariablesNumber = TempVariablesNumber + 1
  end

  if UseDeviationRetirement
          #________________ e_y^-(k)  e_y^+(k)
        for j = 1: SkillsNumber
          Cost[TempVariablesNumber] = 5
          TempVariablesNumber = TempVariablesNumber + 1

          Cost[TempVariablesNumber] = 5
          TempVariablesNumber = TempVariablesNumber + 1
        end
  end
  if UseIndesirableMVT
          #________________ f_y^-  f_y^+
          Cost[TempVariablesNumber] = 0
          TempVariablesNumber = TempVariablesNumber + 1

          Cost[TempVariablesNumber] = 0
          TempVariablesNumber = TempVariablesNumber + 1
  end

  if UseRanksLimit
            #________________ Rd_y^-(k)  Rd_y^+(k)
          for j = 1: size(Ranks, 1)
            Cost[TempVariablesNumber] = 30
            TempVariablesNumber = TempVariablesNumber + 1


            Cost[TempVariablesNumber] = 30
            TempVariablesNumber = TempVariablesNumber + 1
          end
  end
end
