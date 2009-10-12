class ShoeTypeExtras < ActiveRecord::Migration
  def self.up
    add_column :shoes, :shoe_type_id, :integer
    remove_columns :shoes, :model, :manufacturer, :gender
  end

  def self.down
    remove_column :shoes, :shoe_type_id
    add_column :shoes, :model, :string
    add_column :shoes, :manufacturer, :string
    add_column :shoes, :gender, :string
  end
end
