@selenium @content_player @skip
Feature: Content Player Admin (cuke)
#######################################
# RETALTED TICKETS
#######################################
# https://bleacherreport.lighthouseapp.com/projects/6296-bug-reporting/tickets/11832-article-admin-cant-change-photo-hooks

# Also the content player:
# http://d.pr/i/n8mx
  Background: 
    Given I am logged in as an admin.

  Scenario: 
    When I select 