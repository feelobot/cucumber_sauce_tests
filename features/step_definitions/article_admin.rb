#######################################
# BACKGROUND
#######################################
Given(/^I am on the article admin page$/) do
  step ("I am logged in as an admin")
  step ("I select the lead article on the homepage")
  Admin.actions("article admin")
end

Given(/I select the lead article on the homepage/) do 
  Homepage.select_lead_article
end

Given(/^I am logged in as an admin$/) do
  Admin.login
end

When(/^I "(.*?)" the photo hook image$/) do |a|
  ArticleAdmin.action(a)
end

And(/^the image is loaded into the cropper$/) do
  @ic = ImageCropper.new
end

And(/^the cropped image is submitted$/) do
  @ic.submit_crop
end

Then(/^the photo id should match the original$/) do
  ArticleAdmin.compare_photo_urls.should == true
end

Then(/^the photo id should not match the original$/) do
  ArticleAdmin.compare_photo_urls.should == false
end


