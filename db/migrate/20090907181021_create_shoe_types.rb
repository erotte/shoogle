class CreateShoeTypes < ActiveRecord::Migration
  def self.up
    create_table :shoe_types do |t|
      t.integer :manufacturer_id
      t.string :model
      t.string :article_number
      t.timestamps
    end
  end

  def self.down
    drop_table :shoe_types
  end
end
