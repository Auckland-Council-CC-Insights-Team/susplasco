get_overall_score <- function(data, metadata_filepath = NULL) {
  metadata <- get_metadata(metadata_filepath)

  score <- data |>
    filter(
      if_any(matches("(?i)^status$"), ~!(. %in% c("activator", "Activator")))
      ) |>
    left_join(
      get_pou_denominators(metadata),
      by = "pou") |>
    summarise(
      category_score = sum(score),
      .by = c(pou, category_denominator)
    ) |>
    mutate(
      category_percentage = category_score/category_denominator,
      final_category = if_else(category_percentage >= 0.8, "Leader", "Activator")
    )

  return(score)
}


#' Count Total Questions Per Pou
#'
#' @param metadata A dataframe containing the metadata for the online form from
#'   which the Pou and their questions are derived.
#'
#' @return A tibble with two columns.
#'
#' @noRd
get_pou_denominators <- function(metadata) {
  denominator <- metadata |>
    filter(
      if_any(matches("(?i)^status$"), ~!(. %in% c("activator", "Activator")))
    ) |>
    dplyr::with_groups(Pou, summarise, category_denominator = dplyr::n()) |>
    mutate(pou = make_clean_names(Pou), .keep = "unused")

  return(denominator)
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


#' Calculate Scores For Each Status
#'
#' @description For each question, count the number of actions selected against
#'   each status of either Activator, Champion, or Leader. The scores for the
#'   latter two statuses determine the final category for this submission
#'   against each Pou.
#'
#' @param data A dataframe which contains, at minimum, a column for each
#'   multi-choice selection expressed as either 1 or 0.
#' @param metadata_filepath The filepath to a CSV file containing the metadata
#'   for the online form.
#' @param Key-value pairs passed to select(...).
#'
#' @return A tibble.

#' @export
get_status_scores <- function(data, metadata_filepath = NULL, ...) {
  metric <- NULL

  metadata <- get_metadata(metadata_filepath)
  pou <- rep(unique(metadata$Pou), 3)
  status <- c(rep("Activator", 5), rep("Leader", 5), rep("Champion", 5))

  status_scores <- map2(pou, status, ~get_status_score(data, metadata, .x, .y)) |>
    bind_and_tibble(data, ...) |>
    pivot_longer(tidyr::ends_with("_score"), names_to = "metric",
                 values_to = "score") |>
    mutate(
      pou = word(metric, 1, -3, sep = fixed("_")),
      status = word(metric, -2, -2, sep = fixed("_"))
    )

  return(status_scores)
}


#' Calculate A Status Score For A Pou
#'
#' @description For a given Pou, calculate a status score (either Activator,
#'   Leader, or Champion).
#'
#' @param data A dataframe which contains, at minimum, a column for each
#'   multi-choice selection expressed as either 1 or 0.
#' @param metadata A dataframe containing the metadata for the online form from
#'   which the question IDs are derived.
#' @param pou One of the five Pou for which a status score will be calculated:
#'   * Te Tiriti
#'   * Community Resilience
#'   * Zero Waste
#'   * Zero Emissions
#'   * Kai Fr All
#' @param status One of the three statuses for which a score will be calculated:
#'   * Activator
#'   * Champion
#'   * Leader
#'
#' @return A tibble containing only the columns with the status scores for each
#'   Pou.
#'
#' @noRd
get_status_score <- function(data, metadata, pou, status) {
  Pou <- Status <- sub_id <- NULL

  cols_to_score <- metadata |>
    filter(Pou == pou & Status == status) |>
    pull(sub_id)

  new_col_name <- paste0(make_clean_names(pou), "_", str_to_lower(status), "_score")

  score <- data |>
    mutate({{new_col_name}} := rowSums(across(dplyr::any_of(cols_to_score)))) |>
    select(dplyr::all_of(new_col_name))

  return(score)
}
