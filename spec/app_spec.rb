# frozen_string_literal: true

describe 'App' do
  # TODO: DatabaseCleaner
  after(:all) do
    Application['db'][:users].delete
    Application['db'][:paintings].delete
  end

  describe 'GET /api/v1/user' do
    before { create :user }

    subject(:api_response) { JSON.parse(last_response.body) }

    it 'responses success and have balance' do
      get '/api/v1/user'

      expect(last_response.status).to eq 200
      expect(api_response['balance']).to eq 200
    end
  end

  describe 'GET /api/v1/paintings' do
    before { create_list :painting, 3 }

    subject(:api_response) { JSON.parse(last_response.body) }

    it 'responses success' do
      get '/api/v1/paintings'
      expect(last_response.status).to eq 200
      expect(api_response.length).to eq 3
    end
  end

  describe 'POST /api/v1/paintings/:id/sell' do
    before { create :user, balance: 100 }

    let!(:painting) { create :painting, price: 50 }

    it 'responses success' do
      post "/api/v1/paintings/#{painting[:id]}/sell"
      expect(last_response.status).to eq 200
    end
  end
end
