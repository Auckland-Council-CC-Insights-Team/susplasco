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


test_that("multi-choice options are converted to binaries", {
  data <- clean_google_sheet_data("live")

  expect_equal(get_question_answers(data) |> ncol(), 125)
})


test_that("a multi-choice option is converted to binary", {
  data <- clean_google_sheet_data("live")

  binary <- is_option_selected(
    data,
    "tt_1f",
    "how_do_you_connect_with_the_whenua_surrounding_natural_environment",
    "We use our local parks and areas for events"
    )

  expect_equal(binary$tt_1f, 1)
})


test_that("the total number of actions selected across all questions returns as expected", {
  data <- get_data()
  scores <- get_question_scores(data)
  total_score <- scores |> janitor::adorn_totals(where = "col")

  expect_equal(total_score$Total, 37)
})


test_that("the total number of actions selected for a given question returns as expected", {
  data <- get_data()
  metadata <- get_metadata()
  score <- get_question_score(data, "tt_1", metadata)

  expect_equal(score$tt_1_score, 4)
})
