class AddTransposedMatchesView < ActiveRecord::Migration
  def self.up
    create_view :transposed_matches, 
      " select st.id as shoe_type_id, st.model as model_name, sm.name as manufacturer_name, s.size as size, a.size as size_of_other, b.size as size_of_this, b.foot_id as foot_id 
        from shoes as s, manufacturers as sm, shoe_types as st, shoes as a, shoes as b
        where sm.id = st.manufacturer_id
        and st.id = s.shoe_type_id
        and a.size != b.size 
        and a.shoe_type_id = b.shoe_type_id
        and s.foot_id  = a.foot_id
        and a.foot_id != b.foot_id;" do |t|
      t.column :shoe_type_id
      t.column :model_name
      t.column :manufacturer_name
      t.column :size
      t.column :size_of_other
      t.column :size_of_this
      t.column :foot_id
    end
  end

  def self.down
    drop_view :transposed_matches
  end
end
