require 'rails_helper'

RSpec.describe VenuesController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      venue = Venue.create(name: 'Test Venue', description: 'A great place to work')
      get :show, params: { id: venue.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new venue' do
        expect {
          post :create, params: { venue: { name: 'New Venue', description: 'A new place' } }
        }.to change(Venue, :count).by(1)
      end

      it 'redirects to the created venue' do
        post :create, params: { venue: { name: 'New Venue', description: 'A new place' } }
        expect(response).to redirect_to(Venue.last)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new venue' do
        expect {
          post :create, params: { venue: { name: nil, description: 'A new place' } }
        }.to_not change(Venue, :count)
      end

      it 're-renders the new method' do
        post :create, params: { venue: { name: nil, description: 'A new place' } }
        expect(response).to render_template(:new)
      end
    end
  end
end
