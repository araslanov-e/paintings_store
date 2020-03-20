# frozen_string_literal: true

require 'dry/system/container'

class Application < Dry::System::Container
  use :logging
  use :env, inferrer: -> { ENV.fetch("RACK_ENV", :development).to_sym }

  configure do |config|
    config.auto_register = %w[lib]
  end

  load_paths!('lib', 'system')
end
