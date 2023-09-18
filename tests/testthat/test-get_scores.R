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


test_that("the total number of status-specific actions selected across each Pou returns as expected", {
  data <- get_data()
  status_scores <- get_status_scores(data)
  total_status_scores <- status_scores |>
    janitor::adorn_totals() |>
    filter(metric == "Total") |>
    pull(score)

  expect_equal(total_status_scores, 41)
})
