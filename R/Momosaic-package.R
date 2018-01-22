
#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

#' @importFrom magrittr %<>%
#' @export
magrittr::`%<>%`

#' @importFrom magrittr %$%
#' @export
magrittr::`%$%`

#' @importFrom magrittr %T>%
#' @export
magrittr::`%T>%`



#' Momosaics
#'
#' Use primitive layers to draw many shapes or
#' subplot as mosaics of plots.
#'
#'
#' @seealso
#' \itemize{
#'  \item \bold{Homepage}: \url{https://github.com/vbonhomme/Momosaics}
#'  \item \bold{Issues}: \url{https://github.com/vbonhomme/Momosaics/issues}
#'  \item \bold{Tutorial}: \code{browseVignettes("Momosaics")}
#'  \item \bold{Email}: \code{bonhomme.vincent@gmail.com}
#' }
#'
#' @importFrom dplyr filter mutate bind_cols data_frame group_by_ slice ungroup
#' @importFrom Momocs coo_center coo_trans coo_template
#' @importFrom graphics plot polygon lines text segments par strwidth
#' @importFrom stats na.omit
#' @importFrom utils globalVariables
#' @docType package
#' @name Momocs
NULL

# prevents "no visible binding for global variable"
# http://stackoverflow.com/questions/9439256/how-can-i-handle-r-cmd-check-no-visible-binding-for-global-variable-notes-when
globalVariables(c("."))

.onAttach <- function(lib, pkg) {
  packageStartupMessage('This is Momosaics ',
                        utils::packageDescription('Momosaics', field='Version'),
                        appendLF = TRUE) }

