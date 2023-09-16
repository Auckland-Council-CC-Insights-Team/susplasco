#' Sustainable Place Framework Scorecard Metadata
#'
#' Essential metadata which allows the Sustainable Place Framework scorecards to
#' be built. This includes a list of all questions, actions (or multi-choice
#' options) for each question, and coordinates to be used for where to position
#' the tickboxes in the PDFs, where to place the scoring text and the scores
#' themselves. A separate metadata file would need to be created if {susplasco}
#' is being used to produce a different type of scorecard.
#'
#' @format ## `sustainableplaces` A data frame with 125 rows and 10 columns:
#' \describe{
#'   \item{id}{Unique ID for each question in the form}
#'   \item{sub_id}{Unique ID for each action (or multi-choice option) in the form}
#'   \item{Pou}{The text of each of the five Pou}
#'   \item{Question}{The text of each question, as it appears in the Google Form}
#'   \item{Action}{The text of each action (or multi-choice option), as it
#'   appears in the Google Form}
#'   \item{Status}{Determines if a given action is in the Activator, Leader, or
#'   Champion category}
#'   \item{image_coordinates}{Left offset and top offset in pixels, to determine
#'   where the tickbox image should be situated on the page}
#'   \item{page_number}{An integer denoting the page number where the questions
#'   for this Pou should be situated}
#'   \item{text_coordinates}{Left offset and top offset in pixels, to determine
#'   where the text "Score | " should be placed on the page}
#'   \item{score_coordinates}{Left offset and top offset in pixels, to determine
#'   where the score for a given question should be situated on the page}
#' }
#' @source Auckland Council, Connected Communities department
"sustainableplaces"