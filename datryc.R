########## Library
library(copula)
##################################################################################################################
# global model data
.Mod<- list()
.Mod$names<- c("clayton_#1"
               ,"independent"
               ,"ali_mikhail_haq_#3"
               ,"gumbel_hougaard_#4"
               ,"frank_#5"
               ,"joe_#6"
               ,"nelsen_#12"  #7
               ,"nelsen_#13"  #8
)
.Mod$npar<- c(1,0,rep(1,8))   # number of model parameters
.Mod$intl<- list( 0.01            #clayton_#1       #lower bounds
                  , NULL             #independent
                  , 0.0             #ali_mikhail_haq_#3
                  , 1.0             #gener gumbel_hougaard_#4
                  , 0.0             #frank_#5
                  , 1.0             #joe_#6
                  , 1.0             #7 nelsen_#12
                  , 1.0             #8 nelsen_#13
)

.Mod$intu<- list( 100.0         #clayton_#1       #upper bounds
                  , NULL           #independent
                  , 0.99           #ali_mikhail_haq_#3
                  , 100.0          #gumbel_hougaard_#4
                  , 200.0          #frank_#5
                  , 100.0          #joe_#6
                  , 100.0          #7 nelsen_#12
                  , 100.0          #8 nelsen_#13
)

.Mod$spar<- list( 2.0            #clay_#1       #Start values of the parameter
                  , NULL         #independent
                  , 0.5          #ali_mikhail_haq_#3
                  , 2.0          #gumbel_hougaard_#4
                  , 2.0          #frank_#5
                  , 2.0          #joe_#6
                  , 2.0          #7 nelsen_#12
                  , 2.0          #8 nelsen_#13
)
.Modgridpl<- 0.01   #Rastergrenzen für die alpha-Potenzen
.Modgridpu<- 0.99
##################################################################################################################
# 


## read the data table from csv-file
dpath<- ...  #path of data file
dname<- .... #name of data file
xdat <- read.csv2(dpath+dname,header=TRUE,skip=0,dec=".")

#*********************************
#*    marginal distributions
#  providing the data: choose one trait
x0<- na.omit(xdat[c('RSR', 'species','class')]) # remove missing data
x0<- na.omit(xdat[c('SLA', 'species','class')]) # remove missing data
x0<- na.omit(xdat[c('RCNC', 'species','class')]) # remove missing data
x0<- na.omit(xdat[c('LCNC', 'species','class')]) # remove missing data
x0<- na.omit(xdat[c('HW_Ratio', 'species','class')]) # remove missing data

#*** choose herb or grass
x0<- subset(x0,class=="herb")
x0<- subset(x0,class=="grass")


n<- length(x0[,2])  #number of sample items
k<- length(x0[1,])  #number of variables

lspec<-as.list(attributes(factor(x0[,2]))$levels) #list of species
ns<- length(lspec)  # number of species

xmed<- aggregate(x0[,1], list(x0[,2]), median)  #medians of the species

