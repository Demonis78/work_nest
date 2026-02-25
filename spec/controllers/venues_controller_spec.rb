require 'rails_helper'

RSpec.describe VenuesController, type: :controller do
  describe 'GET #search' do
    let!(:venue_warszawa) do
      Venue.create!(name: 'Warszawa Cowork', description: 'In Warsaw, PL').tap do |venue|
        Address.create!(
          addressable: venue,
          street: 'Marszałkowska 1',
          city: 'Warszawa',
          country: 'Poland'
        )
      end
    end

    let!(:venue_warsaw) do
      Venue.create!(name: 'Warsaw Hub', description: 'In Warsaw, EN').tap do |venue|
        Address.create!(
          addressable: venue,
          street: 'Main Street 1',
          city: 'warsaw',
          country: 'Poland'
        )
      end
    end

    let!(:venue_other_city) do
      Venue.create!(name: 'Krakow Space', description: 'In Krakow').tap do |venue|
        Address.create!(
          addressable: venue,
          street: 'Rynek 1',
          city: 'Kraków',
          country: 'Poland'
        )
      end
    end

    it 'finds all Warsaw/Warszawa variants for query warsaw' do
      get :search, params: { q: 'warsaw' }

      expect(assigns(:venues)).to match_array([venue_warszawa, venue_warsaw])
    end

    it 'finds all Warsaw/Warszawa variants for query WARSZAWA (case-insensitive)' do
      get :search, params: { q: 'WARSZAWA' }

      expect(assigns(:venues)).to match_array([venue_warszawa, venue_warsaw])
    end

    it 'returns none when query is blank' do
      get :search, params: { q: '' }

      expect(assigns(:venues)).to be_empty
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      venue = Venue.create(name: 'Test Venue', description: 'A great place to work')
      get :show, params: { id: venue.to_param }
      expect(response).to be_successful
    end
  end
end
