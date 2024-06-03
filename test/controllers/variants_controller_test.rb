require "test_helper"

class VariantsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get variants_new_url
    assert_response :success
  end

  test "should get create" do
    get variants_create_url
    assert_response :success
  end
end
