This repository contains the ongoing development version of MetaCycle. 

## Introduction
MetaCycle is an R package for evaluating periodicity in large scale time-series datasets. This package provides two functions-
**meta2d** and **meta3d**. For analyzing time-series datasets without individual information, **meta2d** is suggested, 
which incorporates [ARSER](https://github.com/cauyrd/ARSER), [JTK_CYCLE](http://openwetware.org/wiki/HughesLab:JTK_Cycle) and
[Lomb-Scargle](http://research.stowers-institute.org/efg/2005/LombScargle/) in the detection of interested rhythms. For analyzing 
time-series datasets with individual information, **meta3d** is suggested, which takes use of any one of these three methods to 
analyze time-series data individual by individual and gives out integrated values based on analysis result of each individual.

## Update news
For accelerating the analysis process of MetaCycle, it is under the development of parallel version which is lead by Xaiver (haohan.li.97@gmail.com). 

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
