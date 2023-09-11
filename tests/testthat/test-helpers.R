library(mockery)

test_that("two dataframes are column-bound and returned as a single tibble", {
  df_1 <- data.frame(x = 1:10, y = letters[1:10])
  df_2 <- data.frame(z = 11:20, a = letters[11:20])
  expected_df <- tibble::tibble(x = 1:10, y = letters[1:10], z = 11:20,
                                   a = letters[11:20])

  expect_equal(bind_and_tibble(df_1, df_2, z:a), expected_df)
})


test_that("Google Sheet data is returned with renamed columns", {
  df_path <- test_path("testdata/scorecard.rds")

  expected <- c(
    "how_do_you_connect_with_the_whenua_surrounding_natural_environment",
    "what_do_you_do_to_grow_knowledge",
    "how_do_you_incorporate_te_reo_and_tikanga",
    "what_do_you_do_around_food_cultures_and_traditions"
    )

  returned <- clean_google_sheet_data(df_path) |> colnames()

  expect_equal(returned[c(6:8, 22)], expected)
  expect_error(returned |> select(dplyr::starts_with("q")))
})

f <- function() {
  return(get_live_data())
}

test_that("when requesting live data, it returns a file path to the updated RDS file", {
  # Stub get_live_data() when called within f
  stub(f, "get_live_data", function() {
    return(test_path("testdata/scorecard_updated.rds"))
  })

  expect_equal(f(), test_path("testdata/scorecard_updated.rds"))
})
