#' Sustainable Place Framework Scorecard Metadata
#'
#' Essential metadata which allows the Sustainable Place Framework scorecards to
#' be built. This includes a list of all questions, actions (or multi-choice
#' options) for each question, and coordinates to be used for where to position
#' the tickboxes in the PDFs, where to place the scoring text and the scores
#' themselves. A separate metadata file would need to be created if {susplasco}
#' is being used to produce a different type of scorecard.
#'
#' @format ## `sustainableplacesmetadata` A data frame with 125 rows and 10 columns:
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
"sustainableplacesmetadata"


#' Sustainable Place Framework Scorecard Data
#'
#' Test data which mimics the kind of data that would be submitted via the
#' Sustainable Place Framework scorecard online form. When {susplasco} is used
#' in production, the user would point to the URL for the Google Form to obtain
#' live data.
#'
#' @format ## `sustainableplacesscorecard` A data frame with 5 rows and 22
#'   columns:
#' \describe{
#'   \item{timestamp}{Date and time when the form was submitted.}
#'   \item{email_address}{Email address as supplied via the form submission}
#'   \item{first_name}{First name as supplied via the form submission}
#'   \item{last_name}{Last name as supplied via the form submission}
#'   \item{your_facility}{Facility name as supplied via the form submission}
#'   \item{q12_how_do_you_connect_with_the_whenua_surrounding_natural_environment}
#'   {Question 12}
#'   \item{q13_what_do_you_do_to_grow_knowledge}{Question 13}
#'   \item{q14_how_do_you_incorporate_te_reo_and_tikanga}{Question 14}
#'   \item{q7_how_are_you_building_sustainable_action}{Question 7}
#'   \item{q8_how_are_you_preparing_for_emergency_management}{Question 8: how are you preparing for emergency management?}
#'   \item{q9_what_do_you_do_to_support_social_enterprise_and_circular_economies}{Question 9}
#'   \item{q10_how_do_you_know_you_are_having_impact}{Question 10}
#'   \item{q11_what_do_you_do_to_be_inclusive_and_accessible}{Question 11}
#'   \item{q1_what_do_you_do_to_make_your_place_low_waste}{Question 1}
#'   \item{q2_what_do_you_do_to_encourage_zero_waste_actions_and_behaviors}{Question 2}
#'   \item{q3_what_do_you_do_to_promote_sustainable_commuting}{Question 3}
#'   \item{q4_what_are_you_doing_to_become_water_and_energy_efficient}{Question 4}
#'   \item{q5_what_are_you_doing_to_reduce_your_carbon_emissions}{Question 5}
#'   \item{q6_what_are_you_doing_to_protect_and_restore_native_biodiversity}{Question 6}
#'   \item{q15_what_do_you_do_around_food_equity_and_sovereignty}{Question 15}
#'   \item{q16_what_do_you_do_for_food_resilience_in_your_area}{Question 16}
#'   \item{q17_what_do_you_do_around_food_cultures_and_traditions}{Question 17}
#' }
#' @source Auckland Council, Connected Communities department
"sustainableplacesscorecard"


#' Sustainable Place Framework Scorecard Data
#'
#' Test data which mimics the kind of data that would be submitted via the
#' Sustainable Place Framework scorecard online form. When {susplasco} is used
#' in production, the user would point to the URL for the Google Form to obtain
#' live data. This particular data represents a new entry submitted through the
#' form since reports were last rendered.
#'
#' @format ## `newsustainableplacesscorecard` A data frame with 1 row and 22
#'   columns:
#' \describe{
#'   \item{timestamp}{Date and time when the form was submitted.}
#'   \item{email_address}{Email address as supplied via the form submission}
#'   \item{first_name}{First name as supplied via the form submission}
#'   \item{last_name}{Last name as supplied via the form submission}
#'   \item{your_facility}{Facility name as supplied via the form submission}
#'   \item{q12_how_do_you_connect_with_the_whenua_surrounding_natural_environment}
#'   {Question 12}
#'   \item{q13_what_do_you_do_to_grow_knowledge}{Question 13}
#'   \item{q14_how_do_you_incorporate_te_reo_and_tikanga}{Question 14}
#'   \item{q7_how_are_you_building_sustainable_action}{Question 7}
#'   \item{q8_how_are_you_preparing_for_emergency_management}{Question 8: how are you preparing for emergency management?}
#'   \item{q9_what_do_you_do_to_support_social_enterprise_and_circular_economies}{Question 9}
#'   \item{q10_how_do_you_know_you_are_having_impact}{Question 10}
#'   \item{q11_what_do_you_do_to_be_inclusive_and_accessible}{Question 11}
#'   \item{q1_what_do_you_do_to_make_your_place_low_waste}{Question 1}
#'   \item{q2_what_do_you_do_to_encourage_zero_waste_actions_and_behaviors}{Question 2}
#'   \item{q3_what_do_you_do_to_promote_sustainable_commuting}{Question 3}
#'   \item{q4_what_are_you_doing_to_become_water_and_energy_efficient}{Question 4}
#'   \item{q5_what_are_you_doing_to_reduce_your_carbon_emissions}{Question 5}
#'   \item{q6_what_are_you_doing_to_protect_and_restore_native_biodiversity}{Question 6}
#'   \item{q15_what_do_you_do_around_food_equity_and_sovereignty}{Question 15}
#'   \item{q16_what_do_you_do_for_food_resilience_in_your_area}{Question 16}
#'   \item{q17_what_do_you_do_around_food_cultures_and_traditions}{Question 17}
#' }
#' @source Auckland Council, Connected Communities department
"newsustainableplacesscorecard"
