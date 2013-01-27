Given /^a dataset exists$/ do
  FactoryGirl.create :dataset
end

When /^I view the list of all datasets$/ do
  visit("/datasets")
end

When /^I view that dataset$/ do
  dataset = Dataset.first
  visit("/datasets/#{dataset.to_param}")
end

Then /^I should see "(.*?)"$/ do |arg1|
  page.should have_text(arg1)  
end