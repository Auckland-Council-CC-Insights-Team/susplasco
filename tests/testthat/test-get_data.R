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
  expect_equal(raw_data[[1]] |> pull(email_address), "anewnetry@me.com")
})


test_that("the new submissions from the form are returned", {
  new_submission_expected <- get_new_submissions()

  expect_equal(new_submission_expected$last_name, "Seldon")
})


test_that("the default metadata is returned successfully", {
  metadata <- get_metadata()
  metadata_cols <- c("id",  "sub_id", "Pou",  "Question", "Action", "Status",
                     "image_coordinates", "page_number", "text_coordinates",
                     "score_coordinates")

  expect_equal(colnames(metadata), metadata_cols)
})
