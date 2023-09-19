test_that("the total number of actions selected across all questions returns as expected", {
  data <- get_data()
  scores <- get_question_scores(data)
  total_score <- scores |> janitor::adorn_totals(where = "col")

  expect_equal(total_score$Total, c(37, 23))
})


test_that("the total number of actions selected for a given question returns as expected", {
  data <- get_data()
  metadata <- get_metadata()
  score <- get_question_score(data, "tt_1", metadata)

  expect_equal(score$tt_1_score, c(4, 2))
})


test_that("the total number of status-specific actions selected across each Pou return as expected", {
  data <- get_data()
  status_scores <- get_status_scores(data)
  total_status_scores <- status_scores |>
    janitor::adorn_totals() |>
    filter(id == "Total") |>
    pull(score)

  expect_equal(total_status_scores, 66)
})


test_that("the total number of actions selected for a given status within a given Pou return as expected", {
  data <- get_data()
  metadata <- get_metadata()
  status_score <- get_status_score(data, metadata, pou = "Te Tiriti", status = "Leader")

  expect_equal(status_score$te_tiriti_leader_score, c(5, 4))
})
