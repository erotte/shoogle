
Given /^I am searching for "([^\"]*)"$/ do |manufacturer|
    visit "/"
    fill_in("foot_searched_shoe_attributes_manufacturer_name", :with => manufacturer)
    click_button("searched_shoe_submit")
end
