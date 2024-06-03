require "test_helper"

class VenuesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get venues_new_url
    assert_response :success
  end

  test "should get create" do
    get venues_create_url
    assert_response :success
  end
end
