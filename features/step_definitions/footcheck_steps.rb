Given /^a foot with$/ do |table|
  table.raw.each do |(manufacturer, model, size_string)|
    fill_shoe_inputs manufacturer, model, size_string
    click_button "shoe_submit"
  end
end

