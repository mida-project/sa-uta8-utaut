library(parameters)
library(readxl)
library(psychTools)
library(GGally)
library(psych)
library(tidySEM)

#Read Data
SimplePre <- read_excel("../data/simple_200.xlsx")
mydata <- SimplePre[c(10,11,12,13,
                      14,15,16,17,
                      18,19,20,21,
                      22,23,24,25,
                      26,27,28,29,
                      30,31,32,33,
                      34,35,36,37)]

# Check the data
pairs.panels(mydata)
corPlot(mydata)

# Calculate the correlation matrix
corMat <- cor(mydata)
print(corMat)

# RMSA < 0.08
# Tucker Lewis Index < 0.99
# If actor correlations are > 0.70 then we will
# have divergence validity problem.

# Run the Factor Analsis
fit_efa <- fa(mydata, 7, fm="ml", rotate="oblimin")
print(fit_efa, digits=2, cutoff=.3)

model1 <- convert_efa_to_cfa(fit_efa, threshold = 0.3)
print(model1)

##################################################
# TESTING START
##################################################
# CFA Model
# Now, we have to define a model. We have all of
# our factors and all of our items. The model is
# not in our dataset, is something we create from
# theory and literature.
# The symbol =~ stands for construct.

# TODO
# Factors from literature = 10
cfa_model_0 <- ' #start of model
# latent variable definitions (common factors)
  Impact =~
  PerfExp =~ Q10 + Q11 + Q12
  EffExp =~ Q13 + Q14 + Q15
  SocInf =~ Q16 + Q17 + Q18
  FacCond =~ Q19 + Q20 + Q21
  IntUse =~ Q22 + Q23 + Q24 + Q25
  Attitude =~ Q26 + Q27 + Q28
  Security =~ Q30 + Q31
  Privacy =~ Q32 + Q33 + Q34
  Trust =~ Q29 + Q35 + Q36 + Q37
' #end of model

fit_cfa_0 <- cfa(cfa_model_0, data=mydata, estimator="MLR", mimic="Mplus")
summary(fit_cfa_0, fit.measures=TRUE, standardized=TRUE)

# Factors from literature = 9
cfa_model_1 <- ' #start of model
# latent variable definitions (common factors)
  PerfExp =~ Q10 + Q11 + Q12
  EffExp =~ Q13 + Q14 + Q15
  SocInf =~ Q16 + Q17 + Q18
  FacCond =~ Q19 + Q20 + Q21
  IntUse =~ Q22 + Q23 + Q24 + Q25
  Attitude =~ Q26 + Q27 + Q28
  Security =~ Q30 + Q31
  Privacy =~ Q32 + Q33 + Q34
  Trust =~ Q29 + Q35 + Q36 + Q37
' #end of model

fit_cfa_1 <- cfa(cfa_model_1, data=mydata, estimator="MLR", mimic="Mplus")
summary(fit_cfa_1, fit.measures=TRUE, standardized=TRUE)

# Factors from literature = 8
cfa_model_2 <- ' #start of model
# latent variable definitions (common factors)
  PerfExp =~ Q10 + Q11 + Q12
  EffExp =~ Q13 + Q14 + Q15
  SocInf =~ Q16 + Q17 + Q18
  FacCond =~ Q19 + Q20 + Q21
  IntUse =~ Q22 + Q23 + Q24 + Q25 + Q26 + Q27 + Q28
  Security =~ Q30 + Q31
  Privacy =~ Q32 + Q33 + Q34
  Trust =~ Q29 + Q35 + Q36 + Q37
' #end of model

# Latent variables = 8 (ordered by factor number)
# ML1 =~ Q19 + Q20
# ML2 =~ Q10 + Q22 + Q23 + Q24 + Q25
# ML3 =~ Q35 + Q36 + Q37
# ML4 =~ Q11 + Q12
# ML5 =~ Q32 + Q33 + Q34
# ML6 =~ Q26 + Q27 + Q28 + Q29 + Q30 + Q31
# ML7 =~ Q13 + Q14 + Q15
# ML8 =~ Q16 + Q17 + Q18 + Q19 + Q21

fit_cfa_2 <- cfa(cfa_model_2, data=mydata, estimator="MLR", mimic="Mplus")
summary(fit_cfa_2, fit.measures=TRUE, standardized=TRUE)

##################################################
# TESTING END
##################################################

#CFA Model
cfa_model_3 <- ' #start of model
# latent variable definitions (common factors)
  PerfExp =~ Q10 + Q11 + Q12
  EffExp =~ Q13 + Q14 + Q15
  SocInf =~ Q16 + Q17 + Q18
  FacCond =~ Q19 + Q20 + Q21
  IntUse =~ Q22 + Q23 + Q24
  Attitude =~ Q26 + Q27 + Q28
  Security =~ Q30 + Q31
  Privacy =~ Q32 + Q33 + Q34
  Trust =~ Q29 + Q35 + Q36 + Q37
# regressions
  SocInf ~ Trust
  Security ~ Privacy
  Trust ~ Privacy + Security
  PerfExp ~ SocInf + EffExp + Privacy + Trust
  IntUse ~ PerfExp + SocInf + FacCond + Security
' #end of model

fit_cfa_3 <- cfa(cfa_model_3, data=mydata)
summary(fit_cfa_3, fit.measures=TRUE, standardized=TRUE)
semPlot::semPaths(fit_cfa_3,"std", fade = F, residuals = F)

graph_sem(model = fit_cfa_3)

cfa_model_4 <- ' #start of model
# latent variable definitions (common factors)
  ImpactCV =~ Q2+Q3+Q4+Q10
  SafetyCV =~ Q5+Q6+Q7+Q8+Q9
  PerfExp =~ Q11+Q12
  EffExp =~ Q13+Q14
  SocInf =~ Q15+Q16
  FacCond =~ Q17+Q18
  IntUse =~ Q19+Q20
  Security =~ Q21+Q22+Q23
  Privacy =~ Q24+Q25
  Trust =~ Q26+Q27
# regressions
# F
  SafetyCV ~ ImpactCV
  SocInf ~ Trust
  Security ~ Privacy
  Trust ~ ImpactCV + Privacy + Security
  PerfExp ~ SocInf + EffExp + Trust
  IntUse ~ PerfExp + SafetyCV + FacCond + Security
' #end of model

fit_cfa_4 <- cfa(cfa_model_4 , data=mydata)
summary(fit_cfa_4, fit.measures=TRUE, standardized=TRUE)
semPlot::semPaths(fit_cfa_4,"std", fade = F, residuals = F)
