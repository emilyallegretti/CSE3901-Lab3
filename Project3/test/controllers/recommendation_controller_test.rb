require "test_helper"

class RecommendationControllerTest < ActionDispatch::IntegrationTest
  test "should get recommend" do
    get recommendation_recommend_url
    assert_response :success
  end
end
