a <- available.packages()
head(rownames(a), 3)

install.packages("ggplot2")
install.packages("devtools")

library(ggplot2)
search()

library(devtools)
find_rtools()

install.packages("KernSmooth")

library(KernSmooth)