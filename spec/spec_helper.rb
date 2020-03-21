# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'pry'
require 'factory_bot'

ENV['RACK_ENV'] = 'test'

require_relative "#{__dir__}/../app"

Sinatra::Base.set :environment, :test

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
