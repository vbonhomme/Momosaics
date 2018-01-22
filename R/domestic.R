

# Internal functions ---------------------------------------
# Calculate how many loci are empty for a given row length
.missing_on_row <- function(x, nc){
  ifelse(x<nc, nc-x, x%%nc)
}
# .missing_on_row(1:10, 4)

# Fill missing loci on row
.fill_row <- function(x, nc){
  # split into a list
  xs <- split(x, x)
  # calculate length of all elements
  xl <- sapply(xs, length)
  # number of loci to fill for each level
  r <- .missing_on_row(xl, nc)
  # prepare the NA complement for each level
  l <- lapply(r, function(.) rep(NA, .))
  # concatenate element-wise, unlist and unname
  mapply(c, xs, l, SIMPLIFY = FALSE) %>% unlist %>% `names<-`(NULL)
}
# .fill_row(x=factor(rep(1:7, 1:7)), nc=4)

#' Template and translate shapes from a mosaic_df
#'
#' Passed with a `mosaic_df`, template shapes to the desired size,
#' then translate shapes to the required locus using `xc` and `yc`
#' columns from the `data.frame`.
#' @param df a `mosaic_df` data.frame
#' @param size the templating size. See [Momocs::coo_template()]
transplate <- function(df, size=0.95){
  for (i in 1:nrow(df)){
    df$shp[[i]] %<>%
      Momocs::coo_center %>%
      Momocs::coo_template(size) %>%
      Momocs::coo_trans(x=df$xc[i], y=df$yc[i])
  }
  df
}

#' Creates a color vector from a factor and a palette name
#'
#' Can be used in conjunction with `add_*` functions.
#'
#' @param f `factor` (or another type of vector coerced as `factor`)
#' as a grouping informations for colors to be returned
#' @param palette a color palette that, given a `integer` return a
#' color code.
#'
#' @examples
#' # creates a palette
#' w2b <- colorRampPalette(c("#FFFFFF", "#000000"))
#' # displays it
#' barplot(rep(1, 5), col=w2b(5))
#' # with palettize
#' palettize(iris$Species, w2b)
#' # alternatively you can use existing palettes
#' palettize(iris$Species, Momocs::col_summer)
#' @export
palettize <- function(f, palette){
  palette(length(unique(f)))[f]
}

