Scenario = "Balance"

#____________________________________________________________________________Problem definition -

#__________________________________________ Arcs set
#
#      [Departure node indice, Arraival node indice, cost]
#
#___________________________________________________
LayersNumber = 65
NodesNumber  = 47
ServiceYears = 43
SkillsNumber =  1

arcs = [[	1	2	1	]
        [	2	2	1	]
        [	2	3	1	]
        [	2	4	1	]
        [	2	9	1	]
        [	3	3	1	]
        [	3	4	1	]
        [	3	7	1	]
        [	3	46	1	]
        [	4	4	1	]
        [	4	8	1	]
        [	4	46	1	]
        [	5	6	1	]
        [	6	6	1	]
        [	6	7	1	]
        [	6	8	1	]
        [	6	10	1	]
        [	7	7	1	]
        [	7	8	1	]
        [	8	8	1	]
        [	9	12	1	]
        [	10	16	1	]
        [	11	12	1	]
        [	12	12	1	]
        [	12	13	1	]
        [	12	14	1	]
        [	13	13	1	]
        [	13	14	1	]
        [	13	17	1	]
        [	13	46	1	]
        [	14	14	1	]
        [	14	18	1	]
        [	14	46	1	]
        [	15	16	1	]
        [	16	16	1	]
        [	16	17	1	]
        [	16	18	1	]
        [	16	19	1	]
        [	17	17	1	]
        [	17	18	1	]
        [	18	18	1	]
        [	19	25	1	]
        [	20	21	1	]
        [	21	21	1	]
        [	21	22	1	]
        [	21	23	1	]
        [	22	22	1	]
        [	22	23	1	]
        [	22	26	1	]
        [	22	46	1	]
        [	23	23	1	]
        [	23	27	1	]
        [	23	46	1	]
        [	24	25	1	]
        [	25	25	1	]
        [	25	26	1	]
        [	25	27	1	]
        [	25	28	1	]
        [	26	26	1	]
        [	26	27	1	]
        [	27	27	1	]
        [	28	34	1	]
        [	29	30	1	]
        [	30	30	1	]
        [	30	31	1	]
        [	30	32	1	]
        [	31	31	1	]
        [	31	32	1	]
        [	31	35	1	]
        [	31	46	1	]
        [	32	32	1	]
        [	32	36	1	]
        [	32	46	1	]
        [	33	34	1	]
        [	34	34	1	]
        [	34	35	1	]
        [	34	36	1	]
        [	34	37	1	]
        [	35	35	1	]
        [	35	36	1	]
        [	36	36	1	]
        [	37	43	1	]
        [	38	39	1	]
        [	39	39	1	]
        [	39	40	1	]
        [	39	41	1	]
        [	40	40	1	]
        [	40	41	1	]
        [	40	44	1	]
        [	40	47	1	]
        [	41	41	1	]
        [	41	45	1	]
        [	41	47	1	]
        [	42	43	1	]
        [	43	43	1	]
        [	43	44	1	]
        [	43	45	1	]
        [	44	44	1	]
        [	44	45	1	]
        [	45	45	1	]]

InitialWorkforce = [0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0       0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0]


function ElementOf(n, tab)
  for i = 1:length(tab)
    if n == tab[i]
      return true
    end
  end
  return false
end


RecruitmentE = [1 5 11 15 20 24 29 33 38 42]
RecruitmentCost = 2
RecruitmentUpLimit = 2000
RecruitmentLowLimit = 0

RecruitmentSkill = [[ 1  2  3  4  5  6  7  8  9 10]]

#Retirement Nodes Number should be declared in a case of different numbers of retirement node on each skill
RetirmentNodes   =  [[7 8 17 18 26 27 35 36 44 45 46 47]]#

RetirmentAllowed = [[0] for i in 1:ServiceYears]

RetirementNodesNB = size(RetirmentNodes, 1)*size(RetirmentNodes, 2)
RetirementCost = 5

Requirements = [[	43	44	45	-1	]
                [	39	40	41	-1	]
                [	34	35	36	-1	]
                [	30	31	32	-1	]
                [	25	26	27	-1	]
                [	21	22	23	-1	]
                [	16	17	18	-1	]
                [	12	13	14	-1	]
                [	6	7	8	-1	]
                [	2	3	4	-1	]
                [	30	34	39	43	]
                [	12	16	21	25	]
                [	2	6	-1	-1	]
                [	31	35	40	44	]
                [	13	17	22	26	]
                [	3	7	-1	-1	]
                [	32	36	41	45	]
                [	14	18	23	27	]
                [	4	8	-1	-1	]
                ]

RequiredAmount =[[1776	931	1184	159	414	197	6286	3453	1800	6350	1050	2670	1800	1380	3540	3070	1620	4140	3280] for i in 1:LayersNumber]

Ranks = Array{Int64, 2}()
LimitRanks = [[]]
# Ranks = [[ 3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22]
#          [23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 -1 -1 -1 -1]
#          [39 40 41 42 43 44 45 46 47 48 49 50 -1 -1 -1 -1 -1 -1 -1 -1]]
#
# LimitRanks = [  [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]
# [	305	400	210	]]
