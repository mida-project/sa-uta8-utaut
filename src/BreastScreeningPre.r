library(corpcor);
library(GPArotation);
library(psych)
library(nFactors)
library(FactoMineR)
library(writexl)
library(parameters)
library(readxl)
library(reshape2)
library(grid) #for adjusting plot margins
library(gridExtra) #for combining the two plots

library(ggplot2)
library(corrplot) #plotting correlation matrices
library(lavaan) #for fitting structural equation models
library(semPlot) #for automatically making diagrams
library(MVN)

# alterar a lista para correr da 10 a 37...
# tentar introd. um novo factor com os loadings maiores
#Read Data
SimplePlm <- read_excel("../data/simple_200.xlsx")
mydata <- SimplePlm[c(10,11,12,13,
                      14,15,16,17,
                      18,19,20,21,
                      22,23,24,25,
                      26,27,28,29,
                      30,31,32,33,
                      34,35,36,37)]

#Check the data
pairs.panels(mydata)
corPlot(mydata)

#Calculate the correlation matrix
corMat <- cor(mydata)
print(corMat)

# Pricipal Components Analysis (PCA)
# entering raw data and extracting PCs 
# from the correlation matrix
# We run a PCA to determine the number
# of facors.
fit_PCA <- princomp(mydata, cor=TRUE)
# The summary purpose is to see exactly
# which components might be intersting.
# In this case, we want to look at the
# "Proportion of Variance" and try to
# understand how much percentage each
# component is explaining of the variance.
summary(fit_PCA) # print variance accounted for
plot(fit_PCA) # plot the PCA
loadings(fit_PCA) # pc loadings
plot(fit_PCA,type="lines") # scree plot
fit_PCA$scores # the principal components
biplot(fit_PCA)

##################################################
# PARALLEL ANALYSIS 2
##################################################

# parallel analysis -> number of factors
pfa = fa.parallel(mydata, fm="ml", fa="fa")

# eigenvalues (kaiser) -> how many over ~0.50?
pfa$fa.values

##################################################
# PARALLEL END
##################################################

##################################################
# TESTING START
##################################################
# Based on the summary it appears 3 components
# (i.e., Variances >= 2) exist.
# However, the next analysis should have the
# factor loadings > 0.50 for acceptance.
# factanal requires...
# dataset: simple_200
# factors: 3
# rotation: varimax (default)
fit_t001 <- factanal(mydata, 3,
                     rotation="promax")
print(fit_t001, digits=2, cutoff=.3)

# Run this again with 2 factors to see if this
# is sufficient.
fit_t002 <- factanal(mydata, 2,
                     rotation="promax")
print(fit_t002, digits=2, cutoff=.3)

# Try hard with more factors to see if we can
# increase the number of factors.
fit_t003 <- factanal(mydata, 7,
                     rotation="promax")
print(fit_t003, digits=2, cutoff=.3)

# Although the summary results are
# representing 3 components, the factor
# loadings > 0.50 can be represented by
# 8 components. Thus, it seems that we can
# represent our EFA with 8 components instead
# of only 3 components.
fit_t004 <- factanal(mydata,
                     8,
                     rotation="promax")
print(fit_t004, digits=2, cutoff=.3)

# FAIL -> some loadings are < 0.50
fit_t005 <- factanal(mydata,
                     9,
                     rotation="varimax",
                     scores="regression")
head(fit_t005$scores)
print(fit_t005, digits=2, cutoff=.3)

##################################################
# TESTING END
##################################################

# Maximum Likelihood Factor Analysis
# entering raw data and extracting 10 factors, 
# with promax rotation
fit_ML <- factanal(mydata, 10, fm = "ml",
                   rotation="promax", scores="regression")
print(fit_ML, digits=2, cutoff=.3)

SimplePlm <- cbind(SimplePlm, fit_ML$scores)# plot factor 1 by factor 2
loadings <- fit_ML$loadings[,1:10]
plot(loadings,type="n") # set up plot
text(loadings,labels=names(mydata),cex=.7) # add variable names

# Determine Number of Factors to Extract
ev <- eigen(cor(mydata)) # get eigenvalues
ap <- parallel(subject=nrow(mydata),var=ncol(mydata),
               rep=100,cent=0.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)

# Visualize results

loadings <- fit_ML$loadings[,1:7]

# Quetion: why 7 factors?

loadings.m <- melt(loadings,
                   id="", 
                   measure=c("Factor 1", "Factor 2", "Factor 3",
                             "Factor 4", "Factor 5", "Factor 6",
                             "Factor 7"),
                   variable.name="Factor",
                   value.name="Loading")

# encontrar alguem que tenha escrito sobre a UTAUT a fundamentar a Exp.

# Note: for each factor, try to regulate from the p-value.
# just do the plot of the p-value for each Factor 1, ..., Factor 10
# extract the best ones, F4, F5, F6.
# For each F of the previous Factor, try to observe the engagement
# of each variable.

colnames(loadings.m)[1] <- "Test"
colnames(loadings.m)[2] <- "Factor"

ggplot(loadings.m, aes(Test, abs(Loading), fill=Loading)) + 
  facet_wrap(~ Factor, nrow=1) + #place the factors in separate facets
  geom_bar(stat="identity") + #make the bars
  coord_flip() + #flip the axes so the test names can be horizontal  
  #define the fill color gradient: blue=positive, red=negative
  scale_fill_gradient2(name = "Loading", 
                       high = "blue", mid = "white", low = "red", 
                       midpoint=0, guide=F) +
  ylab("Loading Strength") + #improve y-axis label
  theme_bw(base_size=10) #use a black-and-white theme with set font size

corrs <- fit_ML$correlation
corrs.m <- melt(corrs, id="Test",
                variable.name="Test2", value.name="Correlation")

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
  guides(fill=F) #omit unnecessary gradient legend

p2 <- ggplot(loadings.m, aes(Test, abs(Loading), fill=Factor)) + 
  geom_bar(stat="identity") + coord_flip() + 
  ylab("Loading Strength") + theme_bw(base_size=10) + 
  #remove labels and tweak margins for combining with
  # the correlation matrix plot
  theme(axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        plot.margin = unit(c(3,1,39,-3), "mm"))
#side-by-side, matrix gets more space
grid.arrange(p1, p2, ncol=2, widths=c(2, 1))
