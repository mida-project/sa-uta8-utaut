#!/usr/bin/env Rscript

library(readxl)
library(lavaan)
library(corrplot)
library(psych)
library(semTools)
library(metaSEM)
library(dplyr)
library(likert)
library(nFactors)
library(reshape)

RadiomicsMod <- read_excel("../data/Radiomics_moderators.xlsx")

moddata <- RadiomicsMod[c(1,2,3,4,5,6,7,8,9,
                          10,11,12,13,14,15,
                          16,17,18,19,20,21,
                          22,23,24,25,26,27,
                          28,29,30,31,32,33,
                          34,35,36,37,38,39,
                          40,41,42)]

cfa_model_mods <- ' #start of model
# latent variable definitions (common factors)
  Impact =~ Q02+Q04
  Guidance =~ Q05+Q06+Q08+Q09
  PerfExp =~ Q10+Q11+Q12
  EffExp =~ Q13+Q14+Q15
  SocInf =~ Q16+Q17+Q18
  FacCond =~ Q19+Q20+Q21
  IntUse =~ Q22+Q23+Q24+Q25
  Security =~ Q29+Q30+Q31
  Risk =~ Q32+Q33+Q34
  Trust =~ Q35+Q36+Q37
# correlated errors
  Impact ~~ Impact
  Guidance ~~ Guidance
  PerfExp ~~ PerfExp
  EffExp ~~ EffExp
  SocInf ~~ SocInf
  FacCond ~~ FacCond
  IntUse ~~ IntUse
  Security ~~ Security
  Risk ~~ Risk
  Trust ~~ Trust
' #end of model

fit_cfa_mods <- cfa(cfa_model_mods, data=moddata)
summary(fit_cfa_mods, fit.measures=TRUE, standardized=TRUE)

inspect(fit_cfa_mods, "rsquare")
inspect(fit_cfa_mods, "cor.lv")

miPowerFit(fit_cfa_mods, stdLoad = 0.4, cor = 0.1, stdBeta = 0.1,
           intcept = 0.2, stdDelta = NULL, delta = NULL, cilevel = 0.9)

#Group by Gender
fit_cfa_gender_1 <- cfa(cfa_model_mods,
                        data = moddata,
                        group = "gender")
fit_cfa_gender_2 <- cfa(cfa_model_mods,
                        data = moddata,
                        group = "gender",
                        group.equal = "loadings")
fit_cfa_gender_3 <- cfa(cfa_model_mods,
                        data = moddata,
                        group = "gender",
                        group.equal = c("intercepts", "loadings"))
lavTestLRT(fit_cfa_gender_1, fit_cfa_gender_2, fit_cfa_gender_3)
summary(fit_cfa_gender_1, fit.measures = TRUE, standardized = TRUE)
measurementInvariance(model = cfa_model_mods,data = moddata, group = "gender")

#Group by Age
fit_cfa_age_1 <- cfa(cfa_model_mods,
                     data=moddata,
                     group="age",
                     estimator = "WLSMV")
fit_cfa_age_2 <- cfa(cfa_model_mods,
                     data=moddata,
                     group="age",
                     estimator = "WLSMV",
                     group.equal = "loadings")
fit_cfa_age_3 <- cfa(cfa_model_mods,
                     data=moddata,
                     group="age",
                     estimator = "WLSMV",
                     group.equal = c("intercepts", "loadings"))
summary(fit_cfa_age_1, fit.measures=TRUE, standardized=TRUE)

compareFit(fit_cfa_age_1, fit_cfa_age_2)
compareFit(fit_cfa_age_2, fit_cfa_age_3)

lavTestLRT(fit_cfa_age_1, fit_cfa_age_2, fit_cfa_age_3)

anova(fit_cfa_age_1, fit_cfa_age_2, fit_cfa_age_3)

lavTestScore(fit_cfa_age_2)

