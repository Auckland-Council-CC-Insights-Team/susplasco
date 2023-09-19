#' Get Newly-Submitted Data For Scoring
#'
#' @param cols_to_keep Columns to keep in addition to the actions (or
#'   multi-choice options), passed using \link[dplyr]{dplyr_tidy_select}.
#' @param metadata_filepath Filepath to the CSV file where the metadata is
#'   stored. By default, this is set to NULL and will return the Sustainable
#'   Places Framework scorecard metadata.
#' @param url The URL to the Google Sheet where the data is stored. By default,
#'   this is set to NULL and will return a fake dataset of Sustainable Places
#'   Framework form submissions.
#'
#' @return A tibble.
#' @export
#'
#' @examples
#' # In this example, the Sustainable Place data and metadata that comes shipped
#' # with the package would be used.
#' \dontrun{
#' get_data(cols_to_keep = timestamp:your_facility)
#' }
get_data <- function(cols_to_keep, url = NULL, metadata_filepath = NULL) {
  g_sheet_binaries <- get_new_submissions(url = url) |>
    get_question_answers(metadata_filepath, {{cols_to_keep}})

  return(g_sheet_binaries)
}


#' Calculate All Scores Needed For Scorecard
#'
#' @param data A dataframe containing, ar minimum, binary values indicating
#'   which actions were selected.
#' @param metadata_path Filepath to the CSV file where the metadata is stored.
#'   By default, this is set to NULL and will return the Sustainable Places
#'   Framework scorecard metadata.
#' @param ... Key-value pairs determining which columns, aside from `id`, are
#'   retained from `data`.
#'
#' @return A tibble.

#' @export
get_scores <- function(data, metadata_path = NULL, ...) {
  # Score each question based on the binary values
  question_scores <- get_question_scores(data, metadata_path, ...)

  # Score for each status of Activator, Champion, and Leader
  status_scores <- get_status_scores(data, metadata_path, ...)

  # Total score for final category (Activator or Leader) per Pou, absolute and percentage
  category_scores <- get_overall_score(status_scores, metadata_path, ...)

  # Combine all scores into one dataframe
  all_scores <- get_all_scores(category_scores, question_scores)

  return(all_scores)
}
