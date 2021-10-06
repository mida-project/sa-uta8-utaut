library(readxl)
library(lavaan)
library(corrplot)
library(psych)
library(semTools)
library(metaSEM)
library(dplyr)
library(likert)
library(nFactors)

# Plot the likert dataset
RadiomicsLikert <- read_excel("../data/Radiomics.xlsx")
names(RadiomicsLikert)<-c("Q01","Q02","Q03","Q04","Q05",
                          "Q06","Q07","Q08","Q09","Q10",
                          "Q11","Q12","Q13","Q14","Q15",
                          "Q16","Q17","Q18","Q19","Q20",
                          "Q21","Q22","Q23","Q24","Q25",
                          "Q26","Q27","Q28","Q29","Q30",
                          "Q31","Q32","Q33","Q34","Q35",
                          "Q36","Q37")
mydata.likert <- likert(as.data.frame(lapply(RadiomicsLikert,as.factor)))

summary(mydata.likert)
plot(mydata.likert, ordered=FALSE, order=names(mydata.likert))

#Check the data
pairs.panels(RadiomicsLikert)
corPlot(RadiomicsLikert)

#Calculate the correlation matrix
corMat <- cor(RadiomicsLikert)
print(corMat)

# Pricipal Components Analysis
# entering raw data and extracting PCs 
# from the correlation matrix 
fit_PCA <- princomp(RadiomicsLikert, cor=TRUE)
summary(fit_PCA) # print variance accounted for
loadings(fit_PCA) # pc loadings
plot(fit_PCA,type="lines") # scree plot
fit_PCA$scores # the principal components
biplot(fit_PCA)
print(fit_PCA, digits=2, cutoff=.4)

# Determine Number of Factors to Extract
ev <- eigen(cor(RadiomicsLikert)) # get eigenvalues
ap <- parallel(subject=nrow(RadiomicsLikert),var=ncol(RadiomicsLikert),
               rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)

# Maximum Likelihood Factor Analysis
# entering raw data and extracting 8 factors, 
# with varimax rotation 
fit_ML <- factanal(RadiomicsLikert, 8, fm = "ml", rotation="varimax", scores="regression")
print(fit_ML, digits=2, cutoff=.4)


#Visualize results
loadings <- fit_ML$loadings[,1:8]

loadings.m <- melt(loadings, id="", 
                   measure=c("Factor 1", "Factor 2", "Factor 3",
                             "Factor 4", "Factor 5", "Factor 6",
                             "Factor 7", "Factor 8"),
                   variable.name="Factor", value.name="Loading")

colnames(loadings.m)[1] <- "Test"
colnames(loadings.m)[2] <- "Factor"

ggplot(loadings.m, aes(Test, abs(Loading), fill=Loading)) + 
  facet_wrap(~ Factor, nrow=1) + #place the factors in separate facets
  geom_bar(stat="identity") + #make the bars
  coord_flip() + #flip the axes so the test names can be horizontal  
  #define the fill color gradient: blue=positive, red=negative
  scale_fill_gradient2(name = "Loading", 
                       high = "blue", mid = "white", low = "red", 
                       midpoint=0, guide="none") +
  ylab("Loading Strength") + #improve y-axis label
  theme_bw(base_size=10) #use a black-and-white theme with set font size

corrs <- fit_ML$correlation
corrs.m <- melt(corrs, id="Test", variable.name="Test2", value.name="Correlation")

colnames(corrs.m)[1] <- "Test"
colnames(corrs.m)[2] <- "Test2"

#place the tests on the x- and y-axes, 
#fill the elements with the strength of the correlation
p1 <- ggplot(corrs.m, aes(Test2, Test, fill=abs(Correlation))) + 
  geom_tile() + #rectangles for each correlation
  #add actual correlation value in the rectangle
  geom_text(aes(label = round(Correlation, 2)), size=2.5) + 
  theme_bw(base_size=10) + #black and white theme with set font size
  #rotate x-axis labels so they don't overlap, 
  #get rid of unnecessary axis titles
  #adjust plot margins
  theme(axis.text.x = element_text(angle = 90), 
        axis.title.x=element_blank(), 
        axis.title.y=element_blank(), 
        plot.margin = unit(c(3, 1, 0, 0), "mm")) +
  #set correlation fill gradient
  scale_fill_gradient(low="white", high="red") + 
  guides(fill="none") #omit unnecessary gradient legend

