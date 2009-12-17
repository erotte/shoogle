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

ActiveRecord::Schema.define(:version => 20091214214658) do

  create_table "belboon_products", :force => true do |t|
    t.string   "belboon_productnumber"
    t.string   "belboon_programid"
    t.string   "productnumber"
    t.string   "ean"
    t.string   "productname"
    t.string   "manufacturername"
    t.string   "brandname"
    t.float    "currentprice"
    t.float    "oldprice"
    t.string   "currency"
    t.datetime "validfrom"
    t.datetime "validuntil"
    t.string   "deeplinkurl"
    t.string   "basketurl"
    t.string   "imagesmallurl"
    t.string   "imagesmallheight"
    t.string   "imagesmallwidth"
    t.string   "imagebigurl"
    t.string   "imagebigheight"
    t.string   "imagebigwidth"
    t.string   "productcategory"
    t.string   "belboonproductcategory"
    t.string   "productkeywords"
    t.string   "productdescriptionshort"
    t.string   "productdescriptionslong"
    t.datetime "lastupdate"
    t.string   "shipping"
    t.string   "availability"
    t.string   "option1"
    t.string   "option2"
    t.string   "option3"
    t.string   "option4"
    t.string   "option5"
  end

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

  create_table "searched_shoes", :force => true do |t|
    t.string   "manufacturer_name"
    t.string   "model_name"
    t.integer  "foot_id"
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

  create_view "direct_matches", "select `st`.`id` AS `shoe_type_id`,`st`.`model` AS `model_name`,`sm`.`name` AS `manufacturer_name`,`s`.`size` AS `size`,`b`.`foot_id` AS `foot_id` from ((((`shoes` `s` join `manufacturers` `sm`) join `shoe_types` `st`) join `shoes` `a`) join `shoes` `b`) where ((`sm`.`id` = `st`.`manufacturer_id`) and (`st`.`id` = `s`.`shoe_type_id`) and (`a`.`size` = `b`.`size`) and (`a`.`shoe_type_id` = `b`.`shoe_type_id`) and (`s`.`foot_id` = `a`.`foot_id`) and (`a`.`foot_id` <> `b`.`foot_id`))", :force => true do |v|
    v.column :shoe_type_id
    v.column :model_name
    v.column :manufacturer_name
    v.column :size
    v.column :foot_id
  end

  create_view "size_equalities", "select `own_shoes`.`foot_id` AS `foot_id`,`other_shoes`.`foot_id` AS `similar_foot_id` from (`shoes` `own_shoes` join `shoes` `other_shoes`) where ((`own_shoes`.`foot_id` <> `other_shoes`.`foot_id`) and (`own_shoes`.`size` = `other_shoes`.`size`) and (`own_shoes`.`shoe_type_id` = `other_shoes`.`shoe_type_id`))", :force => true do |v|
    v.column :foot_id
    v.column :similar_foot_id
  end

  create_view "transposed_matches", "select `st`.`id` AS `shoe_type_id`,`st`.`model` AS `model_name`,`sm`.`name` AS `manufacturer_name`,`s`.`size` AS `size`,`a`.`size` AS `size_of_other`,`b`.`size` AS `size_of_this`,`b`.`foot_id` AS `foot_id` from ((((`shoes` `s` join `manufacturers` `sm`) join `shoe_types` `st`) join `shoes` `a`) join `shoes` `b`) where ((`sm`.`id` = `st`.`manufacturer_id`) and (`st`.`id` = `s`.`shoe_type_id`) and (`a`.`size` <> `b`.`size`) and (`a`.`shoe_type_id` = `b`.`shoe_type_id`) and (`s`.`foot_id` = `a`.`foot_id`) and (`a`.`foot_id` <> `b`.`foot_id`))", :force => true do |v|
    v.column :shoe_type_id
    v.column :model_name
    v.column :manufacturer_name
    v.column :size
    v.column :size_of_other
    v.column :size_of_this
    v.column :foot_id
  end

end
