#######################################
# BACKGROUND
#######################################
Given(/^I am on the article admin page$/) do
  step ("I am logged in as an admin")
  step ("I select the lead article on the homepage")
  Admin.actions("article admin")
end

Given(/^I am logged in as an admin$/) do
  Admin.login
end