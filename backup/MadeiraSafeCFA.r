library(parameters)
library(readxl)
library(psychTools)
library(GGally)
library(psych)
library(tidySEM)

#Read Data
MadeiraSafeAgo <- read_excel("Desktop/MadeiraSafeAgo.xlsx")
mydata <- MadeiraSafeAgo[c(21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47)]

#Check the data
pairs.panels(mydata)
corPlot(mydata)

#Calculate the correlation matrix
corMat <- cor(mydata)
print(corMat)

#Run the Factor Analsis
fit_efa <- fa(mydata,10,fm="ml" ,rotate="oblimin")
print(fit_efa, digits=2, cutoff=.3)

model1 <- convert_efa_to_cfa(fit_efa, threshold = 0.3)
print(model1)

#CFA Model

cfa_model_3 <- ' #start of model
# latent variable definitions (common factors)
  ImpactCV =~ Q1+Q2+Q3+Q4+Q10
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
  SafetyCV ~ ImpactCV
  SocInf ~ Trust
  Security ~ Privacy
  Trust ~ ImpactCV + Privacy + Security
  PerfExp ~ SocInf + EffExp + Privacy + Trust
  IntUse ~ PerfExp + SocInf + SafetyCV + FacCond + Security
' #end of model

fit_cfa_3 <- cfa(cfa_model_3, data=mydata)
summary(fit_cfa_3, fit.measures=TRUE, standardized=TRUE)
semPlot::semPaths(fit_cfa_3,"std", fade = F, residuals = F)

graph_sem(model = fit_cfa_3)


cfa_model_4 <- ' #start of model
# latent variable definitions (common factors)
 ImpactCV =~ Q1+Q2+Q3+Q4+Q10
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
  F
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
