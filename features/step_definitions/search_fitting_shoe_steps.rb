
Given /^I am searching a "([^\"]*)" "([^\"]*)"$/ do |manufacturer, model|
    visit "/"
    fill_in("foot_searched_shoe_manufacturer_name", :with => manufacturer)
    fill_in("foot_searched_shoe_model_name", :with => model)
    click_button("searched_shoe_submit")
end

Given /^I enter shoe "([^\"]*)" "([^\"]*)" in "([^\"]*)"$/ do |manufacturer, model, size|
  fill_shoe_inputs manufacturer, model, size
end


Given /^I have a "([^\"]*)" "([^\"]*)" in "([^\"]*)"$/ do |manufacturer, model, size|
  fill_shoe_inputs manufacturer, model, size
  click_button("shoe_submit")
end


def fill_shoe_inputs manufacturer, model, size
  fill_in("shoe[manufacturer]", :with => manufacturer)
  fill_in("shoe[model]", :with => model)
  fill_in("shoe[size]", :with => size)
end