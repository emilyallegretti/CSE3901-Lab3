require "test_helper"

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get data_home_url
    assert_response :success
  end
end
