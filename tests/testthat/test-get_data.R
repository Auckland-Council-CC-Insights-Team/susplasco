test_that("Google Sheet data is returned with renamed columns", {
  expected <- c(
    "how_do_you_connect_with_the_whenua_surrounding_natural_environment",
    "what_do_you_do_to_grow_knowledge",
    "how_do_you_incorporate_te_reo_and_tikanga",
    "what_do_you_do_around_food_cultures_and_traditions"
  )

  returned <- clean_google_sheet_data("live") |> colnames()

  expect_equal(returned[c(6:8, 22)], expected)
  expect_error(returned |> select(dplyr::starts_with("q")))
})

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
