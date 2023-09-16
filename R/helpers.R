#' Bind A List Of Dataframes As A Tibble
#'
#' @description Column-bind a dataframe to another dataframe whose rows are
#'   exactly aligned, and return a tibble.
#'
#' @param data A dataframe whose rows are in the same order as the dataframe
#'   passed to bind_to.
#' @param bind_to A second dataframe whose rows are in the same order as the
#'   dataframe passed to data.
#' @param ... Key-value pairs passed to select(...).
#'
#' @return A tibble.
#'
#' @noRd
bind_and_tibble <- function(data, bind_to, ...) {
  bind_to <- select(bind_to, ...)

  bound_data <- data |>
    cbind(bind_to) |>
    dplyr::as_tibble()

  return(bound_data)
}
