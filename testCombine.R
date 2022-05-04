# Temp file to test.
# 
# Author: HBossier
###############################################################################


## COMMENTS

#Within `ggsurvplot()` it is possible to set the color and linetype as a 
# string --> pointing to a column in the dataset to plot by a grouping variable. 
#To combine different survfit objects (e.g. when looking at multiple endpoints)
# one could use `ggsurvplot_combine()`.  

library(survival)
# Create a demo data set
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set.seed(123)
demo.data <- data.frame(
    os.time = colon$time,
    os.status = colon$status,
    pfs.time = sample(colon$time),
    pfs.status = colon$status,
    sex = colon$sex, rx = colon$rx, adhere = colon$adhere
)
demo.data <- subset(demo.data, rx %in% c('Lev', 'Lev+5FU'))

# Combine survival curves stratified by treatment assignment rx
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# Fit
pfs <- survfit( Surv(pfs.time, pfs.status) ~ rx, data = demo.data)
os <- survfit( Surv(os.time, os.status) ~ rx, data = demo.data)
# Combine on the same plot
fit <- list(PFS = pfs, OS = os)
ggsurvplot_combine(fit, demo.data, censor = FALSE, color = 'arm', linetype = 'endpoint')

head(demo.data)
survminer::ggsurvplot_combine(fit, demo.data, censor = FALSE, color = 'arm', linetype = 'endpoint')

