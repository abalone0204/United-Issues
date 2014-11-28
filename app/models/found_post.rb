class FoundPost < ActiveRecord::Base
  belongs_to :finder
  has_one :post
end
