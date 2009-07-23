class Relations < ActiveRecord::Migration
  def self.up
    add_column :shoes, :foot_id, :integer
  end

  def self.down
    remove_column :shoes, :foot_id
  end
end
