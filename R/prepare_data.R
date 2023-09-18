#' Remove Question Numbers From Column Names
#'
#' @description The text of the questions in the Google Form are stored in the
#'   Google Sheet as column names. To retrieve the actual text of the questions,
#'   this function removes the question numbers which are prefixed to these in
#'   the column names.
#'
#'
#' @param path_to_data Path to RDS file containing the Google Sheets data, or
#'   the exported dummy data.
#'
#' @return A tibble.
#'
#' @noRd
clean_google_sheet_data <- function(path_to_data) {
  g_sheet_import <- get_updated_data(path_to_data)

  g_sheet_data <- g_sheet_import |>
    dplyr::rename_with(~word(.x, 2, -1, sep = fixed("_")), starts_with("q"))

  return(g_sheet_data)
}


get_overall_score <- function(data, metadata_filepath, score_lvl) {
  metadata <- get_metadata(metadata_filepath)

  denom_name <- paste0(score_lvl, "_denominator")
  score_name <- paste0(score_lvl, "_score")
  perc_name <- paste0(score_lvl, "_percentage")

  score <- prep_scoring_data(data, score_lvl) |>
    left_join(
      get_pou_denominators(metadata, {{denom_name}}, score_lvl),
      by = "pou") |>
    summarise(
      {{score_name}} := sum(score),
      .by = c(timestamp:your_facility, pou, {{denom_name}})
    ) |>
    mutate({{perc_name}} := !!sym(score_name)/!!sym(denom_name)) |>
    get_category(score_lvl)

  return(score)
}


#' Convert Tickbox Selections To Binary Values
#'
#' @param data A dataframe containing the responses from the Google Form,
#'   typically newly-received responses.
#' @param metadata_filepath Filepath to the CSV file where the metadata is
#'   stored.
#' @param ... Key-value pairs passed to `select(...)` within the
#'   `bind_and_tibble()` function.
#'
#' @return A tibble.
#'
#' @noRd
get_question_answers <- function(data, metadata_filepath = NULL, ...) {
  sub_id <- Question <- Action <- NULL

  metadata <- get_metadata(metadata_filepath)

  new_column_name <-  pull(metadata, sub_id)
  target_column <- pull(metadata, Question) |> make_clean_names(allow_dupes = TRUE)
  option_text <-  pull(metadata, Action)

  data_binaries <- pmap(
    list(new_column_name, target_column, option_text),
    ~is_option_selected(data, ..1, ..2, ..3)
  ) |>
    bind_and_tibble(data, ...)

  return(data_binaries)
}


#' Calculate Scores Across All Questions
#'
#' @description For each question, calculate how many options were selected by
#'   the user in total.
#'
#' @param data A dataframe which contains, at minimum, a column for each
#'   multi-choice selection expressed as either 1 or 0.
#' @param metadata_filepath The filepath to a CSV file containing the metadata
#'   for the online form.
#' @param ... Key-value pairs passed to select(...).
#'
#' @return A tibble.
#'
#' @export
get_question_scores <- function(data, metadata_filepath = NULL, ...) {
  id <- NULL

  metadata <- get_metadata(metadata_filepath)
  question_ids <- dplyr::distinct(metadata, id) |> pull(id)

  question_scores <- map(question_ids, ~get_question_score(data, .x, metadata)) |>
    bind_and_tibble(data, ...)

  return(question_scores)
}


#' Calculate Score For A Single Question
#'
#' @param data A dataframe which contains, at minimum, a column for each
#'   multi-choice selection expressed as either 1 or 0.
#' @param question_id The unique ID of the question for which a score will be
#'   calculated, taken from the form metadata.
#' @param metadata A dataframe containing the metadata for the online form from
#'   which the question IDs are derived.
#'
#' @return A tibble with one column and one row.
#'
#' @noRd
get_question_score <- function(data, question_id, metadata) {
  id <- sub_id <- NULL

  cols_to_score <- metadata |>
    filter(id == {{question_id}}) |>
    pull(sub_id)

  new_col_name <- paste0(question_id, "_score")

  score <- data |>
    mutate(
      {{new_col_name}} := rowSums(across(tidyselect::any_of(cols_to_score)))
    ) |>
    select(tidyselect::all_of(new_col_name))

  return(score)
}


#' Return An Answer As A Binary Value
#'
#' @description For a multi-choice option in a question in the form, mark it as
#'   either 1 (selected) or 0 (not selected).
#'
#' @param data A dataframe containing the form responses.
#' @param new_column_name The name of the new column which contains the binary
#'   value.
#' @param target_column The name of the column which holds the question's
#'   multi-choice options.
#' @param option_text The text of the multi-choice option against which we will
#'   assign a binary value.
#'
#' @return A tibble with one column (whose name is passed as new_col_name)
#'   and one row (either a 1 or a 0).
#'
#' @noRd
is_option_selected <- function(data, new_col_name, target_column, option_text){
  data_with_column <- data |>
    mutate(
      {{new_col_name}} := if_else(
        !is.na(!!dplyr::sym(target_column)) & str_detect(!!dplyr::sym(
          target_column), fixed(option_text)),
        1,
        0)) |>
    select({{new_col_name}})

  return(data_with_column)
}