p2 <- ggplot(loadings.m, aes(Test, abs(Loading), fill=Factor)) + 
  geom_bar(stat="identity") + coord_flip() + 
  ylab("Loading Strength") + theme_bw(base_size=10) + 
  #remove labels and tweak margins for combining with the correlation matrix plot
  theme(axis.text.y = element_blank(), 
        axis.title.y = element_blank(), 
        plot.margin = unit(c(3,1,39,-3), "mm"))
grid.arrange(p1, p2, ncol=2, widths=c(2, 1)) #side-by-side, matrix gets more space


#Read Data
mydata <- RadiomicsLikert

cfa_model <- ' #start of model
# latent variable definitions (common factors)
  AdoptAISys =~ Q05+Q06+Q08+Q09
  PerfExp =~ Q10+Q11+Q12
  EffExp =~ Q13+Q14+Q15
  SocInf =~ Q16+Q17+Q18
  FacCond =~ Q19+Q20+Q21
  IntUse =~ Q22+Q23+Q24+Q25
  Security =~ Q29+Q30+Q31
  Privacy =~ Q32+Q33+Q34
  Trust =~ Q35+Q36+Q37
# regressions
  Security ~ Privacy + SocInf + AdoptAISys
  Trust ~  AdoptAISys + Privacy + Security
  EffExp ~ SocInf + FacCond + Trust
  PerfExp ~ SocInf + EffExp + Privacy + Trust
  IntUse ~ PerfExp + FacCond + Security + AdoptAISys
' #end of model

#Calculate the correlation matrix
corMat <- cor(mydata)
print(corMat)

#Performan CFA
fit_cfa <- cfa(cfa_model, data=mydata)
summary(fit_cfa, fit.measures=TRUE, standardized=TRUE)
#Compute relability
reliability(fit_cfa)
#Compute Discriminant Validity
htmt(cfa_model, data=mydata)
#Compute fit measures
fitMeasures(fit_cfa, c("chisq", "df", "pvalue", "cfi", "nfi", "agfi", "tli", "rmsea", "srmr"),
            output = "text")
discriminantValidity(fit_cfa, cutoff = 0.9, merge = FALSE, level = 0.95)

inspect(fit_cfa, "rsquare" )
inspect(fit_cfa, "cor.lv")

# Extract the standardized loading matrix
loadMatrix <- inspect(fit_cfa, "std")$lambda

# Clear the zero loadings
loadMatrix[loadMatrix==0] <- NA

# Calculate mean squared loadings (i.e. AVEs)
apply(loadMatrix^2,2,mean, na.rm = TRUE)

htmt(fit_cfa, mydata)



miPowerFit(fit_cfa, stdLoad = 0.4, cor = 0.1, stdBeta = 0.1,
           intcept = 0.2, stdDelta = NULL, delta = NULL, cilevel = 0.9)

calEffSizes(model=cfa_model, n=mydata.n, Cov=mydata.cor, lavaan.output=FALSE)


mydata2 <- MadeiraSafeAgo[c(3,4,5,52,54,26,27,28,30,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51)]

#Group by Age
fit_cfa_age_1 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Age2")
fit_cfa_age_2 <- cfa(cfa_model, data=mydata2, group="Age2", estimator = "WLSMV", group.equal = "loadings")
fit_cfa_age_3 <- cfa(cfa_model, data=mydata2, group="Age2", estimator = "WLSMV", group.equal = c("intercepts", "loadings"))
summary(fit_cfa_age_1, fit.measures=TRUE, standardized=TRUE)

compareFit(fit_cfa_age_1, fit_cfa_age_2)
compareFit(fit_cfa_age_2, fit_cfa_age_3)

