# Shape drawing functions ----------
#' Add outlines/polygons to a mosaic plot
#'
#' @param df `mosaic_df`
#' @param column (`shp` by default) name or position of a
#' column in `df` to feed [polygon()].
#' @param density `numeric` (recycled) to feed [polygon()]
#' @param angle `numeric` (recycled) to feed [polygon()]
#' @param border `color` (recycled) to feed [polygon()]
#' @param col `color` (recycled) to feed [polygon()]
#' @param lty `numeric` (recycled) to feed [polygon()]
#' @param ... additional arguments to feed [polygon()]
#' @export
add_polygons <-
  function(df,
           column="shp",
           density=rep(NA, nrow(df)),
           angle=45,
           border=rep(NA, nrow(df)),
           col=rep(par("fg"), nrow(df)),
           lty=rep(par("lty"), nrow(df)),
           ...){
    n <- nrow(df)
    if (!missing(density))
      density <- rep_len(density, n)
    if (!missing(angle))
      angle <- rep_len(angle, n)
    if (!missing(border))
      border <- rep_len(border, n)
    if (!missing(col))
      col <- rep_len(col, n)
    if (!missing(lty))
      lty <- rep_len(lty, n)

    for (i in 1:n){
      getElement(df, column)[[i]] %>%
        polygon(density=density[i],
                angle=angle[i],
                border=border[i],
                col=col[i],
                lty=lty[i])
    }
    df
  }

#' @rdname add_polygons
#' @export
add_outlines <- add_polygons

#' Add curves/lines to a mosaic plot
#'
#' @param df `mosaic_df`
#' @param column (`shp` by default) name or position of a
#' column in `df` to feed [lines()].
#' @param col `color` (recycled) to feed [lines()]
#' @param lwd `numeric` (recycled) to feed [lines()]
#' @param lty `numeric` (recycled) to feed [lines()]
#' @param ... additional arguments to feed [lines()]
#' @export
add_lines <-
  function(df, column="shp",
           col=rep(par("fg"), nrow(df)),
           lwd=rep(1, nrow(df)),
           lty=rep(par("lty"), nrow(df)),
           ...){
    n <- nrow(df)
    if (!missing(col))
      col <- rep_len(col, n)
    if (!missing(lwd))
      lwd <- rep_len(lwd, n)
    if (!missing(lty))
      lty <- rep_len(lty, n)

    for (i in 1:n){
      getElement(df, column)[[i]] %>%
        lines(col=col[i],
              lwd=lwd[i],
              lty=lty[i])
    }
    df
  }

#' @rdname add_lines
#' @export
add_curves <- add_lines

#' Add text to shapes of a mosaic plot
#'
#' @param df `mosaic_df`
#' @param column (`shp` by default) name or position of a
#' column in `df` to feed [lines()].
#' If a non-character column is provided, its `names`.
#' @param col `color` (recycled) to feed [text()]
#' @param font `numeric` (recycled) to feed [text()]
#' @param cex `numeric` to feed [text()], if missing tries
#' to obtain something adequate
#' @param ... additional arguments to feed [text()]
#' @export
add_text <-
  function(df, column="shp",
           col=rep(par("fg"), nrow(df)),
           font=rep(1, nrow(df)),
           cex,
           ...){
    n <- nrow(df)
    if (!missing(col))
      col <- rep_len(col, n)
    if (!missing(font))
      font <- rep_len(font, n)

    labels <- getElement(df, column)
    if (!is.character(labels))
      labels %<>% names

    # calculate adapted cex to fill (to the most) 0.9 of a locus
    if (missing(cex)){
      cex <- strwidth(labels, cex=par("cex")) %>%
        max %>% `/`(., 0.9) %>% `/`(par("cex"), .)
    }
    for (i in 1:n){
      text(df$xc[i], df$yc[i],
           labels[i],
           col=col[i],
           font=font[i],
           cex=cex,
           ...)
    }
    df
  }

#' @rdname add_text
#' @export
add_labels <- add_text

#' Add headers to groups on a mosaic plot
#'
#' @param df `mosaic_df`
#' @param column (`f` by default) name or position of a column in `df` to feed [lines()].
#' If a non-character column is provided, its `names`.
#' @param cex `numeric` to feed [text()], if missing tries
#' to obtain something adequate
#' @param ... additional arguments to feed [text()]
#' @export
add_headers <-
  function(df, column="f",
           cex,
           ...){
    df_h <- df %>%
      group_by_(column) %>%
      slice(1) %>%
      ungroup

    labels <- as.character(getElement(df_h, column))

    # calculate adapted cex to fill (to the most) 0.9 of a locus
    if (missing(cex)){
      cex=1
    }

    text(-0.25, df_h$yc, labels, cex=cex, adj=1, ...)
    df
  }
