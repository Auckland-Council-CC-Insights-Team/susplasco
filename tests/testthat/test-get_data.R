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
  expect_type(get_raw_data(), "list")
})


test_that("the new submissions from the form are returned", {
  new_submission_expected <- get_new_submissions()

  expect_equal(new_submission_expected$last_name, "Seldon")
})