lavTestLRT(fit_cfa_age_1, fit_cfa_age_2, fit_cfa_age_3)

anova(fit_cfa_age_1, fit_cfa_age_2, fit_cfa_age_3)

lavTestScore(fit_cfa_age_2)

fitMeasures(fit_cfa_age_1, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_age_2, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_age_3, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")

#Group by Gender
fit_cfa_gender_1 <- cfa(cfa_model, data=mydata2, group="Gender")
fit_cfa_gender_2 <- cfa(cfa_model, data=mydata2, group="Gender", group.equal = "loadings")
fit_cfa_gender_3 <- cfa(cfa_model, data=mydata2, group="Gender", group.equal = c("intercepts", "loadings"))
lavTestLRT(fit_cfa_gender_1, fit_cfa_gender_2, fit_cfa_gender_3)
summary(fit_cfa_gender_1, fit.measures=TRUE, standardized=TRUE)
measurementInvariance(model=cfa_model,data=mydata2, group="Gender")
fitMeasures(fit_cfa_gender_1, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_gender_2, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_gender_3, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")

#Group by Nationality
fit_cfa_nac_1 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Nat2")
fit_cfa_nac_2 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Nat2", group.equal = "loadings")
fit_cfa_nac_3 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Nat2", group.equal = c("intercepts", "loadings"))
lavTestLRT(fit_cfa_nac_1, fit_cfa_nac_2, fit_cfa_nac_3)
summary(fit_cfa, fit.measures=TRUE, standardized=TRUE)
fitMeasures(fit_cfa, c("chisq","df","cfi","rmsea","srmr","agfi","gfi","tli"), output = "matrix")
measurementInvariance(model=cfa_model,data=mydata2, group="Nat2")

fitMeasures(fit_cfa_nac_1, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_nac_2, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_nac_3, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")

#Group by Regularity
fit_cfa_reg_1 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Local")
fit_cfa_reg_2 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Local", group.equal = "loadings")
fit_cfa_reg_3 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Local", group.equal = c("intercepts", "loadings"))
lavTestLRT(fit_cfa_reg_1, fit_cfa_reg_2, fit_cfa_reg_3)

summary(fit_cfa_reg_1, fit.measures=TRUE, standardized=TRUE)
measurementInvariance(model=cfa_model,data=mydata2, group="Local")

fitMeasures(fit_cfa_reg_1, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_reg_2, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_reg_3, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")

#Group by Education
fit_cfa_edu_1 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Edu2")
fit_cfa_edu_2 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Edu2", group.equal = "loadings")
fit_cfa_edu_3 <- cfa(cfa_model, data=mydata2, estimator = "WLSMV", group="Edu2", group.equal = c("intercepts", "loadings"))
lavTestLRT(fit_cfa_edu_1, fit_cfa_edu_2, fit_cfa_edu_3)

summary(fit_cfa, fit.measures=TRUE, standardized=TRUE)
measurementInvariance(model=cfa_model,data=mydata2, group="Edu2")

fitMeasures(fit_cfa_edu_1, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_edu_2, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")
fitMeasures(fit_cfa_edu_3, c("chisq", "df", "pvalue", "cfi", "tli", "rmsea", "srmr"),
            output = "text")

cfa_model <- ' #start of model
# latent variable definitions (common factors)
  ImpactCV =~ Q2+Q3+Q4
  SafetyCV =~ Q6+Q8+Q9
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
  Security ~ Privacy + SocInf + SafetyCV
  Trust ~ ImpactCV + Privacy + Security
  EffExp ~ SocInf + FacCond + Trust
  PerfExp ~ SocInf + EffExp + Privacy + Trust
  IntUse ~ PerfExp + FacCond + Security + SafetyCV
' #end of model

fit_cfa_3 <- cfa(cfa_model_3, data=mydata3)
summary(fit_cfa_3, fit.measures=TRUE, standardized=TRUE)
reliability(fit_cfa_3)
fitted(fit_cfa_3)
