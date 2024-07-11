require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  it 'routes root to home#index' do
    expect(get: '/').to route_to('home#index')
  end

  it 'routes venues to venues#index' do
    expect(get: '/venues').to route_to('venues#index')
  end

  it 'routes offers to offers#index' do
    expect(get: '/offers').to route_to('offers#index')
  end
end
