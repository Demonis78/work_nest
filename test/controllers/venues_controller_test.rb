require 'test_helper'

class VenuesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get venues_url
    assert_response :success
  end

  test 'should get show' do
    venue = venues(:one)
    get venue_url(venue)
    assert_response :success
  end
end
