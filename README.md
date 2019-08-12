This repository contains the ongoing development version of MetaCycle. 

## Introduction
MetaCycle is an R package for evaluating periodicity in large scale time-series datasets. This package provides two functions-
**meta2d** and **meta3d**. For analyzing time-series datasets without individual information, **meta2d** is suggested, 
which incorporates [ARSER](https://github.com/cauyrd/ARSER), [JTK_CYCLE](http://openwetware.org/wiki/HughesLab:JTK_Cycle) and
[Lomb-Scargle](http://research.stowers-institute.org/efg/2005/LombScargle/) in the detection of interested rhythms. For analyzing 
time-series datasets with individual information, **meta3d** is suggested, which takes use of any one of these three methods to 
analyze time-series data individual by individual and gives out integrated values based on analysis result of each individual.

## Update news
MetaCycle 1.2.0 was released in [CRAN](https://cran.r-project.org/web/packages/MetaCycle/index.html), which supports parallel analysis (except on Windows system), and can accept input data frame in addition to input files.

We prepared the new [Vignettes](https://cran.r-project.org/web/packages/MetaCycle/vignettes/implementation.html), includding several new sections(**Pros and Cons of meta2d methods**, **Method selection based on the sampling pattern** and **Notes on the Fisher’s method**).

Next, we will try to make the parallel analysis works on the Windows system, and find a better way (beautiful in theory and powerful in practice) of integrating multiple p-values.

## Reported issues from MetaCycle users and will be fixed in the next version
Input and output data frame instead of using file name. Currently, it needs to set value to 'infile' and 'filestyle'. This is not user-friendly.


```r
testD <- read.csv("example.csv")
timev <- 1:10
outD <- meta2d(infile="csv", filestyle="csv", timepoints = timev, outputFile=FALSE, nDF=testD)
```

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
