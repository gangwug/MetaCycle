This repository contains the ongoing development version of MetaCycle. 

## Introduction
MetaCycle is an R package for evaluating periodicity in large scale time-series datasets. This package provides two functions-
**meta2d** and **meta3d**. For analyzing time-series datasets without individual information, **meta2d** is suggested, 
which incorporates [ARSER](https://github.com/cauyrd/ARSER), [JTK_CYCLE](http://openwetware.org/wiki/HughesLab:JTK_Cycle) and
[Lomb-Scargle](http://research.stowers-institute.org/efg/2005/LombScargle/) in the detection of interested rhythms. For analyzing 
time-series datasets with individual information, **meta3d** is suggested, which takes use of any one of these three methods to 
analyze time-series data individual by individual and gives out integrated values based on analysis result of each individual.

## Installation
Use **devtools** to install this version from Github:

```r
# install 'devtools' in R(>3.0.2)
install.packages("devtools")
# install MetaCycle
devtools::install_github('gangwug/MetaCycle')
```

## Usage
```r
library(MetaCycle)
# see detail introduction and associated application examples about meta2d or meta3d
?meta2d
?meta3d
```

## License
This package is free and open source software, licensed under GPL(>= 2).

## Important notes
If using MetaCycle on both the newest R version (3.6.1 released on 2019-07-05) and older R versions, please run the below command before running MetaCycle when ARSER is selected. There were some changes in R 3.6.0 related to how sample() works, which will affect the ARSER performance. Please be cautious that there may be minor differences for the output results of MetaCycle running on R 3.6.1 comparing to older R versions.

```r
RNGkind(sample.kind = "Rounding")
```

## Update news
MetaCycle 1.2.0 was released in [CRAN](https://cran.r-project.org/web/packages/MetaCycle/index.html), which supports parallel analysis (except on Windows system), and can accept input data frame in addition to input files.

We prepared the new [Vignettes](https://cran.r-project.org/web/packages/MetaCycle/vignettes/implementation.html), includding several new sections(**Pros and Cons of meta2d methods**, **Method selection based on the sampling pattern** and **Notes on the Fisher’s method**).

Next, we will try to make the parallel analysis works on the Windows system, and find a better way (beautiful in theory and powerful in practice) of integrating multiple p-values.

## Reported issues from MetaCycle users
#### Input and output data frame (tibble data does not work well in this version) instead of using file name. 

Currently, it needs to set value to 'infile' and 'filestyle'. The 'timepoints' need to be a numeric vector instead of 'Line1'. This is not user-friendly.

```r
testD <- read.csv("example.csv")
timev <- 1:10
outD <- meta2d(infile="csv", filestyle="csv", timepoints = timev, outputFile=FALSE, inDF=testD)
```

#### JTK does not support non-integer interval. E.g. needs to transform 0.5h to 30 minutes for running JTK. Current JTK version allows maximum 170 time points calculating the exact p-value. If more than 170 input time points, JTK will release an error. 

#### If p-value are 1 for all subjects, the output value will be NA from meta3d if using 'weightedMethod=TRUE'. 'weightedMethod=FALSE' is suggested. 

#### A better demo file introducing about how to use MetaCycle, especially for meta3d. Current introduction file mainly mentions about the design of MetaCycle. 

Currently, there is a workshop folder introducting how to use meta2d step by step (https://github.com/gangwug/SRBR_SMTSAworkshop). The shinny app of meta2d is on Github (https://github.com/gangwug/MetaCycleApp). We also encourge users to post experience of using MetaCycle in their native language. For example, Jiaxuan shared her experience in Chinese (https://abego.cn/2019/05/31/the-rule-of-gene-expression-in-the-day-and-nigth/). 

## The above issues will be fixed in the next version of MetaCycle.