fitMeasures(fit_cfa_age_1, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")
fitMeasures(fit_cfa_age_2, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")
fitMeasures(fit_cfa_age_3, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")

#Group by Nationality
fit_cfa_nat_1 <- cfa(cfa_model_mods,
                     data=moddata,
                     estimator="WLSMV",
                     group="nationality")
fit_cfa_nat_2 <- cfa(cfa_model_mods,
                     data=moddata,
                     estimator="WLSMV",
                     group="nationality",
                     group.equal="loadings")
fit_cfa_nat_3 <- cfa(cfa_model_mods,
                     data=moddata,
                     estimator="WLSMV",
                     group="nationality",
                     group.equal = c("intercepts", "loadings"))
lavTestLRT(fit_cfa_nat_1, fit_cfa_nat_2, fit_cfa_nat_3)
summary(fit_cfa_nat_1, fit.measures=TRUE, standardized=TRUE)
fitMeasures(fit_cfa_nat_1, c("chisq",
                       "df",
                       "cfi",
                       "rmsea",
                       "srmr",
                       "agfi",
                       "gfi",
                       "tli"),
            output = "matrix")
measurementInvariance(model=cfa_model_mods,data=moddata,
                      group="nationality")

fitMeasures(fit_cfa_nat_1, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")
fitMeasures(fit_cfa_nat_2, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")
fitMeasures(fit_cfa_nat_3, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")

#Group by Education
fit_cfa_edu_1 <- cfa(cfa_model_mods,
                     data = moddata,
                     estimator = "WLSMV",
                     group = "education")
fit_cfa_edu_2 <- cfa(cfa_model_mods,
                     data = moddata,
                     estimator = "WLSMV",
                     group = "education",
                     group.equal = "loadings")
fit_cfa_edu_3 <- cfa(cfa_model_mods,
                     data = moddata,
                     estimator = "WLSMV",
                     group="education",
                     group.equal = c("intercepts", "loadings"))
lavTestLRT(fit_cfa_edu_1, fit_cfa_edu_2, fit_cfa_edu_3)

summary(fit_cfa_edu_1, fit.measures=TRUE, standardized=TRUE)
measurementInvariance(model = cfa_model_mods,
                      data = moddata,
                      group = "education")

fitMeasures(fit_cfa_edu_1,
            c("chisq",
              "df",
              "pvalue",
              "cfi",
              "tli",
              "rmsea",
              "srmr"),
            output = "text")
fitMeasures(fit_cfa_edu_2,
            c("chisq",
              "df",
              "pvalue",
              "cfi",
              "tli",
              "rmsea",
              "srmr"),
            output = "text")
fitMeasures(fit_cfa_edu_3,
            c("chisq",
              "df",
              "pvalue",
              "cfi",
              "tli",
              "rmsea",
              "srmr"),
            output = "text")

#Group by Knowledge
fit_cfa_knw_1 <- cfa(cfa_model_mods,
                     data = moddata,
                     estimator = "WLSMV",
                     group = "knowledge")
fit_cfa_knw_2 <- cfa(cfa_model_mods,
                     data = moddata,
                     estimator = "WLSMV",
                     group = "Local",
                     group.equal = "loadings")
fit_cfa_knw_3 <- cfa(cfa_model_mods,
                     data = moddata,
                     estimator = "WLSMV",
                     group = "Local",
                     group.equal = c("intercepts", "loadings"))
lavTestLRT(fit_cfa_knw_1, fit_cfa_knw_2, fit_cfa_knw_3)

summary(fit_cfa_knw_1, fit.measures=TRUE, standardized=TRUE)
measurementInvariance(model = cfa_model_mods,
                      data=moddata,
                      group = "Local")

fitMeasures(fit_cfa_knw_1, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")
fitMeasures(fit_cfa_knw_2, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")
fitMeasures(fit_cfa_knw_3, c("chisq",
                             "df",
                             "pvalue",
                             "cfi",
                             "tli",
                             "rmsea",
                             "srmr"),
            output = "text")

######################################################
######################################################
######################################################