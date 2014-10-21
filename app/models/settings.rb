class Settings < Settingslogic
  if Rails.env == "production"
    source ""
  else
    source "#{Rails.root}/config/application.yml"    
  end
  namespace Rails.env
end