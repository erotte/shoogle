class CreateSizeEqualityView < ActiveRecord::Migration
  def self.up
    create_view :size_equalities,
      "SELECT own_shoes.foot_id AS foot_id, other_shoes.foot_id AS similar_foot_id 
       FROM shoes AS own_shoes, shoes AS other_shoes WHERE
       own_shoes.foot_id != other_shoes.foot_id and
       own_shoes.size = other_shoes.size and
       own_shoes.shoe_type_id = other_shoes.shoe_type_id" do |t|
       
       t.column :foot_id
       t.column :similar_foot_id
    end
  end

  def self.down
    drop_view :size_equalities
  end
end
