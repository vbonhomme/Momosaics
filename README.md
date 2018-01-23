![experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
[![Travis-CI Build Status](https://travis-ci.org/vbonhomme/Momosaics.svg?branch=master)](https://travis-ci.org/vbonhomme/Momosaics) [![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/Momosaics)](http://cran.r-project.org/package=Momosaics) [![Coverage Status](https://img.shields.io/codecov/c/github/vbonhomme/Momosaics/master.svg)](https://codecov.io/github/vbonhomme/Momosaics?branch=master) ![CRAN downloads last month](http://cranlogs.r-pkg.org/badges/Momosaics) ![CRAN downloads grand total](http://cranlogs.r-pkg.org/badges/grand-total/Momosaics)

<!-- README.md is generated from README.Rmd. Please edit that file -->
Momosaics
=========

Momosaics uses primitive layers to draw many shapes or subplots as mosaics of plots.

Installation
------------

You can install Momosaics from github with:

``` r
# install.packages("devtools")
devtools::install_github("vbonhomme/Momosaics")
```

Example
-------

``` r
# First load Momosaics
library(Momosaics)
# To benefit its datasets
library(Momocs)
mosaic_wrap(bot$coo) %>% 
  mosaic_empty_plot() %>% 
  add_outlines()
```

![](README-outlines-1.png)

``` r
mosaic_wrap_factor(bot$coo, bot$fac$type) %>% 
  mosaic_empty_plot() %>% 
  add_outlines(col=palettize(bot$fac$type, col_summer)) %>% 
  add_text() %>% 
  add_headers()
```

![](README-factor-1.png)

More to come.
