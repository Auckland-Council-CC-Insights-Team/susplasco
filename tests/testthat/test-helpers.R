library(mockery)

test_that("two dataframes are column-bound and returned as a single tibble", {
  df_1 <- data.frame(x = 1:10, y = letters[1:10])
  df_2 <- data.frame(z = 11:20, a = letters[11:20])
  expected_df <- tibble::tibble(x = 1:10, y = letters[1:10], z = 11:20,
                                   a = letters[11:20])

  expect_equal(bind_and_tibble(df_1, df_2, z:a), expected_df)
})

