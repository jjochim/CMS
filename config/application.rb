require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CinemaManagmentSystemV2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    I18n.config.available_locales = :pl
    config.i18n.default_locale = :pl
    config.active_record.time_zone_aware_types = [:datetime]
    config.time_zone = 'Warsaw'
    config.active_record.default_timezone = :local

    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
  end
end
