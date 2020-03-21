# frozen_string_literal: true

require 'dotenv/load'

require 'sinatra'
require 'sinatra/namespace'

require_relative './system/boot'

configure do
  use Rack::CommonLogger, Application[:logger]
end

namespace '/api/v1' do
  before do
    content_type 'application/json'
  end

  helpers do
    # TODO: auth
    def current_user
      Application['repo.user_repo'].first
    end
  end

  get '/user' do
    current_user 
      .to_json(only: %w[name balance])
  end

  get '/paintings' do
    Application['repo.painting_repo']
      .all
      .to_json(only: %w[id name price sold])
  end

  post '/paintings/:id/sell' do |painting_id|
    Application['transactions.sell_painting']
      .with_step_args(fetch_user: [user_id: current_user[:id]])
      .call(painting_id: painting_id) do |m|
        m.success {}
        m.failure { |error| halt 400, { error: error }.to_json }
      end
  end
end
