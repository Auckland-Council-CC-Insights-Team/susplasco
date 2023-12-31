f <- function() {
  return(get_live_data())
}

test_that("when requesting live data, it returns a file path to the updated RDS file", {
  # Stub get_live_data() when called within f
  mockery::stub(f, "get_live_data", function() {
    return(newsustainableplacesscorecard)
  })

  expect_equal(f(), newsustainableplacesscorecard)
})

g <- function() {
  return(get_snapshot_data())
}

test_that("when requesting snapshot data, it returns a file path to the existing RDS file", {
  # Stub get_snapshot_data() when called within f
  mockery::stub(g, "get_snapshot_data", function() {
    return(sustainableplacesscorecard)
  })

  expect_equal(g(), sustainableplacesscorecard)
})


test_that("we can return the live data and the snapshot data as a list of tibbles", {
  raw_data <- get_raw_data()

  expect_type(raw_data, "list")
  expect_equal(raw_data[[1]] |> filter(last_name == "Waititi") |> pull(email_address), "waititi@waititiproductions.com")
})


test_that("the new submissions from the form are returned", {
  new_submission_expected <- get_new_submissions()

  expect_equal(new_submission_expected$last_name, c("Seldon", "Waititi"))
})


test_that("the default metadata is returned successfully", {
  metadata <- get_metadata()
  metadata_cols <- c("id",  "sub_id", "Pou",  "Question", "Action", "Status",
                     "image_coordinates", "page_number", "text_coordinates",
                     "score_coordinates")

  expect_equal(colnames(metadata), metadata_cols)
})

test_that("the correct path to the new submissions data is returned", {
  test_live <- get_updated_data(path_to_data = "live")
  test_snapshot <- get_updated_data(path_to_data = "snapshot")

  expect_equal(test_live |> nrow(), 7)
  expect_equal(test_snapshot |> nrow(), 5)
})
