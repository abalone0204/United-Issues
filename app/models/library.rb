class Library < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  # Scope
  scope :country, ->(country) { where(:country_classification => country) if country.present?}
  
  # Association
  has_many :librarizations
  has_many :users, :through => :librarizations

  # Validation
  validates :original_name, presence: true
  validates :translated_name, presence: true
  validates :country_classification, presence: true

  # Enumerize
  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]
  
  # Callback


end
