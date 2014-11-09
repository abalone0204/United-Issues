source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem 'spring'
end

gem 'simple_form'
group :development, :test do
  gem 'pry-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem "shoulda-matchers", "~> 2.4.0", require: false
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.1.0'
  gem 'faker'
  gem "minitest"
end

group :test do
  gem 'fabrication'
end



gem 'devise'

gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'
gem 'cancancan', '~> 1.9'

gem 'enumerize'

gem 'kaminari'

gem "rmagick", :require => 'RMagick'
gem "carrierwave"

gem 'redcarpet'

gem "figaro"
gem "settingslogic" 

gem "omniauth"
gem "omniauth-facebook" 
gem "auto-facebook"

# front-end

gem 'jquery-ui-rails'
gem 'googl'

# Deploy

group :staging, :production do
  gem 'mysql2'
end

gem 'capistrano', '~> 3.1.0'

# rails specific capistrano funcitons
gem 'capistrano-rails', '~> 1.1.0'

# integrate bundler with capistrano
gem 'capistrano-bundler'

# if you are using RBENV
gem 'capistrano-rbenv', "~> 2.0" 

# Use the Unicorn app server
gem 'unicorn'

# Upload file to aws s3

gem 'fog'


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

