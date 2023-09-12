#' Remove Question Numbers From Column Names
#'
#' @param g_sheet_import Path to RDS file containing the Google Sheets data.
#'
#' @return A tibble.
#'
#' @noRd
clean_google_sheet_data <- function(g_sheet_import) {
  g_sheet_data <- readRDS(g_sheet_import) |>
    dplyr::rename_with(~word(.x, 2, -1, sep = fixed("_")), starts_with("q"))

  return(g_sheet_data)
}


#' Read Google Sheet Data And Save It To RDS
#'
#' @return A string pointing to the file path where the RDS file has been saved.
#'
#' @noRd
get_live_data <- function() {
  save_path <- paste0(tere::get_file_storage_path(), "/scorecard_updated.rds")

  url <- "https://docs.google.com/spreadsheets/d/1XdcrQk7OrQchJXTF-VambCS6MQOQ3NkLNMUEb51BAYQ/edit?resourcekey#gid=960956621"
  g_sheet_import_file <- googlesheets4::read_sheet(url) |>
    clean_names()

  saveRDS(g_sheet_import_file, save_path)

  return(save_path)
}
