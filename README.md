
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
library(Momosaics)
#> This is Momosaics 0.1.0
library(Momocs)
#> This is Momocs 1.2.2
#> 
#> Attaching package: 'Momocs'
#> The following object is masked from 'package:stats':
#> 
#>     filter
#> The following object is masked from 'package:base':
#> 
#>     table
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
