class Finder < ActiveRecord::Base
  extend Enumerize
  extend ActiveModel::Naming
  enumerize :country_classification,
    in: %w[Franch Russia Arab Germany Korean Spanish Japan Polish Czech Turkey Other]
end
