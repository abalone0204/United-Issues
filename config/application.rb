require File.expand_path('../boot', __FILE__)

require 'rails/all'
require "yaml"
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UnitedIssues
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    # config.assets.paths << Rails.root.join('bower_components','sweetalert','lib')
    config.assets.paths << Rails.root.join('app','assets', 'javascripts','vendor','jqueryui-timepicker-addon','src')
    config.assets.paths << Rails.root.join('app','assets', 'javascripts','vendor')
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = "Taipei"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :'zh-TW'

    config.assets.precompile += %w[page/*.js disqus/*.js]
    config.assets.precompile += %w[*.woff *.ttf]
  end
end
