require 'rails_helper'

RSpec.describe VenuesController, type: :controller do
  describe 'GET #show' do
    it 'returns a success response' do
      venue = Venue.create(name: 'Test Venue', description: 'A great place to work')
      get :show, params: { id: venue.to_param }
      expect(response).to be_successful
    end
  end
end
