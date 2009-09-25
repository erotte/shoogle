class CreateShoeSizes < ActiveRecord::Migration
  def self.up
    create_table :shoe_sizes do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :shoe_sizes
  end
end
