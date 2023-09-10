
<!-- README.md is generated from README.Rmd. Please edit that file -->

# susplasco

<!-- badges: start -->
<!-- badges: end -->

The goal of susplasco is to automate the process of generating reports
for Sustainable Places.

Whenever someone submits an entry through the [Google
Form](https://docs.google.com/forms/d/e/1FAIpQLSdn90KnYkHDhFY4o7lgXslrAegbU9w6PauwgcbQcTVnW1rjHw/viewform),
simply run `create_scorecards(here::here("survey_questions.csv"))` to
generate a PDF report, which is then saved to SharePoint ready for
distribution.

## Installation

You can install the development version of susplasco from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Auckland-Council-CC-Insights-Team/susplasco")
```
