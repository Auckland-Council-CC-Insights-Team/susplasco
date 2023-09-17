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
