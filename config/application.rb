require_relative "boot"

require "rails"

%w(
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

if defined?(Bundler)
  # If you precompile assets before deploying to production, user this line
  Bundle.require(*Rails.groups(assets: %w(development test)))
  # If you want your assets lazily compiled in production, user this line
  # Bundle.require(:default, :assets, Rails.env)
end

module PullrequestCopy
  class Application < Rails::Application
    # Settings in config/environments/* take precendence over those specifc here
    # Application configuration shoul go files in config/initializers
    # -- All .rb files in that directory are automaticaly loaded

    # Custom directories with classes and modules you want be autoloadeble
    config.autoload_paths += %W(#{config.root}/app/services)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone
    # Run "rake -D time" for a list task for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
    config.i18n.available_locales = [:en, :el, :es, :pt_br, :fi, :fr, :de, :tu, :uk, :th, :it, :nb, :ta, :tr, :zh_Hans, :zh_Hant, :ja, :cs, :hi]

    # Configure the default encoding used in tamplates for Ruby 1.9.
    config.encoding = 'utf-8'

    # Configure sensitive parameters wich will be filtered from the log file
    config.filter_parameters += [:password]

    # Enable escapimg HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumber when creating the database.
    # This is necessary if schema can't be completely dumbed by the schema dumber,
    # Like if you have constraints or database-specifc colums types
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.assets.initialize_on_precompile = false

    # Rate limiting, see config/initialize/rack_attack.rb for config
    config.middleware.user Rack::Attack

    config.exceptions_app = routes

    I18n.config.enforce_available_locales = false

    def current_year
      Time.current.year
    end

    def last_complete_year
      if Time.current.month == 12 && Time.current.day > 24
        current_year
      else
        current_year - 1
      end
    end
  end
end
