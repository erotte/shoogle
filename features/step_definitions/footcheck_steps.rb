Given /^a foot with$/ do |table|
  table.raw.each do |(manufacturer, model, size)|
    fill_shoe_inputs manufacturer, model, size
    click_button "shoe_submit"
  end
end

