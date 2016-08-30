MuMIn包: https://cran.r-project.org/web/packages/MuMIn/MuMIn.pdf

install.packages("MuMIn")#裝package
library(MuMIn)
df <- mtcars[,c("mpg","cyl","disp","hp","wt")]  # subset of mtcars
full.model <- lm(mpg ~ cyl+disp+hp+wt,df)       # model for predicting mpg
options(na.action = "na.fail")#利用na.action去控制遺失值
a=dredge(full.model)

a

