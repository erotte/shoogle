class Relations < ActiveRecord::Migration
  def self.up
    add_column :shoes, :foot_id, :integer
    add_column :feet, :gender, :string
  end

  def self.down
    remove_column :feet, :gender
    remove_column :shoes, :foot_id
  end
end
