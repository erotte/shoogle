
Given /^I am searching a "([^\"]*)" "([^\"]*)"$/ do |manufacturer, model|
    fill_in("manufacturer", :with => manufacturer)
    fill_in("model", :with => model)
    click_button("search_shoes_submit")
end

Given /^I enter shoe "([^\"]*)" "([^\"]*)" in "([^\"]*)"$/ do |manufacturer, model, size|
  fill_in("foot_shoes_attributes__manufacturer", :with => manufacturer)
  fill_in("foot_shoes_attributes__model", :with => model)
  fill_in("foot_shoes_attributes__size", :with => size)
end


Given /^I have a "([^\"]*)" "([^\"]*)" in "([^\"]*)"$/ do |manufacturer, model, size|
  Given I enter shoe "#{manufacturer}" "#{model}" in "#{size}"
  click_button("foot_submit")
end
