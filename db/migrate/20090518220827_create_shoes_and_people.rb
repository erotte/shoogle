class CreateShoesAndPeople < ActiveRecord::Migration
  def self.up
    create_table :shoes do |t|
      t.string :manufacturer
      t.string :model
      t.float :size
      t.integer :user_id
      t.timestamps
    end
    create_table :feet, :force => true do |t|
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :people
    drop_table :shoes
  end
end
