#' Get Newly-Submitted Data For Scoring
#'
#' @param cols_to_keep Columns to keep in addition to the actions (or
#'   multi-choice options), passed using \link[dplyr]{dplyr_tidy_select}.
#' @param metadata_filepath Filepath to the CSV file where the metadata is
#'   stored.
#' @param test Read from the test files? Default is `FALSE`.
#'
#' @return A tibble.
#' @export
#'
#' @examples
#' # In this example, the Sustainable Place metadata that comes shipped with the
#' # package would be used.
#' \dontrun{
#' get_data(cols_to_keep = timestamp:your_facility)
#' }
get_data <- function(cols_to_keep, metadata_filepath = NULL, test = FALSE) {
  g_sheet_binaries <- get_new_submissions(test = test) |>
    get_question_answers(metadata_filepath, {{cols_to_keep}})

  return(g_sheet_binaries)
}
