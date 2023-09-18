#' Read Google Sheet Data And Save It To RDS
#'
#' @description To determine whether or not new reports should be rendered, we
#'   need to compare the data from Google Forms (live data) with the data as it
#'   was the last time reports were rendered (snapshot data). This function
#'   returns a path to the file containing the live data that has been read
#'   directly from Google Sheets.
#'
#' @param url The URL to the Google Sheet where the data is stored. By default,
#'   this points to the Sustainable Place Framework scorecard data.
#' @param save_path Directory path to where the RDS file will be saved under the
#'   name "scorecard_updated.rds".
#'
#' @return A string pointing to the file path where the RDS file has been saved.
#'
#' @noRd
get_live_data <- function(url, save_path = tere::get_file_storage_path()) {
  save_path <- paste0(save_path, "/scorecard_updated.rds")

  g_sheet_import_file <- googlesheets4::read_sheet(url) |>
    clean_names()

  saveRDS(g_sheet_import_file, save_path)

  return(save_path)
}


#' Get Information About Each Question In The Form
#'
#' @param metadata_filepath Filepath to the CSV file where the metadata is
#'   stored.
#'
#' @return A tibble.
#' @export
#'
#' @examples
#' # If no value is passed to metadata_filepath, the function returns the default
#' # metadata required to render the Sustainable Places Framework reports.
#' get_metadata()
get_metadata <- function(metadata_filepath = NULL) {
  if(is.null(metadata_filepath)) {
    return(sustainableplacesmetadata)
  }

  metadata <- readr::read_csv(metadata_filepath, col_types = "c")

  return(metadata)
}


#' Create A Data Table Of Newly-Submitted Form Entries
#'
#' @description To determine whether or not new reports should be rendered, we
#'   need to compare the data from Google Forms (live data) with the data as it
#'   was the last time reports were rendered (snapshot data). This function
#'   returns all the rows in the live data that are not found in the snapshot
#'   data.
#'
#' @param url The URL to the Google Sheet where the data is stored.
#'
#' @return A tibble.
#' @export
get_new_submissions <- function(url = NULL) {
  data <- get_raw_data(url = url)
  live_data <- data[[1]]
  archived_data <- data[[2]]

  new_submissions <- suppressMessages(anti_join(live_data, archived_data))

  return(new_submissions)
}


#' Get Live Data and Snapshot Data Together
#'
#' @description To determine whether or not new reports should be rendered, we
#'   need to compare the data from Google Forms (live data) with the data as it
#'   was the last time reports were rendered (snapshot data). This function
#'   returns a list of two tibbles, one for the live data and one for the
#'   snapshot data.
#'
#' @param url The URL to the Google Sheet where the data is stored.
#'
#' @return A list of two tibbles.
#'
#' @export
get_raw_data <- function(url = NULL) {
  live_data <- ifelse(is.null(url), "live", get_live_data(url))

  snapshot_data <- ifelse(is.null(url), "snapshot", get_snapshot_data())

  data <- map(c(live_data, snapshot_data), clean_google_sheet_data)

  return(data)
}


#' Get Path To The RDS File With Existing Data
#'
#' @description To determine whether or not new reports should be rendered, we
#'   need to compare the data from Google Forms (live data) with the data as it
#'   was the last time reports were rendered (snapshot data). This function
#'   returns a path to the file containing the snapshot data.
#'
#' @return A string containing the path to the file where the snapshot data is
#'   stored.
#'
#' @noRd
get_snapshot_data <- function() {
  g_sheet_import <- paste0(tere::get_file_storage_path(), "/scorecard.rds")

  return(g_sheet_import)
}


#' Read New Submissions Data
#'
#' @param path_to_data Path to where the new submissions data is held, either in
#'   a RDS file or, for testing purposes, in data that is exported with this
#'   package.
#'
#' @return A tibble.
#'
#' @noRd
get_updated_data <- function(path_to_data) {
  if(path_to_data == "live") {
    return(susplasco::newsustainableplacesscorecard)
  } else if(path_to_data == "snapshot") {
    return(susplasco::sustainableplacesscorecard)
  } else {
    return(readRDS(path_to_data))
  }
}
