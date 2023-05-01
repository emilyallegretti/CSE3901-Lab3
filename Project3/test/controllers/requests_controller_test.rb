# frozen_string_literal: true

require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get requests_show_url
    assert_response :success
  end
end
