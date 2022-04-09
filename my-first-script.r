library(tidyverse)
library(dslabs)
data(murders)

print("Hello")


murders %>%
    ggplot(aes(population, total, label = abb, color = region)) +
    geom_label()



print("There")
