require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Boxes
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.generators do |g|
      g.test_framework      :rspec, fixture: true # Use RSpec as test framework
      g.fixture_replacement :factory_girl # Use factories instead of fixtures
      g.view_specs          false # Do not generate view specs
      g.helper              false # Do not generate helpers
      g.helper_specs        false # Do not generate helper specs
      g.assets              false # Do not generate assets
    end

    # Do not wrap invalid form fields because it breaks layout
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag.html_safe }
  end
end