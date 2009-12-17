class BelboonProduct < ActiveRecord::Base
  named_scope :named, lambda {|name| {:conditions => ["productname LIKE ?", "%#{name}%"]}}
end