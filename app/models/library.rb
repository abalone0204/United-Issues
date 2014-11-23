class Library < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming

  # Association
  has_many :librarizations
  # Validation
  validates :original_name, presence: true
  validates :translated_name, presence: true
  validates :country_classification, presence: true

  # Enumerize
  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]
  
  # Callback


end
