class AddDirectMatchesView < ActiveRecord::Migration
  def self.up
    create_view :direct_matches, 
      " select st.model as model_name, sm.name as manufacturer_name, s.size as size, b.foot_id as foot_id 
        from shoes as s, manufacturers as sm, shoe_types as st, shoes as a, shoes as b
        where sm.id = st.manufacturer_id
        and st.id = s.shoe_type_id
        and a.size = b.size 
        and a.shoe_type_id = b.shoe_type_id
        and s.foot_id  = a.foot_id
        and a.foot_id != b.foot_id;" do |t|
      t.column :model_name
      t.column :manufacturer_name
      t.column :size
      t.column :foot_id
    end
  end

  def self.down
    drop_view :direct_matches
  end
end
