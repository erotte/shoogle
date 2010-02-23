Given /^a foot with$/ do |table|
  visit '/'
  click_button "Speichern"
  table.raw.each do |(manufacturer, model, size)|
    fill_shoe_inputs manufacturer, model, size
    click_button "foot_submit"
  end
end

