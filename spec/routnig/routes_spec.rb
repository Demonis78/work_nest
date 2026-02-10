require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it 'routes root to home#index' do
    expect(get: '/').to route_to('home#index')
  end

  it 'routes venue show to venues#show' do
    expect(get: '/venues/1').to route_to('venues#show', id: '1')
  end

  it 'routes venue search to venues#search' do
    expect(get: '/venues/search').to route_to('venues#search')
  end
end
