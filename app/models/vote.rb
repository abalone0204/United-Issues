class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :candidate
  validates_uniqueness_of :user_id
end
