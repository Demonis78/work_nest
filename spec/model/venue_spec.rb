require 'rails_helper'

RSpec.describe Venue, type: :model do
  it 'is valid with valid attributes' do
    venue = Venue.new(name: 'Test Venue', description: 'A great place to work')
    expect(venue).to be_valid
  end

  it 'is not valid without a name' do
    venue = Venue.new(description: 'A great place to work')
    expect(venue).to_not be_valid
  end
end
