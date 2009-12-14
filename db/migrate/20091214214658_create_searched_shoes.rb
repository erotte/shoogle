class CreateSearchedShoes < ActiveRecord::Migration
  def self.up
    create_table :searched_shoes do |t|
      t.string :manufacturer_name
      t.string :model_name
      t.integer :foot_id
      t.timestamps
    end
  end

  def self.down
    drop_table :searched_shoes
  end
end
