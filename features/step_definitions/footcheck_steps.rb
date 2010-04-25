Given /^a foot with$/ do |table|
  visit '/'
  click_button "OK"
  table.raw.each do |(manufacturer, model, size)|
    fill_shoe_inputs manufacturer, model, size
    click_button "shoe_submit"
  end
end

