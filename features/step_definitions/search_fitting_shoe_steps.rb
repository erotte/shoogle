
Given /^I am searching a "([^\"]*)" "([^\"]*)"$/ do |manufacturer, model|
    visit "/"
    fill_in("foot_searched_shoe_attributes_manufacturer_name", :with => manufacturer)
    fill_in("foot_searched_shoe_attributes_model_name", :with => model)
    click_button("searched_shoe_submit")
end

Given /^I enter shoe "([^\"]*)" "([^\"]*)" in "([^\"]*)"$/ do |manufacturer, model, size|
  fill_shoe_inputs manufacturer, model, size
end


Given /^I have a "([^\"]*)" "([^\"]*)" in "([^\"]*)"$/ do |manufacturer, model, size|
  fill_shoe_inputs manufacturer, model, size
  click_button("foot_submit")
end


def fill_shoe_inputs manufacturer, model, size
  fill_in("foot_shoes_attributes__manufacturer", :with => manufacturer)
  fill_in("foot_shoes_attributes__model", :with => model)
  fill_in("foot_shoes_attributes__size", :with => size)
end