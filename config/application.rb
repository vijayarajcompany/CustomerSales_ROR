require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pepsidrc
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.eager_load_paths << Rails.root.join('lib')

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :options, :patch, :put, :delete]
      end
    end

    if config.respond_to?(:washout_builder)
      # the path where the engine should be mounted on
      config.washout_builder.mounted_path = "/washout"
      # this can either be an array of strings or array of regular expressions or a string.
      # If you specify "*" ,will mean all environments
      # otherwise you can specify "development" or ['development', 'staging'] or nil
      # or you can use regular expressions like /development/ or array of regular expressions
      config.washout_builder.whitelisted_envs = "*"
      # this can either be an array of strings or array of regular expressions or a string.
      # you can specify "production" or ['production', 'test'] or nil
      # or you can use regular expressions like /production/ or array of regular expressions
      config.washout_builder.blacklisted_envs = nil
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
