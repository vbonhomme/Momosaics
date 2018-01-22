# Wrapping functions ---------------------------------------

#' Wrap a data.frame into a mosaic_df, with options
#'
#' Given a list of shapes or directly an existing `data.frame`,
#' calculates loci positions (`row` and `col` columns, for their ids)
#' then decuces real coordinates (`xc` and `yc` columns).
#'
#' If no `nr` (and/or `nc`) is passed, tries to return a squared mosaic plot.
#'
#' @param df `data.frame` with `shp` column as a `list` of shapes, and
#' possibly other columns (eg a `factor`) or directly a `list` of shapes
#' @param f `factor` for grouping structure
#' @param nr `integer` the number of rows for the mosaic plot
#' @param nc `interger` the number of columns for the mosaic plot
#'
#' @export
mosaic_wrap <- function(df, nr, nc){
  if (!is.data.frame(df)){
    df <- data_frame(shp=df)
  }
  # handling dimensions when missing
  n <- nrow(df)
  if (missing(nr) & missing(nc)) {
    nc <- ceiling(sqrt(n))
    nr <- ceiling(n/nc)
  }
  if (missing(nr)){
    nr <- ceiling(n/nc)
  }
  if (missing(nc)){
    nc <- ceiling(n/nr)
  }
  # builds the mosaic data_frame
  data_frame(n=1:(nr*nc),
             row=rep(1:nr, each=nc),
             col=rep(1:nc, times=nr)) %>%
    filter(n<=nrow(df)) %>%
    # calculate coordinates of loci centers
    mutate(xc=col-0.5,
           yc=max(row)-row+0.5) %>%
    # binds with original data.frame
    bind_cols(df) %>%
    # adds mosaic_df class
    `class<-`(c("mosaic_df", class(.))) %>%
    # transplate
    transplate()
}

#' @rdname mosaic_wrap
#' @export
mosaic_wrap_factor <- function(df, f, nr, nc){
  if (!is.factor(f))
    f %<>% factor()
  if (!is.data.frame(df)){
    df <- data_frame(shp=df, f=f)
  }
  # handling dimensions when missing
  n <- nrow(df)
  if (missing(nr) & missing(nc)) {
    nc <- ceiling(sqrt(n) + sqrt(nlevels(f)))
    nr <- ceiling(n/nc)
  }
  if (missing(nr)){
    nr <- ceiling(n/nc + nlevels(f))
  }
  if (missing(nc)){
    nc <- ceiling(n/nr + sqrt(nlevels(f)))
  }
  n <- .fill_row(f, nc)
  nr <- ceiling(length(n)/nc)
  # builds the mosaic data_frame
  data_frame(n=n,
             row=rep(1:nr, each=nc),
             col=rep(1:nc, times=nr)) %>%
    # calculate coordinates of loci centers
    mutate(xc=col-0.5,
           yc=max(row)-row+0.5) %>%
    # now removes empty loci
    na.omit() %>%
    # binds with original data.frame
    bind_cols(df) %>%
    mutate(n=1:n()) %>%
    # adds mosaic_df class
    `class<-`(c("mosaic_df", class(.))) %>%
    # transplate
    transplate()
}
