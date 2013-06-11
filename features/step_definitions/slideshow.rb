#######################################
# BACKGROUND
#######################################
Given(/^I am in writer hq and I create a discovery slideshow$/) do
  test = Writer.new("discovery", "Miami Heat", "Discovery Slideshow")
  hq = WriterHQ.new
  hq.create_article("Slideshow")
end

Given(/^I am in writer hq and I create a legacy slideshow$/) do
  test = Writer.new("legacy", "Miami Heat", "Legacy Slideshow")
  hq = WriterHQ.new
  hq.create_article("Slideshow")
end
#######################################
When(/^I create '(\d+)' slides and add a title$/) do |slides|
  SlideShow.create(slides.to_i)
end

When(/^I add "(.*?)" to slide '(\d+)' titled "(.*?)"$/) do |content, slide, title|
  step "I go to slide '#{slide.to_s}'"
  Slide.add_content(title, content)
end

And(/^I preview the slideshow$/) do
 Slide.verify_preview
end

Then(/^I can publish the slideshow$/) do
  SlideShow.publish
end

When(/^I go to slide '(\d+)'$/) do |slide| 
  SlideShow.go_to_slide(slide.to_i)
end
#################

Then(/^I remove slide "(.*?)" $/) do |slide|
  Slide.remove(slide)
end

Then(/^there should be an error alert$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the legacy slide sorter should apper$/) do
  pending # express the regexp above with the code you wish you had
end
