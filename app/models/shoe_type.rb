class ShoeType < ActiveRecord::Base
  belongs_to :manufacturer
  validate_presence_of :model, :article_number
end
