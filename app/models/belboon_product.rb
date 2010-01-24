class BelboonProduct < ActiveRecord::Base
  named_scope :named, lambda {|name| {:conditions => ["productname ILIKE ?", "%#{name}%"]}}
end