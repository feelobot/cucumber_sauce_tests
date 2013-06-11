@slideshows @selenium  
Feature: CMS Slideshows (cucumber)

  Background: 
   Given I am in writer hq and I create a discovery slideshow
  
  @dev
  Scenario: Create slideshow with all types of media
    When I create '3' slides and add a title
    When I add "getty" to slide '0' titled "Getty Slide"
    And I add "presswire" to slide '1' titled "Presswire Slide"
    And I add "ooyala" to slide '2' titled "Ooyala Slide"
    And I add "youtube" to slide '3' titled "Youtube Slide"
    And I preview the slideshow
    Then I can publish the slideshow
  
  @skip  
  Scenario: Try to add a video to an intro slide
    When I create '1' slides and add a title
    When I add a ooyala video to slide '0' titled "Ooyala Slide"
      Then there should be an error alert
    When I add a youtube video to slide '0' titled "Youtube Slide"
      Then there should be an error alert
    When I add a embedded video to slide '0' titled "Embedded Slide"
      Then there should be an error alert

  @skip
  Scenario: Saving an incomplete slideshow
    When I add a getty image to to slide '0' titled "Getty Slide"
    And I try to proceed to next step I should see validation errors

  @skip
  Scenario: Adding/Removing/Moving slides
    When I create '4' slides and add a title
    When I add a getty image to to slide '1' titled "Getty Slide"
    And I move slide "1" below slide "3"
    And I delete slide "1"
    And I add a slide using the + icon
    Then there should be a total of "5" slides

  @skip @embed
  Scenario: Embedded Videos
    When I create '42' slides and add a title
    When I add "getty" to slide '0' titled "Getty Slide"
    And I add "embed" to slide '4' titled "Embedded Video Slide"
