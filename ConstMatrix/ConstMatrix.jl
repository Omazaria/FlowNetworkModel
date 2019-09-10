ar = zeros(Float64, ConstraintNumber, VariablesNumber) #[0.0 for i = 1:(ConstraintNumber*VariablesNumber)]


#______________________________ filling the matrix A
AvailableNbConst = NodesNumber + NodesNumber*(LayersNumber-2)*2
RecruitmentConstnb = (LayersNumber-1)*((UseMinRecruitment)?2:1)

#___________________________________________________________________________________________________________ Rigid constraints
include("AvailableWorkforce.jl")
include("RecruitmentCondition.jl")



#________________________________________________________________________________________ Goal constraints
include("RequirementFulfill.jl")
include("Retirement.jl")
include("IndesirableAndRanks.jl")
include("RecruitmentDeviation.jl")
