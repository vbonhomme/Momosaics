# Graphical window functions -------------------------------

#' Given a mosaic_df, prepares the empty graphical window
#'
#' @param df a `mosaic_df`
#' @export
mosaic_empty_plot <- function(df){
  nr <- max(df$row)
  nc <- max(df$col)
  op <- par(mar=rep(3, 4), xpd=NA)
  plot(NA,
       xlim=c(0, nc), ylim=c(0, nr),
       asp=1, ann=FALSE, axes=FALSE)
  # par(op)
  df
}

# Same as mosaic_plot but with grids
.mosaic_helper_plot <- function(df){
  nr <- max(df$row)
  nc <- max(df$col)
  op <- par(mar=rep(3, 4))
  plot(NA,
       xlim=c(0, nc), ylim=c(0, nr), asp=1)#,
  #ann=FALSE, axes=FALSE)
  #par(op)
  # propagate df
  # par(op)
  df
}

# Given a df, draw loci positions
.mosaic_helper_loci <- function(df){
  # deduce dims
  nr <- max(df$col)
  nc <- max(df$row)
  # add shape loci
  text(df$xc, df$yc, df$n)
  # horizontal segments
  segments(0, 0:nc, nr, 0:nc, col="grey50")
  # vertical segments
  segments(0:nr, 0, 0:nr, nc, col="grey50")
  # propagate df
  df
}
