# do not forget to set workdir to sourcedir

# imports
library(ggplot2)

# load csv file
# format is N;Time;Tag
# N    ... Array size whereas the array contains all integer values from 2 to N
# Time ... Duration of the computation in microseconds
# Tag  ... Computation took place in parallel or sequential
pbench  <- read.csv("./pbench_5000_10000_500_50.csv", sep=";")

# convert N to factor
pbench$N <- as.factor(pbench$N)

# convert Time to milliseconds since numbers are unpleasantly big
pbench$Time <- pbench$Time / 1000

# define color palette for plot
fillcolors <- c("#B00C36", "#F89C0E")

# generate plot
plot <- ggplot(pbench, aes(x=N, y=Time, fill=Tag)) +
  ggtitle("Finding primes between 2 and N") +
  theme_bw() +
  theme(legend.justification=c(0,1), legend.position=c(0,1)) +
  scale_fill_manual(values=fillcolors) +
  geom_boxplot(position="identity") +
  ylab("Time (ms)") +
  labs(fill="Algorithm")

# show plot
plot
