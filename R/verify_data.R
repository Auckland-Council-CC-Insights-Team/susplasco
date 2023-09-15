#' Verify New Submissions Data
#'
#' @param data A dataframe which may contain new submissions data.
#'
#' @return The data is returned if predicate assertion is `TRUE` and an error is
#'   thrown if not.
#'
#' @noRd
verify_new_submissions <- function(data) {
 verify(data, ncol(data) == 22)
}
