@selenium @article_admin @skip
Feature: Article Admin 

# RETALTED TICKETS
# -----------------
# 11832-article-admin-cant-change-photo-hooks

  Background: 
    Given I am on the article admin page

  @positive
  Scenario: Edit Existing Photo
    When I "edit" the photo hook image
    And the image is loaded into the cropper
    And the cropped image is submitted
    Then the photo id should match the original

  @negative
  Scenario: Change Existing Photo
    When I "change" the photo hook image
    Then the photo id should not match the original
