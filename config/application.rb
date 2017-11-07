require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module HackathonOrganizer
  class Application < Rails::Application
    config.load_defaults 5.1

    config.time_zone = 'Berlin'

    config.generators.system_tests = nil
  end
end
