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
