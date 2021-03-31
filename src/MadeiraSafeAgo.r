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


library(psych)
library(ggplot2)
library(corrplot) #plotting correlation matrices
library(lavaan)  #for fitting structural equation models
library(semPlot)  #for automatically making diagrams 
library(MVN)

#Read Data
MadeiraSafeSet <- read_excel("Desktop/MadeiraSafeSet.xlsx")
mydata <- MadeiraSafeSet[c(27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59)]

#Check the data
pairs.panels(mydata)
corPlot(mydata)

#Calculate the correlation matrix
corMat <- cor(mydata)
print(corMat)

# Pricipal Components Analysis
# entering raw data and extracting PCs 
# from the correlation matrix 
fit_PCA <- princomp(mydata, cor=TRUE)
summary(fit_PCA) # print variance accounted for 
loadings(fit_PCA) # pc loadings 
plot(fit_PCA,type="lines") # scree plot 
fit_PCA$scores # the principal components
biplot(fit_PCA)

# Maximum Likelihood Factor Analysis
# entering raw data and extracting 6 factors, 
# with varimax rotation 
fit_ML <- factanal(mydata, 10, fm = "ml", rotation="promax", scores="regression")
print(fit_ML, digits=2, cutoff=.3)

MadeiraSafeAgo <- cbind(MadeiraSafeAgo, fit$scores)# plot factor 1 by factor 2 
loadings <- fit_ML$loadings[,1:7] 
plot(load,type="n") # set up plot 
text(load,labels=names(mydata),cex=.7) # add variable names

# Determine Number of Factors to Extract
ev <- eigen(cor(mydata)) # get eigenvalues
ap <- parallel(subject=nrow(mydata),var=ncol(mydata),
               rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)


#Visualize results

loadings <- fit_ML$loadings[,1:7] 

loadings.m <- melt(loadings, id="", 
                   measure=c("Factor 1", "Factor 2", "Factor 3", 
                             "Factor 4", "Factor 5", "Factor 6", "Factor 7"), 
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
                       midpoint=0, guide=F) +
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
  guides(fill=F) #omit unnecessary gradient legend

p2 <- ggplot(loadings.m, aes(Test, abs(Loading), fill=Factor)) + 
  geom_bar(stat="identity") + coord_flip() + 
  ylab("Loading Strength") + theme_bw(base_size=10) + 
  #remove labels and tweak margins for combining with the correlation matrix plot
  theme(axis.text.y = element_blank(), 
        axis.title.y = element_blank(), 
        plot.margin = unit(c(3,1,39,-3), "mm"))
grid.arrange(p1, p2, ncol=2, widths=c(2, 1)) #side-by-side, matrix gets more space
