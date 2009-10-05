# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090930200426) do

  create_table "feet", :force => true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoe_sizes", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoe_types", :force => true do |t|
    t.integer  "manufacturer_id"
    t.string   "model"
    t.string   "article_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shoes", :force => true do |t|
    t.float    "size"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "foot_id"
    t.integer  "shoe_type_id"
  end

  create_view "direct_matches", "CREATE VIEW \"direct_matches\" AS  select st.model as model_name, sm.name as manufacturer_name, s.size as size, b.foot_id as foot_id \n        from shoes as s, manufacturers as sm, shoe_types as st, shoes as a, shoes as b\n        where sm.id = st.manufacturer_id\n        and st.id = s.shoe_type_id\n        and a.size = b.size \n        and a.shoe_type_id = b.shoe_type_id\n        and s.foot_id  = a.foot_id\n        and a.foot_id != b.foot_id", :force => true do |v|
    v.column :model_name
    v.column :manufacturer_name
    v.column :size
    v.column :foot_id
  end

end
